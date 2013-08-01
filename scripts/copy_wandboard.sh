#!/bin/bash

if [ "x${1}" = "x" ]; then
	echo -e "\nUsage: ${0} <block device> [<image-type>]\n"
	exit 0
fi

DEV=/dev/${1}

if [ ! -b ${DEV} ]; then
    echo -e "\nBlock device $DEV does not exist!\n"
    exit 0
fi

# Check that partitions from the SD card aren't mounted.
# Since this might be a real disk, make the user double check.
# We are not going to do it.
P=`mount | grep ${DEV}1`

if [ -n "$P" ]; then
    echo -e "\nPartition ${DEV}1 needs to be unmounted!\n"
    exit 0
fi

P=`mount | grep ${DEV}2`

if [ -n "$P" ]; then
    echo -e "\nPartition ${DEV}2 needs to be unmounted!\n"
    exit 0
fi

P=`mount | grep ${DEV}3`

if [ -n "$P" ]; then
    echo -e "\nPartition ${DEV}3 needs to be unmounted!\n"
    exit 0
fi


if [ "x${2}" = "x" ]; then
        IMAGE=qte
else
        IMAGE=${2}
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
	echo -e "\nEnvironment variable MACHINE not found!\n"
	echo -e "Choices are wandboard-solo | wandboard-dual | wandboard-quad\n"
	exit 1
else
	echo "MACHINE: $MACHINE"
fi


echo "IMAGE: $IMAGE"


if [ ! -z "$OETMP" ]; then
	cd ${OETMP}/deploy/images
fi

if [ ! -f "pansenti-${IMAGE}-image-${MACHINE}.sdcard" ]; then
        echo -e "File not found: pansenti-${IMAGE}-image-${MACHINE}.sdcard\n"

		if [ ! -z "$OETMP" ]; then
			cd $OLDPWD
		fi

        exit 1
fi


# Here we go
echo -e "\nUsing dd to copy [ pansenti-${IMAGE}-image-${MACHINE}.sdcard ] to $DEV\n"
sudo dd if=pansenti-${IMAGE}-image-${MACHINE}.sdcard of=${DEV} bs=1M


if [ ! -z "$OETMP" ]; then
	cd $OLDPWD
fi

echo -e "\nDone\n"

