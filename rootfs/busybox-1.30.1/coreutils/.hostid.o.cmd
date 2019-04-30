cmd_coreutils/hostid.o := arm-linux-gcc -Wp,-MD,coreutils/.hostid.o.d   -std=gnu99 -Iinclude -Ilibbb  -include include/autoconf.h -D_GNU_SOURCE -DNDEBUG -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D"BB_VER=KBUILD_STR(1.30.1)"  -Wall -Wshadow -Wwrite-strings -Wundef -Wstrict-prototypes -Wunused -Wunused-parameter -Wunused-function -Wunused-value -Wmissing-prototypes -Wmissing-declarations -Wno-format-security -Wdeclaration-after-statement -Wold-style-definition -fno-builtin-strlen -finline-limit=0 -fomit-frame-pointer -ffunction-sections -fdata-sections -fno-guess-branch-probability -funsigned-char -static-libgcc -falign-functions=1 -falign-jumps=1 -falign-labels=1 -falign-loops=1 -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-builtin-printf -Os -march=armv4t    -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(hostid)"  -D"KBUILD_MODNAME=KBUILD_STR(hostid)" -c -o coreutils/hostid.o coreutils/hostid.c

deps_coreutils/hostid.o := \
  coreutils/hostid.c \
    $(wildcard include/config/hostid.h) \
  include/libbb.h \
    $(wildcard include/config/feature/shadowpasswds.h) \
    $(wildcard include/config/use/bb/shadow.h) \
    $(wildcard include/config/selinux.h) \
    $(wildcard include/config/feature/utmp.h) \
    $(wildcard include/config/locale/support.h) \
    $(wildcard include/config/use/bb/pwd/grp.h) \
    $(wildcard include/config/lfs.h) \
    $(wildcard include/config/feature/buffers/go/on/stack.h) \
    $(wildcard include/config/feature/buffers/go/in/bss.h) \
    $(wildcard include/config/feature/verbose.h) \
    $(wildcard include/config/feature/etc/services.h) \
    $(wildcard include/config/feature/ipv6.h) \
    $(wildcard include/config/feature/seamless/xz.h) \
    $(wildcard include/config/feature/seamless/lzma.h) \
    $(wildcard include/config/feature/seamless/bz2.h) \
    $(wildcard include/config/feature/seamless/gz.h) \
    $(wildcard include/config/feature/seamless/z.h) \
    $(wildcard include/config/float/duration.h) \
    $(wildcard include/config/feature/check/names.h) \
    $(wildcard include/config/feature/prefer/applets.h) \
    $(wildcard include/config/long/opts.h) \
    $(wildcard include/config/feature/pidfile.h) \
    $(wildcard include/config/feature/syslog.h) \
    $(wildcard include/config/feature/individual.h) \
    $(wildcard include/config/ash.h) \
    $(wildcard include/config/sh/is/ash.h) \
    $(wildcard include/config/bash/is/ash.h) \
    $(wildcard include/config/hush.h) \
    $(wildcard include/config/sh/is/hush.h) \
    $(wildcard include/config/bash/is/hush.h) \
    $(wildcard include/config/echo.h) \
    $(wildcard include/config/printf.h) \
    $(wildcard include/config/test.h) \
    $(wildcard include/config/test1.h) \
    $(wildcard include/config/test2.h) \
    $(wildcard include/config/kill.h) \
    $(wildcard include/config/killall.h) \
    $(wildcard include/config/killall5.h) \
    $(wildcard include/config/chown.h) \
    $(wildcard include/config/ls.h) \
    $(wildcard include/config/xxx.h) \
    $(wildcard include/config/route.h) \
    $(wildcard include/config/feature/hwib.h) \
    $(wildcard include/config/desktop.h) \
    $(wildcard include/config/feature/crond/d.h) \
    $(wildcard include/config/feature/setpriv/capabilities.h) \
    $(wildcard include/config/run/init.h) \
    $(wildcard include/config/feature/securetty.h) \
    $(wildcard include/config/pam.h) \
    $(wildcard include/config/use/bb/crypt.h) \
    $(wildcard include/config/feature/adduser/to/group.h) \
    $(wildcard include/config/feature/del/user/from/group.h) \
    $(wildcard include/config/ioctl/hex2str/error.h) \
    $(wildcard include/config/feature/editing.h) \
    $(wildcard include/config/feature/editing/history.h) \
    $(wildcard include/config/feature/editing/savehistory.h) \
    $(wildcard include/config/feature/tab/completion.h) \
    $(wildcard include/config/feature/username/completion.h) \
    $(wildcard include/config/feature/editing/vi.h) \
    $(wildcard include/config/feature/editing/save/on/exit.h) \
    $(wildcard include/config/pmap.h) \
    $(wildcard include/config/feature/show/threads.h) \
    $(wildcard include/config/feature/ps/additional/columns.h) \
    $(wildcard include/config/feature/topmem.h) \
    $(wildcard include/config/feature/top/smp/process.h) \
    $(wildcard include/config/pgrep.h) \
    $(wildcard include/config/pkill.h) \
    $(wildcard include/config/pidof.h) \
    $(wildcard include/config/sestatus.h) \
    $(wildcard include/config/unicode/support.h) \
    $(wildcard include/config/feature/mtab/support.h) \
    $(wildcard include/config/feature/clean/up.h) \
    $(wildcard include/config/feature/devfs.h) \
  include/platform.h \
    $(wildcard include/config/werror.h) \
    $(wildcard include/config/big/endian.h) \
    $(wildcard include/config/little/endian.h) \
    $(wildcard include/config/nommu.h) \
  /home/haobo/work/2440/tools/toolschain/bin/../lib/gcc/arm-none-linux-gnueabi/4.3.2/include-fixed/limits.h \
  /home/haobo/work/2440/tools/toolschain/bin/../lib/gcc/arm-none-linux-gnueabi/4.3.2/include-fixed/syslimits.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/limits.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/features.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/predefs.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/cdefs.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/wordsize.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/gnu/stubs.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/posix1_lim.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/local_lim.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/linux/limits.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/posix2_lim.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/xopen_lim.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/stdio_lim.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/byteswap.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/byteswap.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/endian.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/endian.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/stdint.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/wchar.h \
  /home/haobo/work/2440/tools/toolschain/bin/../lib/gcc/arm-none-linux-gnueabi/4.3.2/include/stdbool.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/unistd.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/posix_opt.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/environments.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/types.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/typesizes.h \
  /home/haobo/work/2440/tools/toolschain/bin/../lib/gcc/arm-none-linux-gnueabi/4.3.2/include/stddef.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/confname.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/getopt.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/ctype.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/xlocale.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/dirent.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/dirent.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/errno.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/errno.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/linux/errno.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/asm/errno.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/asm-generic/errno.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/asm-generic/errno-base.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/fcntl.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/fcntl.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/types.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/time.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/select.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/select.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/sigset.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/time.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/sysmacros.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/pthreadtypes.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/uio.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/stat.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/stat.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/inttypes.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/netdb.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/netinet/in.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/socket.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/uio.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/socket.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/sockaddr.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/asm/socket.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/asm/sockios.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/in.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/rpc/netdb.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/siginfo.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/netdb.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/setjmp.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/setjmp.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/signal.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/signum.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/sigaction.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/sigcontext.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/asm/sigcontext.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/sigstack.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/ucontext.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/procfs.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/time.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/user.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/sigthread.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/paths.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/stdio.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/libio.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/_G_config.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/wchar.h \
  /home/haobo/work/2440/tools/toolschain/bin/../lib/gcc/arm-none-linux-gnueabi/4.3.2/include/stdarg.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/sys_errlist.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/stdlib.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/waitflags.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/waitstatus.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/alloca.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/string.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/libgen.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/poll.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/poll.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/poll.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/ioctl.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/ioctls.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/asm/ioctls.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/asm/ioctl.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/asm-generic/ioctl.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/ioctl-types.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/ttydefaults.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/mman.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/mman.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/resource.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/resource.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/wait.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/termios.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/termios.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/param.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/linux/param.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/asm/param.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/pwd.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/grp.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/mntent.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/statfs.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/statfs.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/utmp.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/utmp.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/utmpx.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/bits/utmpx.h \
  /home/haobo/work/2440/tools/toolschain/bin/../arm-none-linux-gnueabi/libc/usr/include/arpa/inet.h \
  include/pwd_.h \
  include/grp_.h \
  include/shadow_.h \
  include/xatonum.h \

coreutils/hostid.o: $(deps_coreutils/hostid.o)

$(deps_coreutils/hostid.o):
