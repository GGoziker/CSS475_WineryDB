#!/bin/bash
export PATH=$PATH:/usr/local/mysql/bin



# ------------------------- Setup -------------------------

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



welcome_message()
{
echo -e "\n\n\t\t\tWelcome to the Wine-About-It winery management database!\n\n\t\t\tMade by Team Go for CSS475\n\n"
}


# ------------------- Manager Interface -------------------

manager_mode()
{
	while :
	do
		display_commands_manager
		process_command_manager
	done
}



display_commands_manager()
{
	echo
	echo 'Enter one of the following commands (case sensitive):'
	echo -e '\tEmployee_list    (View employees of a particular winery)'
	echo -e '\tWinery_list      (View all wineries)'
	echo -e '\tVenue_rentals    (View all currently rented venues at a particular winery)'
	echo -e '\tView_sales       (View all sales at a particular winery)'
	echo -e '\tExit'
	echo
}



process_command_manager()
{
	read -p '->' user_input
	echo
	case $user_input in
		Employee_list)
			echo 'You chose to view employees of a particular winery'
			employee_list
			;;
		Winery_list)
			echo 'You chose to view all wineries'
			winery_list
			;;
		Venue_rentals)
			echo 'You chose to find currently rented venues'
			rentals_list
			;;
		View_sales)
			echo 'You chose to rent a venue'
			Sales_list
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



# ------------------- Customer Interface -------------------

customer_mode()
{
	while :
	do
		display_commands_customer
		process_command_customer
	done
}



display_commands_customer()
{
	echo
	echo 'Enter one of the following commands (case sensitive):'
	echo -e '\tFind_bottle   (Search a particular winery for a particular bottle of wine)'
	echo -e '\tVenue_list    (View rentable venues by winery)'
	echo -e '\tWinery_list   (View all wineries)'
	echo -e '\tExit'
	echo
}



process_command_customer()
{
	read -p '->' user_input
	echo
	case $user_input in
		Find_bottle)
			echo 'You chose to find a bottle'
			find_bottle
			;;
		Venue_list)
			echo 'You chose to view rentable venues'
			find_venue
			;;
		Winery_list)
			echo 'You chose to view all wineries'
			winery_list
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



# Search a winery for a venue
find_venue()
{
	while :
	do
		echo 'Only see available venues? (Type '\''y/n'\'')'
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


winery_list()
{
	query="Select Name as Winery From Winery;"
	mysql -u "$USERNAME" -p"$PASSWORD" -D"$DBNAME" -e "$query"

}



# List all currently rented venues at the specified winery
rentals_list()
{
	printf 'Winery: '
	read winery
	query="Select	venue.name as Venue_Name, venue.Venue_ID, Winery.name as Winery, rental.Date 
		From	Venue, Winery, Rental 
		Where	venue.winery_ID = winery.winery_ID 
			AND winery.name = \"winery\" 
  			And rental.venue_ID = venue.venue_ID 
			AND rental.date = CURRENT_DATE 
		Group By rental.rental_ID;"
	mysql -u "$USERNAME" -p"$PASSWORD" -D"$DBNAME" -e "$query"
}



employee_list()
{
	printf 'Winery: '
	read winery
	echo -e "\nSearching for all employees of $winery"
	query="	Select Emp_ID as Employee_ID, employee.fname as First_Name, employee.lname as Last_Name, employee.super_emp_id as Supervisor_ID 
			From Employee, Winery 
			Where	employee.winery_ID = winery.winery_id 
				AND winery.name = \"$winery\"; "
	mysql -u "$USERNAME" -p"$PASSWORD" -D"$DBNAME" -e "$query"
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
	mysql -u "$USERNAME" -p"$PASSWORD" -D"$DBNAME" -e "$query"

}



# ------------------------ Main Loop ----------------------

welcome_message
connect_to_db


while :
do
	echo 'Manager or customer mode? Type '\''m/c'\'
	echo
	read -p '->' user_input
	echo
	case $user_input in
		m)
			read -sp 'Enter manager password: ' user_input
			echo
			if [ "$user_input" == "password" ]
			then
				echo 'Access granted. Entering manager mode'
				manager_mode
				break
			else
				echo "Incorrect password."
			fi
			;;
		c)
			echo 'Entering customer mode'
			customer_mode
			break
			;;
		*)
			echo 'That'\''s not a valid command.'
			;;
	esac
done

