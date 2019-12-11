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
				# Search for wine by name
				printf 'Wine Name: '
				read wine_name
				printf 'Winery: '
				read winery
				echo -e "\nSearching $winery for bottles of $wine_name"
				find_bottle_by_name_sql
				break
				;;
			c)
				# Search for wine by color
				printf 'Wine Color: '
				read wine_color
				printf 'Winery: '
				read winery
				echo -e "\nSearching $winery for bottles of $wine_color"
				find_bottle_by_color_sql
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
		echo 'See only available venues? (Type '\''y/n'\'')'
		read -p '->' user_input
		echo
		case $user_input in
			y)
				# Search only available venues
				printf 'Winery: '
				read winery
				printf 'Date (format yyyy-mm-dd):'
				read date
				echo -e "\nSearching for venues at $winery available on $date"
				find_venue_available_sql
				break
				;;
			n)
				# Search all venues
				printf 'Winery: '
				read winery
				echo -e "\nSearching for venues at $winery"
				find_venue_all_sql
				break
				;;
			*)
				echo 'That'\''s not a valid option.'
				;;
		esac
		echo
	done
}



rent_venue()
{
	echo 'in rent_venue'
}



# ---------------------- SQL Queries ----------------------

find_bottle_by_name_sql()
{
	query="	Select wine_bottle.name as Bottle, wine_bottle.wine_bottle_id as Wine_ID, winery.name as Winery, wine_bottle.Volume, wine_bottle.unit_price as Price 
		From wine_bottle, winery, wine_cellar 
		Where	wine_bottle.cellar_ID = wine_cellar.cellar_ID 
			AND wine_cellar.winery_id = winery.winery_id 
			AND wine_bottle.name = \"$wine_name\" 
			AND winery.name = \"$winery\";"
	mysql -u "$USERNAME" -p"$PASSWORD" -D"$DBNAME" -e "$query"
}



find_bottle_by_color_sql()
{
	query="	Select wine_type.Color, wine_bottle.name as Bottle, wine_bottle.wine_bottle_id as Wine_ID, winery.name as Winery, wine_bottle.Volume, wine_bottle.unit_price as Price 
		From wine_bottle, winery, wine_cellar, wine_type 
		Where	wine_bottle.cellar_ID = wine_cellar.cellar_ID 
			AND wine_cellar.winery_id = winery.winery_id 
			AND wine_bottle.wine_type_id = wine_type.wine_type_id 
            		AND wine_type.color = \"$wine_color\" 
			AND winery.name = \"$winery\";"
	mysql -u "$USERNAME" -p"$PASSWORD" -D"$DBNAME" -e "$query"
}



find_venue_all_sql()
{
	query="	Select	venue.name as Venue_Name,Venue_ID, Winery.name as Winery 
		From	Venue, Winery 
		Where	venue.winery_ID = winery.winery_ID 
			AND winery.name = \"$winery\";"
	mysql -u "$USERNAME" -p"$PASSWORD" -D"$DBNAME" -e "$query"
}



find_venue_available_sql()
{
	query="	Select	venue.name as Venue_Name, venue.Venue_ID, Winery.name as Winery 
		From	Venue, Winery, Rental 
		Where	venue.winery_ID = winery.winery_ID 
			AND winery.name = \"$winery\" 
  			And not exists ( 
				Select * 
            			From rental 
            			Where	rental.venue_ID = venue.venue_ID 
					AND rental.date = '$date' 
        		) 
		Group By venue.Venue_ID;"
	echo "$query"
	mysql -u "$USERNAME" -p"$PASSWORD" -D"$DBNAME" -e "$query"

}



# ------------------------ Main Loop ----------------------

connect_to_db
while :
do
	display_commands
	process_command
done
