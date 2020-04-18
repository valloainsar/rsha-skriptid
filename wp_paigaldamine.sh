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
	echo "Apache on juba installitud!"
	service apache2 start
fi

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
	echo "mysql server on juba installitud!"
fi

#php paigaldamine
#
# kuna väärtust kasutatakse mitmes kohas
# siis on mõistlik see ära defineerida.
PHP=$(dpkg-query -W -f='${status}' php7.0 2>/dev/null | grep -c 'ok installed')
# Kui väärtus = 0
if [ $PHP -eq 0 ]; then
	# teenuse paigaldmine
	echo "PHP ja lisapakettide paigaldamine!"
	apt install php7.0 libapache2-mod-php7.0 php7.0-mysql
	echo "PHP on paigaldatud!"
# Kui väärtus = 1
elif [ $PHP -eq 1 ]; then
	# Kontrollitakse olemasolu
	echo "PHP on juba installitud!"
fi

# Luuakse kõik vajalikud andmebaasi ning kasutajad
mysql <<EOF
CREATE DATABASE wordpress;
CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';
FLUSH PRIVILEGES;
EOF
echo "Andmebaas ning kasutajad loodud!"

# Et kasutaja jõuaks väljastatud info lugeda!
sleep 10

# Laetakse alla wp ning pakitakse see ettenähtud kausta lahti
cd /var/www/html/
wget https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
cp wordpress/wp-config-sample.php wordpress/wp-config.php
echo "Wordpress allalaetud ning lahtipakitud!"

# Konfigureeritakse wordpress
cd /var/www/html/wordpress/
sed -i 's/database_name_here/wordpress/g' wp-config.php
sed -i 's/username_here/wordpressuser/g' wp-config.php
sed -i 's/password_here/qwerty/g' wp-config.php
echo "Wordpress on konfigureeritud!"

# skripti lõpp
