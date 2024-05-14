select flight_no, scheduled_departure, scheduled_arrival,
	departure_airport_code, arrival_airport_code, ticket_no, amount
from flight, flightticket
where flightticket.flight_id=flight.flight_id
	and scheduled_departure between '2017-08-07 08:00' and '2017-08-07 22:00'
	and scheduled_arrival > '2017-08-07 12:00'
	and departure_airport_code != 'SVO'
	and arrival_airport_code != 'SVO'
	and amount between 5000 and 6500