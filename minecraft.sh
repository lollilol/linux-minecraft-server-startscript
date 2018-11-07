#!/bin/sh
##configuration

#minecraft server .jar Name
binary=minecraft_server.1.13.2.jar

#directory of the minecraft server, write "." if the startscript is in the same folder as the minecraft server.
directory=/home/minecraft

#name, used as screen and display-name in the complete script"
name=minecraft

##RAM
# usage
# for 1 Gigabyte, write: "1G"
# 1 Gigabyte in Megabyte, write: "1024M"
# for 512 Megabyte, write: "512M"
# for 256 Megabyte, write: "256M"
# etc..
ram=1G

##########################################
# no neccesary changes beyond this line! #
##########################################

script=`basename "$0"`
case "$1" in
start)
	if ! screen -ls | grep -q "$name"; then
		cd $directory
		screen -AmdS $name java -Xms100M -Xmx$ram -jar $binary nogui
		sleep 1
		echo "\033[32m$name-server was started..\033[0m"
	else
		echo "\033[31m$name-server is already running!\033[0m"
	fi
	;;
stop)
	if screen -ls | grep -q "$name"; then
		screen -S $name -p 0 -X stuff "kick @a The server is restarting or got stopped.^M"
		screen -S $name -p 0 -X stuff "^C^M"
		sleep 1
		echo "\033[31m$name-server was stopped..\033[0m"
	else
		echo "\033[31m$name-server is not running!\033[0m"
	fi
	;;
restart)
	$0 stop
	$0 start
	;;
kill)
	if screen -ls | grep -q "$name"; then
		screen -XS $name quit
		echo "\033[31m$name-server was killed..\033[0m"
	else
		echo "\033[31m$name-server is not running!\033[0m"
	fi
	;;
reload)
  screen -S $name -p 0 -X stuff "reload^M"
	;;
console)
	if screen -ls | grep -q "$name"; then
		screen -r $name
	else
		echo "\033[31m$name-server is not running!\033[0m"
	fi
	;;
*)
	echo "\033[31mUsage: './$script (start|stop|restart|kill|reload|console)'\033[0m"
	;;
esac
exit 0
