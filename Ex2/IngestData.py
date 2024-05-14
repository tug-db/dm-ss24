#! /usr/bin/env python3

# installing all used packages
# source: https://stackoverflow.com/questions/17271444/how-to-install-a-missing-python-package-from-inside-the-script-that-needs-it

import csv
import psycopg2
import sys

db_host = sys.argv[-5]
db_port = sys.argv[-4]
db_name = sys.argv[-3]
db_user = sys.argv[-2]
db_password = sys.argv[-1]

# names of the csv files which contain the data
aircrafts_csv_name = sys.argv[1]  # 'data/aircrafts_data.csv'
airports_csv_name = sys.argv[2]  # 'data/airports_data.csv'
boarding_passes_csv_name = sys.argv[3]  # 'data/boarding_passes.csv'
bookings_csv_name = sys.argv[4]  # 'data/bookings.csv'
flights_csv_name = sys.argv[5]  # 'data/flights.csv'
seats_csv_name = sys.argv[6]  # 'data/seats.csv'
ticket_flights_csv_name = sys.argv[7]  # 'data/ticket_flights.csv'
tickets_csv_name = sys.argv[8]  # 'data/tickets.csv'


# ------------------------------------------------------------------------------------------------------------------------------------------

def csv_to_list(csv_name):
    # gets data from the csv file and puts it into a list of lists
    # for accessing the data: data_list[row_number][column_number]
    data_list = []
    with open(csv_name, 'r', encoding='utf-8') as csvfile:
        data_squads = csv.reader(csvfile)

        for row in data_squads:
            # to remove all the ', to have no collisions in the code later on
            new_row = []
            for element in row:
                if isinstance(element, str):
                    element = element.replace("'", "`")
                new_row.append(element)
            # print(new_row)

            data_list.append(new_row)
        # deletes the fist row, which contains the table heads
        # optional:uncomment if this makes working with the data easier for you
        # del data_list[0]
    return data_list


# ------------------------------------------------------------------------------------------------------------------------------------------

# Lists from csvs
aircrafts_list = csv_to_list(aircrafts_csv_name)
airports_list = csv_to_list(airports_csv_name)
boarding_passes_list = csv_to_list(boarding_passes_csv_name)
bookings_list = csv_to_list(bookings_csv_name)
flights_list = csv_to_list(flights_csv_name)
seats_list = csv_to_list(seats_csv_name)
ticket_flights_list = csv_to_list(ticket_flights_csv_name)
tickets_list = csv_to_list(tickets_csv_name)

# SQL connection
sql_con = psycopg2.connect(host=db_host, port=db_port, database=db_name, user=db_user, password=db_password)
# cursor, for DB operations
cur = sql_con.cursor()


### HELP:
'''
---Insertion to database:
   cur.execute('INSERT INTO Table1 (col1, col2) VALUES(%s, %s)', (value1, value2))

---Fetching from database:-----------------------------------------------------------------------------------------------------------------
   cur.execute(query)
   resultSet = cur.fetchall() - to fetch the whole result set
   reultSet = cur.fetchone() - to fetch a single row(does not mean only the first row, it means one row at a time)
-------------------------------------------------------------------------------------------------------------------------------------------
'''

#######################
# YOUR CODE GOES HERE #
#######################


# commit the changes, this makes the database persistent
sql_con.commit()

# close connections
cur.close()
sql_con.close()
