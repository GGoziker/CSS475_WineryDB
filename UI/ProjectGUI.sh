#!/bin/bash
export PATH=$PATH:/usr/local/mysql/bin



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
	echo 'Enter one of the following commands (case sensitive):'
	echo -e '\tFind_bottle   (Search a particular winery for a particular bottle of wine)'
	echo -e '\tFind_venue    (Search for rentable venues by winery)'
	echo -e '\tBuy_bottle    (Purchase a bottle)'
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
		Exit)
			echo 'Thanks for using our database!'
			exit
			;;
		*)
			echo 'That'\''s not a valid command.'
			;;
	esac
}



# -------------- Command Processing Functions -------------

# Search a winery for a bottle
find_bottle()
{
	while :
	do
		echo 'Type '\''n'\'' to search by wine name, or '\''c'\'' to search by wine color:'
		read -p '->' user_input
		echo
		case $user_input in
			n)
				printf 'Wine Name: '
				read wine_name
				printf 'Winery: '
				read winery
				echo -e "\nSearching $winery for bottles of $wine_name"
				find_bottle_by_name
				break
				;;
			c)
				printf 'Wine Color: '
				read wine_color
				printf 'Winery: '
				read winery
				echo -e "\nSearching $winery for bottles of $wine_color"
				find_bottle_by_color
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
	while :
	do
		echo 'Type '\''n'\'' to search by wine name, or '\''c'\'' to search by wine color:'
		read -p '->' user_input
		echo
		case $user_input in
			n)
				printf 'Wine Name: '
				read wine_name
				printf 'Winery: '
				read winery
				echo -e "\nSearching $winery for bottles of $wine_name"
				find_bottle_by_name
				break
				;;
			c)
				printf 'Wine Color: '
				read wine_color
				printf 'Winery: '
				read winery
				echo -e "\nSearching $winery for bottles of $wine_name"
				find_bottle_by_name
				break
				;;
			*)
				echo 'That'\''s not a valid option.'
				;;
		esac
		echo
	done
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
	query="	Select wine_bottle.name as Bottle, wine_bottle.wine_bottle_id as Bottle_ID, winery.name as Winery, wine_bottle.Volume, wine_bottle.unit_price as Price 
		From wine_bottle, winery, wine_cellar 
		Where	wine_bottle.cellar_ID = wine_cellar.cellar_ID 
			AND wine_cellar.winery_id = winery.winery_id 
			AND wine_bottle.name = \"$wine_name\" 
			AND winery.name = \"$winery\";"
	mysql -u "$USERNAME" -p"$PASSWORD" -D"$DBNAME" -e "$query"
}



find_bottle_by_color()
{
	query="	Select wine_type.Color, wine_bottle.name as Bottle, wine_bottle.wine_bottle_id as Bottle_ID, winery.name as Winery, wine_bottle.Volume, wine_bottle.unit_price as Price 
		From wine_bottle, winery, wine_cellar, wine_type 
		Where	wine_bottle.cellar_ID = wine_cellar.cellar_ID 
			AND wine_cellar.winery_id = winery.winery_id 
			AND wine_bottle.wine_type_id = wine_type.wine_type_id 
            		AND wine_type.color = \"$wine_color\" 
			AND winery.name = \"$winery\";"
	mysql -u "$USERNAME" -p"$PASSWORD" -D"$DBNAME" -e "$query"
}



# ------------------------ Main Loop ----------------------

connect_to_db
while :
do
	display_commands
	process_command
done
