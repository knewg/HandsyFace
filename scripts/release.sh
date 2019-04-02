#!/bin/bash

cd $(dirname $0)

APP_NAME="HandsyFace"
KEYS="${HOME}/src/Garmin/key/"
SDKPATH="${HOME}/src/Garmin/sdk/connectiq-sdk-mac-3.0.9-2019-2-27-0ad96b4"
P_INFO="$SDKPATH/bin/projectInfo.xml"


# build via monkeyc 
$SDKPATH/bin/monkeyc -y $KEYS/developer_key -o ../release/${APP_NAME}_$@.prg -f ../monkey.jungle -w -p $P_INFO -s 3.0.0 -r -d $@
