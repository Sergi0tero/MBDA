
CREATE OR REPLACE PACKAGE PC_room AS
	PROCEDURE AD_room(
		xid IN VARCHAR,
		xname IN CHAR(5));
	
	PROCEDURE MOD_room(
		xcapacity IN NUMBER);
		
	PROCEDURE ELI_room(
		xid IN VARCHAR,
		xname IN CHAR(5),
		xcapacity IN NUMBER);
	
	FUNCTION CO_room
		RETURN SYS_REFCURSOR;
	
	FUNCTION CO_room_ocupation
		RETURN SYS_REFCURSOR;
		
	FUNCTION CO_room_clashes
		RETURN SYS_REFCURSOR;
		
END PC_room;

CREATE OR REPLACE PACKAGE PA_IM IS
	PROCEDURE AD_room(
		xid IN VARCHAR,
		xname IN CHAR(5));
	
	PROCEDURE MOD_room(
		xcapacity IN NUMBER);
		
	PROCEDURE ELI_room(
		xid IN VARCHAR,
		xname IN CHAR(5)
		xcapacity IN NUMBER);
	
	FUNCTION CO_room
		RETURN SYS_REFCURSOR;
	
	FUNCTION CO_room_ocupation
		RETURN SYS_REFCURSOR;
		
	FUNCTION CO_room_clashes
		RETURN SYS_REFCURSOR;
		
END PA_IM;

CREATE OR REPLACE PACKAGE PA_LE IS
	PROCEDURE AD_room(
		xid IN VARCHAR,
		xname IN CHAR(5));
	
	PROCEDURE MOD_room(
		xcapacity IN NUMBER);
		
	PROCEDURE ELI_room(
		xid IN VARCHAR,
		xname IN CHAR(5)
		xcapacity IN NUMBER);
	
	FUNCTION CO_room
		RETURN SYS_REFCURSOR;
	
	FUNCTION CO_room_ocupation
		RETURN SYS_REFCURSOR;
		
	FUNCTION CO_room_clashes
		RETURN SYS_REFCURSOR;
		
END PA_LE;


GRANT EXECUTE
ON PA_IM
TO Infrastructure Manager;

GRANT EXECUTE
ON PA_LE
TO Logistics Employee;

GRANT SELECT (capacity)
ON PC_room
TO PA_IM;

GRANT SELECT (id)
ON PC_room
TO PA_LE;


REVOKE SELECT (capacity)
ON PC_room
FROM PA_IM;

REVOKE SELECT (id)
ON PC_room
FROM PA_LE;

REVOKE ALL
ON PA_IM
FROM infrastructure manager;

REVOKE ALL
ON PA_LE
FROM logistics employee;

DROP PACKAGE PC_room;