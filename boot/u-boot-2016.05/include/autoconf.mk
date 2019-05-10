CONFIG_USB_OHCI=y
CONFIG_BOOTM_NETBSD=y
CONFIG_BOARD_EARLY_INIT_F=y
CONFIG_SYS_CLK_FREQ=12000000
CONFIG_BOOTM_VXWORKS=y
CONFIG_RTC_S3C24X0=y
CONFIG_CMD_MTDPARTS=y
CONFIG_SYS_FLASH_LEGACY_512Kx16=y
CONFIG_SYS_MAX_NAND_DEVICE=y
CONFIG_SYS_LONGHELP=y
CONFIG_IS_MODULE(option)="config_enabled(CONFIG_VAL(option ##_MODULE))"
CONFIG_SYS_LOAD_ADDR=0x30800000
CONFIG_BOOTDELAY=5
CONFIG_SYS_NAND_BASE=0x4E000000
CONFIG_SYS_HELP_CMD_WIDTH=8
CONFIG_NR_DRAM_BANKS=y
CONFIG_FS_FAT=y
CONFIG_BOOTM_RTEMS=y
CONFIG_SYS_CBSIZE=256
CONFIG_CMD_UBI=y
CONFIG_SYS_MONITOR_LEN="(448 * 1024)"
CONFIG_BOOTM_LINUX=y
CONFIG_BOOTP_GATEWAY=y
CONFIG_CMD_REGINFO=y
CONFIG_MTD_PARTITIONS=y
CONFIG_RESET_TO_RETRY=y
CONFIG_SMDK2410=y
CONFIG_ZERO_BOOTDELAY_CHECK=y
CONFIG_ENV_OVERWRITE=y
CONFIG_ENV_SIZE=0x10000
CONFIG_SYS_MALLOC_LEN="(4 * 1024 * 1024)"
CONFIG_INITRD_TAG=y
CONFIG_CS8900=y
CONFIG_SYS_S3C2410_NAND_HWECC=y
CONFIG_SYS_FLASH_BANKS_LIST="{ CONFIG_SYS_FLASH_BASE }"
CONFIG_NAND_S3C2410=y
CONFIG_SYS_TEXT_BASE=0x0
CONFIG_SYS_DEF_EEPROM_ADDR=0
CONFIG_ENV_SECT_SIZE=$(CONFIG_ENV_SIZE)
CONFIG_SYS_BARGSIZE=$(CONFIG_SYS_CBSIZE)
CONFIG_BOOTM_PLAN9=y
CONFIG_IS_BUILTIN(option)="config_enabled(CONFIG_VAL(option))"
CONFIG_S3C2410=y
CONFIG_CMD_NAND=y
CONFIG_ENV_ADDR="(CONFIG_SYS_FLASH_BASE + 0x070000)"
CONFIG_LZMA=y
CONFIG_CS8900_BUS16=y
CONFIG_SYS_MAXARGS=16
CONFIG_IPADDR="10.0.0.110"
CONFIG_SYS_PBSIZE="(CONFIG_SYS_CBSIZE + sizeof(CONFIG_SYS_PROMPT)+16)"
CONFIG_BOOTP_HOSTNAME=y
CONFIG_BOARDDIR="board/samsung/smdk2410"
CONFIG_YAFFS2=y
CONFIG_CMDLINE_EDITING=y
CONFIG_FLASH_CFI_DRIVER=y
CONFIG_SYS_BOOT_RAMDISK_HIGH=y
CONFIG_ZLIB=y
CONFIG_S3C24X0=y
CONFIG_FLASH_CFI_LEGACY=y
CONFIG_BOOTP_BOOTFILESIZE=y
CONFIG_DOS_PARTITION=y
CONFIG_GZIP=y
CONFIG_BZIP2=y
CONFIG_SYS_BAUDRATE_TABLE="{ 9600, 19200, 38400, 57600, 115200 }"
CONFIG_VAL(option)="config_val(option)"
CONFIG_SYS_SUPPORT_64BIT_DATA=y
CONFIG_ENV_IS_IN_FLASH=y
CONFIG_SYS_SDRAM_BASE="PHYS_SDRAM_1"
CONFIG_IMAGE_FORMAT_LEGACY=y
CONFIG_USB_OHCI_S3C24XX=y
CONFIG_SYS_MONITOR_BASE=$(CONFIG_SYS_FLASH_BASE)
CONFIG_S3C24X0_SERIAL=y
CONFIG_SYS_INIT_SP_ADDR="(CONFIG_SYS_SDRAM_BASE + 0x1000 - GENERATED_GBL_DATA_SIZE)"
CONFIG_ENV_OFFSET="(CONFIG_ENV_ADDR - CONFIG_SYS_FLASH_BASE)"
CONFIG_BAUDRATE=115200
CONFIG_NETMASK="255.255.255.0"
CONFIG_CMDLINE_TAG=y
CONFIG_BOOT_RETRY_TIME="-1"
CONFIG_SYS_FLASH_CFI=y
CONFIG_PARTITIONS=y
CONFIG_SYS_MEMTEST_END=0x33F00000
CONFIG_CMD_UBIFS=y
CONFIG_CMD_DATE=y
CONFIG_FS_EXT4=y
CONFIG_SYS_FLASH_BASE="PHYS_FLASH_1"
CONFIG_SYS_MAX_FLASH_BANKS=y
CONFIG_MTD_DEVICE=y
CONFIG_SYS_ARM_CACHE_WRITETHROUGH=y
CONFIG_BOOTP_BOOTPATH=y
CONFIG_USB_STORAGE=y
CONFIG_DISPLAY_CPUINFO=y
CONFIG_SETUP_MEMORY_TAGS=y
CONFIG_SERIAL1=y
CONFIG_SYS_MEMTEST_START=0x30000000
CONFIG_LMB=y
CONFIG_USB_KEYBOARD=y
CONFIG_RBTREE=y
CONFIG_CS8900_BASE=0x19000300
CONFIG_SYS_MAX_FLASH_SECT="(19)"
CONFIG_IS_ENABLED(option)="(config_enabled(CONFIG_VAL(option)) || config_enabled(CONFIG_VAL(option ##_MODULE)))"
CONFIG_SERVERIP="10.0.0.1"
CONFIG_FLASH_SHOW_PROGRESS=45
CONFIG_LZO=y
CONFIG_CMD_BSP=y