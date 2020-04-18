# apache paigaldamine, kuna järgnevat väärtust kasutatakse mitu korda siis on mõistlik defineerida
APACHE2=$(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c 'ok installed')
# Kui muutuja väärtus = 0-ga
if [ $APACHE2 -eq 0 ]; then
	echo "Apache2 paigaldamine"
	apt install apache2
	echo "Apache on paigaldatud"
# Kui muutuja väärtus = 1-ga
# samuti kontrollitakse, kas teenus on aktiivne ilma veateadeteta
elif [ $APACHE2 -eq 1 ]; then
	echo "Apache on juba installitud"
	service apache2 start
	service apache2 status

fi

# skripti lõpp
