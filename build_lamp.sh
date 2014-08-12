#! /bin/sh
SCRIPT_PATH="/usr/local/bin"
SCRIPT_NAME="build_lamp_loop.py"
NAME="BuildLamp"
PIDFILE=/var/run/$NAME.pid

### BEGIN INIT INFO
# Provides:          build lamp service
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Simple script to start build lamp deamon at startup
### END INIT INFO

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
