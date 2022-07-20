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

INSERT INTO event VALUES ('co12004.L01','co12004','L','Wednesday','11:00',1,'cr.SMH');
INSERT INTO event VALUES ('co12004.L02','co12004','L','Monday','17:00',1,'cr.B13');
INSERT INTO event VALUES ('co12004.T01','co12004','T','Monday','11:00',2,'co.G78+G82');

INSERT INTO room VALUES ('co.117+118', '118', 40, null);
INSERT INTO room VALUES ('co.B7', 'B7', 20, null);
INSERT INTO room VALUES ('co.G74', 'G74', 20, null);

--AtributosOK
room.id LIKE 'ca.43'
room.capacity LIKE 55

--AtributosNoOK
room.id LIKE 'co.117+118co.117+118co.117+118co.117+118co.117+118co.117+118co.117+118'
room.capacity LIKE 900

--Tuplas

ALTER TABLE room ADD CONSTRAINT CK_room_parent
CHECK (parent IN ('ca.$', 'oa.$', 'cr.$'));

--TuplasOK

INSERT INTO room VALUES ('co.123', '115', 30, null);
INSERT INTO room VALUES ('co.124', '112', 35, null);
INSERT INTO room VALUES ('co.125', 'G79', 40, null);

--TuplasNoOk

INSERT INTO room VALUES ('co.117+118', '118', 500, null);
INSERT INTO room VALUES ('co.B7', 'B7', 600, null);
INSERT INTO room VALUES ('co.G74', 'G74', 700, null);

-- ACCIONES

CONSTRAINT FK_event_room FOREIGN KEY (room)
REFERENCES room(id)
ON DELETE(CASCADE);

ALTER TABLE event
ADD CONSTRAINT FK_event_room FOREIGN KEY (room)
REFERENCES room(id);

-- DISPARADORES

CREATE OR REPLACE TRIGGER TR_ROOM_BI
BEFORE INSERT ON room
FOR EACH ROW
BEGIN IF NOT EXISTS id 
	  THEN id = 'ca.$'; 
	  END IF;
	  IF NEW id IN (SELECT id FROM room) 
	  THEN RAISE_APPLICATION_ERROR(-23424, 'Este id ya existe');
	  END IF;
END;

CREATE OR REPLACE TRIGGER TR_ROOM_BU
BEFORE UPDATE OF capacity ON room
FOR EACH ROW
BEGIN IF :NEW.capacity > 20 AND NEW.capacity < 200 THEN
      OLD.capacity := NEW.capacity;
      END IF;
END;

CREATE OR REPLACE TRIGGER TR_ROOM_BD
BEFORE DELETE ON room
FOR EACH ROW
BEGIN IF (SELECT COUNT(*)
          FROM ROOM
          WHERE id IN (SELECT room FROM event)) > 0 THEN
          DELETE room.id;
      END IF;
END;
          
		  
--DisparadoresOk

INSERT INTO room VALUES ('co.321', '115', 30, null);

UPDATE room 
SET capacity = 40
WHERE id = co.125;

DELETE FROM room WHERE id LIKE 'co.321'

--DisparadoresNoOk

INSERT INTO room VALUES ('co.321', '115', 500, null);

UPDATE room 
SET name = '115'
WHERE id = co.125;

DELETE FROM room WHERE id LIKE 'co.G74'