#!/bin/bash
ruta=`pwd`
ext=`$2`
mkdir "$ruta"/$1
touch "$ruta"/$1.$ext

