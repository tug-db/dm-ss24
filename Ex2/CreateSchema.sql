DROP TABLE IF EXISTS Aircraft, Airport, Flight, Booking, Ticket, Seat, FlightTicket, BoardingPass;
DROP TYPE IF EXISTS flight_status, fare_condition_type;


CREATE TYPE flight_status AS ENUM ('Scheduled', 'Cancelled', 'Arrived', 'On Time', 'Delayed', 'Departed');
CREATE TYPE fare_condition_type AS ENUM('Business', 'Comfort', 'Economy');

CREATE TABLE Aircraft(
	aircraft_code varchar(3) primary key,
	model_name varchar(100),
	aircraft_range integer
);

CREATE TABLE Airport(
	airport_code varchar(3) primary key, -- a surrogate key works as well, especially when the primary key is not an integer
	airport_name varchar(100),
	city varchar(20),
	timezone varchar(100),
	latitude decimal(14,11), -- float is accepted for this assigment
	longitude decimal(14,11) -- float is accepted for this assigment
);

CREATE TABLE Flight(
	flight_id int primary key,
	scheduled_departure timestamp,
	scheduled_arrival timestamp,
	flight_no varchar(10),
	status flight_status, -- enum is not necessary, varchar(10) works too
	aircraft_code varchar(3) references Aircraft,
	departure_airport_code varchar(3) references Airport,
	arrival_airport_code varchar(3) references Airport
);

CREATE TABLE Booking(
	book_ref varchar(6) primary key,
	book_timestamp timestamp,
	total_amount int -- not required to have this one, but it's accepted
);

CREATE TABLE Ticket(
	ticket_no varchar(20) primary key, -- int or bigint is accepted
	passenger_id varchar(20), -- int or bigint is accepted
	book_ref varchar(6) references Booking
);

CREATE TABLE Seat(
	seat_no varchar(3),
	fare_conditions fare_condition_type,
	aircraft_code varchar(3) references Aircraft,
	primary key(seat_no, aircraft_code)
);

CREATE TABLE FlightTicket(
	amount int,
	fare_conditions fare_condition_type, -- not required to have this one, but it's accepted
	flight_id int references Flight,
	ticket_no varchar(20) references Ticket,
	primary key(flight_id, ticket_no)
);

CREATE TABLE BoardingPass(
	flight_id int references Flight,
	ticket_no varchar(20) references Ticket,
	seat_no varchar(3),
	aircraft_code varchar(3),
	foreign key (seat_no, aircraft_code) references Seat,
	primary key (flight_id, ticket_no, seat_no, aircraft_code)
);
