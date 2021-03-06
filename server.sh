#!/bin/sh
# Minecraft Server Startscript
# Github: https://github.com/lollilol/minecraft-server-startscript

##configuration

#minecraft server .jar Name
#binary=server.jar
#you cant set a custom binary.jar for now, please rename your server jar file to "server.jar" and dont change this variable here.

#directory of the minecraft server, write "." if the startscript is in the same folder as the minecraft server.
#dont put a "/" at the end of the line and use absolute paths!
dir=/usr/mc

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
ram=6G

##Updating
#Here you can specify an url to an always up-to-date server.jar
url=https://papermc.io/ci/job/Paper-1.15/lastSuccessfulBuild/artifact/paperclip.jar
#spigot url: https://cdn.getbukkit.org/spigot/spigot-1.15.jar

snapshot=false
#possible usages: true, false
#if set to true, the latest snapshot jar will get installed if updated. If set to false, the jar file url specified above will get installed.
#its not recommended to change this when there already is a world generated.

EDITOR=nano
#editor to edit this file and the properties file. (with $0 edit/properties)

##Backup
backup_folder=backups
backup_file=world-$(date +"%d.%m.%y_%H:%M").tar.gz


##########################################
# no neccesary changes beyond this line! #
##########################################

binary=server.jar
case "$1" in
start)
	if ! [ -f "$dir/eula.txt" ]; then
		echo -n "\033[31m"
		read -p "The EULA is not accepted. Do you want to accept the minecraft eula? (https://account.mojang.com/documents/minecraft_eula) (y/N) " eula
		echo -n "\033[0m"
		case "$eula" in
		y|Y) echo "eula=true" >> $dir/eula.txt ;;
		*) echo; echo "\033[31mAborting!\033[0m";echo	;;
		esac
	fi
	if ! screen -ls | grep -q "$name"; then
		cd "$dir"
		screen -AmdS "$name" java -jar -Xms$ram -Xmx$ram $flags $binary nogui
		echo "\033[32m$name-server was started..\033[0m"
	else
		echo "\033[31m$name-server is already running!\033[0m"
	fi
	;;
stop)
	if screen -ls | grep -q "$name"; then
		screen -S "$name" -p 0 -X stuff "stop^M"
		echo "\033[32mWaiting for the server to be stopped.\033[0m"
			while screen -list | grep -q "$name"; do
				sleep 0.1
			done
		echo "\033[31m$name-server was stopped..\033[0m"
	else
		echo "\033[31m$name-server is not running!\033[0m"
	fi
	;;
restart)
	$0 stop
	echo "\033[32mStarting server\033[0m"
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
		screen -S "$name" -p 0 -X stuff "save-all^M"
		echo "\033[32msaving $name-server..\033[0m"
	else
		echo "\033[31m$name-server is not running!\033[0m"
	fi
	;;
kill)
	if screen -ls | grep -q "$name"; then
		screen -XS "$name" quit
		echo "\033[31m$name-server was killed..\033[0m"
	else
		echo "\033[31m$name-server is not running!\033[0m"
	fi
	;;
reload)
	if screen -ls | grep -q "$name"; then
		screen -S "$name" -p 0 -X stuff "reload confirm^M"
		echo "\033[32m$name-server was reloaded..\033[0m"
	else
		echo "\033[31m$name-server is not running!\033[0m"
	fi
	;;
console)
	if screen -ls | grep -q "$name"; then
		screen -rx "$name"
	else
		echo "\033[31m$name-server is not running!\033[0m"
	fi
	;;
update|init|install)
	if ! [ -d "$dir" ]; then
		mkdir "$dir"
	fi
	if [ "$snapshot" = true ]; then
		export MC_BINARY=$binary
		if ! [ -f "$dir/update_snapshot.py" ]; then
			echo "\033[31msnapshot-updating script does not exist. Downloading it..\033[0m"
			wget -q -O "$dir/update_snapshot.py" https://raw.githubusercontent.com/lollilol/minecraft-server-startscript/master/usr/mc/update_snapshot.py
			chmod +x "$dir/update_snapshot.py"
		fi
			cd "$dir"
			python3 "$dir/update_snapshot.py"
			echo "\033[32mSucessfully updated $name-server (snapshot)\033[0m"
	else
		wget -O "$dir/$binary" $url
		echo "\033[32mSucessfully updated $name-server (stable)\033[0m"
	fi
	if ! [ -f "$dir/eula.txt" ]; then
		echo -n "\033[31m"
		read -p "The EULA is not accepted. Do you want to accept the minecraft eula? (https://account.mojang.com/documents/minecraft_eula) (y/N) " eula
		echo -n "\033[0m"
		case "$eula" in
		y|Y) echo "eula=true" >> $dir/eula.txt ;;
		*) echo; echo "\033[31mAborting!\033[0m";echo	;;
		esac
	fi
	;;
backup)
	if ! [ -d "$dir/"$backup_folder"" ]; then
		cd $dir
		echo "\033[31mBackup Folder doesnt exist. Creating it...\033[0m"
		mkdir "$backup_folder"
	fi
	if screen -ls | grep -q "$name"; then
		$0 save
		echo "\033[32mThis can take up to 1 - 2 minutes"
		sleep 15 #if the server takes longer saving the world than these 15 seconds, the backup file will be corrupted. So be sure this is set right.
	fi
	cd "$dir"
	if [ -d "$dir/world_nether" ] || [ -d "$dir/world_the_end" ]; then
		echo "\033[32mStarting Backup progress on a bukkit/spigot based server...\033[0m"
		tar -czf "$backup_folder/$backup_file" "world" "world_nether" "world_the_end"
	else
		echo "\033[32mStarting Backup progress on a vanilla server (no separate world folders)...\033[0m"
		tar -czf "$backup_folder/$backup_file" "world"
	fi
	echo "\033[32mWorld successfully backupped. Location: $dir/$backup_folder/$backup_file \033[0m"
	;;
edit)
	${EDITOR:-nano} $0
	;;
properties)
	${EDITOR:-nano} "$dir"/server.properties
	;;
*)
	echo "\033[31mUsage: '$0 (start|stop|restart|status|save|kill|reload|console|update|backup|edit|properties)'\033[0m"
	;;
esac
exit 0
