#!/bin/sh

[ -r /etc/default/camera-start ] && . /etc/default/camera-start


case "$START_CAMERA" in
        [Nn]*)
                exit 0
                ;;
esac

start_camera() {
    if [ -f /usr/bin/SyntroV4LCamera ]; then
        /usr/bin/SyntroV4LCamera -s/home/root/SyntroV4LCamera.ini -c -d
    fi
}

case "$1" in
    start)
        echo "Starting SyntroV4LCamera"
        start_camera
        ;;

    stop)
        echo "Stopping SyntroV4LCamera"
        killall SyntroV4LCamera
        ;;

    restart)
        echo "Stopping SyntroV4LCamera"
        killall SyntroV4LCamera
        sleep 3
        echo "Starting SyntroV4LCamera"
        start_camera
        ;;

    *)
        echo "Usage: /etc/init.d/camera-start.sh {start|stop|restart}"
        exit 2
esac
