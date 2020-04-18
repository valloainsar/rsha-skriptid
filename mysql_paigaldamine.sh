# mysql-serveri paigaldamine
# defineeritakse väärtus
MYSQL=$(dpkg-query -W -f='${status}' mysql-server 2>/dev/null | grep -c 'ok installed')
# Kui väärtus = 0
if [ $MYSQL -eq 0 ]; then
	# siis installitakse mysql server
	echo "Paigaldatakse mysql ja lisad!"
	apt install mysql-server
	echo "mysql on paigaltatud"
	# ilma kasutaja ja paroolita
	touch $Home/.my.cnf
	echo "[client]" >> $Home/.my.cnf
	echo "host = localhost" >> $Home/.my.cnf
	echo "user = root" >> $Home/.my.cnf
	echo "password = qwerty" >> $Home/.my.cnf
# Kui väärtus = 1
elif [ $MYSQL -eq 1 ]; then
	# Siis kontrollitakse mysql olemasolu
	echo "mysql server on juba installitud"
	mysql
fi

# skripti lõpp
