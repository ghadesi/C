#!/bin/sh
# This script takes a photo if the computer has not been idle for longer than a period of time
# it uses isightcapture from https://www.macupdate.com/app/mac/18598/isightcapture
 
[ -z "$USER" ] && echo "missing variable \$USER " && exit 1
if [ ! -d /Users/$USER/daily_photo ]; then
    mkdir -p $/Users/$USER/daily_photo
fi
IDLE=$((`/usr/sbin/ioreg -c IOHIDSystem | sed -e '/HIDIdleTime/!{ d' -e 't' -e '}' -e 's/.* = //g' -e 'q'` / 1000000000 ))
export SUDO_ASKPASS=/Users/$USER/bin/get_pass.sh
if [ $IDLE -lt 61 ]; then
    PID=`pgrep -f '/System/Library/CoreServices/loginwindow.app/Contents/MacOS/loginwindow console'`
    D=`date +%Y%m%d_%H%M%S`
    sudo -A /bin/launchctl bsexec $PID /Users/$USER/bin/isightcapture -t png /Users/$USER/daily_photo/$D.png
fi


