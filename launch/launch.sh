#! /bin/bash

export ZWY_HOME=/Users/mb
export ZWY_DIR=$ZWY_HOME/ZwyShell
export ZWY_DIR_FeiGeNAT=$ZWY_HOME/ZwyShell/darwin_amd64_client
export PATH=$PATH:$ZWY_DIR:$ZWY_DIR_FeiGeNAT

LOG_PATH=$ZWY_DIR/launch/launch.log

echo "====start zwy launch====" >> $LOG_PATH

echo $(date +"%Y-%m-%d %H:%M:%S") >> $LOG_PATH
echo "npc is in "`which npc` >> $LOG_PATH

npc -server=mb.nps.zwyxxd.press:8024 -vkey=zwy -type=tcp > $ZWY_DIR_FeiGeNAT/npc_home.log


