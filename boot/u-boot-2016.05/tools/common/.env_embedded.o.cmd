cmd_tools/common/env_embedded.o := cc -Wp,-MD,tools/common/.env_embedded.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -include ./include/libfdt_env.h -idirafterinclude -idirafter./arch/arm/include -I./lib/libfdt -I./tools -DCONFIG_SYS_TEXT_BASE=0x0 -DUSE_HOSTCC -D__KERNEL_STRICT_NAMES -D_GNU_SOURCE  -c -o tools/common/env_embedded.o tools/common/env_embedded.c

source_tools/common/env_embedded.o := tools/common/env_embedded.c

deps_tools/common/env_embedded.o := \
  /usr/include/stdc-predef.h \
  include/libfdt_env.h \
  include/compiler.h \
    $(wildcard include/config/use/stdint.h) \
  /usr/lib/gcc/x86_64-linux-gnu/7/include/stddef.h \
  /usr/lib/gcc/x86_64-linux-gnu/7/include/stdint.h \
  /usr/include/stdint.h \
  /usr/include/x86_64-linux-gnu/bits/libc-header-start.h \
  /usr/include/features.h \
  /usr/include/x86_64-linux-gnu/sys/cdefs.h \
  /usr/include/x86_64-linux-gnu/bits/wordsize.h \
  /usr/include/x86_64-linux-gnu/bits/long-double.h \
  /usr/include/x86_64-linux-gnu/gnu/stubs.h \
  /usr/include/x86_64-linux-gnu/gnu/stubs-64.h \
  /usr/include/x86_64-linux-gnu/bits/types.h \
  /usr/include/x86_64-linux-gnu/bits/typesizes.h \
  /usr/include/x86_64-linux-gnu/bits/wchar.h \
  /usr/include/x86_64-linux-gnu/bits/stdint-intn.h \
  /usr/include/x86_64-linux-gnu/bits/stdint-uintn.h \
  /usr/include/errno.h \
  /usr/include/x86_64-linux-gnu/bits/errno.h \
  /usr/include/linux/errno.h \
  /usr/include/x86_64-linux-gnu/asm/errno.h \
  /usr/include/asm-generic/errno.h \
  /usr/include/asm-generic/errno-base.h \
  /usr/include/stdlib.h \
  /usr/include/x86_64-linux-gnu/bits/waitflags.h \
  /usr/include/x86_64-linux-gnu/bits/waitstatus.h \
  /usr/include/x86_64-linux-gnu/bits/floatn.h \
  /usr/include/x86_64-linux-gnu/bits/floatn-common.h \
  /usr/include/x86_64-linux-gnu/bits/types/locale_t.h \
  /usr/include/x86_64-linux-gnu/bits/types/__locale_t.h \
  /usr/include/x86_64-linux-gnu/sys/types.h \
  /usr/include/x86_64-linux-gnu/bits/types/clock_t.h \
  /usr/include/x86_64-linux-gnu/bits/types/clockid_t.h \
  /usr/include/x86_64-linux-gnu/bits/types/time_t.h \
  /usr/include/x86_64-linux-gnu/bits/types/timer_t.h \
  /usr/include/endian.h \
  /usr/include/x86_64-linux-gnu/bits/endian.h \
  /usr/include/x86_64-linux-gnu/bits/byteswap.h \
  /usr/include/x86_64-linux-gnu/bits/byteswap-16.h \
  /usr/include/x86_64-linux-gnu/bits/uintn-identity.h \
  /usr/include/x86_64-linux-gnu/sys/select.h \
  /usr/include/x86_64-linux-gnu/bits/select.h \
  /usr/include/x86_64-linux-gnu/bits/types/sigset_t.h \
  /usr/include/x86_64-linux-gnu/bits/types/__sigset_t.h \
  /usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h \
  /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h \
  /usr/include/x86_64-linux-gnu/bits/select2.h \
  /usr/include/x86_64-linux-gnu/sys/sysmacros.h \
  /usr/include/x86_64-linux-gnu/bits/sysmacros.h \
  /usr/include/x86_64-linux-gnu/bits/pthreadtypes.h \
  /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h \
  /usr/include/x86_64-linux-gnu/bits/pthreadtypes-arch.h \
  /usr/include/alloca.h \
  /usr/include/x86_64-linux-gnu/bits/stdlib-bsearch.h \
  /usr/include/x86_64-linux-gnu/bits/stdlib-float.h \
  /usr/include/x86_64-linux-gnu/bits/stdlib.h \
  /usr/include/stdio.h \
  /usr/include/x86_64-linux-gnu/bits/types/__FILE.h \
  /usr/include/x86_64-linux-gnu/bits/types/FILE.h \
  /usr/include/x86_64-linux-gnu/bits/libio.h \
  /usr/include/x86_64-linux-gnu/bits/_G_config.h \
    $(wildcard include/config/h.h) \
  /usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h \
  /usr/lib/gcc/x86_64-linux-gnu/7/include/stdarg.h \
  /usr/include/x86_64-linux-gnu/bits/stdio_lim.h \
  /usr/include/x86_64-linux-gnu/bits/sys_errlist.h \
  /usr/include/x86_64-linux-gnu/bits/stdio.h \
  /usr/include/x86_64-linux-gnu/bits/stdio2.h \
  /usr/include/string.h \
  /usr/include/strings.h \
  /usr/include/x86_64-linux-gnu/bits/strings_fortified.h \
  /usr/include/x86_64-linux-gnu/bits/string_fortified.h \
  /usr/include/x86_64-linux-gnu/sys/mman.h \
  /usr/include/x86_64-linux-gnu/bits/mman.h \
  /usr/include/x86_64-linux-gnu/bits/mman-linux.h \
  /usr/include/x86_64-linux-gnu/bits/mman-shared.h \
  /usr/include/fcntl.h \
  /usr/include/x86_64-linux-gnu/bits/fcntl.h \
  /usr/include/x86_64-linux-gnu/bits/fcntl-linux.h \
  /usr/include/x86_64-linux-gnu/bits/types/struct_iovec.h \
  /usr/include/linux/falloc.h \
  /usr/include/x86_64-linux-gnu/bits/stat.h \
  /usr/include/x86_64-linux-gnu/bits/fcntl2.h \
  /usr/include/byteswap.h \
  /usr/include/time.h \
  /usr/include/x86_64-linux-gnu/bits/time.h \
  /usr/include/x86_64-linux-gnu/bits/timex.h \
  /usr/include/x86_64-linux-gnu/bits/types/struct_tm.h \
  /usr/include/x86_64-linux-gnu/bits/types/struct_itimerspec.h \
  include/linux/types.h \
    $(wildcard include/config/uid16.h) \
  /usr/include/linux/posix_types.h \
  /usr/include/linux/stddef.h \
  /usr/include/x86_64-linux-gnu/asm/posix_types.h \
  /usr/include/x86_64-linux-gnu/asm/posix_types_64.h \
  /usr/include/asm-generic/posix_types.h \
  /usr/include/x86_64-linux-gnu/asm/bitsperlong.h \
  /usr/include/asm-generic/bitsperlong.h \
    $(wildcard include/config/64bit.h) \
  /usr/include/x86_64-linux-gnu/asm/types.h \
  /usr/include/asm-generic/types.h \
  /usr/include/asm-generic/int-ll64.h \
  /usr/lib/gcc/x86_64-linux-gnu/7/include/stdbool.h \
  tools/../common/env_embedded.c \
    $(wildcard include/config/build/envcrc.h) \
    $(wildcard include/config/sys/use/ppcenv.h) \
    $(wildcard include/config/env/addr/redund.h) \
    $(wildcard include/config/env/offset.h) \
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
    $(wildcard include/config/cmdline.h) \
    $(wildcard include/config/menu.h) \
  include/environment.h \
    $(wildcard include/config/env/offset/redund.h) \
    $(wildcard include/config/env/sect/size.h) \
    $(wildcard include/config/env/size/redund.h) \
    $(wildcard include/config/sys/redundand/environment.h) \
    $(wildcard include/config/env/is/embedded.h) \
    $(wildcard include/config/env/is/in/mmc.h) \
    $(wildcard include/config/env/is/in/nand.h) \
    $(wildcard include/config/env/offset/oob.h) \
    $(wildcard include/config/env/is/in/ubi.h) \
    $(wildcard include/config/env/ubi/part.h) \
    $(wildcard include/config/env/ubi/volume.h) \
    $(wildcard include/config/env/ubi/volume/redund.h) \
    $(wildcard include/config/env/is/in/onenand.h) \
    $(wildcard include/config/env/is/in/spi/flash.h) \
    $(wildcard include/config/cmd/saveenv.h) \
    $(wildcard include/config/env/is/nowhere.h) \
    $(wildcard include/config/env/aes.h) \
    $(wildcard include/config/needs/manual/reloc.h) \
    $(wildcard include/config/sys/mmc/env/part.h) \
  include/compiler.h \
  include/env_attr.h \
  include/env_callback.h \
    $(wildcard include/config/env/callback/list/static.h) \
    $(wildcard include/config/silent/console.h) \
    $(wildcard include/config/splashimage/guard.h) \
    $(wildcard include/config/regex.h) \
    $(wildcard include/config/cmd/dns.h) \
    $(wildcard include/config/net.h) \
  include/env_flags.h \
    $(wildcard include/config/cmd/net.h) \
    $(wildcard include/config/env/flags/list/static.h) \
    $(wildcard include/config/overwrite/ethaddr/once.h) \
    $(wildcard include/config/cmd/env/flags.h) \
  include/linker_lists.h \
  include/linux/compiler.h \
    $(wildcard include/config/sparse/rcu/pointer.h) \
    $(wildcard include/config/trace/branch/profiling.h) \
    $(wildcard include/config/profile/all/branches.h) \
    $(wildcard include/config/kasan.h) \
    $(wildcard include/config/enable/must/check.h) \
    $(wildcard include/config/enable/warn/deprecated.h) \
    $(wildcard include/config/kprobes.h) \
  /usr/include/search.h \
  include/linux/stringify.h \

tools/common/env_embedded.o: $(deps_tools/common/env_embedded.o)

$(deps_tools/common/env_embedded.o):
