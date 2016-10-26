#if (( $("-r" | "--route" | "-dr" | "-rd") == "$1" ))
#!/bin/bash
##########################################################################################
# Name: creac                                                                
# Author: Hiei <blascogasconiban@gmail.com>                                                  
# Version: 2.3                                                                           
# Description: 
#              This Script will create file wherever you want with almost any extension
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
if [[ "$1" == "-r" ]] || [[ "$1" == "--route" ]] || [[ "$1" == "-dr" ]] || [[ "$1" == "-rd" ]] ; then
	read -ep "${red}[CREAC]${yellow} Path: ${reset}" ruta
	if [ ! -d $ruta ] && [[ "$1" == "-dr" ]] || [[ "$1" == "-rd" ]]  ; then
  		mkdir -p $ruta;
	fi
fi
read -p ${red}"[CREAC]${yellow} Name of the file and the extension [file.ext]:${reset} " filename
IFS=. read name ext <<<"${filename}"

case "$ext" in
("odt"|"xml"|"dtd"|"dia"|"txt")
	if [[ "$1" == "-d" ]] || [[ "$1" == "--directory" ]] ; then
		mkdir -p "$ruta"/$name
		cp /etc/creac/ext/1.$ext "$ruta"/$name
		mv "$ruta"/$name/1.$ext "$ruta"/$name/"$name.$ext"
	else
		cp /etc/creac/ext/1.$ext "$ruta"
		mv "$ruta"/1.$ext "$ruta"/"$name.$ext"		
	fi
#	touch "$ruta"/$name/$name.$ext
   ;;
*) echo ${red}"The extension you chosen is not available at the moment!" ${reset}
   ;;
esac