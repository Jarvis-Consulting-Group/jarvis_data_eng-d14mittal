# Introduction

This project focuses on a recently established country club and its comprehensive dataset. The dataset includes information about club members, details of amenities available, and records of bookings made for these amenities.

The main objective of this project is to efficiently analyze and evaluate the usage and demand of the club's facilities using the provided dataset. To achieve this, we will be using PostgreSQL, a widely-used and powerful relational database management system. This diagram visually represents the tables and their connections, serving as a useful reference for understanding the database schema and guiding the analysis process.

Throughout the project, we will explore various SQL queries and statements to extract valuable insights from the dataset. Tasks such as adding new facilities, correcting data entry errors, retrieving specific information, and generating informative reports will be performed. By leveraging SQL and our understanding of the dataset, our aim is to uncover valuable insights into facility usage patterns and member behaviour.

## DDL STATEMENTS

```
CREATE TABLE cd.members (
    memid integer NOT NULL;
    surname character varying(200) NOT NULL,
    address character varying(300) NOT NULL,
    zipcode integer NOT NULL,
    telephone character varying(20) NOT NULL,
    recommendedby integer,
    joindate timestamp NOT NULL,
    CONSTRAINT members_pk PRIMARY KEY (memid),
    CONSTRAINT fk_members_recommendedby FOREIGN KEY (recommendedby) 
        REFERENCES cd.members(memid) ON DELETE SET NULL
);

CREATE TABLE cd.bookings (
    faceid integer NOT NULL,
    memid integer NOT NULL,
    starttime timestamp NOT NULL,
    slots integer NOT NULL,
    CONSTRAINT bookings_pk PRIMARY KEY (bookid),
    CONSTRAINT fk_bookings_facid FOREIGN KEY (facid) REFERENCES cd.facilities(facid)
    CONSTRAINT fk_bookings_memid FOREIGN KEY (memid) REFERENCES cd.members(memid)
);

CREATE TABLE cd.facilities (
    facid integer NOT NULL, 
    name character varying(100) NOT NULL, 
    membercost numeric NOT NULL, 
    guestcost numeric NOT NULL, 
    initialoutlay numeric NOT NULL, 
    monthlymaintenance numeric NOT NULL, 
    CONSTRAINT facilities_pk PRIMARY KEY (facid)
);
```

