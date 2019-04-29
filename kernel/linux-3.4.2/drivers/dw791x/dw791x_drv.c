/*
 * Dongwoon Anatech haptic driver for DW791X series
 * Copyright(c) 2018 - 2019 Dongwoon Anatech Corporation.
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms and conditions of the GNU General Public License,
 * version 2, as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 * more details.
 *
 * The full GNU General Public License is included in this distribution in
 * the file called "COPYING".
 *
 */

#include <linux/module.h>
#include <linux/init.h>
#include <linux/i2c.h>
#include <linux/delay.h>
#include <linux/slab.h>
#include <linux/gpio.h>
#include <linux/interrupt.h>
#include <linux/workqueue.h>
#include <linux/hrtimer.h>
#include <sound/soc.h>
#include <sound/pcm.h>
#include <sound/pcm_params.h>
#include <sound/soc-dapm.h>
#include <sound/initval.h>
#include <sound/tlv.h>
#include <linux/of_gpio.h>
#include <linux/ktime.h>
#include <linux/firmware.h>
#include <linux/wakelock.h>
#include <linux/leds.h>
#include "dw791x_drv.h"

//---------------------------------------------//
/* A2V Play Type */
#define A2V_RTP
//#define A2V_MEM

/* Haptic Motor Type */
#define DW7914_GAMMA
//#define DW7914_COIN0832
//#define DW7914_COIN1040

/* Debug Message */
#define DWA_DEBUG
//---------------------------------------------//

#define FW_FILE "dwa_hpitic_mem_wave.bin"
#define RTP_FW_FILE "RTP_TEST_625ms.bin"

#ifdef DWA_DEBUG
	#define ggprint(fmt, args...) pr_info("[dw791x] %s: " fmt, __FUNCTION__ , ## ##args)
#else
	#define ggprint(x...) do { } while (0)
#endif
#define gprint(fmt, args...) pr_info("[dw791x] %s: " fmt, __FUNCTION__ , ## ##args)

struct dw791x_priv {
	struct work_struct work;
	struct mutex dev_lock;
	struct hrtimer timer;
	struct led_classdev	cdev;
	struct hrtimer hr_timer;
	struct i2c_client *dwclient;
	struct autovib_reg autovib;
	const struct firmware *fw;

	int activate;
	int duration;
	int state;
	int rtp_input_node;
	int mode;
	int set_sequencer;
	int scale;
	int ctrl_loop;
	int lp_trigger_effect;
	int a2v_vib_lock;
	int irq_gpio;

	u32 device;
	u32 irq_num;
	u32 checksum;
	u32 version;

	u8 rtp_input;
	u8 mem_input;
	u8 play_back;
	u8 fifo_level;
	u8 fifo_addrh;
	u8 fifo_addrl;
	u8 play_mode;
	s8 dev_name[8];
};

/* =====================================================================================
function : dw791x_a2v_seq_write
descript : A2V data write function
====================================================================================== */
int dw791x_a2v_seq_write(u8* data, u32 size)
{
#ifdef A2V_RTP
	dw791x_byte_write(dw791x->play_mode, RTP);
	dw791x_byte_write(dw791x->play_back, DRV_PLAY);
	dw791x_seq_write(dw791x->rtp_input, 0, RAM_ADDR8, (u8*)data, size);
#else // A2V MEM mode
	if(data[0] > 0) {
#ifdef DW7914_COIN1040
		dw791x_byte_write(0x0F, 0x02);
#endif
#ifdef DW7914_COIN0832
		dw791x_byte_write(0x0F, 0x01);
#endif
#ifdef DW7914_GAMMA
		dw791x_byte_write(0x0F, 0x03);
#endif
		dw791x_byte_write(0x04, 0x05);
	}

	if(data[0] == 1 && dw791x->a2v_vib_lock != 1) {
		dw791x_byte_write(0x0A, 0x71); //4.52v, soft
		dw791x_byte_write(dw791x->play_back, DRV_PLAY);
	}
	else if(data[0] == 2 && dw791x->a2v_vib_lock != 2) {
		dw791x_byte_write(0x0A, 0x8A); //5.52v
		dw791x_byte_write(dw791x->play_back, DRV_PLAY);
	}
	else if(data[0] == 3 && dw791x->a2v_vib_lock != 3) {
		dw791x_byte_write(0x0A, 0xBC); //7.52v, strong
		dw791x_byte_write(dw791x->play_back, DRV_PLAY);		
	}
	dw791x->a2v_vib_lock = data[0];
#endif

	return 0;
}

/* =====================================================================================
function : dw791x_byte_write
====================================================================================== */
static int dw791x_byte_write(u8 addr, u8 data)
{
	int ret;

	ret = i2c_smbus_write_byte_data(dw791x->dwclient, addr, data);

	if (ret < 0) {
		gprint("%s i2c byte write fail.!\n", dw791x->dev_name);
	}

	return ret;
}

/* =====================================================================================
function : dw791x_word_write
====================================================================================== */
static int dw791x_word_write(u8 addr, u32 data)
{
	int ret;
	u8 xbuf[3];
	struct i2c_msg xfer[1];
	struct i2c_client *i2c_fnc = dw791x->dwclient;

	memset(xbuf, 0, sizeof(xbuf));

	xbuf[0] = (u8)addr;			
	xbuf[1] = data >> 8;
	xbuf[2] = data;

	xfer[0].addr  = CHIP_ID;
	xfer[0].len   = 3;
	xfer[0].flags = 0;
	xfer[0].buf = xbuf;
	ret = i2c_transfer(i2c_fnc->adapter, xfer, 1);
	
	return ret;
}

/* =====================================================================================
function : dw791x_byte_write
====================================================================================== */
int dw791x_byte_read(u8 addr)
{
	int ret;

	ret = i2c_smbus_read_byte_data(dw791x->dwclient, addr);
	
	if (ret < 0) {
		gprint("%s i2c byte read fail.!\n",dw791x->dev_name);
	}	
	
	return ret;
}

