#! /bin/sh
# /etc/init.d/BuildLamp

SCRIPT_PATH="/usr/local/bin"
SCRIPT_NAME="build_lamp_loop.py"
NAME="BuildLamp"
PIDFILE=/var/run/$NAME.pid

case "$1" in
  start)
    echo "Starting $NAME deamon"
    PID=$(python $SCRIPT_PATH/$SCRIPT_NAME > /dev/null & echo $!)
    if [ -z $PID ]; then
        echo "Starting $NAME deamon failed"
    else
        echo $PID > $PIDFILE
        echo "Successfully started $NAME deamon"
    fi
    ;;
  stop)
    echo "Stopping $NAME"
    PID=$(cat $PIDFILE)
    if [ -f $PIDFILE ]; then
        kill -HUP $PID
        echo "OK"
        rm -f $PIDFILE
    else
        echo "pidfile not found"
    fi
    ;;
  *)
    echo "Usage: /etc/init.d/$SCRIPT_NAME {start|stop}"
    exit 1
    ;;
esac

exit 0
