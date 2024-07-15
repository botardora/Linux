#!/bin/bash

# Név: Botar Dóra
# Azonosító: bdgi4409

# 6. A paraméterekként megadott állományokban szereplő minden nagybetűtől különböző karaktert 
# cserélejen ki az első paraméterként megadott karakterre. 
# A paraméterek sorrendje: karakter állományn(év/evek).

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

karakter=$1
shift

while [[ $@ ]]
do
	if [[ ! -f $1 ]]
        then
                echo "$1 nem letezik az allomany"
        else
        	sed -i -r "s/[^A-Z ]/$karakter/g" "$1"
        	echo "$1 modositottuk"
	fi
	shift
done        	
        	
        	
        	
        	