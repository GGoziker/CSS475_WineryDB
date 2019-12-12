#!/bin/bash
export PATH=$PATH:/usr/local/mysql/bin



# ----------------------- Setup DB -----------------------

connect_to_db()
{
	DBNAME='Winery_DB'
	USERNAME='root'
	read -sp 'Enter password for local MySQL server: ' PASSWORD

	echo

	while $(! mysql -u "$USERNAME" -p"$PASSWORD" -e "use $DBNAME");
	do
		echo
		read -sp 'MySQL Password: ' PASSWORD
	done
	echo
	echo -e 'Connected to database!\n~~~~~~~~~~~~~~~~~~~~~\n'
}



# ------------------- Manager Interface -------------------
manager_mode()
{
	while :
	do
		echo -e '\nEnter one of the following commands (case sensitive):'
		echo -e '\tCommand\t\t\tAction'
		echo -e '\t0\t\t\tClose the program '
		echo -e '\t1\t\t\tView employees of a particular winery'
		echo -e '\t2\t\t\tView all wineries'
		echo -e '\t3\t\t\tSee what kind of event spaces a winery has'
		echo -e '\t4\t\t\tView all currently rented venues at a particular winery\n'

		read -p '->' user_input
		echo
		case $user_input in
			0)
				echo 'Thanks for using our database!'
				exit
				;;
			1)
				echo 'You chose to view employees of a particular winery'
				employee_list
				;;
			2)
				echo 'You chose to view all wineries'
				winery_list
				;;
			3)
				echo 'You chose to look at event spaces'
				find_venue
				;;
			4)
				echo 'You chose to find currently rented venues'
				rentals_list
				;;
			*)
				echo 'That'\''s not a valid command.'
				;;
		esac
	done
}



# ------------------- Customer Interface -------------------
customer_mode()
{
	while :
	do
		echo -e '\n\t\tCustomer mode'
		echo 'Enter one of the following commands (case sensitive):'
		echo -e '\tCommand\t\t\tAction'
		echo -e '\t-------\t\t\t------'
		echo -e '\t0\t\t\tClose the program '
		echo -e '\t1\t\t\tCheck a winery'\''s stock for a particular bottle'
		echo -e '\t2\t\t\tSee what kind of event spaces a winery has'
		echo -e '\t3\t\t\tView all wineries\n'

		read -p '->' user_input
		echo
		case $user_input in
			0)
				echo 'Thanks for using our database!'
				exit
				;;
			1)
				echo 'You chose to find a bottle'
				find_bottle
				;;
			2)
				echo 'You chose to look at event spaces'
				find_venue
				;;
			3)
				echo 'You chose to view all wineries'
				winery_list
				;;
			*)
				echo 'That'\''s not a valid command.'
				;;
		esac
	done
}



# -------------- Command Processing Functions -------------

# Search a winery for a bottle
find_bottle()
{
	while :
	do
		
		echo 'Would you like to search by wine name, or by wine color?'
		echo -e '\t0\t\tWine name'
		echo -e '\t1\t\tWine color'
		read -p '->' user_input
		echo
		
		case $user_input in
			0)
				# Search for wine by name
				all_wines
				printf 'Enter a wine name from the list: '
				read wine_name
				winery_list
				echo 'Enter the name of the winery you'\''d like to search for this wine: '
				read winery
				echo -e "\nSearching $winery for bottles of $wine_name"
				find_bottle_by_name_sql
				break
				;;
			1)
				# Search for wine by color
				all_wine_colors
				printf 'Enter a wine color from the list: '
				read wine_color
				winery_list
				printf 'Enter the name of the winery you'\''d like to search for this wine: '
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
		echo 'Would you like to filter results for venues which are available on a certain day?'
		echo -e '\t0\t\tYes, only show venues with availability'
		echo -e '\t1\t\tNo, show all venues'
		read -p '->' user_input
		echo

		case $user_input in
			0)
				# Search only available venues
				printf 'Winery: '
				read winery
				printf 'Date (format yyyy-mm-dd):'
				read date
				echo -e "\nSearching for event spaces at $winery available on $date"
				find_venue_available_sql
				break
				;;
			1)
				# Search all venues
				printf 'Winery: '
				read winery
				echo -e "\nSearching for event spaces at $winery"
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

all_wines()
{
	query="select distinct wine_bottle.name as Wine_Name from wine_bottle;"
	mysql -u "$USERNAME" -p"$PASSWORD" -D"$DBNAME" -e "$query"
}



all_wine_colors()
{
	query="select distinct wine_type.color from wine_type;"
	mysql -u "$USERNAME" -p"$PASSWORD" -D"$DBNAME" -e "$query"
}



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

echo -e "\n\n\tWelcome to the Wine-About-It winery management database!\n\n\tMade by Team Go - Grace, Camila, Andrei, and Gahl\n\n\tCourse: CSS475\n\n"
connect_to_db
while :
do
	echo -e 'Would you like to sign in as an employee, or as a customer?'
		echo -e '\t0\t\t\tEmployee'
		echo -e '\t1\t\t\tCustomer'

	echo
	read -p '->' user_input
	echo
	case $user_input in
		0)
			read -sp 'Enter employee password: ' user_input
			echo
			if [ "$user_input" == "password" ]
			then
				echo -e 'Access granted. Signing in as an employee\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
				manager_mode
				break
			else
				echo "Incorrect password."
			fi
			;;
		1)
			echo -e 'Signing in as a customer\n~~~~~~~~~~~~~~~~~~~~~~~~'
			customer_mode
			break
			;;
		*)
			echo 'That'\''s not a valid command.'
			;;
	esac
done

