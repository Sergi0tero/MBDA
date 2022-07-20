CREATE TABLE Paises(
codigo NUMBER(2) NOT NULL,
nombre VARCHAR(20) NOT NULL);

CREATE TABLE LoHablan(
porcentaje NUMBER(2) NOT NULL,
codigoPais NUMBER(2) NOT NULL);

CREATE TABLE Idiomas(
nombre CHAR(5) NOT NULL,
estudiantes NUMBER(4) NOT NULL);

CREATE TABLE Nivel(
id NUMBER(10) NOT NULL,
orden NUMBER(3) NOT NULL,
tema CHAR(10),
idioma CHAR(5) NOT NULL,
competencia CHAR(5) NOT NULL);

CREATE TABLE Objetivos(
idNivel NUMBER(10) NOT NULL,
objetivo VARCHAR(10) NOT NULL);

CREATE TABLE Competencias(
corto CHAR(5) NOT NULL,
descripcion VARCHAR(10) NOT NULL,
maximo NUMBER(2) NOT NULL,
maximoGratuito NUMBER(2) NOT NULL,
tiempo NUMBER(2,1));

CREATE TABLE Lecciones(
codigo CHAR(5) NOT NULL,
descripcion VARCHAR(10) NOT NULL,
nivel NUMBER(10) NOT NULL);

CREATE TABLE Contienen(
codigoLeccion CHAR(5) NOT NULL,
idEjercicio CHAR(5) NOT NULL);

CREATE TABLE Ejercicios(
id CHAR(5) NOT NULL,
creacion TIMESTAMP  NOT NULL,
introduccion VARCHAR (20),
dificultad  NUMBER(1) NOT NULL,
intentos NUMBER(5) NOT NULL,
puntaje NUMBER(5) NOT NULL,
tiempo NUMBER(2,1),
idioma CHAR(5) NOT NULL,
examen CHAR (5) NOT NULL,
Competencias CHAR(5) NOT NULL);

CREATE TABLE Examenes(
codigo CHAR(5) NOT NULL,
puntajeMinimo NUMBER(2) NOT NULL,
nivel NUMBER(10) NOT NULL);

CREATE TABLE Grabaciones(
id CHAR(5) NOT NULL,
frase VARCHAR(20),
programa VARCHAR(30) NOT NULL);

--Pk's

ALTER TABLE Ejercicios
    ADD CONSTRAINT pk_ejercicios
    PRIMARY KEY (id);

ALTER TABLE Grabaciones
    ADD CONSTRAINT pk_Grabaciones
    PRIMARY KEY (id);
    
--Fk's

ALTER TABLE Grabaciones
    ADD CONSTRAINT fk_Grabaciones_Ejercicios
    FOREIGN KEY (id)
    REFERENCES Ejercicios(id);

--Uk's
ALTER TABLE Ejercicios
    ADD CONSTRAINT uk_Ejercicios
    UNIQUE (introduccion);

--Disparadores
CREATE OR REPLACE TRIGGER IN_ejercicios_fechaCreacion
BEFORE INSERT ON Ejercicios
FOR EACH ROW 
DECLARE 
fecha TIMESTAMP;
BEGIN
    SELECT TO_CHAR(SYSDATE, 'DD/MM/YYYY HH:MI:SS AM') INTO fechA FROM dual;
    :NEW.creacion:=fecha;
END IN_ejercicios_fechaCreacion;

CREATE OR REPLACE TRIGGER IN_Ejercicios_inetntos
BEFORE INSERT ON Ejercicios
FOR EACH ROW
DECLARE
difi NUMBER;
BEGIN
    difi := :NEW.dificultad * 3 ;
    IF :NEW.intentos IS NULL THEN :NEW.intentos := difi;
    END IF;
END IN_Ejercicios_inetntos;
    

--La siguiente parte está escrita en sql developer, por lo tanto lo mas seguro es que de un error al correrlo
CREATE DOMAIN TTiempo AS NUMBER CONSTRAINT 
    CHECK(VALUE IN (0-40));
    
ALTER TABLE Competencias ADD CONSTRAINT CK_Competencias_maximos
    CHECK (maximoGratuito IN (0 -( maximo//2)));
    
--Para verificar que se ingresa en miles, se hace un disparador
CREATE OR REPLACE TRIGGER IN_idiomas_estudiantes
BEFORE INSERT ON Idiomas
FOR EACH ROW 
BEGIN
    :OLD.estudiantes = (:NEW.estudiantes / 1000);
END IN_idiomas_estudiantes;
--

CREATE DOMAIN estudiantes AS NUMBER CONSTRAINT 
    CHECK(VALUE < 100));
    
CREATE ASSERTION AS_LoHablan_Idiomas
CHECK(100 >= (SELECT SUM(porcentaje) FROM LoHablan
                JOIN Idiomas ON Idiomas.nombre =  LoHablan.nombreIdioma
                GROUP BY paises);

DELETE CASCADE Ejercicios;

DROP TABLE Paises;
DROP TABLE LoHablan;
DROP TABLE Nivel;
DROP TABLE Objetivos;
DROP TABLE Competencias;
DROP TABLE Lecciones;
DROP TABLE Contienen;
DROP TABLE Ejercicios CASCADE CONSTRAINTS;
DROP TABLE Examenes;
DROP TABLE Grabaciones;
DROP TABLE Idiomas;


                