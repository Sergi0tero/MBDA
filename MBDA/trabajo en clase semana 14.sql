--2. 
CREATE OR REPLACE
PROCEDURE INSCRIBIR(xEstudiante IN NUMBER, xMateria IN CHAR, xNumero IN NUMBER) IS
	xInscritos NUMBER(2);
	xCapacidad NUMBER(2);

BEGIN TRANSACTION
	SELECT inscritos, capacidad INTO xInscritos, xCapacidad 
		FROM GRUPOS
		WHERE materia=xMateria AND numero=xNumero;
IF (xInscritos < xCapacidad) THEN
    INSERT INTO INSCRIPCIONES(materia,numero,estudiante) 
        VALUES (xMateria,xNumero,xEstudiante);
        
    UPDATE GRUPOS SET 
            inscritos=inscritos+1
        WHERE materia=xMateria AND numero=xNumero;
ELSE THEN RAISE_APPLICATION_ERROR(-20002, 'No se puede exceder la capacidad del curso.') 
END IF;
	COMMIT
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20001, SQLERRM)
END INSCRIBIR;

--3.
CREATE OR REPLACE
PROCEDURE INSCRIBIR(xEstudiante IN NUMBER, xMateria IN CHAR, xNumero IN NUMBER) IS
	xInscritos NUMBER(2);
	xCapacidad NUMBER(2);

BEGIN TRANSACTION
	SELECT inscritos, capacidad INTO xInscritos, xCapacidad 
		FROM GRUPOS
		WHERE materia=xMateria AND numero=xNumero;
	IF (xInscritos < xCapacidad) THEN
		INSERT INTO INSCRIPCIONES(materia,numero,estudiante) 
			VALUES (xMateria,xNumero,xEstudiante);
			
		UPDATE GRUPOS SET 
				inscritos=inscritos+1
			WHERE materia=xMateria AND numero=xNumero;
	END IF;
	COMMIT
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
			RAISE_APPLICATION_ERROR(-20001, SQLERRM)
END INSCRIBIR;