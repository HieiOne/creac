#!/bin/bash
##########################################################################################
# Name: creac
# Author: Hiei <blascogasconiban@gmail.com>
# Version: 3.2.1/stable
# Description:
#              This Script will create file wherever you want with almost any extension
#
#
#
# BUGS: 	None found yet!
#
# IMPORTANT:
#	        -   If any extension is not included, you can add it manually by:
#			1.- Create a file "1.extension" in the folder /etc/creac/ext
#			2.- Add it to the case like (odt|xml|dtd)
#
##########################################################################################
source creac.conf
DIRECTORY=$(pwd)
USER=""

function create() {
	#$1=FILE_NAME $2=EXTENSION $3=DIRECTORY $4=FILES_DIRECTORY $5=USER
	mkdir -p "$3" #creates the directory if doesn't exist
	cp -i "$4/1.$2" "$3" #copies the file
	mv -i "$3/1.$2" "$3/$5$1.$2" #renames the file
}

function help {
	echo """${red}Usage: ${bold}[CREAC]${reset}${red} <OPTION>
	OPTION:
	    ${yellow}<noargs>    --> 	Creates the file in the active directory
		<r>	--> 	Specify the route if you dont want the active directory
		<d>	--> 	Creates the file inside the specified folder
		<u>	-->	Creates the file with the USERNAME
		<h>	--> 	Shows help${reset}"""
	exit 0
}

while getopts ":r :d :u :h" OPT; do
	case $OPT in
		r) read -ep "${red}[CREAC]${yellow} Path: ${reset}" DIRECTORY ;;
		d) read -p "${red}[CREAC]${yellow} Directory name: " FOLDER_NAME;DIRECTORY="$DIRECTORY/$FOLDER_NAME" ;;
		u) USER=$USER_NAME ;; #default value user name
		h) help ;;
	 	\?) echo "Invalid option: -$OPTARG";exit 1 ;;
	esac
done

read -p "${red}[CREAC]${yellow} Extension for your file: ${reset}" FILE_EXTENSION
case $FILE_EXTENSION in
	odt|xml|dtd|dia|txt) read -p "${red}[CREAC]${yellow} Your file name: ${reset}" FILE_NAME
 			     create "$FILE_NAME" "$FILE_EXTENSION" "$DIRECTORY" "$FILES_DIRECTORY" "$USER" ;;
	*) echo "${red}${bold}Error: choose a valid extension!${reset}";exit 1
esac
exit 0
