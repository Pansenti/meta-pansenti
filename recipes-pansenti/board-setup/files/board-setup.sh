#!/bin/sh

init_gpio() {
    # GPIO1_16 = (1 * 32) + 16 = 48
    if [ ! -d /sys/class/gpio/gpio48 ]; then
        echo 48 > /sys/class/gpio/export
        echo out > /sys/class/gpio/gpio48/direction
    fi

    # GPIO1_17 = (1 * 32) + 17 = 49
    if [ ! -d /sys/class/gpio/gpio49 ]; then
        echo 49 > /sys/class/gpio/export
    	echo out > /sys/class/gpio/gpio49/direction
    fi

    # GPIO3_19 = (3 * 32) + 19 = 115
    if [ ! -d /sys/class/gpio/gpio115 ]; then
    	echo 115 > /sys/class/gpio/export
    	echo in > /sys/class/gpio/gpio115/direction
    fi

    # GPIO1_28 = (1 * 32) + 28 = 60
    if [ ! -d /sys/class/gpio/gpio60 ]; then
    	echo 60 > /sys/class/gpio/export
    	echo out > /sys/class/gpio/gpio60/direction
    fi
}


init_adc() {
    if [ ! -d /sys/devices/ocp.2/44e0d000.tscadc ]; then
	    echo cape-bone-iio > /sys/devices/bone_capemgr.9/slots
    fi
}

case "$1" in
    start)
        echo "Initializing gpio pins"
        init_gpio
        echo "Initializing adc pins"
        init_adc
        ;;

    *)
        echo "Usage: /etc/init.d/mote-init.sh start"
        exit 1
esac