/* =====================================================================================
function : dw791x_vd_clamp_set
descript : voltage level control function
====================================================================================== */
static void dw791x_vd_clamp_set(u32 vol)
{
	u8 clamp;
	int ret=0;

	clamp = vol / 40;

	if(dw791x->device == DW7912) {
		ret = dw791x_byte_write(DW7912_VD_CLAMP, clamp);
	}

	else if(dw791x->device == DW7914) {
		ret = dw791x_byte_write(DW7914_VD_CLAMP, clamp);
	}

	if(ret < 0) gprint("%s i2c vd clamp set fail.!\n",dw791x->dev_name);
	else gprint("vd clamp: %dmV\n",vol);
}

/* =====================================================================================
function : dw791x_bst_option
descript : dw791x device boost control option
====================================================================================== */
#ifdef BST_OPT
static void dw791x_bst_option(u32 lv, u32 limit, u32 ofs)
{
    u8 set=0;
    int ret=0;

    if(dw791x->device == DW7912) {
        set = limit << 5 | (ofs / 80);
        ret = dw791x_byte_write(DW7912_BST_OPTION, set);
    }

    if(dw791x->device == DW7914) {
        set = lv<<6 | limit << 4 | (ofs / 80);
        ret = dw791x_byte_write(DW7914_BST_OPTION, set);
    }

    if(ret < 0) gprint("%s i2c boost option set fail.!\n", dw791x->dev_name);
    else gprint("%s boost offset: %dmV\n", dw791x->dev_name, set);

}
#endif

/* =====================================================================================
function : dw791x_fifo_size_set
descript : FIFO size set function
			value(2) = mean(2KB) / value(4) = mean(4KB) / value(6) = mean(6KB)
====================================================================================== */
static void dw791x_fifo_size_set(u32 size)
{
	int ret=0;
	u32 fifo_set;

	fifo_set = SRAM_BASE - (1024 * size + 4);
	gprint("fifo size: %dbyte\n", 1024 * size);
	ret = dw791x_word_write(dw791x->fifo_addrh, fifo_set);

	if(ret < 0) gprint("%s i2c fifo size set fail.!\n", dw791x->dev_name);
}

/* =====================================================================================
function : dw7914_mode_set
descript : only DW7914 devices are supported.
====================================================================================== */
static void dw7914_mode_set(u8 type, u8 bitset)
{
	int ret, reg;

	reg = dw791x_byte_read(DW7914_MODE);

	if(bitset == BITSET) { reg = reg | type;
	}
	else { reg = reg & ~type;
	}

	ret = dw791x_byte_write(DW7914_MODE, reg);

	if(ret < 0)
		gprint("%s i2c mode register set fail.!\n", dw791x->dev_name);
	else 
		gprint("mode register set: %x\n", reg);
}


/* =====================================================================================
function : dw7924_trigctrl_set
descript : dw7914 trig control setup.
			only DW7914 devices are supported.
====================================================================================== */
#ifdef TRIG_OPT
static void dw7914_trigctrl_set(u8 type, u8 bitset)
{
	int ret, reg;

	reg = dw791x_byte_read(DW7914_TRIG_CTRL);

	if(bitset == BITSET) { reg = reg | type;
	}
	else { reg = reg & (~type);
	}
	
	ret = dw791x_word_write(DW7914_TRIG_CTRL, reg);
	
	gprint("trig ctrl register set: %x\n", reg);

	if(ret < 0) gprint("%s i2c trig register set fail.!\n", dw791x->dev_name);
}
#endif

/* =====================================================================================
function : dw7914_autovib_set
descript : dw7914 auto track & brake ctrl setup.
			only DW7914 devices are supported.

			Exmaple Design Info
			- LRA F0 IN : 3F 00 AA 
			- Track Pattern : 34 80 (follow setting value)
			- Track Loop & Track0 cycle : 34 80
			- Track_Play : 35 09 (106ms)
			- Track_Idle : 36 00 (10.66ms)
			- Track0 Wave : 37 00
			- Track1 Wave : 38 01
			- NULL=GND time : 3c 33 (100us)
			- ZXD time : 3d 67 ( 450us)
			- Actuator conversions range : 147Hz ~ 193Hz	
====================================================================================== */
static void dw7914_autovib_set(void)
{
	// setp 0: ------ auto track wave transfer
	transfer_atuovib_wave((u8*)auto_track_base_m1);

	// step 1: ------ control mode setting
	dw7914_mode_set(D14_AUTO_TRACK , BITSET);

	// step 2: ------ register setting
	dw791x_word_write(DW7914_LRA_F0_INH, 0xAA);
	dw791x_byte_write(DW7914_TRACK_CTRL0, 0x80);
	dw791x_byte_write(DW7914_TRACK_CTRL1, 0x09);
	dw791x_byte_write(DW7914_TRACK_CTRL2, 0x00);
	dw791x_byte_write(DW7914_TRACK0_WAVE, 0x00);
	dw791x_byte_write(DW7914_TRACK1_WAVE, 0x01);
	dw791x_byte_write(DW7914_ZXD_CTRL1, 0x33);
	dw791x_byte_write(DW7914_ZXD_CTRL2, 0x67);
}

