CREATE TABLE student (
id VARCHAR(20) NOT NULL PRIMARY KEY,
name VARCHAR(50),
sze INT,
parent VARCHAR(20));

CREATE TABLE staff(
id VARCHAR(20) NOT NULL PRIMARY KEY,
name VARCHAR(50));

CREATE TABLE room(
id VARCHAR(20) NOT NULL PRIMARY KEY,
name VARCHAR(50),
capacity INT,
parent VARCHAR(20));

CREATE TABLE event(
id VARCHAR(20) NOT NULL PRIMARY KEY,
modle VARCHAR(20) ,
kind CHAR(1),
dow VARCHAR(15),
tod CHAR(5),
duration INT,
room VARCHAR(20));

ALTER TABLE event
ADD CONSTRAINT FK_event_room FOREIGN KEY (room)
REFERENCES room(id);

CREATE TABLE attends(
student VARCHAR(20) NOT NULL,
event VARCHAR(20) NOT NULL,
PRIMARY KEY(student, event));

ALTER TABLE attends
ADD CONSTRAINT FK_attends_student FOREIGN KEY (student)
REFERENCES student(id);

ALTER TABLE attends
ADD CONSTRAINT FK_attends_event FOREIGN KEY (event)
REFERENCES event(id);

CREATE TABLE teaches(
staff VARCHAR(20) NOT NULL,
event VARCHAR(20) NOT NULL,
PRIMARY KEY(staff, event));

ALTER TABLE teaches
ADD CONSTRAINT FK_teaches_staff FOREIGN KEY (staff)
REFERENCES staff(id);

ALTER TABLE teaches
ADD CONSTRAINT FK_teaches_event FOREIGN KEY (event)
REFERENCES event(id);

CREATE TABLE occurs(
event VARCHAR(20) NOT NULL,
week VARCHAR(20) NOT NULL,
PRIMARY KEY(event, week));

ALTER TABLE occurs
ADD CONSTRAINT FK_occurs_week FOREIGN KEY (week)
REFERENCES week(id);

ALTER TABLE occurs
ADD CONSTRAINT FK_occurs_event FOREIGN KEY (event)
REFERENCES event(id);

CREATE TABLE modle(
id VARCHAR(20) NOT NULL PRIMARY KEY,
name VARCHAR(50));

CREATE TABLE week(
id VARCHAR(2) NOT NULL PRIMARY KEY,
wkstart DATE
);

INSERT INTO event VALUES ('co12004.L01','co12004','L','Wednesday','11:00',1,'cr.SMH');
INSERT INTO event VALUES ('co12004.L02','co12004','L','Monday','17:00',1,'cr.B13');
INSERT INTO event VALUES ('co12004.T01','co12004','T','Monday','11:00',2,'co.G78+G82');

INSERT INTO attends VALUES ('co.12008.Ea','co12008.L01');
INSERT INTO attends VALUES ('co.12008.Ea','co12008.T01');
INSERT INTO attends VALUES ('co.12008.Eb','co12008.L01');

INSERT INTO teaches VALUES ('co.ACg','co12005.T01');
INSERT INTO teaches VALUES ('co.ACg','co42010.L01');
INSERT INTO teaches VALUES ('co.ACg','co42010.T01');

INSERT INTO occurs VALUES ('co12004.L01','1');
INSERT INTO occurs VALUES ('co12004.L01','10');
INSERT INTO occurs VALUES ('co12004.L01','11');

INSERT INTO modle VALUES ('co12001','Rapid Application Development');
INSERT INTO modle VALUES ('co12002','Software Development 1A');
INSERT INTO modle VALUES ('co12003','Professional Skills');

INSERT INTO week VALUES ('01',to_date('Mon, 01 Oct 2018 00:00:00 GMT'));
INSERT INTO week VALUES ('02',to_date('Mon, 08 Oct 2018 00:00:00 GMT'));
INSERT INTO week VALUES ('03',to_date('Mon, 15 Oct 2018 00:00:00 GMT'));

INSERT INTO room VALUES ('co.117+118', '118', 40, null);
INSERT INTO room VALUES ('co.B7', 'B7', 20, null);
INSERT INTO room VALUES ('co.G74', 'G74', 20, null);

INSERT INTO student VALUES ('co.12008.Ea', 'WP and SS Elective', 50, null);
INSERT INTO student VALUES ('co.12008.Eb', 'WP and SS Elective', 50, null);
INSERT INTO student VALUES ('co.12012.E', 'UEC Elective', 32, null);

INSERT INTO staff VALUES ('co.ACg','Cumming, Andrew');
INSERT INTO staff VALUES ('co.ACr','Crerar, Dr Alison');
INSERT INTO staff VALUES ('co.AFA','Armitage, Dr Alistair');

--consultas

SELECT room
FROM event 
WHERE id LIKE ‘co42010.L01’;

SELECT dow, tod, room
FROM event 
WHERE modle LIKE ‘co72010’;

SELECT name
FROM staff 
WHERE id IN (SELECT staff
             FROM teaches 
             WHERE event IN (SELECT id
                           FROM event 
                           WHERE modle LIKE ‘co72010’));

SELECT name, modle
FROM event 
JOIN teaches ON event.id = teaches.event
JOIN staff ON teaches.staff = staff.id
WHERE room LIKE ‘cr.132’ AND dow LIKE ‘Wednesday’;

SELECT student, name
FROM attends 
JOIN event ON event.id = attends.event
JOIN modle ON modle.id = event.modle
JOIN student ON student.id = attends.student
WHERE moodle.name LIKE ‘%Database%’
Medium questions;

SELECT COUNT(student.name)
FROM event 
JOIN modle ON modle.id = event.modle
JOIN attends ON attends.id = event.id
JOIN student ON student.id = attends.student
WHERE moodle.id LIKE ‘co72010%’;

SELECT modle, COUNT(DISTINCT staff)
FROM teaches 
JOIN staff ON teaches.staff = staff.id
JOIN event ON teaches.event = event.id
WHERE moodle LIKE ‘co7%’
GROUP BY event.modle;

SELECT DISTINCT (modle.name)
FROM event 
JOIN modle ON modle.id = event.modle
JOIN occurs ON occurs.event = event.id
GROUP BY event.id, modle.name
HAVING COUNT(occurs.week) < 10;

SELECT DISTINCT(id)
FROM event 
WHERE CONCAT(tod, dow) IN (SELECT CONCAT(tod, dow) FROM event WHERE modle LIKE ‘co72010’);

DELETE FROM staff WHERE id in (SELECT id FROM staff WHERE id LIKE 'co.A%');
DELETE FROM student WHERE id in (SELECT id FROM student WHERE id LIKE 'co.12%');
DELETE FROM room WHERE id in (SELECT id FROM room WHERE id LIKE 'co.B%');
DELETE FROM week WHERE id in (SELECT id FROM week WHERE id LIKE '0%');
DELETE FROM modle WHERE id in (SELECT id FROM modle WHERE id LIKE 'co1%');
DELETE FROM occurs WHERE id in (SELECT id FROM occurs WHERE id LIKE 'co%');
DELETE FROM teaches WHERE id in (SELECT id FROM teaches WHERE id LIKE 'co.ACg%');
DELETE FROM attends WHERE id in (SELECT id FROM attends WHERE id LIKE 'co.%');
DELETE FROM event WHERE id in (SELECT id FROM event WHERE id LIKE 'co12004%');

DROP TABLE staff;
DROP TABLE student;
DROP TABLE room;
DROP TABLE week;
DROP TABLE modle;
DROP TABLE occurs;
DROP TABLE teaches;
DROP TABLE attends;
DROP TABLE event;