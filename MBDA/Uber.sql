--Tablas

CREATE TABLE personas (
id INT NOT NULL,
tipo VARCHAR(2),
numero INT,
nombre VARCHAR(50),
registro DATE,
celular INT,
correo VARCHAR(50));

CREATE TABLE idiomas (
nombre VARCHAR(50) NOT NULL,
idPersona INT NOT NULL);

CREATE TABLE conductores (
cedula NUMBER  NOT NULL ,
licencia VARCHAR(10),
fechaNacimiento DATE,
estrellas INT,
estado VARCHAR(1));

CREATE TABLE vehiculos (
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

CREATE TABLE clientes(
id INT NOT NULL,
numeroTargeta INT,
direccionUbicacion VARCHAR(20),
idiomas VARCHAR(50));

CREATE TABLE tarjetas (
numero INT NOT NULL,
entidad VARCHAR(10),
vencimiento DATE);

CREATE TABLE ubicaciones(
nombre VARCHAR(5),
direccion VARCHAR(20),
latitud FLOAT,
longitud FLOAT);

CREATE TABLE solicitudes(
codigo INT NOT NULL,
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

CREATE TABLE posiciones(
latitud NUMBER(3,2),
longitud FLOAT);

CREATE TABLE requerimientos(
id INT NOT NULL,
placaVehiculo VARCHAR(30),
musica VARCHAR(15),
ruta VARCHAR(50),
descripcion VARCHAR(50));

-- PK's

ALTER TABLE personas
    ADD CONSTRAINT pk_persona
    PRIMARY KEY (id);

ALTER TABLE conductores
    ADD CONSTRAINT pk_conductor
    PRIMARY KEY (licencia);

ALTER TABLE vehiculos
    ADD CONSTRAINT pk_vehiculo
    PRIMARY KEY (placa);

ALTER TABLE clientes
    ADD CONSTRAINT pk_cliente
    PRIMARY KEY (id);

ALTER TABLE tarjetas
    ADD CONSTRAINT pk_tarjeta
    PRIMARY KEY (numero);

ALTER TABLE ubicaciones
    ADD CONSTRAINT pk_ubicacion
    PRIMARY KEY (direccion);

ALTER TABLE solicitudes
    ADD CONSTRAINT pk_solicitud
    PRIMARY KEY (codigo);

ALTER TABLE posiciones
    ADD CONSTRAINT pk_posicion
    PRIMARY KEY (latitud, longitud);

ALTER TABLE requerimientos
    ADD CONSTRAINT pk_requerimiento
    PRIMARY KEY (id);

--FK's

ALTER TABLE vehiculos
ADD CONSTRAINT fk_vehiculos_conductores
FOREIGN KEY (id)
REFERENCES conductores (id);

ALTER TABLE clientes
ADD CONSTRAINT fk_clientes_tarjetas
FOREIGN KEY (numeroTarjeta)
REFERENCES tarjetas (numeroTarjeta);

ALTER TABLE clientes
ADD CONSTRAINT fk_clientes_ubicaciones
FOREIGN KEY (direccionUbicacion)
REFERENCES ubicaciones (direccionUbicacion);

ALTER TABLE clientes
ADD CONSTRAINT fk_clientes_idiomas
FOREIGN KEY (nombre)
REFERENCES idiomas (nombre);

ALTER TABLE clientes
ADD CONSTRAINT fk_clientes_personas
FOREIGN KEY (id)
REFERENCES personas (id);

ALTER TABLE conductores
ADD CONSTRAINT fk_conductores_personas
FOREIGN KEY (id)
REFERENCES personas (id);

ALTER TABLE ubicaciones
ADD CONSTRAINT fk_ubicaciones_posiciones
FOREIGN KEY (latitud, longitud)
REFERENCES posiciones (latitud, longitud);

ALTER TABLE requerimientos
ADD CONSTRAINT fk_requerimientos_vehiculos
FOREIGN KEY (placaVehiculo)
REFERENCES vehiculos (placaVehiculo);

ALTER TABLE solicitudes
ADD CONSTRAINT fk_solicitudes_posiciones
FOREIGN KEY (latitudInicio, longitudInicio)
REFERENCES posiciones (latitudInicio, longitudInicio);

ALTER TABLE solicitudes
ADD CONSTRAINT fk_solicitudes_posiciones
FOREIGN KEY (latitudFinal, longitudFinal)
REFERENCES posiciones (latitudFinal, longitudFinal);

ALTER TABLE solicitudes
ADD CONSTRAINT fk_solicitudes_requerimientos
FOREIGN KEY (id)
REFERENCES requerimientos (id);

ALTER TABLE solicitudes
ADD CONSTRAINT fk_solicitudes_clientes
FOREIGN KEY (id)
REFERENCES clientes (id);

--UK's

ALTER TABLE personas
    ADD CONSTRAINT uk_personas
    UNIQUE(tipo, numero);

-- Atributos

ALTER TABLE personas ADD CONSTRAINT CK_personas_id 
    CHECK (LENGTH(id>0));

ALTER TABLE personas ADD CONSTRAINT CK_personas_tipo
    CHECK (tipo IN ('CE' OR 'CC' OR 'TI' OR 'PS'));

ALTER TABLE personas ADD CONSTRAINT CK_personas_numero
    CHECK (numero>0);

ALTER TABLE personas ADD CONSTRAINT CK_personas_nombre
    CHECK (LENGTH(nombre>0));

ALTER TABLE personas ADD CONSTRAINT CK_personas_registro
    CHECK (registro>0);

ALTER TABLE personas ADD CONSTRAINT CK_personas_celular
    CHECK (celular>0);

ALTER TABLE personas ADD CONSTRAINT CK_personas_correo
    CHECK (correo LIKE '%@%.%');

ALTER TABLE conductores ADD CONSTRAINT CK_conductores_cedula
    CHECK (cedula>0);

ALTER TABLE conductores ADD CONSTRAINT CK_conductores_licencia
    CHECK (licencia>0);

ALTER TABLE conductores ADD CONSTRAINT CK_conductores_fechaNacimiento
    CHECK (fechaNacimiento IN (To date ('DD-MM-YYYY' )));

ALTER TABLE conductores ADD CONSTRAINT CK_conductores_estrellas
    CHECK (estrellas>0);

ALTER TABLE conductores ADD CONSTRAINT CK_conductores_estado
    CHECK (estado IN ('disponible' OR  'ocupado'));
	
ALTER TABLE vehiculos ADD CONSTRAINT CK_vehiculos_placa
    CHECK (LENGTH(placa<6));

ALTER TABLE vehiculos ADD CONSTRAINT CK_vehiculos_llantas
    CHECK (llantas>0);

ALTER TABLE vehiculos ADD CONSTRAINT CK_vehiculos_cilindraje
    CHECK (cilindraje>0);

ALTER TABLE vehiculos ADD CONSTRAINT CK_vehiculos_a_o
    CHECK (a_o>0);

ALTER TABLE vehiculos ADD CONSTRAINT CK_vehiculos_tipo
    CHECK (tipo IN ('uberX' OR 'uberXL' OR 'uberBLACK' OR 'uberX VIP');

ALTER TABLE vehiculos ADD CONSTRAINT CK_vehiculos_estado
    CHECK (estado IN ('bien' OR 'dañadas');

ALTER TABLE vehiculos ADD CONSTRAINT CK_vehiculos_puertas
    CHECK (puertas>0);

ALTER TABLE vehiculos ADD CONSTRAINT CK_vehiculos_pasajeros
    CHECK (pasajeros>0);

ALTER TABLE vehiculos ADD CONSTRAINT CK_vehiculos_carga
    CHECK (carga>0);

ALTER TABLE vehiculos ADD CONSTRAINT CK_conductor
    CHECK (conductor>0);

ALTER TABLE clientes ADD CONSTRAINT CK_clientes_id
    CHECK ((LENGTH(id>0));

ALTER TABLE clientes ADD CONSTRAINT CK_clientes_numeroTarjeta
    CHECK (numeroTarjeta>0);

ALTER TABLE clientes ADD CONSTRAINT CK_clientes_direccionUbicacion
    CHECK (direccionUbicacion IN ('Localidad' OR 'calle');

ALTER TABLE clientes ADD CONSTRAINT CK_clientes_idiomas
    CHECK (idiomas IN ('español' OR 'ingles');
	
ALTER TABLE tarjetas ADD CONSTRAINT CK_tarjetas_numero
    CHECK (numero>0);

ALTER TABLE tarjetas ADD CONSTRAINT CK_tarjetas_entidad
    CHECK (entidad);

ALTER TABLE tarjetas ADD CONSTRAINT CK_tarjetas_vencimiento
    CHECK (vencimiento IN (to date ('DD-MM-YYYY' )));

ALTER TABLE ubicaciones ADD CONSTRAINT CK_ubicaciones_nombre
    CHECK (LENGTH(nombre));

ALTER TABLE ubicaciones ADD CONSTRAINT CK_ubicaciones_direccion
    CHECK (direccion);

ALTER TABLE ubicaciones ADD CONSTRAINT CK_ubicaciones_latitud
    CHECK (latitud>0);

ALTER TABLE ubicaciones ADD CONSTRAINT CK_ubicaciones_longitud
    CHECK (longitud>0);

ALTER TABLE solicitudes ADD CONSTRAINT CK_solicitudes_codigo
    CHECK (codigo>0);

ALTER TABLE solicitudes ADD CONSTRAINT CK_solicitudes_fechaCreacion
    CHECK (fechaCreacion IN (to date('DD-MM-YYYY' )));

ALTER TABLE solicitudes ADD CONSTRAINT CK_solicitudes_fechaViaje
    CHECK (fechaViaje IN (to date('DD-MM-YYYY' )));

ALTER TABLE solicitudes ADD CONSTRAINT CK_solicitudes_plataforma
    CHECK (plataforma);

ALTER TABLE solicitudes ADD CONSTRAINT CK_solicitudes_precio
    CHECK (precio>0);
 
ALTER TABLE solicitudes ADD CONSTRAINT CK_solicitudes_estado
    CHECK (estado IN ('disponible' OR  'ocupado');

ALTER TABLE solicitudes ADD CONSTRAINT CK_solicitudes_requerimineto
    CHECK (requerimiento);

ALTER TABLE solicitudes ADD CONSTRAINT OK_solicitudes_latitudInicio
    CHECK (latitudInicio>0);

ALTER TABLE solicitudes ADD CONSTRAINT OK_solicitudes_longitudInicio
    CHECK (logitudInicio>0);

ALTER TABLE solicitudes ADD CONSTRAINT OK_solicitudes_latitudFinal
    CHECK (latitudFinal>0);

ALTER TABLE solicitudes ADD CONSTRAINT OK_solicitudes_longitudFinal
    CHECK (longitudFinal>0);
	
ALTER TABLE posiciones ADD CONSTRAINT CK_posiciones_latitud
    CHECK (Latitud>0);

ALTER TABLE posiciones ADD CONSTRAINT CK_posiciones_longitud
    CHECK (longitud>0);

ALTER TABLE requerimientos ADD CONSTRAINT CK_requerimientos_id
    CHECK (id>0);

ALTER TABLE requerimientos ADD CONSTRAINT CK_requerimientos_placa
    CHECK (LENGTH(placa=30);

ALTER TABLE requerimientos ADD CONSTRAINT CK_requerimientos_musica
    CHECK (LENGTH(musica=15));

ALTER TABLE requerimientos ADD CONSTRAINT CK_requerimientos_ruta
    CHECK (LENGTH(ruta=50));

ALTER TABLE requerimientos ADD CONSTRAINT CK_requerimientos_descripcion
    CHECK (LENGTH(descripcion=50));
	
ALTER TABLE solicitudes ADD CONSTRAINT CK_FECHA_SOLICITUD
    CHECK (fechaViaje>fechaCreacion);

ALTER TABLE solicitudes ADD CONSTRAINT CK_INICIO_FINAL
    CHECK ((latitudInicio AND longitudInicio) NOT LIKE (latitudFinal AND longitudFinal));

ALTER TABLE solicitudes ADD CONSTRAINT CK_SOLICITUD_ESTADO
    CHECK ((COUNT(estado LIKE 'Activa'))<2);

ALTER TABLE solicitudes ADD CONSTRAINT CK_CREACION_ACTUAL
    CHECK (fechaViaje>fechaCreacion);


-- Triggers

CREATE TRIGGER vehiculos_estado_ins
BEFORE INSERT ON vehiculos
BEGIN
    IF (:NEW.conductor NOT LIKE NULL OR :NEW.estado NOT LIKE 'I')
        THEN RAISE_APPLICATION_ERROR(-20000, 'El vehiculo no esta inactivo o tiene un conductor asignado');
    END IF;
END vehiculos_estado_ins;
/
CREATE TRIGGER vehiculos_motos_ins
BEFORE INSERT ON vehiculos
WHEN (NEW.tipo LIKE 'M')
BEGIN
    IF ((:NEW.puertas NOT LIKE NULL) OR (:NEW.pasajeros NOT LIKE NULL) OR (:NEW.carga NOT LIKE NULL))
        THEN RAISE_APPLICATION_ERROR(-20002, 'El vehiculo "M" no puede tener todos estos valores');
    END IF;
END vehiculos_motos_ins;
/
CREATE TRIGGER vehiculos_automoviles_ins
BEFORE INSERT ON vehiculos
WHEN (NEW.tipo LIKE 'A')
BEGIN
    IF ((:NEW.puertas LIKE NULL) OR (:NEW.pasajeros LIKE NULL) OR (:NEW.carga NOT LIKE NULL))
        THEN RAISE_APPLICATION_ERROR(-20002, 'El vehiculo "A" tiene valores erroneos');
    END IF;
END vehiculos_automoviles_ins;
/
CREATE TRIGGER vehiculos_camiones_ins
BEFORE INSERT ON vehiculos
BEGIN
    IF ((:NEW.puertas LIKE NULL) OR (:NEW.pasajeros LIKE NULL) OR (:NEW.carga LIKE NULL))
        THEN RAISE_APPLICATION_ERROR(-20003, 'El vehiculo "C" no posee toda la informacion');
    END IF;
END vehiculos_camiones_ins;
/

CREATE TRIGGER vehiculos_upd
BEFORE UPDATE (placa, cilindraje, a_o, tipo, puertas, pasajeros, carga)
BEGIN
	RAISE_APPLICATION_ERROR(-20004, 'Solo se pueden modificar el conductor y el estado del vehiculo')
END vehiculos_upd;
/
CREATE TRIGGER vehiculos_estado_upd
BEFORE UPDATE ON vehiculos
BEGIN
	IF ((:OLD.estado LIKE 'A') AND (:NEW.estado LIKE 'I')) OR ((:OLD.estado LIKE 'I') AND (:NEW.estado LIKE 'A')) THEN :OLD.estado = :NEW.estado END IF;
	IF ((:OLD.estado LIKE 'I') AND (:NEW.estado LIKE 'R')) OR ((:OLD.estado LIKE 'R') AND (:NEW.estado LIKE 'I')) THEN :OLD.estado = :NEW.estado END IF;
	IF ((:OLD.estado LIKE 'O') AND (:NEW.estado LIKE 'A')) OR ((:OLD.estado LIKE 'A') AND (:NEW.estado LIKE 'O')) THEN :OLD.estado = :NEW.estado END IF;
END vehiculos_estado_upd;
/
CREATE TRIGGER vehiculos_conductor_a_upd
BEFORE UPDATE ON vehiculos
BEGIN 
	IF ((:OLD.conductor LIKE NULL) AND (:NEW.estado LIKE 'A')) OR ((:OLD.estado LIKE 'A') AND (:NEW.conductor LIKE NULL))
		THEN RAISE_APPLICATION_ERROR(-20005, 'Para que un vehiculo pueda estar en estado "A" debe pertenecer a un conductor');
	END IF;
END vehiculos_conductor_a_upd;		
/
CREATE TRIGGER vehiculo_del
BEFORE DELETE ON vehiculos
BEGIN
	IF :OLD.estado NOT LIKE 'R' THEN RAISE_APPLICATION_ERROR(-20006, 'No se puede eliminar un vehiculo si su estado no es "R"')
	END IF;
END vehiculo_del;
/
CREATE TRIGGER IN_CODIGO_FECHA
BEFORE INSERT ON codigo, fechaCreacion
BEGIN
	SELECT COUNT(codigo) + 1 INTO NEW.codigo FROM solicitudes;
END IN_CODIGO_FECHA;
/
CREATE TRIGGER IN_SOLICITUD_ESTADO
BEFORE INSERT ON solicitudes
BEGIN
	IF :NEW.estado NOT LIKE 'P'
		THEN RAISE_APPLICATION_ERROR(-20007, 'El estado debe ser "P" inicialmente')
	END IF;
END IN_SOLICITUD_ESTADO;
/
CREATE TRIGGER IN_FECHA_PRECIO
BEFORE INSERT ON solicitudes
BEGIN
	IF (:NEW.fechaViaje NOT LIKE NULL) OR (:NEW.precio NOT LIKE NULL)
		THEN RAISE_APPLICATION_ERROR(-20008, 'El precio y la fecha de viaje deben ser NULL inicialmente')
	END IF;
END IN_FECHA_PRECIO;
/
CREATE TRIGGER UP_FV_PRECIO_ESTADO
BEFORE UPDATE (codigo, idCliente, fechaCreacion, plataforma, descripcion, latitudInicio, logitudInicio, latitudFinal, longitudFinal) ON solicitudes
BEGIN
	RAISE_APPLICATION_ERROR(-20009, 'Solo se pueden modificar las columnas de fechaViaje, precio y estado')
END UP_FV_PRECIO_ESTADO;
/
CREATE TRIGGER UP_FV_PRECIO
BEFORE UPDATE (fechaViaje, precio)
WHEN OLD.estado LIKE 'P'
BEGIN
	:OLD.fechaViaje = :NEW.fechaViaje;
	:OLD.precio = :NEW.precio
END UP_FV_PRECIO;
/
CREATE TRIGGER UP_ESTADO
BEFORE UPDATE solicitudes
WHEN NEW.estado = 'C'
BEGIN
	RAISE_APPLICATION_ERROR(-20010, 'No se pueden modificar solicitudes de viajes cancelados')
END UP_ESTADO;
/
CREATE TRIGGER DEL_SOLICITUDES
BEFORE DELETE solicitudes
BEGIN
	RAISE_APPLICATION_ERROR(-20011, 'No se pueden eliminar las solicitudes')
END DEL_SOLICITUDES;
/
--PoblarOK

INSERT INTO personas VALUES (134697825, 'TI', 15, 'Yesid Carrillo', to_date('24-02-2002', 'DD-MM-YYYY'), 3129845267, 'yesidcarrillo@gmail.com');
INSERT INTO personas VALUES (976431258, 'CC', 26, 'Julia Mejia', to_date('25-02-2002', 'DD-MM-YYYY'), 3129326571, 'juliamejia@gmail.com');
INSERT INTO personas VALUES (845721963, 'CE', 19, 'Sergio Otero', to_date('26-02-2002', 'DD-MM-YYYY'), 3125846392, 'sergiotero@gmail.com');

INSERT INTO conductores VALUES (134697826, 'Ca87654321', to_date('26-03-2002', 'DD-MM-YYYY'), 4, 'I');
INSERT INTO conductores VALUES (134697827, 'Ca87654322', to_date('27-03-2002', 'DD-MM-YYYY'), 5, 'A');
INSERT INTO conductores VALUES (134697828, 'Ca87654323', to_date('28-03-2002', 'DD-MM-YYYY'), 3, 'R');

INSERT INTO vehiculos VALUES ('ABC123', 1, 123, 1900, 'A', 'I', 4, 3, 123, NULL);
INSERT INTO vehiculos VALUES ('ABC124', 2, 456, 1901, 'B', 'I', 4, 2, 321, NULL);
INSERT INTO vehiculos VALUES ('ABC125', 3, 789, 1902, 'C', 'I', 4, 2, 132, NULL);

INSERT INTO clientes VALUES (134697825, 123456789101112, 'Cra 2a #12-64', 'Español');
INSERT INTO clientes VALUES (976431258, 123456789101111, 'Cra 2a #12-65', 'Español');
INSERT INTO clientes VALUES (845721963, 123456789101113, 'Cra 2a #12-66', 'Español');

INSERT INTO tarjetas VALUES(12345678910112, 'Bancolombi', to_date('26-03-2027', 'DD-MM-YYYY'));
INSERT INTO tarjetas VALUES(12345678910111, 'Davivienda', to_date('27-03-2027', 'DD-MM-YYYY'));
INSERT INTO tarjetas VALUES(12345678910113, 'Itau', to_date('26-03-2027', 'DD-MM-YYYY'));

INSERT INTO ubicaciones VALUES('Cedro', 'Calle 147 #21-04', 004.72, -074.04);
INSERT INTO ubicaciones VALUES('Cedro', 'Calle 148 #21-05', 004.73, -074.04);
INSERT INTO ubicaciones VALUES('Cedro', 'Calle 152 #31-05', 004.73, -074.05);

INSERT INTO solicitudes VALUES(123456789, 134697825, '26-03-2021-6:30', '26-03-2021-7:30', 'D', 200, 'P', 753916248, 004.72, -074.04, 004.75, -074.04);
INSERT INTO solicitudes VALUES(123456781, 976431258, '27-03-2021-6:40', '27-03-2021-8:30', 'B', 300, 'A', 753916249, 004.73, -074.04, 004.73, -074.05);
INSERT INTO solicitudes VALUES(123456782, 845721963, '28-03-2021-6:50', '28-03-2021-9:30', 'A', 400, 'C', 753916240, 004.73, -074.05, 004.76, -074.06);

INSERT INTO posiciones VALUES(004.75, -074.04);
INSERT INTO posiciones VALUES(004.76, -074.04);
INSERT INTO posiciones VALUES(004.76, -074.06);

INSERT INTO requerimientos VALUES(753916248, 'ABC123', 'BAD BUNNY', 'Autopista', 'Casa 22');
INSERT INTO requerimientos VALUES(753916249, 'ABC124', 'DAFT PUNK', 'Autopista', 'Conjunto Costa Rica');
INSERT INTO requerimientos VALUES(753916240, 'ABC125', 'EMINEM', 'Autopista', 'Centro Comercial Cedritos');

--DisparadoresOK

INSERT INTO solicitudes VALUES(123456700, 134697824, '26-03-2021-6:30', '26-03-2021-7:30', 'D', 200, 'P', 753916248, 004.72, -074.04, 004.75, -074.04);
INSERT INTO vehiculos VALUES('ABC126', 1, 123, 1900, 'A', 'I', 4, 3, 123, NULL);

UPDATE solicitudes SET precio = 200 WHERE estado LIKE 'P';
UPDATE solicitudes SET fechaViaje = to_date('26-05-2002', 'DD-MM-YYYY') WHERE estado LIKE 'A';
UPDATE solicitudes SET estado = 'I' WHERE estado NOT LIKE 'C';
UPDATE vehiculos SET conductor = 134697826 WHERE placa LIKE 'ABC123'; 

DELETE FROM vehiculos WHERE placa = 'ABC124';

--DisparadoresNoOK

INSERT INTO solicitudes VALUES(123456700, 134697824, '26-03-2021-6:30', '26-03-2021-7:30', 'D', 200, 'A', 753916248, 004.72, -074.04, 004.75, -074.04);
INSERT INTO vehiculos VALUES('ABC126', 1, 123, 1900, 'A', 'I', 4, 3, 123, 134697826);
INSERT INTO solicitudes VALUES(NULL, 134697824, NULL, '26-03-2021-7:30', 'D', 200, 'A', 753916248, 004.72, -074.04, 004.75, -074.04);
INSERT INTO solicitudes VALUES(123456700, 134697824, '26-03-2021-6:30', '26-03-2019-7:30', 'D', 200, 'A', 753916248, 004.72, -074.04, 004.75, -074.04)

UPDATE solicitudes SET codigo = 123456799 WHERE estado LIKE 'A';
UPDATE solicitudes SET estado = 'I' WHERE estado LIKE 'C';
UPDATE solicitudes SET precio = 200 WHERE estado LIKE 'A';
UPDATE vehiculos SET cilindraje = 123 WHERE placa LIKE 'ABC123';

DELETE FROM vehiculos WHERE placa = 'ABC123';
DELETE FROM solicitudes WHERE codigo LIKE 123456789;

--Acciones

CONSTRAINT fk_vehiculos_conductores FOREIGN KEY (id)
REFERENCES conductores (id)
ON DELETE(CASCADE);

CONSTRAINT fk_clientes_tarjetas FOREIGN KEY (numeroTargeta)
REFERENCES tarjetas (numeroTarjeta)
ON DELETE(CASCADE);

CONSTRAINT fk_clientes_ubicaciones FOREIGN KEY (direccionUbicacion)
REFERENCES  ubicaciones (direccionUbicacion)
ON DELETE(CASCADE);

CONSTRAINT fk_clientes_idiomas FOREIGN KEY (nombre)
REFERENCES idiomas (nombre)
ON DELETE(CASCADE);

CONSTRAINT fk_clientes_personas FOREIGN KEY (id)
REFERENCES  personas (id)
ON DELETE(CASCADE);

CONSTRAINT fk_conductores_personas FOREIGN KEY (id)
REFERENCES  personas (id)
ON DELETE(CASCADE);

CONSTRAINT fk_ubicaciones_posiciones FOREIGN KEY (latitud, longitud)
REFERENCES posiciones (latitud, longitud)
ON DELETE(CASCADE);

CONSTRAINT fk_requerimientos_vehiculos FOREIGN KEY (placaVehiculo)
REFERENCES vehiculos (placaVehiculo)
ON DELETE(CASCADE);

CONSTRAINT fk_solicitudes_posiciones FOREIGN KEY (latitudInicio, longitudInicio)
REFERENCES posiciones (latitudInicio, longitudInicio)
ON DELETE(CASCADE);

CONSTRAINT fk_solicitudes_posiciones FOREIGN KEY (latitudFinal, longitudFinal)
REFERENCES posiciones (latitudFinal, longitudFinal)
ON DELETE(CASCADE);

CONSTRAINT fk_solicitudes_requerimientos FOREIGN KEY (id)
REFERENCES requerimientos (id)
ON DELETE(CASCADE);

CONSTRAINT fk_solicitudes_clientes FOREIGN KEY (id)
REFERENCES clientes (id)
ON DELETE(CASCADE);



--XDisparadores

DROP TRIGGER vehiculos_estado_ins;
DROP TRIGGER vehiculos_motos_ins;
DROP TRIGGER vehiculos_automoviles_ins;
DROP TRIGGER vehiculos_camiones_ins;
DROP TRIGGER vehiculos_upd;
DROP TRIGGER vehiculos_estado_upd;
DROP TRIGGER vehiculos_conductor_a_upd;
DROP TRIGGER vehiculos_canticondutor_upd;
DROP TRIGGER vehiculo_del;

--XTablas

DROP TABLE clientes CASCADE CONSTRAINTS;
DROP TABLE idiomas CASCADE CONSTRAINTS;
DROP TABLE personas CASCADE CONSTRAINTS;
DROP TABLE conductores CASCADE CONSTRAINTS;
DROP TABLE vehiculos CASCADE CONSTRAINTS;
DROP TABLE tarjetas CASCADE CONSTRAINTS;
DROP TABLE ubicaciones CASCADE CONSTRAINTS;
DROP TABLE solicitudes CASCADE CONSTRAINTS;
DROP TABLE posiciones CASCADE CONSTRAINTS;
DROP TABLE requerimientos CASCADE CONSTRAINTS;