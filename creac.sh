#!/bin/bash
##########################################################################################
# Name: creac                                                                
# Author: Hiei <blascogasconiban@gmail.com>                                                  
# Version: 2.7                                                                           
# Description: 
#              This Script will create file wherever you want with almost any extension
# 
# To do: Interactive if the file already exists
#		
#	                                                                                                                                            
# IMPORTANT:                                                                             
#	        -   If any extension is not included, you can add it manually by: 
#			1.- Create a file "1.extension" in the folder /etc/creac/ext
#			2.- Add it to the case like ("odt")                                                                             
#                                                                                                                                                    
##########################################################################################
red=`tput setaf 1`
reset=`tput sgr0`
yellow=`tput setaf 3`


ruta=`pwd`
user="IvanBlasco_" #Modify the user if you want other name

if [[ "$1" == "-r" ]] || [[ "$1" == "--route" ]] || [[ "$1" == "-dr" ]] || [[ "$1" == "-rd" ]] ; then 
	read -ep "${red}[CREAC]${yellow} Path: ${reset}" ruta #Changing "ruta" if -r
	if [ ! -d $ruta ] && [[ "$1" == "-dr" ]] || [[ "$1" == "-rd" ]]  ; then
  		mkdir -p $ruta;
	fi
fi

read -p ${red}"[CREAC]${yellow} Name of the file and the extension [file.ext]:${reset} " filename  #Reading the file name user wants

ext=${filename##*.}		 #Cutting out the extension of the file
name=${filename%"."$ext}	#Cutting out the name of the file

case "$ext" in
("odt"|"xml"|"dtd"|"dia"|"txt")		#Enabled extensions, just add the extension to the folder and add it for enable another one
	
	if [[ "$1" == "-d" ]] || [[ "$1" == "--directory" ]] || [[ "$1" == "-ud" ]] || [[ "$1" == "-du" ]]  ; then 
		mkdir -p "$ruta"/$name
		if [[ ! -e "$ruta"/$name/"$user$name.$ext" ]] || [[ ! -e "$ruta"/$name/"$name.$ext" ]] ; then  
			cp -i /etc/creac/ext/1.$ext "$ruta"/$name
			if [[ "$1" == "-u" ]] || [[ "$1" == "-ud" ]] || [[ "$1" == "-du" ]] ; then
				mv -i "$ruta"/$name/1.$ext "$ruta"/$name/"$user$name.$ext"
			else
				mv -i "$ruta"/$name/1.$ext "$ruta"/$name/"$name.$ext"
			fi
		else
			echo "File already exists"
		fi
	else
		cp -i /etc/creac/ext/1.$ext "$ruta"
		if [[ "$1" == "-u" ]] || [[ "$1" == "-ud" ]] || [[ "$1" == "-du" ]] ; then
			mv -i "$ruta"/1.$ext "$ruta"/"$user$name.$ext"
		else
			mv -i "$ruta"/1.$ext "$ruta"/"$name.$ext"
		fi		
	fi
   ;;
*) echo ${red}"The extension you chosen is not available at the moment!" ${reset}
   ;;
esac
exit 0
