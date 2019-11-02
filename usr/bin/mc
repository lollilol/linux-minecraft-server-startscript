#!/bin/sh
##configuration

#minecraft server .jar Name
binary=server.jar

#directory of the minecraft server, write "." if the startscript is in the same folder as the minecraft server.
#dont put a "/" at the end of the line! otherwise update wont work!
directory=/usr/mc

#flags / commandline parameter
flags="-XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=100 -XX:+DisableExplicitGC -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:G1MixedGCLiveThresholdPercent=35 -XX:+AlwaysPreTouch -XX:+ParallelRefProcEnabled -Dusing.aikars.flags=mcflags.emc.gs"

#name, used as screen and display-name in the entire script"
name=mc

##RAM
# usage
# for 1 Gigabyte, write: "1G"
# 1 Gigabyte in Megabyte, write: "1024M"
# for 512 Megabyte, write: "512M"
# for 256 Megabyte, write: "256M"
# etc..
ram=4G

##Updating
#Here you can specify an url to an always up-to-date server.jar
url=https://papermc.io/ci/job/Paper-1.14/lastSuccessfulBuild/artifact/paperclip.jar
#spigot url: https://cdn.getbukkit.org/spigot/spigot-1.13.2.jar

##Backup
backup_folder=backups
backup_file=world-$(date +"%d.%m.%y_%H:%M").tar.gz


##########################################
# no neccesary changes beyond this line! #
##########################################

script=`basename "$0"`
case "$1" in
start)
	if ! screen -ls | grep -q "$name"; then
		cd $directory
		screen -AmdS $name java -jar -Xms$ram -Xmx$ram $flags $binary nogui
		sleep 1
		echo "\033[32m$name-server was started..\033[0m"
	else
		echo "\033[31m$name-server is already running!\033[0m"
	fi
	;;
stop)
	if screen -ls | grep -q "$name"; then
		screen -S $name -p 0 -X stuff "minecraft:kick @a The server is restarting or got stopped.^M"
		screen -S $name -p 0 -X stuff "stop^M"
		sleep 1
		echo "\033[31m$name-server was stopped..\033[0m"
	else
		echo "\033[31m$name-server is not running!\033[0m"
	fi
	;;
restart)
	$0 stop
	sleep 10
	$0 start
	;;
status)
	if screen -ls | grep -q "$name"; then
		echo "\033[32m$name-server is running.\033[0m"
	else
		echo "\033[31m$name-server is not running.\033[0m"
	fi
	;;
save)
	if screen -ls | grep -q "$name"; then
		screen -S $name -p 0 -X stuff "save-all^M"
		echo "\033[32m$name-server was saved..\033[0m"
	else
		echo "\033[31m$name-server is not running!\033[0m"
	fi
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
	if screen -ls | grep -q "$name"; then
		screen -S $name -p 0 -X stuff "reload confirm^M"
		echo "\033[32m$name-server was reloaded..\033[0m"
	else
		echo "\033[31m$name-server is not running!\033[0m"
	fi
	;;
console)
	if screen -ls | grep -q "$name"; then
		screen -rx $name
	else
		echo "\033[31m$name-server is not running!\033[0m"
	fi
	;;
update)
	wget -O $directory/$binary $url
	;;
backup)
	if [ -d "$directory/$backup_folder" ]
	then
		if screen -ls | grep -q "$name"; then
			$0 save
			sleep 20 #if the server tooks longer saving the world than these two seconds, the backup file will be corrupted. So be sure this is set right.
		fi
	else
		cd $directory
		echo "\033[31mBackup Folder doesnt exist. Creating it...\033[0m"
		sleep 1
		mkdir $backup_folder
	fi
	cd $directory
	echo "\033[32mStarting Backup progress...\033[0m"
	tar -czf $backup_folder/$backup_file world/
	echo "\033[32mWorld successfully backupped. Location: $backup_folder/$backup_file\033[0m"
	;;
edit)
	if [ -z ${EDITOR+x} ]; then nano $0; else $EDITOR $0; fi
	;;
*)
	echo "\033[31mUsage: '$0 (start|stop|restart|status|save|kill|reload|console|update|backup)'\033[0m"
	;;
esac
exit 0
