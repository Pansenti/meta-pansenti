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
    IMAGE=wt
else
    IMAGE=${2}
fi

if [ "x${3}" = "x" ]; then
	TARGET_HOSTNAME=$MACHINE
else
    TARGET_HOSTNAME=${3}
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
echo "HOSTNAME: $TARGET_HOSTNAME"


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

if [ $TARGET_HOSTNAME != $MACHINE ]; then
    MORE_WORK="yes"
elif [ -f interfaces ]; then
    MORE_WORK="yes"
elif [ -f wpa_supplicant.conf ]; then
    MORE_WORK="yes"
else
    MORE_WORK="no"
fi

if [ $MORE_WORK = "yes" ]; then
  
    sleep 10

    ROOTPART="${DEV}2"
    
    echo -e "\nMounting $ROOTPART at /media/card"
    sudo mount -t ext3 $ROOTPART /media/card

    if [ $TARGET_HOSTNAME != $MACHINE ]; then
	    echo "Writing hostname to /etc/hostname"
	    export TARGET_HOSTNAME
	    sudo -E bash -c 'echo ${TARGET_HOSTNAME} > /media/card/etc/hostname'
    fi

	if [ -f interfaces ]; then
		echo "Writing interfaces to /media/card/etc/network/"
		sudo cp interfaces /media/card/etc/network/interfaces
	fi

	if [ -f wpa_supplicant.conf ]; then
		echo "Writing wpa_supplicant.conf to /media/card/etc/"
		sudo cp wpa_supplicant.conf /media/card/etc/wpa_supplicant.conf
	fi

	echo "Unmounting $ROOTPART"
	sudo umount $ROOTPART
fi

if [ ! -z "$OETMP" ]; then
	cd $OLDPWD
fi

echo -e "\nDone\n"

