#!/bin/bash
python3 ~/OFF.py
echo compiling...

arduino-cli compile --fqbn arduino:avr:mega ~/$1

echo compiling successful!
echo uploading...

if [ -z "$2" ]
then
arduino-cli upload -v -p /dev/ttyACM0 --fqbn arduino:avr:mega ~/$1
else
arduino-cli upload -p $2 --fqbn arduino:avr:mega ~/$1
fi

echo upload successful!
python3 ~/ON.py
echo opening serial monitor...
if [ -z "$2" ]
then
arduino-cli monitor -p /dev/ttyACM0
else
arduino-cli monitor -p $2
fi