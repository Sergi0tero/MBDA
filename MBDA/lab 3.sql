--Tablas

CREATE TABLE persona (
id INT,
tipo VARCHAR(2),
numero INT,
nombre VARCHAR(50),
registro DATE,
celular INT,
correo VARCHAR(50));

CREATE TABLE conductor (
cedula INT,
licencia VARCHAR(10),
fechaNacimiento DATE,
estrellas INT,
estado VARCHAR(1));

CREATE TABLE vehiculo (
placa VARCHAR(30) NOT NULL,
llantas INT,
cilindraje INT,
a_o INT,
tipo VARCHAR(1),
estado VARCHAR(1),
puertas INT,
pasajeros INT,
carga INT,
conductor INT);

CREATE TABLE cliente(
id INT,
numeroTargeta INT,
direccionUbicacion VARCHAR(20),
idiomas VARCHAR(50));

CREATE TABLE tarjeta (
numero INT,
entidad VARCHAR(10),
vencimiento DATE);

CREATE TABLE ubicacion(
nombre VARCHAR(5),
direccion VARCHAR(20),
latitud FLOAT,
longitud FLOAT);

CREATE TABLE solicitud(
codigo INT,
idCliente INT,
fechaCreacion TIMESTAMP,
fechaViaje TIMESTAMP,
plataforma VARCHAR(1),
precio INT,
estado VARCHAR(1),
requerimiento INT,
latitudInicio FLOAT,
longitudInicio FLOAT,
latitudFinal FLOAT,
longitudFinal FLOAT);

CREATE TABLE posicion(
latitud FLOAT,
longitud FLOAT);

CREATE TABLE requerimiento(
id INT,
placaVehiculo VARCHAR(30),
musica VARCHAR(15),
ruta VARCHAR(50),
descripccion VARCHAR(50));

--PoblarOK

INSERT INTO persona VALUES (134697825, 'TI', 15, 'Yesid Carrillo', to_date('24-02-2002', 'DD-MM-YYYY'), 3129845267, 'yesidcarrillo@gmail.com');
INSERT INTO persona VALUES (976431258, 'CC', 26, 'Julia Mejia', to_date('25-02-2002', 'DD-MM-YYYY'), 3129326571, 'juliamejia@gmail.com');
INSERT INTO persona VALUES (845721963, 'CE', 19, 'Sergio Otero', to_date('26-02-2002', 'DD-MM-YYYY'), 3125846392, 'sergiotero@gmail.com');

INSERT INTO conductor VALUES (134697826, 'Ca87654321', to_date('26-03-2002', 'DD-MM-YYYY'), 4, 'I');
INSERT INTO conductor VALUES (134697827, 'Ca87654322', to_date('27-03-2002', 'DD-MM-YYYY'), 5, 'A');
INSERT INTO conductor VALUES (134697828, 'Ca87654323', to_date('28-03-2002', 'DD-MM-YYYY'), 3, 'R');

INSERT INTO vehiculo VALUES ('ABC123', 1, 123, 1900, 'A', 'R', 4, 3, 123, 134697826);
INSERT INTO vehiculo VALUES ('ABC124', 2, 456, 1901, 'B', 'I', 4, 2, 321, 134697827);
INSERT INTO vehiculo VALUES ('ABC125', 3, 789, 1902, 'C', 'O', 4, 2, 132, 134697828);

INSERT INTO cliente VALUES (134697825, 123456789101112, 'Cra 2a #12-64', 'Español');
INSERT INTO cliente VALUES (976431258, 123456789101111, 'Cra 2a #12-65', 'Español');
INSERT INTO cliente VALUES (845721963, 123456789101113, 'Cra 2a #12-66', 'Español');

INSERT INTO tarjeta VALUES(12345678910112, 'Bancolombi', to_date('26-03-2027', 'DD-MM-YYYY'));
INSERT INTO tarjeta VALUES(12345678910111, 'Davivienda', to_date('27-03-2027', 'DD-MM-YYYY'));
INSERT INTO tarjeta VALUES(12345678910113, 'Itau', to_date('26-03-2027', 'DD-MM-YYYY'));

