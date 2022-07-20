-- TABLAS

CREATE TABLE soluciones (
codigo NUMBER NOT NULL,
nombre VARCHAR(250) NOT NULL,
descripcion VARCHAR(500) NOT NULL,
tipo VARCHAR(100) NOT NULL);

CREATE TABLE adquisiciones (
codigo NUMBER NOT NULL,
calificacion NUMBER NOT NULL,
observacion VARCHAR(250) NOT NULL,
fechaAdquisicion DATE NOT NULL,
fechaRetiro DATE NOT NULL,
cliente NUMBER,
plan NUMBER NOT NULL, 
solucion NUMBER NOT NULL);

CREATE TABLE clientes (
codigo NUMBER NOT NULL,
nombre VARCHAR(250) NOT NULL,
correo VARCHAR(250) NOT NULL,
idioma VARCHAR(50) NOT NULL);

CREATE TABLE usuarios (
nickName VARCHAR(50) NOT NULL,
cliente NUMBER NOT NULL);

CREATE TABLE acudientes (
nombre VARCHAR(250) NOT NULL,
usuario VARCHAR(50) NOT NULL,
cliente NUMBER NOT NULL);

CREATE TABLE organizaciones (
contacto VARCHAR(250) NOT NULL,
telefono NUMBER NOT NULL,
cliente NUMBER NOT NULL);

CREATE TABLE reportes (
usuario VARCHAR(50) NOT NULL,
organizacion VARCHAR(250) NOT NULL,
telefono NUMBER NOT NULL);

CREATE TABLE cuestionarios (
codigo NUMBER NOT NULL,
titulo VARCHAR(50) NOT NULL,
descripcion VARCHAR(250) NOT NULL,
fechaCreacion DATE NOT NULL);

CREATE TABLE respuestas (
texto VARCHAR(250) NOT NULL,
esCorrecta BOOLEAN NOT NULL,
pregunta VARCHAR(250) NOT NULL);

CREATE TABLE opciones (
usuario VARCHAR(50) NOT NULL,
respuesta VARCHAR(250) NOT NULL,
pregunta VARCHAR(250) NOT NULL);

CREATE TABLE preguntas (
texto VARCHAR(250) NOT NULL,
puntos NUMBER NOT NULL,
cuestionario NUMBER NOT NULL);

CREATE TABLE planes (
numero NUMBER NOT NULL,
nombre VARCHAR(250) NOT NULL,
descripcion VARCHAR(500) NOT NULL,
precio NUMBER NOT NULL,
tipo VARCHAR(3) NOT NULL);

CREATE TABLE creaciones (
usuario VARCHAR(50),
cuestionario NUMBER,
cliente NUMBER);

-- Atributos

ALTER TABLE soluciones ADD CONSTRAINT CK_soluciones_codigo
    CHECK (LENGTH(codigo)=10);

ALTER TABLE soluciones ADD CONSTRAINT CK_soluciones_tipo
    CHECK (tipo IN ('colegio' OR 'trabajo' OR 'entretenimiento' OR 'academia'));

ALTER TABLE adquisiciones ADD CONSTRAINT CK_adquisiciones_codigo
    CHECK (LENGTH(codigo)=10);

ALTER TABLE adquisiciones ADD CONSTRAINT CK_adquisiciones_calificacion
    CHECK (calificacion IN ('buena' OR 'regular' OR 'mala'));

ALTER TABLE planes ADD CONSTRAINT CK_planes_numero
    CHECK (LENGTH(numero)=10);

ALTER TABLE planes ADD CONSTRAINT CK_planes_precio
    CHECK (precio IN ('$' OR '€'));

ALTER TABLE planes ADD CONSTRAINT CK_planes_tipo
    CHECK (plan IN ('basico' OR 'pro' OR 'premium'));

ALTER TABLE organizaciones ADD CONSTRAINT CK_organizaciones_telefono
    CHECK (LENGTH(telefono)=10);

ALTER TABLE clientes ADD CONSTRAINT CK_clientes_codigo
    CHECK (LENGTH(codigo)=10);