/* =====================================================================================
function : dw7914_checksum
descript : dw7914 memory check-sum check function
			only DW7914 devices are supported.
			- page : sram(12KB) memory model select
			- return 0 (sucess)
			- return -1 (fail)
====================================================================================== */
static int dw7914_checksum(u32 type, u32 page)
{
	int ret=0;
	u8 *p=NULL, rx[4];
	u32 point, gsum;

	dw791x_fifo_size_set(4);
	
	if(request_firmware(&dw791x->fw, FW_FILE, &dw791x->dwclient->dev) == 0) 
	{		
		p = (u8*)dw791x->fw->data;
		point = (1 + page) * BIN_BASE;
		rx[3] = p[point-4];
		rx[2] = p[point-3];
		rx[1] = p[point-2];
		rx[0] = p[point-1];
		dw791x->checksum = (u32)rx[3]<<24|(u32)rx[2]<<16|(u32)rx[1]<<8|(u32)rx[0]<<0;
		gprint("fw_name= %s fw_size= %ld fw_checksum= %x\n", FW_FILE, dw791x->fw->size, dw791x->checksum);
	} release_firmware(dw791x->fw);
	
	dw7914_mode_set(D14_CHKSUM, BITSET);
	msleep(20);
	rx[3] = dw791x_byte_read(DW7914_RAM_CHKSUM3);
	rx[2] = dw791x_byte_read(DW7914_RAM_CHKSUM2);
	rx[1] = dw791x_byte_read(DW7914_RAM_CHKSUM1);
	rx[0] = dw791x_byte_read(DW7914_RAM_CHKSUM0);
	gsum = (u32)rx[3]<<24|(u32)rx[2]<<16|(u32)rx[1]<<8|(u32)rx[0]<<0;

	if(gsum == dw791x->checksum) {
		ret = 0;
		gprint("memory checksum passed!: %x\n", gsum);
	}
	else {
		ret = -1;
		gprint("memory checksum failed!: %x, %x\n", gsum, dw791x->checksum);
	}
		
	return ret;
}

/* =====================================================================================
function : dw791x_seq_write
descript : bulk I2C transfer function
====================================================================================== */
static int dw791x_seq_write(u32 addr, u32 ram_addr, u32 ram_bit, u8* data, u32 size)
{
	int ret=0;
	u8 xbuf[1028];
	struct i2c_msg xfer[1];
	struct i2c_client *i2c_fnc = dw791x->dwclient;

	memset(xbuf, 0, sizeof(xbuf));

	if(size > 1027) { 
		ret = -1;
		gprint("The transferable size has been exceeded.\n");		
		return ret;
	}

	if(ram_bit == RAM_ADDR8) { 
		xbuf[0] = (u8)addr;	
		xfer[0].addr  = CHIP_ID;
		xfer[0].len   = size + 1;
		xfer[0].flags = 0;
		xfer[0].buf = xbuf;
		memcpy((u8*)xbuf + 1, (u8*)data, size);
	}
	else if(ram_bit == RAM_ADDR16) {
		xbuf[0] = addr;
		xbuf[1] = ram_addr >> 8;
		xbuf[2] = (u8)ram_addr;
		
		xfer[0].addr  = CHIP_ID;
		xfer[0].len   = size + 3;
		xfer[0].flags = 0;
		xfer[0].buf = xbuf;
		memcpy((u8*)xbuf + 3, (u8*)data, size);
	}

	ret = i2c_transfer(i2c_fnc->adapter, xfer, 1);

	return ret;
}

static int dw791x_Mem_Write(u8* data, u32 size)
{
	int reg;

	dw791x_seq_write(dw791x->mem_input, 0, RAM_ADDR8, (u8*)data, 7);
	reg = (int)data[2] << 8 | data[3];
	dw791x_seq_write(dw791x->mem_input, reg, RAM_ADDR16, (u8*)data + 7, size - 7);

	return 0;
}

/* =====================================================================================
function : transfer_autovib_wave
descript : transfer auto track brake memory wave
			only DW7914 devices are supported.
			header(pure header 5byte), body(pure wave data), not include memory address.
====================================================================================== */
static int transfer_atuovib_wave(u8* wave)
{
	int ret, i, loop, tail, wave_size;
	int start_addr, set_addr, trans_size;

	// setp 0: ---------------------------- dw7914 memory mode set
	ret = 0;
	dw7914_mode_set(D14_MEM_MODE, MEM);

 	// setp 1: ---------------------------- dw7914 header data transfer
	set_addr = (u32)wave[0]<<8 | wave[1];
	dw791x_seq_write(dw791x->mem_input, set_addr, RAM_ADDR16, (u8*)wave + 2, 5);

	// step 2: ---------------------------- dw7914 body data transfer
	trans_size = I2C_TRANS_MEM;
	set_addr = (int)wave[2] << 8 | wave[3];
	wave_size = (int)(0xF & wave[4]) << 8 | wave[5];

	gprint("auto vib body wave size: %d\n",wave_size);

	loop = wave_size / trans_size;
	tail = wave_size % trans_size;

	for(i=0; i<loop; i++) {
		start_addr = set_addr + i * trans_size;
		dw791x_seq_write(dw791x->mem_input, start_addr, RAM_ADDR16, (u8*)wave + 7 + i * trans_size, trans_size);
	}

	if(tail > 0) {
		start_addr = set_addr + loop * trans_size;
		dw791x_seq_write(dw791x->mem_input, start_addr, RAM_ADDR16, (u8*)wave + 7 + loop * trans_size, tail);
	}

	gprint("auto vib memory data write done!\n");

	return ret;
}

