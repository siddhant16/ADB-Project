
CREATE TABLE Train
(
train_id INT NOT NULL,
train_name VARCHAR(50) NOT NULL,
train_source VARCHAR(25) NOT NULL,
destination VARCHAR(25) NOT NULL ,
PRIMARY KEY(train_id)
);

CREATE TABLE TrainStatus
(
train_id INT NOT NULL,
available_count INT,
booked_count INT,
waiting_count INT,
Status_Date DATE NOT NULL,
FOREIGN KEY(train_id) REFERENCES Train(train_id),
PRIMARY KEY(train_id, Status_Date)
);

CREATE TABLE Route
(
train_id INT NOT NULL,
Arrival_Time DATETIME,
route_point VARCHAR(20) NOT NULL,
FOREIGN KEY(train_id) REFERENCES Train(train_id)
);

CREATE TABLE Ticket
(
ticket_id INT NOT NULL,
ticket_price INT NOT NULL,
ticket_status VARCHAR(15),
departure_date DATE,
PRIMARY KEY(ticket_id)
);

CREATE TABLE Passenger
(
passenger_id INT NOT NULL,
train_id INT NOT NULL,
ticket_id INT NOT NULL,
Passenger_name VARCHAR(14) NOT NULL,
Gender VARCHAR(2),
Age INT,
Contact INT,
PRIMARY KEY(passenger_id),
FOREIGN KEY(train_id) REFERENCES train(train_id),
FOREIGN KEY(ticket_id) REFERENCES Ticket(ticket_id)
);
