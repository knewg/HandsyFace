#!/bin/bash

cd $(dirname $0)

APP_NAME="HandsyFace"
KEYS="${HOME}/src/Garmin/key/"
SDKPATH="${HOME}/src/Garmin/sdk/connectiq-sdk-mac-3.0.9-2019-2-27-0ad96b4"
P_INFO="$SDKPATH/bin/projectInfo.xml"

# kill the simulator if it's running
pkill simulator

# build via monkeyc 
$SDKPATH/bin/monkeyc -y $KEYS/developer_key -o ../build/$APP_NAME.prg -f ../monkey.jungle -w -p $P_INFO -s 3.0.0 -g -d $@

# launch the simulator, and wait
$SDKPATH/bin/connectiq
sleep 3

# run the app, as the corresponding device type
$SDKPATH/bin/monkeydo ../build/$APP_NAME.prg $@