/* =====================================================================================
function : request_transfer_rtp_wave
descript : request transfer rtp wave function
			Only DW7914 devices are supported.
header   : 5byte[0xAE, size, size, size, size] total size 32bit
data	 : rtp wave data
====================================================================================== */
static int request_transfer_rtp_wave(u8* wave, u32 repeat)
{
	u8 rx[2];
	u32 ret, run, curcnt, trans_size, play_size;
	u32 empty_lock, fifo_level, fifo_size, wait_t;

	// step 0: ------------------ timer set check & clear & size read
	run = curcnt = empty_lock = fifo_level = 0;
	play_size = (u32)wave[1]<<24|(u32)wave[2]<<16|(u32)wave[3]<<8|(u32)wave[4]<<0;

	if(dw791x->device == DW7912) {
		dw791x_byte_write(dw791x->play_back, DRV_STOP);
	}
	else if(dw791x->device == DW7914) {
		dw7914_mode_set(D14_FIFO_FLUSH, BITSET);
		dw7914_mode_set(D14_MEM_MODE, RTP);
		dw791x_byte_read(DW7914_STATUS0);
		dw791x_byte_read(DW7914_STATUS1);
	}

	// step 1: ------------------ fifo set size read
	rx[0] = dw791x_byte_read(dw791x->fifo_addrh);
	rx[1] = dw791x_byte_read(dw791x->fifo_addrl);
	fifo_size = SRAM_BASE - ((u32)rx[0] << 8 | rx[1]);
	gprint("fifo area size: %dbyte\n",fifo_size);

	// step 2 : ----------------- short time play
	if(play_size < I2C_TRANS_RTP) {
		ret = dw791x_seq_write(dw791x->rtp_input, 0, RAM_ADDR8, (unsigned char*)wave + 5, play_size);
		dw791x_byte_write(dw791x->play_back, DRV_PLAY);
		gprint("rtp play done! size: %d\n",play_size);
		return ret;
	}

	while(!run)
	{
		// step 3: ------------------ fifo level check
		if(dw791x->device == DW7912)
		{
			rx[0] = dw791x_byte_read(dw791x->fifo_level);
			fifo_level = (u32)rx[0] * 64 + 64;
		}
		else if(dw791x->device == DW7914)
		{
			rx[0] = dw791x_byte_read(dw791x->fifo_level);
			rx[1] = dw791x_byte_read(dw791x->fifo_level + 1);
			fifo_level = ((u32)rx[0] << 8) | rx[1];
		}

		// step 4: ------------------ i2c transfer size define
		if((fifo_size - fifo_level) > I2C_TRANS_RTP) {
			trans_size = I2C_TRANS_RTP;
		}
		else {
			trans_size = fifo_size - fifo_level;
		}
		
		// step 5: ------------------ wave data transfer loop
		if(curcnt < play_size) 
		{
			if((curcnt + trans_size) > play_size) {
				trans_size = play_size - curcnt;
			}

			if(trans_size > 0) {
				ret = dw791x_seq_write(dw791x->rtp_input, 0, RAM_ADDR8, (unsigned char*)wave + 5 + curcnt, trans_size);	// fifo full write
				curcnt += trans_size;
			}

			if(empty_lock == 0) {
				if(fifo_level > (fifo_size / 2)) {
					empty_lock = 1;
					dw791x_byte_write(dw791x->play_back, DRV_PLAY);
				}
			}

			if(empty_lock == 1) {
				rx[0] = dw791x_byte_read(DW7914_STATUS0);
				rx[1] = dw791x_byte_read(DW7914_STATUS1);

				if((rx[0] & 0x8F) || (rx[1] & 0xFE)) {
					run = 1;
					gprint("An event occurred during rtp operation! status0:%x, status1:%x\n",rx[0], rx[1]);
					break;
				}
				if((rx[1] & 0x01) == 0) {
					run = 1;
					gprint("rtp operation stop!. status0:%x, status1:%x\n",rx[0], rx[1]);
					break;
				}
			}

			if(fifo_level > (fifo_size - fifo_size / 3))	// wait interrupt delay
			{
				wait_t = msecs_to_jiffies(10);				// set 10ms fixed
				schedule_timeout_interruptible(wait_t);
			}
		}

		// step 6: ------------------ wave data transfer done!
		else {	// play stop
			if(repeat > 1) {
				curcnt = 0;
				repeat--;
			}
			else {
				run = 1;
				gprint("The rtp operation is finished. size: %d, repeat: %d\n", curcnt, repeat);
				break;
			}
		}
	}

	return ret;
}

/* =====================================================================================
function : request_transfer_mem_wave
descript : request transfer rtp mem function
			only use binary waves.  memory addresses not included.
page	 : 12kb bin file model start page 0 ~ n
point	 : memory header call number 0: all wirte, 1: header no.1
pw_data  : bin file data pointer
size	 : bin wave size
====================================================================================== */
static int request_transfer_mem_wave(u32 page, u32 point, u8* fw_data, u32 size)
{	
	int ret=0;
	u32 i, loop, tail, wave_size, start_addr, set_addr, trans_size, fw_point;

	// setp 0: ---------------------------- dw791x memory mode set
	trans_size = I2C_TRANS_MEM;
	ret = dw791x_byte_write(dw791x->play_mode, MEM);

	if(ret < 0) return ret;

	// step 1: ---------------------------- dw791x find header data pointer
	if(point > 0) {
		set_addr = (point * 5) - 4;
		fw_point = set_addr + BIN_BASE * page;
		dw791x_seq_write(dw791x->mem_input, set_addr, RAM_ADDR16, (u8*)fw_data + fw_point, 5);

		set_addr = (u32)(fw_data[fw_point + 0]) << 8 | fw_data[fw_point + 1];
		wave_size = (u32)(0xF & fw_data[fw_point + 2]) << 8 | fw_data[fw_point + 3];
	}
	else {
		set_addr = 0;
		wave_size = BIN_BASE;
		fw_point = (1 + page) * BIN_BASE;
	}
	gprint("request trans page: %d point: %d size: %d\n",page, point, wave_size);

	// step 2: ---------------------------- dw791x find body data pointer
	loop = wave_size / trans_size;
	tail = wave_size % trans_size;
	gprint("set addr:%d loop:%d tail:%d\n", set_addr, loop, tail);

	for(i=0; i<loop; i++) {
		start_addr = set_addr + (i * trans_size);
		fw_point = start_addr + BIN_BASE * page;
		dw791x_seq_write(dw791x->mem_input, start_addr, RAM_ADDR16, (u8*)fw_data + fw_point, trans_size);
	}

	if(tail > 0) {
		start_addr = set_addr + (loop * trans_size);
		fw_point = start_addr + BIN_BASE * page;
		dw791x_seq_write(dw791x->mem_input, start_addr, RAM_ADDR16, (u8*)fw_data + fw_point, tail);
	}

	gprint("requeset firmware transfer complete!\n");

	return ret;
}

