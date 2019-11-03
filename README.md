# Startscript for a minecraft server.
A customizable, basic bash script to manage your minecraft server.

Which once was a simple script to start, stop and restart your server has evolved in a big script, supporting updating the server, edit the properties, switch the server to snapshot, taking backups from your world and you can even add your own server cli parameter.

## Overview
Features:
+ Start, stop and reload your minecraft server (reload only on minecraft 1.12+ or on every spigot/papermc server)
+ You only need the script to set up a server! It automatically downloads the latest paper.jar (customizable) or the latest snapshot
+ should work on any linux distro.

## Downloads
#### [Raw Script](https://raw.githubusercontent.com/lollilol/minecraft-server-startscript/master/usr/bin/mc)

## Usage
```
mc (start|stop|restart|status|save|kill|reload|console|update|backup|edit|properties)
```

## How to download:

+ Connect to your Server via SSH.
+ Go to the directory where you want to download the file
+ Execute `wget -O /usr/bin/mc https://git.io/Jegiv`
+ Customize it with `nano $(which mc)`
+ make it executeable with `chmod a+x $(which mc)`
+ done.

or just paste
>`wget -O /usr/bin/mc https://git.io/Jegiv && nano $(which mc) && chmod a+x $(which mc)`

into ssh, to download the script in the current folder and make it executeable.

## Required/Dependencies
+ screen (in the most Repositorys called "screen")
+ java ([How to install](java8.md))

## Autostart integration
+ Please make sure you have crontab/cron installed
+ Execute `crontab -e`
+ you may have to choose your editor: i would recommend "nano"
+ now the crontab file is opened. scroll to the end of the file
+ now insert `@reboot /usr/bin/mc start`
+ done.
