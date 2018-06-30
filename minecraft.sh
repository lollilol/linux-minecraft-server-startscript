#!/bin/sh
##configuration

#minecraft server .jar Name
binary=minecraft_server.1.12.2.jar

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
	cd $directory
	screen -AmdS $name java -Xms$ram -Xmx$ram -jar $binary nogui
	sleep 1
	echo "\033[32m$name-server was started..\033[0m"
	;;
stop)
  screen -S $name -p 0 -X stuff "kick @a The server is restarting or got stopped.^M"
	screen -S $name -p 0 -X stuff "stop^M"
	sleep 1
	echo "\033[31m$name-server was stopped..\033[0m"
	;;
restart)
	$0 stop
	$0 start
	;;
reload)
  screen -S $name -p 0 -X stuff "reload^M"
	;;
console)
  echo "\033[32mTo exit the console without stopping the server, press "CTRL+A+D"\033[0m"
	sleep 3
	screen -r $name
	;;
*)
	echo "\033[31mUsage: './$script (start|stop|restart|reload|console)'\033[0m"
	;;
esac
exit 0