INSERT INTO ubicacion VALUES('Cedro', 'Calle 147 #21-04', 004.72, -074.04);
INSERT INTO ubicacion VALUES('Cedro', 'Calle 148 #21-05', 004.73, -074.04);
INSERT INTO ubicacion VALUES('Cedro', 'Calle 152 #31-05', 004.73, -074.05);

INSERT INTO solicitud VALUES(123456789, 134697825, '26-03-2021-6:30', '26-03-2021-7:30', 'D', 200, 'P', 753916248, 004.72, -074.04, 004.75, -074.04);
INSERT INTO solicitud VALUES(123456781, 976431258, '27-03-2021-6:40', '27-03-2021-8:30', 'B', 300, 'A', 753916249, 004.73, -074.04, 004.73, -074.05);
INSERT INTO solicitud VALUES(123456782, 845721963, '28-03-2021-6:50', '28-03-2021-9:30', 'A', 400, 'C', 753916240, 004.73, -074.05, 004.76, -074.06);

INSERT INTO posicion VALUES(004.75, -074.04);
INSERT INTO posicion VALUES(004.76, -074.04);
INSERT INTO posicion VALUES(004.76, -074.06);

INSERT INTO requerimiento VALUES(753916248, 'ABC123', 'BAD BUNNY', 'Autopista', 'Casa 22');
INSERT INTO requerimiento VALUES(753916249, 'ABC124', 'DAFT PUNK', 'Autopista', 'Conjunto Costa Rica');
INSERT INTO requerimiento VALUES(753916240, 'ABC125', 'EMINEM', 'Autopista', 'Centro Comercial Cedritos');

--PoblarNoOK(1)

INSERT INTO cliente VALUES ('13d4f6fggd9d7d8f25', 123456789101112, 'Cra 2a #12-64', 'Español'); --No sirve por la id pues se mete algo que no es un entero
INSERT INTO persona VALUES (134697825, 'TI', 15, 'Yesid Carrillo', to_date('24-02-2002', 'DD-MM-YYYY'), 3129845267, 'yesidcarriwhalkjbfbhkjfdsahuvfduhvhhuiovfsuhfsdvvhovdfshufdvusllo@gmail.com'); --No sirve por que el correo sale del rango determinado
INSERT INTO conductor VALUES (134697828, 'Ca87654323', to_date('28-03', 'DD-MM-YYYY'), 3, 'R'); -- la fecha no esta en el formato correcto
INSERT INTO vehiculo VALUES ('ABC123', 1, 123, 1900, 'A', 'L', 'tres', 3, 123, 134697826); --No sirve por la cantidad de puertas, esta escrito como cadena
INSERT INTO tarjeta VALUES(123456789101112, 'Bancolombi', to_date('26-03-2027 7:30PM', 'DD-MM-YYYY')); --No sirve por que la fecha no esta expresada en el formato que le corresponde

--PoblarNoOK(2)

INSERT INTO solicitud VALUES(123456792, 845721963, '28-03-2021-6:50', '28-03-2021-9:30', 'A', 400, 'C', 753916240, 004.73, -074.05, 004.76, -074.06); --No deberia servir porque la fecha del viaje es de un año que ya paso
INSERT INTO vehiculo VALUES ('ABC123', 1, 123, 1900, 'A', 'L', 4, 3, 123, 134697826); --No deberia servir por el estado, no existe
INSERT INTO ubicacion VALUES('Cedro', 'Calle 147 #21-04', 024.62, -044.36); --No deberia servir por la ubicacion, pues esta está en medio del oceano atlantico
INSERT INTO solicitud VALUES(123456799, 134697825, '26-03-2021-6:30', '26-03-2021-7:30', 'D', 200, 'P', 753916248, 004.72, -074.04, 051.54, 046.01); --No deberia servir pues es un viaje que no se puede realizar en uber (De Bogotá, Colombia, a Sarátov, Rusia)
INSERT INTO persona VALUES (845721963, 'CE', 19, '123456789', to_date('26-02-2002', 'DD-MM-YYYY'), 3125846392, 'sergiotero@gmail.com'); --No deberia servir pues una persona no puede tener como nombre un numero