/* =====================================================================================
function : dw791x_device_init
descript : apply device default setting.
			auto detected devices model.
====================================================================================== */
static int dw791x_device_init(struct i2c_client *client)
{
	int ret=0;

	// step 0: --------------- find the device
	dw791x->device = dw791x_byte_read(DW791x_PID);

	// step 1: --------------- change the register according to the device.
	if(dw791x->device == DW7912)
	{
		dw791x->play_mode = DW7912_MODE;
		dw791x->play_back = DW7912_PLAYBACK;
		dw791x->rtp_input = DW7912_RTP_INPUT;
		dw791x->fifo_level = DW7912_RTP_INPUT;
		dw791x->mem_input = DW7912_RAM_ADDR;
		dw791x->fifo_addrh = DW7912_FIFO_ADDRH;
		dw791x->fifo_addrl = DW7912_FIFO_ADDRL;
		dw791x->version = 0x7912F001;
		dw791x_play_mode_sel(1, 0);

		snprintf(dw791x->dev_name, 8, "DW7912");
	}
	else if(dw791x->device == DW7914) 
	{
		dw791x->play_mode = DW7914_MODE;
		dw791x->play_back = DW7914_PLAYBACK;
		dw791x->rtp_input = DW7914_RTP_INPUT;
		dw791x->mem_input = DW7914_RAM_ADDR;
		dw791x->fifo_addrh = DW7914_FIFO_ADDRH;
		dw791x->fifo_addrl = DW7914_FIFO_ADDRL;
		dw791x->fifo_level = DW7914_FIFO_LEVEL;
		dw791x->version = 0x7914F002;
		dw791x_fifo_size_set(FIFO_4KB);
		dw791x_play_mode_sel(1, 0);

		snprintf(dw791x->dev_name, 8, "DW7914A");
	}
	gprint("DWA %s driver version %x\n",dw791x->dev_name, dw791x->version);

	return ret;	
}

#ifdef INT_EVENT_OPT
static struct workqueue_struct *rtp_workqueue;
static void irq_rtp_work(struct work_struct *work)
{
	dw791x_byte_write(dw791x->play_back, DRV_PLAY);
}

DECLARE_WORK(work, irq_rtp_work);

static irqreturn_t irq_rtp_handler(int irq, void *unuse)
{
	queue_work(rtp_workqueue, &work);

	return IRQ_HANDLED;
}

static int init_irq_rtp(void)
{
	int ret;

	if (gpio_request(dw791x->irq_gpio, "request_irq_gpio")) {
		gprint("GPIO request faiure: %d\n", dw791x->irq_gpio);
		return -1;
	}

	ret = gpio_direction_input(dw791x->irq_gpio);

	if(ret < 0) {
		gprint("Can't set GPIO direction, error %i\n", ret);
		gpio_free(dw791x->irq_gpio);
		return -EINVAL;
	}
	else gprint("GPIO direction input: %d\n", dw791x->irq_gpio);

	dw791x->irq_num = gpio_to_irq(dw791x->irq_gpio);

	gprint("IRQ Line: %d\n", dw791x->irq_num);

	ret = request_irq(dw791x->irq_num, (irq_handler_t)irq_rtp_handler, IRQF_TRIGGER_FALLING, "trig_interrupt", NULL);

	if(ret < 0) {
		irq_rtp_exit();
		gprint("IRQ requset error: %d\n", ret);
	}

	rtp_workqueue = create_singlethread_workqueue("rtp_work_queue");

	return ret;
}

static int irq_rtp_exit(void)
{
	free_irq(dw791x->irq_num, NULL);
	cancel_work_sync(&work);
	destroy_workqueue(rtp_workqueue);

	return 0;
}
#endif

static ssize_t enableVIB_set (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
{
	int mode=0;

	sscanf(buf, "%d", &mode);
	gprint("enableVIB_set cmd: buf=%s\n", buf);

	dw791x_play_mode_sel(mode, 0);
	return count;
}

static ssize_t enableVIB_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	int ret;

	ret = dw791x_byte_read(DW791x_PID);
	gprint("product id : %x\n", ret);

	ret = dw791x_byte_read(DW791x_STATUS);
	gprint("chip status : %x\n", ret);

	return snprintf(buf, PAGE_SIZE, "[VIB] status = %x\n", ret);
}

static ssize_t patternVIB_set (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
{
	return count;
}

static ssize_t patternVIB_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	int ret = 0;
	return ret;
}

DEVICE_ATTR(enableVIB, (S_IWUSR|S_IRUGO), enableVIB_show, enableVIB_set);
DEVICE_ATTR(patternVIB, (S_IWUSR|S_IRUGO), patternVIB_show, patternVIB_set);

static int dw791x_vibrator_sysfs_init(void)
{
	int ret = 0;
	android_vibrator_kobj = kobject_create_and_add("dongwoon_haptic_drv", NULL);

	if (android_vibrator_kobj == NULL) {
		gprint("%s:subsystem_register_failed", __func__);
	}

	ret = sysfs_create_file(android_vibrator_kobj, &dev_attr_enableVIB.attr);
	if (ret) {
		gprint("%s: sysfs_create_file enableVIB failed\n", __func__);
	}
	gprint("attribute enableVIB file register Done");

	ret = sysfs_create_file(android_vibrator_kobj, &dev_attr_patternVIB.attr);
	if (ret) {
		gprint("%s: sysfs_create_file patternVIB failed\n", __func__);
	}
	gprint("attribute patternVIB file register Done");

	return 0;
}

#ifdef CONFIG_OF
static int dw791x_parse_dt(struct i2c_client *i2c, struct dw791x_priv *pdev)
{
	struct device *dev = &i2c->dev;
	struct device_node *np = dev->of_node;

	if (!np) return -1;

	pdev->irq_gpio = of_get_named_gpio(np, "dw791x,en-gpio", 0);

	if (pdev->irq_gpio < 0) {
		gprint("Looking up %s property in node %s failed %d\n", "dw791x,en-gpio", dev->of_node->full_name, pdev->irq_gpio);
		pdev->irq_gpio = -1;
	}

	if(!gpio_is_valid(pdev->irq_gpio)) {
		gprint("enable pin(%u) is invalid\n", pdev->irq_gpio);
	}

	return 0;
}
#else
static int dw791x_parse_dt(struct i2c_client *i2c, struct dw791x_priv *pdev)
{
	return NULL;
}
#endif

