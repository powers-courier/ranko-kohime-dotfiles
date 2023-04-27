#!/bin/bash

usedMem=`free -m | grep Mem | gawk '{ printf $3 }'`
totalMem=`free -m | grep Mem | gawk '{ printf $2 }'`
usedMemPercent=`printf %.2f%% "$((10**3 * 100 * $usedMem/$totalMem))e-3"`

usedSwap=`free -m | grep Swap | gawk '{ printf $3 }'`
totalSwap=`free -m | grep Swap | gawk '{ printf $2 }'`
usedSwapPercent=`printf %.2f%% "$((10**3 * 100 * $usedSwap/$totalSwap))e-3"`

case $1 in
    -m) printf $usedMemPercent ;;
    -s) printf $usedSwapPercent ;;
    *) printf "Error" ;;
esac
