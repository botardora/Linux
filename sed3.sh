#!/bin/bash

# Név: Botar Dóra
# Azonosító: bdgi4409

# 10. A paraméterekként megadott állományok soraiban cserélje fel az első és harmadik szót. 
# A szavak csak betűket tartalmaznak, minden más karaktert elválasztó karakternek tekintünk.

if [ $# -lt 1 ]
then
        echo "nincs parameter"
        exit 1
fi

while [[ $@ ]]; do
	file=$1
	if [ ! -f $file ]; then
		echo "a $file allomany nem letezik"
	else
		sed -i -r 's/^([a-zA-Z]*)([^a-zA-Z]+[a-zA-Z]+[^a-zA-Z]+)([a-zA-Z]*)(.*)/\3\2\1\4/g' "$file"
		echo "$file modositottuk"
	fi
	shift 
done
