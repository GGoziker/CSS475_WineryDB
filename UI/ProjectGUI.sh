#!/bin/bash



# ------------------- Utility Functions -------------------

connect_to_db()
{
	DBNAME='Winery_DB'
	USERNAME='root'
	read -sp 'MySQL Password: ' PASSWORD

	echo

	while $(! mysql -u "$USERNAME" -p"$PASSWORD" -e "use $DBNAME");
	do
		echo
		read -sp 'MySQL Password: ' PASSWORD
	done
	echo
	echo 'Connected to database!'
}



display_commands()
{
	echo
	echo 'Enter one of the following commands:'
	echo -e '\tFind_bottle (Search for where to buy a particular bottle)'
	echo -e '\tFind_venue (Search for rentable venues by winery)'
	echo -e '\tBuy_bottle'
	echo -e '\tRent_venue'
	echo -e '\tExit'
	echo
}



process_command()
{
	read -p '->' user_input
	echo
	case $user_input in
		Find_bottle)
			echo 'You chose to find a bottle'
			find_bottle
			;;
		Find_venue)
			echo 'You chose to find a venue'
			find_venue
			;;
		Buy_bottle)
			echo 'You chose to buy a bottle'
			buy_bottle
			;;
		Rent_venue)
			echo 'You chose to rent a venue'
			rent_venue
			;;
		exit)
			echo 'Thanks for using our database!'
			exit
			;;
		*)
			echo 'That'\''s not a valid command.'
			;;
	esac
}



# -------------- Command Processing Functions -------------

# Search database for a bottle
find_bottle()
{
	while :
	do
		echo 'Type '\''n'\'' to search by wine name, or '\''c'\'' to search by wine color:'
		read -p '->' user_input
		echo
		case $user_input in
			n)
				read -p 'Wine name: ' wine_name
				read -p 'Winery: ' winery
				find_bottle_by_name wine_name winery
				break
				;;
			c)
				read -p 'Wine color: ' wine_color
				read -p 'Winery: ' winery
				# TODO call SQL query
				break
				;;
			*)
				echo 'That'\''s not a valid option.'
				;;
		esac
		echo
	done
}



find_venue()
{
	echo 'in find_venue'
}



buy_bottle()
{
	echo 'in buy_bottle'
}



rent_venue()
{
	echo 'in rent_venue'
}



# ---------------------- SQL Queries ----------------------

find_bottle_by_name()
{
	query="	Select wine_bottle.wine_bottle_id, winery.name as winery, wine_bottle.volume, wine_bottle.unit_price as price 
		From wine_bottle, winery, wine_cellar 
		Where	wine_bottle.cellar_ID = wine_cellar.cellar_ID 
			AND wine_cellar.winery_id = winery.winery_id 
			AND wine_bottle.name = \"eu\" 
			AND winery.name = \"Columbia Winery\";"
	run_query "$query"
}



run_query()
{
	mysql -u "$USERNAME" -p"$PASSWORD" -D"$DBNAME" -e "$1"
}



# ------------------------ Main Loop ----------------------

connect_to_db
while :
do
	display_commands
	process_command
done
