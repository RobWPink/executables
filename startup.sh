while :
do
	ping -c1 www.google.com 1>/dev/null 2>/dev/null
	SUCCESS=$?
	if [ $SUCCESS -eq 0 ]
	then
		python3 /home/defaultUser/ON.py
		sleep 5
		screen -dmS server python3 /home/defaultUser/raspiThingsboard/raspiThingsboard.py -u reformer1_pad -d
#		autossh -R 5001:localhost:22 -N 34.236.51.120 -l ubuntu &
#		screen -dmS autossh sshpass -P "Enter passphrase for key '/home/defaultUser/Thingsboard_key.pem':" -p "oneh2" -v autossh -R 5002:localhost:22 -N 34.236.51.120 -l ubuntu -o ServerAliveInterval=30 -i /home/defaultUser/Thingsboard_key.pem
		break
	fi
done
