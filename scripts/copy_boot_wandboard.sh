#!/bin/bash

if [ "x${1}" = "x" ]; then
	echo -e "\nUsage: ${0} <block device>\n"
	exit 0
fi

if [ -z "$OETMP" ]; then
	echo -e "\nWorking from local directory"
else
	echo -e "\nOETMP: $OETMP"

	if [ ! -d ${OETMP}/deploy/images ]; then
		echo "Directory not found: ${OETMP}/deploy/images"
		exit 1
	fi
fi 

if [[ -z "${MACHINE}" ]]; then
	echo "Environment variable MACHINE not found!"
	echo "Choices are wandboard-solo|wandboard-dual|wandboard-quad"
	exit 1
else
	echo -e "MACHINE: $MACHINE\n"
fi

if [ ! -z "$OETMP" ]; then
	cd ${OETMP}/deploy/images
fi

if [ ! -f u-boot-${MACHINE}.imx ]; then
	echo -e "File not found: u-boot-${MACHINE}.imx\n"
 
	if [ ! -z "$OETMP" ]; then
		cd $OLDPWD
	fi

	exit 1
fi

if [ ! -f uImage-${MACHINE}.bin ]; then
	echo -e "File not found: uImage-${MACHINE}.bin\n"
 
	if [ ! -z "$OETMP" ]; then
		cd $OLDPWD
	fi

	exit 1
fi

DEV=/dev/${1}

if [ -b $DEV ]; then
	echo "Using dd to copy u-boot to unpartitioned space"
	sudo dd if=u-boot-${MACHINE}.imx of=${DEV} conv=notrunc seek=2 skip=0 bs=512

	echo -e "\nFormatting FAT partition on ${DEV}1 \n"
	sudo mkfs.vfat ${DEV}1 -n BOOT

	echo "Mounting ${DEV}1"
	sudo mount ${DEV}1 /media/card

	echo "Copying uImage"
	sudo cp uImage-${MACHINE}.bin /media/card/uImage

	echo "Unmounting ${DEV}1"
	sudo umount ${DEV}1
else
	echo -e "\nBlock device not found: ${DEV}\n"
fi

if [ ! -z "$OETMP" ]; then
	cd $OLDPWD
fi

echo "Done"

