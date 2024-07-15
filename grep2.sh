#!/bin/bash

# Név: Botar Dóra
# Azonosító: bdgi4409

# 10. Írassa ki a paraméterként megadott felhasználó(k)ról,
# hogy a bejelentkezési katalógusuk tartalma mások számára kilistázható-e vagy sem. 
# FIGYELEM! Természetesen csak a létező felhasználóneveket vegyük figyelembe, 
# a nemlétezőkre is írjunk ki megfelelő üzenetet.
# Az eredményt a következő formában írjuk ki:
# [user1] - [listazhato/nem listazhato]
# [dklghskdjg] - nem letezik
# [user2] - [listazhato/nem listazhato]
# ahol a [user] helyett a megfelelő felhasznónevet, 
# [listazhato/nem listazhato] helyére pedig a bejelentkezési katalógusra vonatkozó megfelelő információt írjuk.

if [ $# -lt 1 ]; then
	echo "nincs parameter"
	echo "hasznalat: $0 felhasznalo"
	exit 1
fi

grep  -oE "^[^:]+" /etc/pseudopasswd | cut -d: -f1 | while (($#)); do
        felhasznalo=$1
        if id "$felhasznalo" >/dev/null 2>&1; then
		if  [ -x "/home/$felhasznalo" ]; then
			echo "$felhasznalo - listazhato"
                else
                        echo "$felhasznalo - nem listazhato"
                fi
        else
                echo "$felhasznalo - nem letezik"
	fi
	shift 
done	
		
 