# Startscript for a minecraft server.
A customizable, basic bash script to manage your minecraft server.

## Overview
Features:
+ Start, stop and reload your minecraft server (reload only on minecraft 1.12+ or on every spigot/papermc server)
+ You only need the script to set up a server! It automatically downloads newest paper.jar (customizable)
+ should work on any linux distro.

## Downloads
#### [Raw Script](https://raw.githubusercontent.com/lollilol/linux-minecraft-server-startscript/master/minecraft.sh)

## Usage
```
./minecraft.sh (start|stop|restart|status|save|kill|reload|console|update|backup)
```

## How to download:

+ Connect to your Server via SSH.
+ Go to the directory where you want to download the file
+ Execute `wget -O minecraft.sh https://git.io/fh5VS`
+ Customize it with `nano minecraft.sh`
+ make it executeable with `chmod a+x minecraft.sh`
+ done.

or just paste
>`wget -O minecraft.sh https://git.io/fh5VS && nano minecraft.sh && chmod a+x minecraft.sh`

into ssh, to download the script in the current folder and make it executeable.

## Required/Dependencies
+ screen (in the most Repositorys called "screen")
+ java ([How to install](java8.md))

## Autostart integration
+ Please make sure you have crontab/cron installed
+ Execute `crontab -e`
+ you may have to choose your editor: i would recommend "nano"
+ now the crontab file is opened. scroll to the end of the file
+ now insert `@reboot /file/to/your/minecraft.sh start`
+ done.
