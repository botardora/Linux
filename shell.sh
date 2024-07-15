#!/bin/bash

# Név: Botar Dóra
# azonosító: bdgi4409

# 10.Írjon shell script-et, amely paraméterként egy állománynévből és egy k számból álló párokat kap. Minden ilyen párra írja ki 
# az állomány nevét, a k számot és
# amennyiben az állománynak több, mint k sora van, az állomány első k sorát
# amennyiben az állománynak kevesebb, mint k sora van, akkor minden sorból az első k karaktert
# Minden állomány listázása esetén írjuk ki előbb, hogy mit csinálunk, és a rendszeridőt is:
# [filename] [k]
# elso [k] sor listazasa [ora:perc:masodperc]
# [sorok]
# vagy
# [filename] [k]
# soronkent az elso [k] karakter listazasa [ora:perc:masodperc]
# [karakterek]
# ahol a [filename] helyére a paraméterként megadott állománynevek, a [k] helyére a paraméterként megadott számok, míg az [ora:perc:masodperc] helyére a művelet végrehajtásának rendszerideje (a megadott formátumban), a [sorok], illetve [karakterek] helyére az állományok megfelelő sorai és karakterei kerüljenek.
# Az olvashatóság kedvéért két állományra vonatkozó kiírás közé tegyünk egy elválasztó sort a következő módon:
# ------------------------------

#parameterek szamanak ellenorzese
if [ $# -lt 2 ]
then
	echo "hasznalat: $0 nincs legalabb 2 parameter"
        exit 1
fi

#paros-e a parameterek szama
p=$#
if [ $((p%2)) -ne 0 ]
then
	echo "hasznalat: $0 a parameterek szama nem paros, minden file-hoz kell tartozzon egy szam is"
	exit 1
fi

#ellenorzes, hogy file e az elso parameter
if [ ! -f $1 ]
then
        echo "hasznalat: $0 $1 nem egy file"
        echo "--------------------------------"
        shift 2
fi

#ellenorzes, hogy szam-e a masodik parameter 
if [ ! $1 = ~^[0-9]+$ ] 
then
	echo "hasznalat: $0 $2 nem szam"
        echo "--------------------------------"
        shift 2
fi

while (($#)); do
	allomanynev=$1 
	k=$2
	echo "$allomanynev" "$k"
	sorokszama=$( (wc -l) < $allomanynev )
	if(( "sorokszama" > "k" )); then
		most=$(date +"%T")
		echo "elso $k sor listazasa $most "
		head -n $k $allomanynev
		echo "--------------------------------"
	
	elif(( "sorokszama" < "k" )); then
		most=$(date +"%T")
                echo "soronkent az elso $k karakter listazasa $most " 
                cut -c1-$k $allomanynev
                echo "--------------------------------"
        else
        	most=$(date +"%T")
                echo "soronkent az elso $k karakter listazasa $most "
                cut -c1-$k $allomanynev
                echo "--------------------------------"
        	
	fi
	shift 2
done