static
enum led_brightness dw791x_brightness_get(struct led_classdev *cdev)
{
		return 0;
}

static void dw791x_brightness_set(struct led_classdev *cdev,
				enum led_brightness level)
{
}

static ssize_t activate_show(struct device *dev,
				struct device_attribute *attr, char *buf)
{
	return snprintf(buf, PAGE_SIZE, "%d\n", dw791x->activate);
}

/* =====================================================================================
function : dw791x_play_mode_sel
descript : select the play mode
====================================================================================== */
int dw791x_play_mode_sel(int play_mode, u32 set1)
{
	int ret = 0;

	gprint("play_mode : %d\n", play_mode);

	if(dw791x->device == DW7912) {
		switch(play_mode)
		{
			case 1:
				dw791x_byte_write(DW7912_WAVQ1, 1);
				dw791x_byte_write(dw791x->play_mode, MEM);
			break;
		}
	}
	else if(dw791x->device == DW7914) {
		switch(play_mode)
		{
			case 0: // test mode
				dw7914_autovib_set();
				dw7914_checksum(0, 0);
				dw7914_trigctrl_set(0, 0);
				dw791x_vd_clamp_set(3800);
#ifdef BST_OPT
				dw791x_bst_option(0, 0, 0);
#endif
				if(request_firmware(&dw791x->fw, FW_FILE, &dw791x->dwclient->dev) == 0) {
					gprint(" fw_name= %s fw_size= %ld\n", FW_FILE, dw791x->fw->size);
					request_transfer_mem_wave(0, 1, (u8*)dw791x->fw->data, dw791x->fw->size);
				} release_firmware(dw791x->fw);

				if(request_firmware(&dw791x->fw, RTP_FW_FILE, &dw791x->dwclient->dev) == 0) {
					gprint("fw_name= %s fw_size= %ld\n", RTP_FW_FILE, dw791x->fw->size);
					request_transfer_rtp_wave((u8*)dw791x->fw->data, 2);
				} release_firmware(dw791x->fw);
				break;

			case 1:	// haptic init code
#ifdef DW7914_COIN0832
				dw791x_vd_clamp_set(3800);
				dw791x_byte_write(0x0B, 0x05);
				dw791x_byte_write(0x0F, 0x01);
				dw791x_byte_write(0x1C, 0x03);
				dw791x_byte_write(0x1D, 0x04);
				dw791x_byte_write(0x1E, 0x0D);
				dw791x_Mem_Write((u8*)coin0832_mem1, sizeof(coin0832_mem1));
				dw791x_Mem_Write((u8*)coin0832_mem2, sizeof(coin0832_mem2));
				dw791x_Mem_Write((u8*)coin0832_mem3, sizeof(coin0832_mem3));
				dw791x_Mem_Write((u8*)coin0832_mem4, sizeof(coin0832_mem4));
				dw791x_Mem_Write((u8*)coin0832_mem5, sizeof(coin0832_mem5));
#endif
#ifdef DW7914_COIN1040
				dw791x_vd_clamp_set(3800);
				dw791x_byte_write(0x0B, 0x05);
				dw791x_byte_write(0x0F, 0x02);
				dw791x_byte_write(0x1C, 0x00);
				dw791x_byte_write(0x1D, 0x03);
				dw791x_byte_write(0x1E, 0x28);
				dw791x_Mem_Write((u8*)coin1040_mem1, sizeof(coin1040_mem1));
				dw791x_Mem_Write((u8*)coin1040_mem2, sizeof(coin1040_mem2));
				dw791x_Mem_Write((u8*)coin1040_mem3, sizeof(coin1040_mem3));
				dw791x_Mem_Write((u8*)coin1040_mem4, sizeof(coin1040_mem4));
#endif
#ifdef DW7914_GAMMA
				dw791x_vd_clamp_set(3800);
				dw791x_byte_write(0x0B, 0x05);
				dw791x_byte_write(0x0F, 0x03);
				dw791x_byte_write(0x1C, 0x00);
				dw791x_byte_write(0x1D, 0x04);
				dw791x_byte_write(0x1E, 0x28);
				dw791x_Mem_Write((u8*)gma_mem1, sizeof(gma_mem1));
				dw791x_Mem_Write((u8*)gma_mem2, sizeof(gma_mem2));
				dw791x_Mem_Write((u8*)gma_mem3, sizeof(gma_mem3));
				dw791x_Mem_Write((u8*)gma_mem4, sizeof(gma_mem4));
				dw791x_Mem_Write((u8*)gma_mem5, sizeof(gma_mem5));
				dw791x_Mem_Write((u8*)gma_mem6, sizeof(gma_mem6));
				dw791x_Mem_Write((u8*)gma_mem7, sizeof(gma_mem7));
#endif
				break;
			case 2:	// haptic ------------------------- long press
#ifdef DW7914_COIN0832
				dw791x_byte_write(0x04, 0x01);
				dw791x_byte_write(0x0B, 0x05);
				dw791x_byte_write(0x0F, 0x01);
				dw791x_byte_write(0x1E, 0x0D);
				dw791x_byte_write(dw791x->play_back, DRV_PLAY);
#endif
#ifdef DW7914_COIN1040
				dw791x_byte_write(0x04, 0x01);
				dw791x_byte_write(0x0B, 0x05);
				dw791x_byte_write(0x0F, 0x02);
				dw791x_byte_write(dw791x->play_back, DRV_PLAY);
#endif
#ifdef DW7914_GAMMA
				dw791x_byte_write(0x04, 0x01);
				dw791x_byte_write(0x0B, 0x05);
				dw791x_byte_write(0x0F, 0x03);
				dw791x_byte_write(dw791x->play_back, DRV_PLAY);
#endif
				break;				
			case 3:	// pixel -------------------------- jog dial
#ifdef DW7914_COIN0832
				dw791x_byte_write(0x04, 0x01);
				dw791x_byte_write(0x0B, 0x05);
				dw791x_byte_write(0x0F, 0x02);
				dw791x_byte_write(0x1E, 0x2C);
				dw791x_byte_write(dw791x->play_back, DRV_PLAY);
#endif
#ifdef DW7914_COIN1040
				dw791x_byte_write(0x04, 0x01);
				dw791x_byte_write(0x0B, 0x01);
				dw791x_byte_write(0x0F, 0x04);
				dw791x_byte_write(dw791x->play_back, DRV_PLAY);
#endif
#ifdef DW7914_GAMMA
				dw791x_byte_write(0x04, 0x01);
				dw791x_byte_write(0x0B, 0x01);
				dw791x_byte_write(0x0F, 0x01);
				dw791x_byte_write(dw791x->play_back, DRV_PLAY);
#endif
				break;
			case 4:	// haptic ------------------------- short press
#ifdef DW7914_COIN0832
				dw791x_byte_write(0x04, 0x01);
				dw791x_byte_write(0x0B, 0x05);
				dw791x_byte_write(0x0F, 0x05);
				dw791x_byte_write(0x1E, 0x0C);
				dw791x_byte_write(dw791x->play_back, DRV_PLAY);
#endif
#ifdef DW7914_COIN1040
				dw791x_byte_write(0x04, 0x01);
				dw791x_byte_write(0x0B, 0x01);
				dw791x_byte_write(0x0F, 0x01);
				dw791x_byte_write(dw791x->play_back, DRV_PLAY);
#endif
#ifdef DW7914_GAMMA
				dw791x_byte_write(0x04, 0x01);
				dw791x_byte_write(0x0B, 0x01);
				dw791x_byte_write(0x0F, 0x02);
				dw791x_byte_write(dw791x->play_back, DRV_PLAY);
#endif
				break;
			case 5:	// request f/w for RTP
				dw791x_vd_clamp_set(3800);
				dw791x_byte_write(0x0B, 0x00);
				if(request_firmware(&dw791x->fw, RTP_FW_FILE, &dw791x->dwclient->dev) == 0) {
					gprint("fw_name= %s fw_size= %ld\n", RTP_FW_FILE, dw791x->fw->size);
					request_transfer_rtp_wave((u8*)dw791x->fw->data, 10);	// 6.24sec play
				} release_firmware(dw791x->fw);
				break;
			case 6: // request_transfer_rtp_wave function test
				dw791x_vd_clamp_set(3800);
				dw791x_byte_write(0x0B, 0x00);
				//request_transfer_rtp_wave((u8*)dw7914_RTP_TEST_625ms, 10);	// 6.24sec play
				break;
		}
	}	

	return ret;
}

