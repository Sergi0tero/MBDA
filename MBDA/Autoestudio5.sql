CREATE TABLE hojasDeVida(
	area VARCHAR (20) NOT NULL,
	grado VARCHAR (20) NOT NULL,
	titulo XMLTYPE NOT NULL,
	asignatura XMLTYPE NOT NULL,
	evaluacion XMLTYPE NOT NULL);
	
INSERT INTO hojasDeVida VALUES(	'informatica', 
    'pos-grado',
    '<titulos   nombre = "Insertar buen titulo"
                institucion = "ECI"
                fecha = "22/04/2020"
                grado = "pos-grado">
	</titulos>',
    '<asignaturas	sigla = "MBDA"
                    nombre = "Yesid Carrillo"
                    dictado = "3">
	</asignaturas>',
    '<evaluaciones	año = "2020"
                    semestre = "2"
                    asignatura = "MBDA">
		<promedios
			profesor = "4.5"
			estudiantes = "4.5"
			asignaturas = "4.5"
			recursos = "4.5">
		</promedios>
	</evaluaciones>');
    
INSERT INTO hojasDeVida VALUES(	'matematica', 
    'pregrado',
    '<titulos   nombre = "Insertar buen titulo 2"
                institucion = "ECI"
                fecha = "22/04/2020"
                grado = "pregrado">
	</titulos>',
    '<asignaturas	sigla = "MBDA"
                    nombre = "Sergio Otero"
                    dictado = "3">
	</asignaturas>',
    '<evaluaciones	año = "2020"
                    semestre = "2"
                    asignatura = "CALV">
		<promedios
			profesor = "4.8"
			estudiantes = "4.5"
			asignaturas = "4.5"
			recursos = "4.5">
		</promedios>
	</evaluaciones>');
SELECT EXTRACT(asignatura, '/asignaturas/@nombre') FROM hojasDeVida
WHERE area = 'informatica' AND grado = 'pos-grado';
SELECT EXTRACT(titulo, '/titulos/@*') FROM hojasDeVida;
SELECT EXTRACT(asignatura, '/asignaturas[@sigla = "MBDA"]/@nombre') FROM hojasDeVida;
SELECT EXTRACT(evaluacion, '/evaluaciones[@asignatura = "MBDA"]/promedios/@asignaturas') FROM hojasDeVida;
SELECT EXTRACT(asignatura, '/asignaturas/@nombre') FROM hojasDeVida;

DROP TABLE hojasDevida CASCADE CONSTRAINTS;
