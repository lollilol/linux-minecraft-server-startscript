# Startscript for a minecraft server.
A customizable, little script to start your minecraft server.

## Overview
Features:
+ Start, stop and reload your minecraft server (reload works only on minecraft 1.12+)
+ You dont need any start.sh in your minecraft folder! Only a startable minecraft server.
+ currently im supporting only Debian 8 with Java 8. (but of course you can use it on other systems, and with newer or older java.)

## Downloads
#### [Direct Download]()

[Releases]()

[Raw script]() (right click, wget friendly, most up to date)

## Usage
```
./startscript.sh (start|stop|restart|reload)
```

## How to download:

+ Connect to your VPS via SSH.
+ Go to the directory where you want to download the file
+ Execute `wget <link>`
+ Customize it with `nano minecraft.sh`
+ make it executeable with `chmod a+x minecraft.sh`
+ done.

or just paste
>`cd && wget <link> && nano startscript.sh && chmod a+x minecraft.sh`

into ssh, to download the script in the home folder and make it executeable.

## Required/Dependencies
+ screen (in the most Repositorys called "screen")
+ java ([How to install](debian8_java8.md))
+ one minecraft server

## Autostart integration
+ Please make sure you have crontab/cron installed
+ Execute `crontab -e`
+ you may have to choose your editor: i would recommend "nano"
+ now the crontab file is opened. scroll to the end of the file
+ now insert `@reboot /file/to/your/minecraft.sh start`
+ done.
