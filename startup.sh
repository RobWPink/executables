while :
do
	ping -c1 www.google.com 1>/dev/null 2>/dev/null
	SUCCESS=$?
	if [ $SUCCESS -eq 0 ]
	then
		python3 ON.py
		sleep 5
		screen -dmS server python3 /home/defaultUser/raspiThingsboard/raspiThingsboard.py -u reformer1_pad -d
		ssh -fN -R 5001:localhost:22 ubuntu@34.236.51.120
		break
	fi
done
