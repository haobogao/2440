cmd_u-boot.lds := arm-linux-gcc -E -Wp,-MD,./.u-boot.lds.d -D__KERNEL__ -D__UBOOT__   -D__ARM__ -marm -mno-thumb-interwork  -mabi=aapcs-linux  -mword-relocations  -fno-pic  -ffunction-sections -fdata-sections -fno-common -ffixed-r9  -msoft-float   -pipe -march=armv4t   -Iinclude   -I./arch/arm/include -include ./include/linux/kconfig.h  -nostdinc -isystem /home/haobo/work/2440/tools/toolschain/bin/../lib/gcc/arm-none-linux-gnueabi/4.3.2/include -include ./include/u-boot/u-boot.lds.h -DCPUDIR=arch/arm/cpu/arm920t  -ansi -D__ASSEMBLY__ -x assembler-with-cpp -P -o u-boot.lds arch/arm/cpu/u-boot.lds

source_u-boot.lds := arch/arm/cpu/u-boot.lds

deps_u-boot.lds := \
    $(wildcard include/config/cmdline.h) \
    $(wildcard include/config/armv7/secure/base.h) \
    $(wildcard include/config/armv7/nonsec.h) \
  include/u-boot/u-boot.lds.h \
  include/config.h \
    $(wildcard include/config/boarddir.h) \
  include/config_defaults.h \
    $(wildcard include/config/defaults/h/.h) \
    $(wildcard include/config/bootm/linux.h) \
    $(wildcard include/config/bootm/netbsd.h) \
    $(wildcard include/config/bootm/plan9.h) \
    $(wildcard include/config/bootm/rtems.h) \
    $(wildcard include/config/bootm/vxworks.h) \
    $(wildcard include/config/gzip.h) \
    $(wildcard include/config/zlib.h) \
    $(wildcard include/config/partitions.h) \
  include/config_uncmd_spl.h \
    $(wildcard include/config/uncmd/spl/h//.h) \
    $(wildcard include/config/spl/build.h) \
    $(wildcard include/config/spl/dm.h) \
    $(wildcard include/config/dm/serial.h) \
    $(wildcard include/config/dm/gpio.h) \
    $(wildcard include/config/dm/i2c.h) \
    $(wildcard include/config/dm/spi.h) \
    $(wildcard include/config/dm/warn.h) \
    $(wildcard include/config/dm/stdio.h) \
  include/configs/smdk2410.h \
    $(wildcard include/config/h.h) \
    $(wildcard include/config/s3c24x0.h) \
    $(wildcard include/config/s3c2410.h) \
    $(wildcard include/config/smdk2410.h) \
    $(wildcard include/config/sys/text/base.h) \
    $(wildcard include/config/sys/arm/cache/writethrough.h) \
    $(wildcard include/config/sys/clk/freq.h) \
    $(wildcard include/config/cmdline/tag.h) \
    $(wildcard include/config/setup/memory/tags.h) \
    $(wildcard include/config/initrd/tag.h) \
    $(wildcard include/config/cs8900.h) \
    $(wildcard include/config/cs8900/base.h) \
    $(wildcard include/config/cs8900/bus16.h) \
    $(wildcard include/config/s3c24x0/serial.h) \
    $(wildcard include/config/serial1.h) \
    $(wildcard include/config/usb/ohci.h) \
    $(wildcard include/config/usb/ohci/s3c24xx.h) \
    $(wildcard include/config/usb/keyboard.h) \
    $(wildcard include/config/usb/storage.h) \
    $(wildcard include/config/dos/partition.h) \
    $(wildcard include/config/rtc/s3c24x0.h) \
    $(wildcard include/config/baudrate.h) \
    $(wildcard include/config/bootp/bootfilesize.h) \
    $(wildcard include/config/bootp/bootpath.h) \
    $(wildcard include/config/bootp/gateway.h) \
    $(wildcard include/config/bootp/hostname.h) \
    $(wildcard include/config/cmd/bsp.h) \
    $(wildcard include/config/cmd/date.h) \
    $(wildcard include/config/cmd/nand.h) \
    $(wildcard include/config/cmd/reginfo.h) \
    $(wildcard include/config/cmdline/editing.h) \
    $(wildcard include/config/bootdelay.h) \
    $(wildcard include/config/boot/retry/time.h) \
    $(wildcard include/config/reset/to/retry.h) \
    $(wildcard include/config/zero/bootdelay/check.h) \
    $(wildcard include/config/netmask.h) \
    $(wildcard include/config/ipaddr.h) \
    $(wildcard include/config/serverip.h) \
    $(wildcard include/config/cmd/kgdb.h) \
    $(wildcard include/config/kgdb/baudrate.h) \
    $(wildcard include/config/sys/longhelp.h) \
    $(wildcard include/config/sys/cbsize.h) \
    $(wildcard include/config/sys/pbsize.h) \
    $(wildcard include/config/sys/prompt.h) \
    $(wildcard include/config/sys/maxargs.h) \
    $(wildcard include/config/sys/bargsize.h) \
    $(wildcard include/config/display/cpuinfo.h) \
    $(wildcard include/config/sys/memtest/start.h) \
    $(wildcard include/config/sys/memtest/end.h) \
    $(wildcard include/config/sys/load/addr.h) \
    $(wildcard include/config/bzip2.h) \
    $(wildcard include/config/lzo.h) \
    $(wildcard include/config/lzma.h) \
    $(wildcard include/config/nr/dram/banks.h) \
    $(wildcard include/config/sys/flash/base.h) \
    $(wildcard include/config/sys/flash/cfi.h) \
    $(wildcard include/config/flash/cfi/driver.h) \
    $(wildcard include/config/flash/cfi/legacy.h) \
    $(wildcard include/config/sys/flash/legacy/512kx16.h) \
    $(wildcard include/config/flash/show/progress.h) \
    $(wildcard include/config/sys/max/flash/banks.h) \
    $(wildcard include/config/sys/flash/banks/list.h) \
    $(wildcard include/config/sys/max/flash/sect.h) \
    $(wildcard include/config/env/addr.h) \
    $(wildcard include/config/env/is/in/flash.h) \
    $(wildcard include/config/env/size.h) \
    $(wildcard include/config/env/overwrite.h) \
    $(wildcard include/config/sys/malloc/len.h) \
    $(wildcard include/config/sys/monitor/len.h) \
    $(wildcard include/config/sys/monitor/base.h) \
    $(wildcard include/config/nand/s3c2410.h) \
    $(wildcard include/config/sys/s3c2410/nand/hwecc.h) \
    $(wildcard include/config/sys/max/nand/device.h) \
    $(wildcard include/config/sys/nand/base.h) \
    $(wildcard include/config/cmd/ubi.h) \
    $(wildcard include/config/cmd/ubifs.h) \
    $(wildcard include/config/cmd/mtdparts.h) \
    $(wildcard include/config/mtd/device.h) \
    $(wildcard include/config/mtd/partitions.h) \
    $(wildcard include/config/yaffs2.h) \
    $(wildcard include/config/rbtree.h) \
    $(wildcard include/config/sys/sdram/base.h) \
    $(wildcard include/config/sys/init/sp/addr.h) \
    $(wildcard include/config/board/early/init/f.h) \
  arch/arm/include/asm/config.h \
    $(wildcard include/config/h/.h) \
    $(wildcard include/config/lmb.h) \
    $(wildcard include/config/sys/boot/ramdisk/high.h) \
    $(wildcard include/config/arm64.h) \
    $(wildcard include/config/phys/64bit.h) \
    $(wildcard include/config/static/rela.h) \
    $(wildcard include/config/ls102xa.h) \
    $(wildcard include/config/cpu/pxa27x.h) \
    $(wildcard include/config/cpu/monahans.h) \
    $(wildcard include/config/cpu/pxa25x.h) \
    $(wildcard include/config/fsl/layerscape.h) \
  include/config_fallbacks.h \
    $(wildcard include/config/fallbacks/h.h) \
    $(wildcard include/config/spl.h) \
    $(wildcard include/config/spl/pad/to.h) \
    $(wildcard include/config/spl/max/size.h) \
    $(wildcard include/config/sys/baudrate/table.h) \
    $(wildcard include/config/cmd/fat.h) \
    $(wildcard include/config/fs/fat.h) \
    $(wildcard include/config/cmd/ext4.h) \
    $(wildcard include/config/cmd/ext2.h) \
    $(wildcard include/config/fs/ext4.h) \
    $(wildcard include/config/cmd/ext4/write.h) \
    $(wildcard include/config/ext4/write.h) \
    $(wildcard include/config/cmd/ide.h) \
    $(wildcard include/config/cmd/sata.h) \
    $(wildcard include/config/cmd/scsi.h) \
    $(wildcard include/config/cmd/usb.h) \
    $(wildcard include/config/cmd/part.h) \
    $(wildcard include/config/cmd/gpt.h) \
    $(wildcard include/config/mmc.h) \
    $(wildcard include/config/systemace.h) \
    $(wildcard include/config/sandbox.h) \
    $(wildcard include/config/partition/uuids.h) \
    $(wildcard include/config/efi/partition.h) \
    $(wildcard include/config/random/uuid.h) \
    $(wildcard include/config/cmd/uuid.h) \
    $(wildcard include/config/bootp/pxe.h) \
    $(wildcard include/config/lib/uuid.h) \
    $(wildcard include/config/lib/rand.h) \
    $(wildcard include/config/lib/hw/rand.h) \
    $(wildcard include/config/api.h) \
    $(wildcard include/config/lcd.h) \
    $(wildcard include/config/cmd/bmp.h) \
    $(wildcard include/config/fit/signature.h) \
    $(wildcard include/config/image/format/legacy.h) \
    $(wildcard include/config/disable/image/legacy.h) \
    $(wildcard include/config/sys/i2c.h) \
    $(wildcard include/config/menu.h) \

u-boot.lds: $(deps_u-boot.lds)

$(deps_u-boot.lds):
