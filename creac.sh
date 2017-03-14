#!/bin/bash
##########################################################################################
# Name: creac
# Author: Hiei <blascogasconiban@gmail.com>
# Version: 3.3.6/stable
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
#		-   If you use argument "-d" make sure to use arguments one by one (e.g creac -d "name" -u"
#
##########################################################################################
source "$(dirname $0)"/creac.conf #to avoid problems if it is moved, creac.sh and creac.conf must stay together

DIRECTORY=$(pwd)
USER=""

function updater {
LOCAL=$(git -C "$(dirname $0)" rev-parse @)
REMOTE=$(git -C "$(dirname $0)" ls-remote origin -h refs/heads/master | cut -f1)

if ! [ $LOCAL = $REMOTE ]; then
	echo "${red}${bold}You need to update $0!"
	read -ep "Want to do it now? ${reset}" ANSWER
	if [ $ANSWER = "y" ] || [ $ANSWER = "Y" ]; then
		git -C "$(dirname $0)" pull
		exit 0
	else
		exit 1
	fi
else
	echo "${red}${bold}You have the latest available version!${reset}"
	exit 0
fi
}

function create() {
	#$1=FILE_NAME $2=EXTENSION $3=DIRECTORY $4=FILES_DIRECTORY $5=USER
	mkdir -p "$3" #creates the directory if doesn't exist
	cp -i "$4/1.$2" "$3" #copies the file
	mv -i "$3/1.$2" "$3/$5$1.$2" #renames the file
}

function help {
	echo """${red}Usage: ${bold}[CREAC]${reset}${red} <OPTION>
	OPTION:
	    ${yellow}<noargs>      --> 	Creates the file in the active directory
		<r>	  --> 	Specify the path if you dont want the active directory
		<d><name> --> 	Creates the file inside the specified folder
		<D>	  -->	Same as "d" but no argument needed
		<u>	  -->	Creates the file with the USERNAME
		<f>	  -->	Check if there's any new version
		<h>	  --> 	Shows help${reset}"""
	exit 0
}

while getopts ":r :d: :D :u :h :f" OPT; do
	case $OPT in
		r) read -ep "${red}[CREAC]${yellow} Path: ${reset}" DIRECTORY ;;
		d) DIRECTORY="$DIRECTORY/$OPTARG" ;;
		D) read -p "${red}[CREAC]${yellow} Directory name: ${reset}" FOLDER_NAME;DIRECTORY="$DIRECTORY/$FOLDER_NAME" ;;
		u) USER=$USER_NAME ;; #default value user name
		h) help ;;
		f) updater ;;
	 	\?) echo "${red}${bold}Invalid option: -$OPTARG";exit 1 ;;
		:) echo "${red}${bold}Option -$OPTARG requires an argument";exit 1 ;;
	esac
done

read -p "${red}[CREAC]${yellow} Extension for your file: ${reset}" FILE_EXTENSION
case $FILE_EXTENSION in
	odt|xml|dtd|dia|txt) read -p "${red}[CREAC]${yellow} Your file name: ${reset}" FILE_NAME
 			     create "$FILE_NAME" "$FILE_EXTENSION" "$DIRECTORY" "$FILES_DIRECTORY" "$USER" ;;
	*) echo "${red}${bold}Error: choose a valid extension!${reset}";exit 1
esac
exit 0