ALTER TABLE cuestionarios ADD CONSTRAINT CK_cuestionarios_codigo
    CHECK (LENGTH(codigo)=10);

-- Pk's

ALTER TABLE soluciones
    ADD CONSTRAINT pk_soluciones
    PRIMARY KEY (codigo);

ALTER TABLE adquisiciones
    ADD CONSTRAINT pk_adquisiciones
    PRIMARY KEY (codigo);

ALTER TABLE clientes
    ADD CONSTRAINT pk_clientes
    PRIMARY KEY (codigo);

ALTER TABLE usuarios
    ADD CONSTRAINT pk_usuarios
    PRIMARY KEY (nickName, cliente);

ALTER TABLE acudientes
    ADD CONSTRAINT pk_acudientes
    PRIMARY KEY (nombre, usuario);

ALTER TABLE organizaciones
    ADD CONSTRAINT pk_organizaciones
    PRIMARY KEY (contacto, telefono);

ALTER TABLE reportes
    ADD CONSTRAINT pk_reportes
    PRIMARY KEY (usuario, organizacion);

ALTER TABLE cuestionarios
    ADD CONSTRAINT pk_cuestionarios
    PRIMARY KEY (codigo);

ALTER TABLE respuestas
    ADD CONSTRAINT pk_respuestas
    PRIMARY KEY (texto, pregunta);

ALTER TABLE opciones
    ADD CONSTRAINT pk_opciones
    PRIMARY KEY (usuario, respuesta);
    
ALTER TABLE preguntas
    ADD CONSTRAINT pk_preguntas
    PRIMARY KEY (texto, cuestionario);
    
ALTER TABLE planes
    ADD CONSTRAINT pk_planes
    PRIMARY KEY (numero);
	
ALTER TABLE creaciones
    ADD CONSTRAINT pk_creaciones
    PRIMARY KEY (usuario, cuestionario);

-- Fk's

ALTER TABLE adquisiciones
ADD CONSTRAINT fk_adquisiciones_clientes
FOREIGN KEY (cliente)
REFERENCES clientes (codigo);

ALTER TABLE adquisiciones
ADD CONSTRAINT fk_adquisiciones_planes
FOREIGN KEY (plan)
REFERENCES planes (numero);

ALTER TABLE adquisiciones
ADD CONSTRAINT fk_adquisiciones_soluciones
FOREIGN KEY (solucion)
REFERENCES soluciones (codigo);

ALTER TABLE acudientes
ADD CONSTRAINT fk_acudientes_usuarios
FOREIGN KEY (usuario, cliente)
REFERENCES usuarios (nickName, cliente);

ALTER TABLE respuestas
ADD CONSTRAINT fk_respuestas_preguntas
FOREIGN KEY (pregunta)
REFERENCES preguntas (texto);

ALTER TABLE preguntas
ADD CONSTRAINT fk_preguntas_cuestionario
FOREIGN KEY (cuestionario)
REFERENCES cuestionarios(codigo);

ALTER TABLE usuarios
ADD CONSTRAINT fk_usuarios_cliente
FOREIGN KEY (cliente)
REFERENCES clientes(codigo);

ALTER TABLE organizaciones
ADD CONSTRAINT fk_organizaciones_cliente
FOREIGN KEY (cliente)
REFERENCES clientes (codigo);

ALTER TABLE creaciones
ADD CONSTRAINT fk_creaciones_usuarios
FOREIGN KEY (usuario, cliente)
REFERENCES usuarios (nickName, cliente);

ALTER TABLE creaciones
ADD CONSTRAINT fk_creaciones_cuestionarios
FOREIGN KEY (cuestionario)
REFERENCES cuestionarios (codigo);

ALTER TABLE opciones
ADD CONSTRAINT fk_creaciones_usuarios
FOREIGN KEY (usuario, cliente)
REFERENCES usuarios (nickName, cliente);

