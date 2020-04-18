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
	which php
fi

# skripti lõpp
