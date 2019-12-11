#!/bin/bash

connect_to_db()
{
	read -p 'MySQL DB Name: ' dbname
	read -p 'MySQL Username: ' username
	read -sp 'MySQL Password: ' password

	echo

	while $(! mysql -u "$username" -p"$password" -e "use $dbname");
	do
		echo
		echo 'Please double-check username/password/DB name and try again.'
		echo
		read -p 'MySQL DB Name: ' dbname
		read -p 'MySQL Username: ' username
		read -sp 'MySQL Password: ' password
	done
	echo
	echo 'Connected to database!'
}

connect_to_db