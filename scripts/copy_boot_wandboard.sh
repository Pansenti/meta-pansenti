#!/bin/bash
#
# Use MACHINE for u-boot, but always wandboard-quad for kernel
#

if [ "x${1}" = "x" ]; then
	echo -e "\nUsage: ${0} <block device>\n"
	exit 0
fi

DEV=/dev/${1}

if [ ! -b $DEV ]; then
	echo -e "\nBlock device not found: ${DEV}\n"
	exit 0
fi

if [[ -z "${MACHINE}" ]]; then
	echo "Environment variable MACHINE not found!"
	echo "Choices are wandboard-dual|wandboard-quad"
	exit 1
else
	echo -e "MACHINE: $MACHINE\n"
fi

if [ -z "$OETMP" ]; then
	echo -e "\nWorking from local directory"
else
	echo -e "\nOETMP: $OETMP"

	if [ ! -d ${OETMP}/deploy/images/${MACHINE} ]; then
		echo "Directory not found: ${OETMP}/deploy/images/${MACHINE}"
		exit 1
	fi

	cd ${OETMP}/deploy/images/${MACHINE}
fi

if [ ! -f u-boot-${MACHINE}.imx ]; then
	echo -e "File not found: u-boot-${MACHINE}.imx\n"
 
	if [ "${MACHINE}" = "wandboard-dual" ]; then
		echo -e "You need to manually copy u-boot-wandboard-dual.imx to the wandboard-quad TMPDIR\n"
	fi

	if [ ! -z "$OETMP" ]; then
		cd $OLDPWD
	fi

	exit 1
fi

KERNEL_MACHINE="wandboard-quad"

if [ ! -f uImage-${KERNEL_MACHINE}.bin ]; then
	echo -e "File not found: uImage-${KERNEL_MACHINE}.bin\n"
 
	if [ ! -z "$OETMP" ]; then
		cd $OLDPWD
	fi

	exit 1
fi


echo "Using dd to copy u-boot to unpartitioned space"
sudo dd if=u-boot-${MACHINE}.imx of=${DEV} conv=notrunc seek=2 skip=0 bs=512

echo -e "\nFormatting FAT partition on ${DEV}1 \n"
sudo mkfs.vfat ${DEV}1 -n BOOT

echo "Mounting ${DEV}1"
sudo mount ${DEV}1 /media/card

echo "Copying uImage"
sudo cp uImage-${KERNEL_MACHINE}.bin /media/card/uImage

echo "Unmounting ${DEV}1"
sudo umount ${DEV}1


if [ ! -z "$OETMP" ]; then
	cd $OLDPWD
fi

echo "Done"

