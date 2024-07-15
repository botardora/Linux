

# Név: Botar Dóra
# Azonosító: bdgi4409

# B. Adott egy állomány, melynek formátuma:
#       diák_felhasználónév tantárgy1 jegy1 tantárgy2 jegy2 ... tantárgyN jegyN
# Asszociatív tömb(ök) használatával írjunk ki statisztikát az alábbi információkkal, a fent megadott formátumú, 
# első paraméterként megadott állományt felhasználva:
# - melyik tantárgyból hány diák vizsgázott - illetve hány diáknak sikerült a vizsgája
# - az összes tantárgyat tekintve melyik jegy hányszor szerepel
# - a második paraméterként megadott tantárgyat tekintve melyik jegy hányszor szerepelt, és melyik jegy 
# szerepelt a legtöbbször (ha több jegyből is ugyanannyi van, akkor a legnagyobb jegyet írjuk ki)

if [ $# -lt 1 ]
then
	echo "hasznalat: $0 nem adtal meg parametert"
        exit 1
fi

if [ ! -f $1 ]
then
	echo "hasznalat: $0 $1 nem egy allomany"
	exit 1
fi

awk '
#megszamoljuk melyik tantargybol hanyan vizsgaztak es hanynak sikerult a vizsgaja, azaz lett legalabb 5-os jegye
{ for (i=2; i<=NF; i=i+2) { tantargyak[$i]++; 
	if ( $(i+1) >= 5 ) { atmeno[$i]++ }}}

#megszamoljuk melyik jegy hanyszor szerepel
{ for (i=3; i<=NF; i=i+2) { jegyszam[$i]++ }}

END { 
print "----- Vizsgazo diakok szama tantargyakkent ----- " 
for (i in tantargyak) print i, "-", tantargyak[i];
print "----- Sikeresen vizsgazo diakok szama ----- "
for (i in atmeno) print i, "-", atmeno[i]}' $1

awk '
#megszamoljuk melyik jegy hanyszor szerepel
{ for (i=3; i<=NF; i=i+2) { if ($i ~ /^[0-9]+$/) {jegyszam[$i]++}}}

END {
print "----- Jegyek gyakorisaga ----- "
for (i in jegyszam) print i, "-", jegyszam[i]}' $1

#ellenorizzuk, ha letezik a tantargy
if grep -q $2 $1 
then

awk -v targy=$2 max=0'
#megszamoljuk melyik jegy hanyszor szerepel
{ for (i=2; i<=NF; i=i+2) { if ( $i==targy ) { jegyek[$(i+1)]++ }}}

#megkeressuk a legtobbszor szereplo jegyet
{ for (i in jegyek) { if( max<jegyek[i] ) { max=jegyek[i]; jmax=i }
if ( max==jegyek[i] && jmax<i ) { jmax=i }}}

END {
print "----- megadott targy szerint melyik jegy hanyszor szerepelt -----"
for (i in jegyek) print i, "-", jegyek[i];
print "a legtobbszor megjeleno jegy: ", jmax;
}' $1

else echo "hasznalat: $0  $2 tantargy nem letezik"
fi


