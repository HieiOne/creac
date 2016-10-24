#!/bin/bash
ruta=`pwd`
mkdir "$ruta"/$1
cp /home/ivan/1.odt "$ruta"/$1
mv "$ruta"/$1/1.odt "$ruta"/$1/$1.odt