static ssize_t activate_store(struct device *dev,
					struct device_attribute *attr, const char *buf,
					size_t count)
{
	gprint("%s %s(%dms)\n", __func__, buf, dw791x->duration);

	if(buf[0]=='1')
	{
		if(dw791x->duration==10) {	// short press
			dw791x_play_mode_sel(4, 0);
		}
		else if(dw791x->duration==12) {	// deep press
			dw791x_play_mode_sel(2, 0);
		}
		else if(dw791x->duration==4) {	// jog dial
			dw791x_play_mode_sel(3, 0);
		}
	}
	else if(buf[0]=='0') {
		//dw791x_byte_write(dw791x->play_mode, RTP);
	}

	return count;
}

static ssize_t duration_show(struct device *dev,
				struct device_attribute *attr, char *buf)
{
	//read duration

	return snprintf(buf, PAGE_SIZE, "%d\n", dw791x->duration);
}

static ssize_t duration_store(struct device *dev,
					struct device_attribute *attr, const char *buf,
					size_t count)
{
	int ret;
	int val;
	ret=kstrtouint(buf, 0, &val);
	if(ret <0) {
		gprint("kstrtouint failed\n");
		return ret;
	}

	gprint("duration: %d\n", val);
	dw791x->duration=val;

	return count;
}

static ssize_t state_show(struct device *dev,
					struct device_attribute *attr, char *buf)
{
	return snprintf(buf, PAGE_SIZE, "%d\n", dw791x->state);
}

static ssize_t state_store(struct device *dev,
					struct device_attribute *attr, const char *buf,
					size_t count)
{
	return count;
}

static ssize_t rtp_input_show(struct device *dev,
					struct device_attribute *attr, char *buf)
{
	return snprintf(buf, PAGE_SIZE, "%d\n", dw791x->rtp_input_node);
}

static ssize_t rtp_input_store(struct device *dev,
					struct device_attribute *attr, const char *buf,
					size_t count)
{
	return count;
}

static ssize_t mode_show(struct device *dev,
				struct device_attribute *attr, char *buf)
{
	return 0;
}

static ssize_t mode_store(struct device *dev,
				struct device_attribute *attr, const char *buf,
				size_t count)
{
	return count;
}

static ssize_t scale_show(struct device *dev,
				struct device_attribute *attr, char *buf)
{
	return snprintf(buf, PAGE_SIZE, "%d\n", dw791x->scale);
}

static ssize_t scale_store(struct device *dev,
				struct device_attribute *attr, const char *buf,
				size_t count)
{
	return count;
}

static ssize_t ctrl_loop_show(struct device *dev,
				struct device_attribute *attr, char *buf)
{
	return snprintf(buf, PAGE_SIZE, "%d\n", dw791x->ctrl_loop);
}

static ssize_t ctrl_loop_store(struct device *dev,
				struct device_attribute *attr, const char *buf,
				size_t count)
{
	return count;
}

static ssize_t set_sequencer_store(struct device *dev,
				struct device_attribute *attr,
				const char *buf, size_t count)
{
	return count;
}

