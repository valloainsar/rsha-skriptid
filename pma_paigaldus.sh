# phpmyadmin paigaldamine

# defineeritakse väärtus
# kontrollimaks pma olemasolu
PMA=$(dpkg-query -W -f='${status}' phpmyadmin 2>/dev/null | grep -c 'ok installed')
# Kui väärtus = 0
if [ $PMA -eq 0 ]; then
	# siis pma installitakse
	echo "Installeerime phpmyadmini ning vajalikud lisad!!"
	apt install phpmyadmin
	echo "phpadmin on installeeritud!"
# Kui väärtus = 1
elif [ $PMA -eq 1 ]; then
	# siis kontrollitakse olemasolu
	echo "phpmyadmin on juba installitud!"
fi

# skripti lõpp
