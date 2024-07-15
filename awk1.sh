

# Név: Botar Dóra 
# Azonosító: bdgi4409

# A.Határozzuk meg az első paraméterként kapott katalógus alkatalógusainak átlagos 
# méretét, illetve a második paraméterként megadott méretnél nagyobb alkatalógusok 
# nevét és számát. A paraméterként megadott méret kilobyte-ban van megadva. 
# Az eredményt a következőképpen írjuk ki:
#  átlag: [átlag]
#  [alkatalógus]
#  [alkatalógus]
#  ...
#  összesen [n] darab [k] kilobyte-nál nagyobb alkatalógus
# ahol a helykitöltők helyére a megfelelő adatok kerülnek.

if [ $# -lt 2 ]
then
        echo "nincs 2 parameter"
        exit 1
fi


katalogus=$1
meret=$2

if  [ -d $katalogus ]
then
        if [[ $meret =~ ^[0-9]+$ ]]
        then
        du $katalogus/* | awk -v  meret=$meret '
        BEGIN {
            atlag = 1;
            ossz = 0;
            szam = 0;
            nagyobb_katalogus = "";
            s = 0;
        }
        {
                kat_meret = $1;
                kat_neve = substr($0, index($0,$2));
                ossz += kat_meret;
                szam++;
                if(kat_meret>meret) {nagyobb_katalogus = nagyobb_katalogus "  " kat_neve "\n"; s++}
        }
        END{
                atlag=(szam>0)? ossz/szam : 0;
                printf "atlag: %s\n", atlag;
                printf "alkatalogusok:\n%s", nagyobb_katalogus;
                printf "osszesen %d darab %s kilobyte-nal nagyobb alkatalogus\n", s, meret;
        }'
         else
                echo "$meret - nem szam"
        fi
else
        echo "$katalogus - nem egy katalogus"
fi