ALTER TABLE opciones
ADD CONSTRAINT fk_creaciones_respuestas
FOREIGN KEY (respuesta, pregunta)
REFERENCES respuestas (texto, pregunta);

ALTER TABLE reportes
ADD CONSTRAINT fk_reportes_organizaciones
FOREIGN KEY (organizacion, telefono)
REFERENCES organizaciones (organizacion, telefono)

ALTER TABLE reportes
ADD CONSTRAINT fk_reportes_usuario
FOREIGN KEY (usuario, cliente)
REFERENCES organizaciones (nickName, cliente)


-- Uk's

ALTER TABLE soluciones
    ADD CONSTRAINT uk_soluciones
    UNIQUE(nombre);

ALTER TABLE clientes
    ADD CONSTRAINT uk_clientes
    UNIQUE(correo);
    
ALTER TABLE usuarios
    ADD CONSTRAINT uk_usuarios
    UNIQUE(nickName);
    
ALTER TABLE planes
    ADD CONSTRAINT uk_planes
    UNIQUE(nombre);
    
-- Restricciones

CREATE DOMAIN plan AS VARCHAR(3) CONSTRAINT
	CHECK (VALUE IN ('Bas', 'Pro', 'Pre'));

ALTER TABLE adquisiciones ADD CONSTRAINT CK_adquisiciones
	CHECK (fechaAdquisicion < fechaRetiro)
	
CREATE DOMAIN calificacion AS NUMBER CONSTRAINT
	CHECK (VALUE IN (1-5))

-- Disparadores
CREATE TRIGGER tipo_planes
BEFORE INSERT ON planes
FOR EACH ROW
BEGIN
	IF :NEW.tipo IN ('Bas', 'Pro', 'Pre') 
		THEN :OLD.tipo = :NEW.tipo
	END IF;
END tipo_planes;


CREATE TRIGGER add_adquisicion_cod
BEFORE INSERT INTO adquisiciones
FOR EACH ROW
BEGIN
	SELECT COUNT(codigo) + 1 INTO :NEW.codigo FROM adquisiciones;
	
END add_adquisicion_cod;

CREATE TRIGGER add_adquisicion_activa
BEFORE INSERT INTO adquisiciones
FOR EACH ROW
BEGIN
	IF cliente IN (SELECT cliente FROM adquisiciones)
		THEN RAISE_APPLICATION_ERROR(-20001, 'No se puede insertar un cliente con una adquisicion ya acativa')
	END IF;
END add_adquisicion_activa;


CREATE TRIGGER up_adquisiciones_calificacion_observacion
BEFORE UPDATE INTO adquisiciones
FOR EACH ROW
BEGIN
    IF ((:OLD.fechaRetiro < NEW.fechaRetiro) THEN (OLD.calificacion = NEW.oservacion AND OLD.observacion = NEW.observacion))
    END IF
END up_adquisiciones_calificacion_observacion;

CREATE TRIGGER up_planes_descripcion
BEFORE UPDATE INTO planes
BEGIN
    IF ((:OLD.descripcion = NEW.descripcion) THEN RAISE_APPLICATION_ERROR('incluye....', 'No se puede actualizar la descripcion'))
    END IF
END up_planes_descripcion;

CREATE TRIGGER up_organizaciones_contacto
BEFORE UPDATE INTO organizaciones
BEGIN 
    IF ((COUNT(OLD.contacto)> 200 THEN OLD.contacto = 200) OR (COUNT(OLD.contacto)<200 THEN OLD.contacto = OLD.contacto))
    END IF
END up_organizaciones_contacto;


CREATE TRIGGER del_adquisicion_cliente
AFTER DELETE ON cliente
FOR EACH ROW
BEGIN
	DELETE cliente ON adquisiciones WHERE OLD.cliente = cliente
END del_adquisicion_cliente;

CREATE TRIGGER del_adquisicion_cliente
BEFORE DELETE ON adquisiciones
BEGIN
	RAISE_APPLICATION_ERROR(-20000, 'No se pueden eliminar las adquisiciones')
END del_adquisicion_cliente;