echo "Preparing systems"
sleep 2
echo "Mounting rocket"
sleep 2
echo "All thrusters ready"
sleep 2 
echo "All final checks sucessful"
sleep 2
echo "Preparing for launch"
sleep 2
echo "Enter launch code:"
read launchcode
if [ $launchcode == 190995 ]
then 
	echo "CONGRADULATIONS launch successful"
	echo "You have completed the assignment, well done!"
else
	echo "Oh my god......"
	sleep 2
	echo "Somethings happening to the rocket"
	sleep 2
	echo "RUN RUN THE ROCKET IS SELF DESCTRUCTING"
	sleep 2
	echo "KABOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOM"
	sleep 3
	echo "You have destroyed canberra GAME OVER"
fi

