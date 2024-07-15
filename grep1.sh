#!/bin/bash

# Név: Botar Dóra
# Azonosító: bdgi4409

# 5.Írassa ki a paraméterként megadott parancsot végrehajtó felhasználók azonosítóját.
# Az eredményt lista formájában írjuk ki a képernyőre, a következő formában:
# [user1]
# [user2]
# ...
# [userN]
# ahol a [user] helyett a megfelelő felhasználóneveket jelenítsük meg.

if [ $# -ne 1 ]
then
        echo "nincs parameter"
        echo "hasznalat: $0 parancs"
        exit 1
fi

parancs=$1
pid=$(ps -C "$parancs" -o pid=)
if  [ -n "$pid" ] 
then 
	w | grep "$parancs" | cut -d" " -f1
else
        echo "nem hasznalja senki a parancsot"
fi