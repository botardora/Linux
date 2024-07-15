# Név: Botar Dóra
# Azonosító: bdgi4409

#!/bin/bash

# 10.Írjunk felügyelő programot, amely egy "időzített üzeneteket" tartalmazó állományt kap paraméterként. Ennek szerkezete a következő formátumú:
#         [perc]
#         * [max 10 soros szöveg, melynek minden sora a * karakterre kezdődik]
# A script percenként figyelje a rendszeridőt, és amennyiben a percek száma éppen megegyezik a megadott állomány valamelyik bemenetében megadottal, végezzük el az alábbi feladatokat a config állományban található beállítások alapján:
# -uzemmod=lassu esetén a többsoros szöveg sorait 5 másodpercenként írjuk ki
# -uzemmod=csendes esetén a szöveget egy kimenet nevű állományhoz adjuk hozzá úgy, hogy az üzenet elé a pontos dátum illetve rendszeridő kerüljön
# -alapértelmezett eset (ha a config állomány bármi mást tartalmaz vagy esetleg nem is létezik): a megfelelő szöveget a képernyőre írjuk ki.
# Amikor a script észreveszi, hogy csendes üzemmódból áttértünk valamelyik másik üzemmódba, jelenítsük meg a kimenet nevű állomány tartalmát a képernyőn, majd töröljük a kimenet állományt.
# Megjegyzés: a szöveget a sor elején levő * karakterek nélkül írjuk ki.

if [ $# -ne 1 ]
then
        echo "nincs parameter"
        echo "hasznalat: $0 parameter"
        exit 1
fi

if [ ! -f $1 ]
then
	echo "$1 nem egy allomany"
	echo "hasznalat: $0"
	exit 1
fi

touch kimnenet
while true
do
	perc=$(date +"%M")
	while read -r sor
	do
	        if [ -f "config" ] && grep -q "csendes" config; then
                	uzemmod="csendes"
        	elif [ -f "config" ] && grep -q "lassu" config; then
                	uzemmod="lassu"
        	else
                	uzemmod="mas"
        	fi
        	#echo $uzemmod
		if [[ $sor =~ ^[0-9]+$ ]]
		then
	#	echo $sor
			percsor=${sor%% *}
			if [ $percsor == $perc ]
			then
				if [ $uzemmod == "lassu" ]
				then  	
					while read kovsor
					do
                			if echo "$kovsor" | grep -qE '^[0-9]+.*$' 
                			then  
                    				break 
                			else
                    			echo "$kovsor"  | awk '{sub(/^\*/, ""); system("sleep 5");  print}'
			                fi
			           	done
			        				
				elif [ $uzemmod == "csendes" ]
				then
					regi=$(stat -c %Y config)
					echo $date > kimenet
					while read kovsor
                                        do
                                        if echo "$kovsor" | grep -qE '^[0-9]+.*$'
                                        then
                                                break
                                        else
                                        echo "$kovsor"  | awk '{sub(/^\*/, ""); system("sleep 5");  print}'  >> kimenet
                                        fi
                                        done
                                        sleep 15
                                        most=$(stat -c %Y config)
                                        
    					if [[ "$regi" != "$most" ]]; then
        					cat kimenet
        					rm kimenet
        					regi=$most
    					fi
				elif [ $uzemmod == "mas" ]; then
					while read kovsor
                                        do
                                        if echo "$kovsor" | grep -qE '^[0-9]+.*$'
                                        then
                                                break
                                        else
                                        echo "$kovsor"  | awk '{sub(/^\*/, ""); print}' 
                                        fi
                                        done
				fi
			fi
    	fi
    	done <$1
	sleep 60
done 