###### Question 1: The club is adding a new facility - a spa. We need to add it into the facilities table. Use values: facid: 9, Name: 'Spa', membercost: 20, guestcost: 30, initialoutlay: 100000, monthlymaintenance: 800.
```
INSERT INTO cd.facilities
(
    facid,
    name,
    membercost,
    guestcost,
    initialoutlay,
    monthlymaintenance
)
VALUES
(9, 'Spa', 20, 30, 100000, 800);
```
###### Questions 2: Let's try adding the spa to the facilities table again. This time, though, we want to automatically generate the value for the next facid, rather than specifying it as a constant. Use the following values for everything else: Name: 'Spa', membercost: 20, guestcost: 30, initialoutlay: 100000, monthlymaintenance: 800.
```
INSERT INTO cd.facilities
VALUES
(
    (
        SELECT MAX(facid) FROM cd.facilities
    ) + 1,
    'Spa',
    20,
    30,
    100000,
    800
);
```
###### Questions 3: We made a mistake when entering the data for the second tennis court. The initial outlay was 10000 rather than 8000: you need to alter the data to fix the error.
```
UPDATE cd.facilities
SET initialoutlay = 10000
WHERE facid = 1;
```
###### Questions 4: We want to alter the price of the second tennis court so that it costs 10% more than the first one. Try to do this without using constant values for the prices, so that we can reuse the statement if we want to.
```
UPDATE cd.facilities
SET membercost =
    (
        SELECT membercost FROM cd.facilities WHERE facid = 1
    ) * 1.1,
    guestcost =
    (
        SELECT guestcost FROM cd.facilities WHERE facid = 1
    ) * 1.1
WHERE facid = 2;
```
###### Questions 5: As part of a clearout of our database, we want to delete all bookings from the cd.bookings table. How can we accomplish this?
```
TRUNCATE TABLE cd.bookings;
```
###### Questions 6: We want to remove member 37, who has never made a booking, from our database. How can we achieve that?
```
DELETE FROM cd.members
WHERE memid = 37;
```
###### Questions 7: How can you produce a list of facilities that charge a fee to members, and that fee is less than 1/50th of the monthly maintenance cost? Return the facid, facility name, member cost, and monthly maintenance of the facilities in question.
```
SELECT facid,
       name,
       membercost,
       monthlymaintenance
FROM cd.facilities
WHERE membercost < monthlymaintenance / 50
      AND membercost > 0;
```
###### Questions 8: How can you produce a list of all facilities with the word 'Tennis' in their name?'
```
SELECT *
FROM cd.facilities
WHERE name LIKE '%Tennis%';
```
###### Questions 9: How can you retrieve the details of facilities with ID 1 and 5? Try to do it without using the OR operator.
```
SELECT *
FROM cd.facilities
WHERE facid IN (1, 5);
Questions 10: How can you produce a list of members who joined after the start of September 2012? Return the memid, surname, firstname, and joindate of the members in question.
SELECT memid,
       surname,
       firstname,
       joindate
FROM cd.members
WHERE joindate >= '2012-09-01';
```
###### Questions 11: Combined List of All Surnames and Facility Names
```
SELECT surname FROM cd.members
UNION
SELECT name FROM cd.facilities;
```
###### Questions 12: Start Times for Bookings by Members Named 'David Farrell'
```
SELECT bs.starttime
FROM cd.bookings AS bs
    JOIN cd.members AS ms
        ON ms.memid = bs.memid
WHERE ms.firstname = 'David'
      AND ms.surname = 'Farrell';
```
###### Questions 13: How can you produce a list of the start times for bookings for tennis courts, for the date '2012-09-21'? Return a list of start time and facility name pairings, ordered by the time.
```
SELECT bs.starttime,
       fa.name
FROM cd.bookings AS bs
    JOIN cd.facilities AS fa
        ON bs.facid = fa.facid
WHERE bs.starttime >= '2012-09-21'
      AND bs.starttime < '2012-09-22'
      AND fa.name LIKE 'Tennis Court%'
ORDER BY bs.starttime;
```
###### Questions 14: How can you output a list of all members, including the individual who recommended them (if any)? Ensure that results are ordered by (surname, firstname).
```
SELECT ms.firstname AS memfname,
       ms.surname AS memsname,
       rs.firstname AS recfname,
       rs.surname AS recsname
FROM cd.members AS ms
    LEFT OUTER JOIN cd.members AS rs
        ON rs.memid = ms.recommendedby
ORDER BY memsname,
         memfname;
```
###### Questions 15: How can you output a list of all members who have recommended another member? Ensure that there are no duplicates in the list, and that results are ordered by (surname, firstname).
```
SELECT DISTINCT
    rs.firstname,
    rs.surname
FROM cd.members AS ms
    INNER JOIN cd.members AS rs
        ON rs.memid = ms.recommendedby
ORDER BY rs.surname,
         rs.firstname;
```
###### Questions 16: How can you output a list of all members, including the individual who recommended them (if any), without using any joins? Ensure that there are no duplicates in the list, and that each firstname + surname pairing is formatted as a column and ordered. (Without Joins)
```
SELECT DISTINCT
  ms.firstname || ' ' || ms.surname AS member,
  (
    SELECT rs.firstname || ' ' || rs.surname
    FROM cd.members AS rs
    WHERE rs.memid = ms.recommendedby
  ) AS recommender
FROM cd.members AS ms
ORDER BY member;
```
###### Questions 17: Produce a count of the number of recommendations each member has made. Order by member ID.
```
SELECT recommendedby,
       COUNT(*)
FROM cd.members
WHERE recommendedby IS NOT NULL
GROUP BY recommendedby
ORDER BY recommendedby;
```
###### Questions 18: Produce a list of the total number of slots booked per facility. For now, just produce an output table consisting of facility id and slots, sorted by facility id.
```
SELECT facid,
       SUM(slots) AS Total_Slots
FROM cd.bookings
GROUP BY facid
ORDER BY facid;
```
###### Questions 19: Produce a list of the total number of slots booked per facility in the month of September 2012. Produce an output table consisting of facility id and slots, sorted by the number of slots.
```
SELECT facid,
       SUM(slots) AS Total_Slots
FROM cd.bookings
WHERE starttime >= '2012-09-01'
      AND starttime < '2012-10-01'
GROUP BY facid
ORDER BY Total_Slots;
```
###### Questions 20: Produce a list of the total number of slots booked per facility per month in the year of 2012. Produce an output table consisting of facility id and slots, sorted by the id and month.
```
SELECT facid, 
       EXTRACT(month FROM starttime) AS month, 
       SUM(slots) AS "Total Slots" 
FROM cd.bookings 
WHERE EXTRACT(year FROM starttime) = 2012 
GROUP BY facid, month 
ORDER BY facid, month;
```
###### Questions 21: Find the total number of members (including guests) who have made at least one booking.
```
SELECT COUNT(DISTINCT memid)
FROM cd.bookings;
```
###### Questions 22: Produce a list of each member name, id, and their first booking after September 1st 2012. Order by member ID.
```
SELECT ms.surname,
       ms.firstname,
       ms.memid,
       MIN(bs.starttime)
FROM cd.members AS ms
    JOIN cd.bookings AS bs
        ON ms.memid = bs.memid
WHERE bs.starttime >= '2012-09-01'
GROUP BY ms.surname,
         ms.firstname,
         ms.memid
ORDER BY ms.memid;
```
###### Questions 23: Produce a list of member names, with each row containing the total member count. Order by join date, and include guest members.
```
SELECT COUNT(*) OVER () AS "Total Members",
       firstname,
       surname
FROM cd.members
ORDER BY joindate;
```
###### Questions 24: Produce a monotonically increasing numbered list of members (including guests), ordered by their date of joining. Remember that member IDs are not guaranteed to be sequential.
```
SELECT ROW_NUMBER() OVER (ORDER BY joindate) AS row_number,
       firstname,
       surname
FROM cd.members
ORDER BY joindate;
```
###### Questions 25: Output the facility id that has the highest number of slots booked. Ensure that in the event of a tie, all tieing results get output.
```
SELECT facid,
       total
FROM
(
    SELECT facid,
           SUM(slots) AS total,
           RANK() OVER (ORDER BY SUM(slots) DESC) AS rank
    FROM cd.bookings
    GROUP BY facid
) AS ranked
WHERE rank = 1;
```
###### Questions 26: Output the names of all members, formatted as 'Surname, Firstname'
```
SELECT surname || ', ' || firstname AS name 
FROM cd.members;
Questions 27: You've noticed that the club's member table has telephone numbers with very inconsistent formatting. You'd like to find all the telephone numbers that contain parentheses, returning the member ID and telephone number sorted by member ID.
SELECT memid, 
       telephone 
FROM cd.members 
WHERE telephone ~ '[()]' 
ORDER BY memid;
```
###### Questions 28: You'd like to produce a count of how many members you have whose surname starts with each letter of the alphabet. Sort by the letter, and don't worry about printing out a letter if the count is 0.
```
SELECT SUBSTR(surname, 1, 1) AS letter,
       COUNT(*) AS count
FROM cd.members
GROUP BY letter
ORDER BY letter;
```
