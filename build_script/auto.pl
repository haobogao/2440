#!/bin/bash

#this is a main script for this project


# PATH define
time_prefix=$(date "+%Y%m%d-%H%M%S")
old_path=$PATH
src_root=$(dirname "$PWD")
boot_path=$src_root/boot
bootloader_path=$boot_path/bootloader
uboot_path=$boot_path/uboot/
kernel_path=$src_root/kernel/linux-3.4.2 

script_path=$src_root/build_script
rootfs_path=$src_root/rootfs/
down_path=$script_path/download

echo_path(){
	date
	echo bootloader at : $bootloader_path
	echo source code root dir at : $src_root
	echo bootdir:  $boot_path
	echo uboot at:  $uboot_path
	echo kernel at: $kernel_path 

}



usage(){
	echo "usage:"
	echo "./auto.pl  [function] [subfunction]"
	echo "the function could be: build , download ,clean"
	echo "the subfunction could be : uboot,boot,kernel,rootfs "
	echo "usage end"
}



bld_uboot(){

	cd $uboot_path
	make distclean
	make smdk2440 -j16
	if [  -f "$uboot_path/u-boot.bin" ]
	then
		cp $uboot_path/u-boot.bin $src_root/out/$time_prefix
	fi
	echo "____________end build u-boot___ $(date "+%Y-%m-%d %H:%M:%S")  _______"
	echo "the u-boot.bin could now at $out_path directory!"
}

bld_kernel(){
		cd $kernel_path
		make distclean
		cp config_ok .config
		make uImage -j16
	 	if [  -f "$kernel_path/arch/arm/boot/uImage" ]
		then
	 		cp $kernel_path/arch/arm/boot/uImage $src_root/out/$time_prefix
	 	fi
		echo "____________end build kernel_ $(date "+%Y-%m-%d %H:%M:%S") _________"
		echo "the kernel uImage could now at $out_path directory! "
}

bld_rootfs(){
	cd $rootfs_path
	mkyaffs2image root/ rootfs.yaffs2
	if [  -f "$rootfs_path/rootfs.yaffs2" ]
	then
		cp rootfs.yaffs2 $src_root/out/$time_prefix
	fi
	echo "____________end build rootfs_____ $(date "+%Y-%m-%d %H:%M:%S") _____"
	echo "the rootfs could now at $out_path directory!"
}



echo "user input: "
echo $*

#if it is build command
if [ "$1"x = "build"x ] 
then
	. setenv.sh
	echo $PATH
	echo_path
	out_path=$src_root/out/$time_prefix
	mkdir  $src_root/out/$time_prefix
	if [ "$2"x = "uboot"x ]
	then
		bld_uboot
	fi
	if [ "$2"x = "kernel"x ]
	then
		bld_kernel
	fi
	if [ "$2"x = "rootfs"x ]
	then
		bld_rootfs
	fi
	if [ "$2"x = "all"x ]
	then
		bld_uboot
		bld_kernel
		bld_rootfs
		cp $out_path/* ~/tftpboot
	fi
#download
elif [ "$1"x = "download"x ]
then
	cd $down_path
	sudo -S ./down.sh  $uboot_path/u-boot.bin <<EOF
 
EOF

# clean
elif [ "$1"x = "clean"x ]
then
	pwd
else 
	usage
fi


#restore the PATH
export PATH=$old_path

echo "ok"
echo "***************finshed @ $(date "+%Y-%m-%d %H:%M:%S")* ************"





