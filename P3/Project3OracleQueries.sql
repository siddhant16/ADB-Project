--1 
EXPLAIN PLAN FOR
SELECT *FROM TRAIN;
SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());

--2
EXPLAIN PLAN FOR
select DISTINCT(passenger_id),passenger_name,age,t.train_id,t.train_name
From passenger p, train t
where t.train_id=p.train_id
order by passenger_name;
SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());

--3
EXPLAIN PLAN FOR
SELECT train_name FROM train
WHERE train_id IN 
(SELECT route.train_id FROM route
WHERE route.route_point = 'San Francisco');
SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());

--4
EXPLAIN PLAN FOR

SELECT * FROM
(SELECT Train_name, booked_count FROM Train t
INNER JOIN TrainStatus ts ON
t.train_id = ts.train_id
ORDER BY Booked_count DESC) tr
WHERE ROWNUM < 5 ;
SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());

--5
EXPLAIN PLAN FOR
SELECT t.train_id, train_name, count(*) As Stops
FROM train t
JOIN route r
ON t.train_id = r.train_id
GROUP BY t.train_id, train_name, TRUNC(arrival_time);

SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());


--6
EXPLAIN PLAN FOR
SELECT gender, Count(*) / (select count(*) FROM Passenger) AS Sex_Ratio FROM passenger
GROUP BY gender;
SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());

--7
EXPLAIN PLAN FOR
SELECT DISTINCT train_name, r.* FROM route r
LEFT JOIN Train t
ON t.train_id = r.train_id
Where TO_Char(Arrival_time,'hh24')
between 0 AND 11;
    
SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());

select TO_CHAR(Arrival_time, 'hh24') from route;

--8
EXPLAIN PLAN FOR
SELECT train_name, count(*)  FROM train T
JOIN
route r
ON r.train_id = t.train_id
GROUP BY train_name, TRUNC(arrival_time)
HAVING Count(*) > 4;

SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());


--9
EXPLAIN PLAN FOR
SELECT DISTINCT(Passenger_name), Train_name, Ticket_price, ti.Ticket_id, Ticket_status, Status_date  FROM Passenger p
INNER JOIN Train t ON t.train_id = p.train_id
INNER JOIN Ticket ti ON p.ticket_id = p.ticket_id
INNER JOIN TrainStatus ts ON t.train_id = ts.train_id
WHERE Ticket_price = 35;

SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());


--10
EXPLAIN PLAN FOR 
SELECT tt.train_id, train_name, AVG(Ticket_price) FROM 
(SELECT t.train_id, train_name, ticket_id FROM train t
LEFT JOIN passenger p ON t.train_id = p.train_id)
tt
LEFT JOIN ticket ti ON
tt.ticket_id = ti.ticket_id
GROUP BY tt.train_id,train_name;
SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());