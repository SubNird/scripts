#!/bin/bash
#by Nird (https://github.com/SubNird)
workdir=/opt/cprocsp/bin/amd64
if [ ! -f $workdir/certmgr ]
then
	echo -e "CryptoPro не установлен или директория по умолчанию отличается от '$workdir'\n"
	exit
else
	cd $workdir
fi
case $1 in
	"-list" )
		./csptest -keyset -enum_cont -fqcn -verifyc
		;;
	"-info")
		if [ -z "$2" ]
		then
			echo -e "\e[31mНеобходимо ввести название контейнера\e[0m"
		else
			./csptest -keyset -container "$2" -info
		fi
		;;
	"-inst")
		if [ -z "$2" ]
		then
			echo -e "\e[31mНеобходимо ввести название контейнера\e[0m"
		else
			./certmgr -inst -cont "$2"
		fi
		;;
	"-copy")
		if [ -z "$2" ]
		then
			echo -e "\e[31mНеобходимо ввести название контейнера\e[0m"
		elif [ -z "$3" ]
		then
			echo -e "\e[31mНеобходимо ввести название нового контейнера\e[0m"
		else
			./csptest -keycopy -contsrc "$2" -contdest "\\\.\HDIMAGE\\$3"
		fi
		;;
	* )
		echo -e "Скрипт для работы с КриптоПРО 4.0 RC4"
		echo -e "-list Просмотр всех контейнеров"
		echo -e "-info [контейнер] Просмотр информации о контейнере"
		echo -e "-inst [контейнер] Установка сертификата из контейнера"
		echo -e "-copy [исходный контейнер] [имя нового локального контейнера] копируется в \\\.\HDIMAGE\\"
		;;
esac
