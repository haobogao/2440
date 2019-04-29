#!/bin/bash

#this is a main script for this project


# PATH define
old_path=$PATH
src_root=$(dirname "$PWD")
boot_path=$src_root/boot
bootloader_path=$boot_path/bootloader
uboot_path=$boot_path/uboot/
kernel_path=$src_root/kernel/linux-3.4.2 
out_path=$src_root/out
script_path=$src_root/build_script
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


echo "user input: "
echo $*

#if it is build command
if [ "$1"x = "build"x ] 
then
	. setenv.sh
	echo $PATH
	echo_path
	if [ "$2"x = "uboot"x ]
	then
		cd $uboot_path
		make distclean
		make smdk2440 -j16
	 	if [  -f "$uboot_path/u-boot.bin" ]
		then
	 		cp $uboot_path/u-boot.bin $src_root/out
	 	fi
		echo "____________end build u-boot__________"
		echo "the u-boot.bin could now at out directory!"
	fi
#download
elif [ "$1"x = "download"x ]
then
	cd $down_path
	sudo -S ./down.sh $out_path/u-boot.bin <<EOF
 
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
echo "***************finshed *************"





