#!/bin/sh

[ -r /etc/default/camera-start ] && . /etc/default/camera-start


case "$START_CAMERA" in
        [Nn]*)
                exit 0
                ;;
esac

if [ ! -f /usr/bin/SyntroCam ]; then
    exit 0
fi

start_camera() {
    if [ ! -d /home/root/syntro ]; then
        mkdir /home/root/syntro
    fi

    cd /home/root/syntro

    /usr/bin/SyntroCam -s/home/root/syntro/SyntroCam.ini -c -d    
}

case "$1" in
    start)
        echo "Starting SyntroCam"
        start_camera
        ;;

    stop)
        echo "Stopping SyntroCam"
        killall SyntroCam
        ;;

    restart)
        echo "Stopping SyntroCam"
        killall SyntroCam
        sleep 3
        echo "Starting SyntroCam"
        start_camera
        ;;

    *)
        echo "Usage: /etc/init.d/camera-start.sh {start|stop|restart}"
        exit 2
esac