static ssize_t lp_trigger_effect_show(struct device *dev,
				struct device_attribute *attr, char *buf)
{
	return snprintf(buf, PAGE_SIZE, "%d\n", dw791x->lp_trigger_effect);
}

static ssize_t lp_trigger_effect_store(struct device *dev,
				struct device_attribute *attr,
				const char *buf, size_t count)
{
	return count;
}

static struct device_attribute dw791x_haptics_attrs[] = {
	__ATTR(activate, 0664, activate_show, activate_store),
	__ATTR(duration, 0664, duration_show, duration_store),
	__ATTR(state, 0664, state_show, state_store),
	__ATTR(rtp_input, 0664, rtp_input_show, rtp_input_store),
	__ATTR(mode, 0664, mode_show, mode_store),
	__ATTR(scale, 0664, scale_show, scale_store),
	__ATTR(ctrl_loop, 0664, ctrl_loop_show, ctrl_loop_store),
	__ATTR(set_sequencer, 0664, NULL, set_sequencer_store),
	__ATTR(lp_trigger_effect, 0664, lp_trigger_effect_show, lp_trigger_effect_store),
};

static int dw791x_probe(struct i2c_client *client, const struct i2c_device_id *id)
{
	int ret = -1;
	int i=0;

	gprint("Haptic driver probe start....V1.00\n");

	dw791x = kzalloc(sizeof(struct dw791x_priv), GFP_KERNEL);

	if (dw791x == NULL) {
		gprint("kzalloc failed\n");
		return -ENOMEM;
	}

	ret = dw791x_parse_dt(client, dw791x);

	i2c_set_clientdata(client, dw791x);

	mutex_init(&dw791x->dev_lock);

	dw791x->dwclient = client;
	dw791x_vibrator_sysfs_init();
	mdelay(100);

	dw791x_device_init(client);

	dw791x->cdev.name="vibrator";
	dw791x->cdev.brightness_get = dw791x_brightness_get;
	dw791x->cdev.brightness_set = dw791x_brightness_set;
	dw791x->cdev.max_brightness = 100;

	ret = devm_led_classdev_register(&dw791x->dwclient->dev, &dw791x->cdev);

	if (ret < 0) {
		gprint("%s devm_led_classdev_register failed\n", __func__);
		return -1;
	}

	dw791x->activate=0;
	dw791x->duration=0;
	dw791x->state=0;
	dw791x->mode=0;
	dw791x->set_sequencer=0;
	dw791x->scale=0;
	dw791x->ctrl_loop=0;
	dw791x->lp_trigger_effect=0;

	for(i=0;i<ARRAY_SIZE(dw791x_haptics_attrs);i++) {
		ret = sysfs_create_file(&dw791x->cdev.dev->kobj, &dw791x_haptics_attrs[i].attr);
		if(ret < 0) {
			gprint("sysfs create failed\n");
			return -1;
		}
	}

	// --- start gpio init
#ifdef INT_EVENT_OPT
	init_irq_rtp();
#else
	mdelay(10);
	ret = gpio_direction_output(dw791x->irq_gpio, 0);
	mdelay(10);
	ret = gpio_direction_output(dw791x->irq_gpio, 1);

	if (ret < 0) {
		dev_err(&client->dev, "enable pin level set failed");
		ret = -EIO;
		gpio_free(dw791x->irq_gpio);
		gprint("enable pin open failed: %d\n", ret);
	}
	else {
		gprint("enalbe pin set complete!");
	}
#endif

	gprint("%s probe success!\n", dw791x->dev_name);

	return 0;
}

static int dw791x_remove(struct i2c_client *client)
{
	struct dw791x_priv *dw791x = i2c_get_clientdata(client);

	gpio_free(dw791x->irq_gpio);
	free_irq(dw791x->irq_num, NULL);
	i2c_set_clientdata(client, NULL);
	mutex_destroy(&dw791x->dev_lock);
	kfree(dw791x);

	return 0;
}

#ifdef CONFIG_PM
static int dw791x_suspend(struct device *dev)
{
	return 0;
}

static int dw791x_resume(struct device *dev)
{
	return 0;
}

static SIMPLE_DEV_PM_OPS(dw791x_pm_ops, dw791x_suspend, dw791x_resume);

#define DW7912_VIBRATOR_PM_OPS (&dw791x_pm_ops)
#else
#define DW7912_VIBRATOR_PM_OPS NULL
#endif

MODULE_DEVICE_TABLE(i2c, dw791x_drv_id);

static struct i2c_driver dw791x_i2c_driver = {
	.probe = dw791x_probe,
	.remove = dw791x_remove,
	.id_table = dw791x_drv_id,
	.driver = {
		.name = "dw791x-codec",
		.owner = THIS_MODULE,
#ifdef CONFIG_OF
		.of_match_table = of_match_ptr(dw791x_i2c_dt_ids),
#endif
#ifdef CONFIG_PM
		.pm	= DW7912_VIBRATOR_PM_OPS,
#endif
	},
};

static int __init dw791x_modinit(void)
{
	int ret;

	ret = i2c_add_driver(&dw791x_i2c_driver);

	if (ret)
		gprint("Failed to register dw791x I2C driver: %d\n", ret);
	else 
		gprint("Vibration motor driver Initializes the I2C interface.\n");

	return ret;
}

late_initcall(dw791x_modinit);

static void __exit dw791x_exit(void)
{
	i2c_del_driver(&dw791x_i2c_driver);
	gprint("Vibration motor driver I2C interface remove.!\n");
	sysfs_remove_file(android_vibrator_kobj, &dev_attr_enableVIB.attr);
	kobject_del(android_vibrator_kobj);
}

module_exit(dw791x_exit);
MODULE_DESCRIPTION("Vibrator DW791x codec driver");
MODULE_AUTHOR("jks8051@dwanatech.com");
MODULE_LICENSE("GPL/BSD Dual");
