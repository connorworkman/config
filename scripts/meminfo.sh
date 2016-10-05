#!/bin/sh

#RAM=`cat /proc/meminfo | grep "MemFree" | awk -F" " '{print $2}'`
RAM=`free -h | grep "Mem:" | awk '{print $3 "/" $2}'`
#RAM=`free -h | grep "Mem:" | awk '{print $3}'`
#SWAP=`cat /proc/meminfo | grep "SwapFree" | awk -F" " '{print $2}'`
SWAP=`free -h | grep "Swap:" | awk '{print $3 "/" $2}'`
#SWAP=`free -h | grep "Swap:" | awk '{print $3}'`
echo -n "RAM-${RAM} Swap-${SWAP}"
