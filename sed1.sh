#!/bin/bash

# Név: Botar Dóra
# Azonosító: bdgi4409

# 2. A paraméterekként megadott állomány(ok)ból törölje ki azokat a sorokat, 
# amelyek az első paraméterként megadott szóval kezdődnek. A paraméterek sorrendje: szó állományn(év/evek).


if [ $# -lt 1 ]
then
        echo "nincs parameter"
        exit 1
fi

if [ $# -lt 2 ]
then
        echo "nincs 2 parameter"
        exit 1
fi

if expr "$1" : "^[0-9]\+$" >/dev/null 
then
	echo "a $1 parameter nem szo"
	exit 1
fi

szo=$1
shift 
while [[ $@ ]]
do	
	if [[ ! -f $1 ]]
	then
		echo "$1 nem letezik az allomany"
	else
		sed -i "/^$szo/d" "$1"
               	echo "$1 modositottuk"
	fi
shift 
done