-------------Tabla Persona-------------
--CLAVE PRIMARIA

ALTER TABLE Persona
ADD CONSTRAINT pk_persona_id
PRIMARY KEY (id);

--CLAVE UNICA

ALTER TABLE Persona
ADD CONSTRAINT uk_persona_tipo
UNIQUE KEY (tipo);

ALTER TABLE Persona
ADD CONSTRAINT uk_persona_numero
UNIQUE KEY (numero);

--ATRIBUTOS

ALTER TABLE persona ADD CONSTRAINT OK_id
CHECK (VALUE IN(id>0));

ALTER TABLE persona ADD CONSTRAINT OK_tipo
CHECK (VALUE IN(tipo = 'CE' OR tipo = 'CC' OR tipo = 'TI' OR tipo = 'PS'));

ALTER TABLE persona ADD CONSTRAINT OK_numero
CHECK (VALUE IN(numero>0);

ALTER TABLE persona ADD CONSTRAINT OK_nombre
CHECK (VALUE IN(nombre));

ALTER TABLE persona ADD CONSTRAINT OK_registro
CHECK (VALUE IN(registro));

ALTER TABLE persona ADD CONSTRAINT OK_celular
CHECK (VALUE IN(celular>0));

ALTER TABLE persona ADD CONSTRAINT OK_correo
CHECK (VALUE IN(correo LIKE '%@%.%'));

--PoblarNoOk

INSERT INTO persona
VALUES (987654321,'CC',6738266120,'Andres Gonzalez',to_date('13-07-2020', 'DD-MM-YYYY'),3165428131,'andres26@gmail.com');

--------------------Tabla Conductor----------------------
--CLAVE PRIMARIA

ALTER TABLE Conductor
ADD CONSTRAINT pk_conductor_licencia
PRIMARY KEY (licencia);

--CLAVE UNIQUE

ALTER TABLE Conductor
ADD CONSTRAINT pk_conductor_cedula
UNIQUE KEY (cedula);

--ATRIBUTOS

ALTER TABLE persona ADD CONSTRAINT OK_cedula
CHECK (VALUE IN(cedula>0));

ALTER TABLE persona ADD CONSTRAINT OK_licencia
CHECK (VALUE IN(licencia>0));

ALTER TABLE persona ADD CONSTRAINT OK_fechaNacimiento
CHECK (VALUE IN(fechaNacimiento);

ALTER TABLE persona ADD CONSTRAINT OK_estrellas
CHECK (VALUE IN(estrellas > 0));

ALTER TABLE persona ADD CONSTRAINT OK_estado
CHECK (VALUE IN(estado));

--PoblarNoOk

INSERT INTO persona
VALUES (1000573515,'6738266120',to_date('13-07-2020', 'DD-MM-YYYY'),20,'activo');
--------------------Tabla Vehiculo------------------
--CLAVE PRIMARIA

ALTER TABLE Vehiculo
ADD CONSTRAINT pk_vehiculo_placa
PRIMARY KEY (placa);

--ATRIBUTOS

ALTER TABLE Vehiculo ADD CONSTRAINT OK_placa
CHECK (VALUE IN(placa));

ALTER TABLE Vehiculo ADD CONSTRAINT OK_llantas
CHECK (VALUE IN(llantas);

ALTER TABLE Vehiculo ADD CONSTRAINT OK_cilindraje
CHECK (VALUE IN(cilindraje));

ALTER TABLE Vehiculo ADD CONSTRAINT OK_a_o
CHECK (VALUE IN(a_o > 0));

ALTER TABLE Vehiculo ADD CONSTRAINT OK_tipo
CHECK (VALUE IN(tipo ));

ALTER TABLE Vehiculo ADD CONSTRAINT OK_estado
CHECK (VALUE IN(estado));

ALTER TABLE Vehiculo ADD CONSTRAINT OK_puertas
CHECK (VALUE IN(puertas>0));

ALTER TABLE Vehiculo ADD CONSTRAINT OK_pasajeros
CHECK (VALUE IN(pasajeros > 0));

ALTER TABLE Vehiculo ADD CONSTRAINT OK_carga
CHECK (VALUE IN(carga>0));

ALTER TABLE Vehiculo ADD CONSTRAINT OK_conductor
CHECK (VALUE IN(conductor>0));

--PoblarNoOk

INSERT INTO vehiculo
VALUES (,'mt0927',4,7,5,'clasico' ,'nuevo',4,6,20,1);

-------------------Tabla Cliente-----------------------
--CLAVE PRIMARIA

ALTER TABLE Cliente
ADD CONSTRAINT pk_cliente_id
PRIMARY KEY (id);

--CLAVE FOREIGN

ALTER TABLE Cliente
ADD CONSTRAINT fk_tarjeta_numero
FOREIGN KEY (tarjeta_numero)
REFERENCES tarjeta (numero);

ALTER TABLE Cliente
ADD CONSTRAINT fk_ubicacion_direccion
FOREIGN KEY (ubicacion_direccion)
REFERENCES ubicacion (direccion);

--ATRIBUTOS

ALTER TABLE cliente ADD CONSTRAINT OK_id
CHECK (VALUE IN(id>0 ));

ALTER TABLE cliente ADD CONSTRAINT OK_numeroTarjeta
CHECK (VALUE IN(numeroTarjeta>0);

ALTER TABLE cliente ADD CONSTRAINT OK_direccionUbicacion
CHECK (VALUE IN(direccionUbicacion);

ALTER TABLE cliente ADD CONSTRAINT OK_idiomas
CHECK (VALUE IN(idiomas));

--PoblarNoOk

INSERT INTO vehiculo
VALUES (,6738266120,13128381,'calle 73 57-23','ingles, aleman');
--------------------Tabla Tarjeta--------------------
--CLAVE PRIMARIA

ALTER TABLE Tarjeta
ADD CONSTRAINT pk_tarjeta_numero
PRIMARY KEY (numero);

--ATRIBUTOS

ALTER TABLE tarjeta ADD CONSTRAINT OK_numero
CHECK (VALUE IN(numero>0));

ALTER TABLE tarjeta ADD CONSTRAINT OK_entidad
CHECK (VALUE IN(entidad);

ALTER TABLE tarjeta ADD CONSTRAINT OK_vencimiento
CHECK (VALUE IN(vencimiento));

--PoblarNoOk

INSERT INTO vehiculo
VALUES (6738266120,'bancolombia',to_date('13 07 2020', 'DD MM YYYY'));

-------------------Tabla Ubicacion -----------------------
--CLAVE PRIMARIA

ALTER TABLE Ubicacion
ADD CONSTRAINT pk_ubicacion_nombre
PRIMARY KEY (codigo);

--ATRIBUTOS

ALTER TABLE ubicacion ADD CONSTRAINT OK_nombre
CHECK (VALUE IN(nombre));

ALTER TABLE ubicacion ADD CONSTRAINT OK_direccion
CHECK (VALUE IN(direccion));

ALTER TABLE ubicacion ADD CONSTRAINT OK_latitud
CHECK (VALUE IN(latitud));

ALTER TABLE ubicacion ADD CONSTRAINT OK_longitud
CHECK (VALUE IN(longitud));

--PoblarNoOk

INSERT INTO vehiculo
VALUES (,'salitre','calle 73 57-23','30 grados sur','74 oeste');
-------------------Tabla Solicitud-----------------------
--CLAVE PRIMARIA

ALTER TABLE Solicitud
ADD CONSTRAINT pk_solicitud_codigo
PRIMARY KEY (codigo);

--ATRIBUTOS

ALTER TABLE solicitud ADD CONSTRAINT OK_codigo
CHECK (VALUE IN(codigo>0));

ALTER TABLE solicitud ADD CONSTRAINT OK_fechaCreacion
CHECK (VALUE IN(fechaCreacion));

ALTER TABLE solicitud ADD CONSTRAINT OK_fechaViaje
CHECK (VALUE IN(fechaViaje));

ALTER TABLE solicitud ADD CONSTRAINT OK_plataforma
CHECK (VALUE IN(plataforma));

ALTER TABLE solicitud ADD CONSTRAINT OK_precio
CHECK (VALUE IN(precio>0));

ALTER TABLE solicitud ADD CONSTRAINT OK_estado
CHECK (VALUE IN(estado));

ALTER TABLE solicitud ADD CONSTRAINT OK_requerimineto
CHECK (VALUE IN(requerimiento));

ALTER TABLE solicitud ADD CONSTRAINT OK_latitudInicio
CHECK (VALUE IN(latitudInicio));

ALTER TABLE solicitud ADD CONSTRAINT OK_longitudInicio
CHECK (VALUE IN(logitudInicio));

ALTER TABLE solicitud ADD CONSTRAINT OK_latitudFinal
CHECK (VALUE IN(latitudFinal));

ALTER TABLE solicitud ADD CONSTRAINT OK_longitudFinal
CHECK (VALUE IN(longitudFinal));

--PoblarNoOk

INSERT INTO vehiculo
VALUES (673826612,to_date('13 07 2020', 'DD MM YYYY'),to_date('13 07 2020', 'DD MM YYYY'), 'avianca',8131,'activo','disponibilidad 24 horas','30 grados sur', '20 oeste','54 oeste', '32 este');
-------------------Tabla Posicion-----------------------
--CLAVE PRIMARIA

ALTER TABLE Posicion
ADD CONSTRAINT pk_posicion_latitudLongitud
PRIMARY KEY (latitudLongitud);

--ATRIBUTOS

ALTER TABLE posicion ADD CONSTRAINT OK_latitud
CHECK (VALUE IN(latitud ));

ALTER TABLE posicion ADD CONSTRAINT OK_longitud
CHECK (VALUE IN(longitud));

--PoblarNoOk

INSERT INTO vehiculo
VALUES ('30 grados sur','74 oeste');
-------------------Tabla Requerimiento-----------------------
--CLAVE PRIMARIA

ALTER TABLE Requerimiento
ADD CONSTRAINT pk_requerimiento_id
PRIMARY KEY (id);

--ATRIBUTOS

ALTER TABLE requerimiento ADD CONSTRAINT OK_id
CHECK (VALUE IN(id>0));

ALTER TABLE requerimiento ADD CONSTRAINT OK_placa
CHECK (VALUE IN(placa));

ALTER TABLE requerimiento ADD CONSTRAINT OK_musica
CHECK (VALUE IN(musica));

ALTER TABLE requerimiento ADD CONSTRAINT OK_ruta
CHECK (VALUE IN(ruta));

ALTER TABLE requerimiento ADD CONSTRAINT OK_descripcion
CHECK (VALUE IN(descripcion ));

--PoblarNoOk

INSERT INTO vehiculo
VALUES (311273, 'dsda456','rock','la nqs','tomar a la izquierda despues de la bomba');

--XPoblar

DELETE FROM persona WHERE celular LIKE '312%';
DELETE FROM conductor WHERE cedula LIKE '13%';
DELETE FROM vehiculo WHERE placa LIKE 'ABC%';
DELETE FROM cliente WHERE numeroTargeta LIKE '123%';
DELETE FROM tarjeta WHERE numero LIKE '123%';
DELETE FROM ubicacion WHERE nombre LIKE 'Cedro%';
DELETE FROM solicitud WHERE codigo LIKE '123%';
DELETE FROM posicion WHERE latitud LIKE '004%';
DELETE FROM requerimiento WHERE id LIKE '753%';

--XTablas

DROP TABLE cliente;
DROP TABLE persona;
DROP TABLE conductor;
DROP TABLE vehiculo;
DROP TABLE tarjeta;
DROP TABLE ubicacion;
DROP TABLE solicitud;
DROP TABLE posicion;
DROP TABLE requerimiento;