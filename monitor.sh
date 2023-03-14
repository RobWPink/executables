#!/bin/bash

if [ -z "$1" ]
then
arduino-cli monitor -p /dev/ttyACM0
else
arduino-cli monitor -p $1
fi

