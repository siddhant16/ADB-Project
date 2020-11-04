/*where clause */
/* displaying seat details for all trains from <source> to <destination> on <date> */
select total_seats, available seats from train_info where departure_date = ”” and source="" and destination ="" ;
 
 drop table train,trainstatus,route, ticket, passenger;
 drop table route;
 -- display top 4 train names and there booking count with maximum booked tickets
 
SELECT distinct(Train_name), booked_count from Train t
INNER JOIN TRainStatus ts ON
t.train_id = ts.train_id
ORDER BY Booked_count DESC
limit 4;
 
/*update statement */
/* Updating number of available seats */
UPDATE train_status 
SET available=10
WHERE train_id=1234 AND date="17-02-2020";

/*count of female passengers*/
SELECT Gender, count(passenger_ID) FROM passenger GROUP BY gender;


SELECT gender, Count(*) / (select count(*) FROM Passenger) AS Sex_Ratio FROM passenger
GROUP BY gender ;
/*Group By */
/* Displaying Trains having more thn 2 route points */
SELECT train_name, count(*)  Stops
FROM train T 
JOIN 
route r
ON r.train_id = t.train_id 
GROUP BY r.train_id, Date(arrival_time)
HAVING Stops > 4;

select COUNT(*) from route group by train_id, Date(arrival_time) ;
/* Nested Queries */
/* Displaying Train Numbers going through a specific Route Point */

SELECT train_name FROM train
WHERE train_id IN 
(SELECT route.train_id FROM route
WHERE route.route_point="San Francisco");

/* Order By and Join */
/* Displaying name, ticket_id, price */

SELECT name, ticket_id, price FROM passenger p
JOIN ticket t
ON p.ticket_id = t.ticket_id
ORDER BY price DESC; 


/*Complex Join*/
/* Displaying name, route, train details for Female passengers */
SELECT DISTINCT(passenger_name), route_point, train_name FROM passenger p
JOIN train t
ON t.train_id = p.train_id
JOIN route r
ON t.train_id = r.train_id
WHERE gender="F"
GROUP BY route_point;

SELECT DISTINCT(Passenger_name), Train_name, Ticket_price, ti.Ticket_id, Ticket_status, Status_date  FROM Passenger p
INNER JOIN Train t ON t.train_id = p.train_id
INNER JOIN Ticket ti ON p.ticket_id = p.ticket_id
INNER JOIN TrainStatus ts ON t.train_id = ts.train_id
WHERE Ticket_price = 35;

DROP procedure updateentries
DELIMITER //
CREATE PROCEDURE UpdateEntries(Modified_Rate Float)
BEGIN
	SET SQL_SAFE_UPDATES=0;
	UPDATE Ticket SET Ticket_price = Modified_Rate * Ticket_price 
	WHERE departure_date > '2020-01-01' ;
END //
DELIMITER 

Select *from Ticket ORDER BY ticket_id ;
CAll  UpdateEntries(1.5);
Select *from Ticket where ROW > 2

SELECT t.train_id, Train_name, 
CASE WHEN AVG(ticket_price) IS NULL THEN 0 
ELSE  AVG(ticket_price) END As Average
FROM Ticket ti
INNER JOIN Passenger p ON ti.ticket_id = p.ticket_id
RIGHT JOIN Train t ON t.train_id = p.train_id
GROUP BY t.train_id

CREATE VIEW TrainStops AS
SELECT t.train_id, train_name, group_concat(distinct route_point) AS Routes FROM route r
INNER JOIN Train t ON t.train_id = r.train_id
GROUP BY train_id;

ALTER VIEW TrainStops AS
SELECT t.train_id, train_name, group_concat(distinct route_point) AS Routes, booked_count FROM route r
INNER JOIN Train t ON t.train_id = r.train_id
LEFT JOIN TrainStatus ts ON ts.train_id = t.train_id
GROUP BY train_id;


Select *from trainstops
CREATE VIEW
SELECT *FROM Train
UNION 
SELECT *FROM Ticket

SELECT DISTINCT train_name, r.* FROM route r
LEFT JOIN Train t
ON t.train_id = r.train_id
Where TIME(Arrival_time)
between '00:00' AND '12:00'

select *from route
SELECT Distinct(Route_point) FROM Route

DELETE FROM Route
WHERE Train_id = 92307 AND Route_point = 'North San Jose'

INSERT INTO Train VALUES
(91101, 'San Jose Express', 'San Jose', 'San Francisco')

DELIMITER //
CREATE TRIGGER CheckValues BEFORE INSERT ON Ticket
       FOR EACH ROW
       BEGIN
           IF NEW.ticket_price < 0 THEN
               SET NEW.ticket_price = 1;
           ELSEIF NEW.ticket_price > 100 THEN
               SET NEW.ticket_price = 100;
           END IF;
       END; //
DELIMITER ;

INSERT INTO Ticket 
VALUES
(41990, -20, 'Booked', '2019-11-19'),
(41993, 102, 'Waiting', '2020-02-13'),
(41998, 28, 'Booked', '2020-01-28');

Select *FROM Ticket ORDER BY Ticket_id DESC;

SELECT COUNT(*) As CountBeforeInsert FROM Train;
START TRANSACTION; 
INSERT INTO Train 
VALUES
(99988, 'San Francisco CalTrain', 'San Francisco', 'San Jose'),
(99389, 'Amtrak ACE Express Train', 'Fremont', 'Montreo');
ROLLBACK;
SELECT COUNT(*) AS CountAfterInsert FROM Train;

DELETE FROM Train 
WHERE train_id in (99988, 99389);

select train_id, rank() over
(partition by route_point order by train_id) from route;

SELECT DISTINCT t.train_id, train_name, count(*) AS TrainStops,Arrival_Time 
FROM train t
INNER JOIN route r ON t.train_id = r.train_id
GROUP BY t.train_name, DATE(arrival_time)
ORDER BY COUNT(*);

CREATE TABLE sample 
SELECT *FROM route;

SELECT *FROM
(SELECT Passenger_id, t.train_id, Passenger_name, age, train_name, train_source, destination FROM Passenger p
INNER JOIN Train t ON t.train_id = p.train_id ORDER BY Age  ) AS T ORDER BY Passenger_name LIMIT 10;
