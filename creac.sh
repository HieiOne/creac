#!/bin/bash
red=`tput setaf 1`
reset=`tput sgr0`
ruta=`pwd`

case "$2" in
("odt"|"xml"|"dtd"|"dia"|"txt") 
	mkdir "$ruta"/$1
	touch "$ruta"/$1/$1.$2
   ;;
*) echo ${red}"The extension you chosen is not available at the moment!" ${reset}
   ;;
esac


#	cp /home/ivan/1.$2 "$ruta"/$1
#	mv "$ruta"/$1/1.$2 "$ruta"/$1/"$1.$2"
##Parche hasta que pueda modificar XML
#unzip path/container.odt content.xml
#xmlstarlet ed -u "/note/from" -v 123 xmlinside.xml > archivo.xml
#xmlstarlet ed --subnode "/osm/node" --type elem -n newsubnode -v "TEXT GOES HERE" input.xml > output.xml