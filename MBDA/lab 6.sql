--Tablas

CREATE TABLE personas (
id NUMBER NOT NULL,
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
estado VARCHAR(1),
persona NUMBER);

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
conductor NUMBER);

CREATE TABLE clientes(
id INT NOT NULL,
numeroTarjeta INT,
direccionUbicacion VARCHAR(20),
idioma VARCHAR(50));

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
codigo NUMBER(9),
fechaCreacion TIMESTAMP,
fechaViaje TIMESTAMP,
plataforma VARCHAR(1),
precio NUMBER(5),
estado VARCHAR(1),
descripcion VARCHAR(100),
latitudInicio FLOAT,
longitudInicio FLOAT,
latitudFinal FLOAT,
longitudFinal FLOAT,
idCliente INT  );

CREATE TABLE posiciones(
latitud NUMBER(3,2),
longitud FLOAT);

CREATE TABLE requerimientos(
id INT NOT NULL,
placaVehiculo VARCHAR(30),
musica VARCHAR(15),
ruta VARCHAR(50),
descripcion VARCHAR(50));

-- CRUD paquetes

CREATE OR REPLACE PACKAGE PC_solicitudes AS
    PROCEDURE AD_solicitudes(
        xfechaViaje TIMESTAMP,
        xplataforma VARCHAR,
        xprecio NUMBER,
        xestado VARCHAR,
        xdescripcion VARCHAR);
END;
/
CREATE OR REPLACE PACKAGE BODY PC_solicitudes IS
    PROCEDURE AD_solicitudes(
        xfechaViaje TIMESTAMP,
        xplataforma VARCHAR,
        xprecio NUMBER,
        xestado VARCHAR,
        xdescripcion VARCHAR) IS
    BEGIN
        INSERT INTO solicitudes (fechaViaje, plataforma, precio, estado, descripcion) VALUES (xfechaViaje, xplataforma, xprecio, xestado, xdescripcion);
    END;
END;
/ 
CREATE OR REPLACE PACKAGE PC_vehiculos AS
    PROCEDURE EL_vehiculos(
        xplaca VARCHAR);
    PROCEDURE AD_vehiculos(
        xplaca VARCHAR,
        xcilindraje NUMBER,
        xa_o NUMBER,
        xtipo VARCHAR,
        xconductor NUMBER);
    PROCEDURE UP_vehiculos(
        xestado CHAR);
END;
/
CREATE OR REPLACE PACKAGE BODY PC_vehiculos IS
    PROCEDURE EL_vehiculos(
        xplaca VARCHAR) IS
    BEGIN
        DELETE FROM vehiculos WHERE placa = xplaca;
    END;
    PROCEDURE AD_vehiculos(
        xplaca VARCHAR,
        xcilindraje NUMBER,
        xa_o NUMBER,
        xtipo VARCHAR,
        xconductor NUMBER) IS
    BEGIN
        INSERT INTO vehiculos (placa, cilindraje, a_o, tipo, conductor) VALUES (xplaca, xcilindraje, xa_o, xtipo, xconductor);
    END;
    PROCEDURE UP_vehiculos(
        xestado CHAR) IS
    BEGIN
        UPDATE vehiculos SET estado = xestado;
    END;
END;
/
CREATE OR REPLACE PACKAGE PA_cliente AS
    PROCEDURE AD_solicitudes(
        xfechaviaje TIMESTAMP,
        xdescripcion VARCHAR);
    PROCEDURE UP_solicitudes(
        xfechaviaje TIMESTAMP,
        xdescripcion VARCHAR);
    PROCEDURE DEL_solicitudes(
        xcodigo NUMBER);
    PROCEDURE AD_tarjeta(
        xnumero NUMBER,
        xentidad VARCHAR,
        xvencimiento DATE);
    PROCEDURE UP_tarjeta(
        xnumero NUMBER,
        xentidad VARCHAR,
        xvencimiento DATE);
    PROCEDURE DEL_tarjeta(
        xnumero NUMBER);
END;
/
CREATE OR REPLACE PACKAGE BODY PA_cliente AS
    PROCEDURE AD_solicitudes(
        xfechaviaje TIMESTAMP,
        xdescripcion VARCHAR) IS
    BEGIN
        INSERT INTO solicitudes(fechaViaje, descripcion) VALUES(xfechaViaje, xdescripcion);
    END;
    PROCEDURE UP_solicitudes(
        xfechaviaje TIMESTAMP,
        xdescripcion VARCHAR) IS
    BEGIN
        UPDATE solicitudes SET fechaViaje = xfechaviaje, descripcion = xdescripcion;
    END;
    PROCEDURE DEL_solicitudes(
        xcodigo NUMBER) IS
    BEGIN
        DELETE FROM solicitudes WHERE codigo = xcodigo;
    END;
    PROCEDURE AD_tarjeta(
        xnumero NUMBER,
        xentidad VARCHAR,
        xvencimiento DATE) IS 
    BEGIN
        INSERT INTO tarjetas(numero, entidad, vencimiento) VALUES(xnumero, xentidad, xvencimiento);
    END;
    PROCEDURE UP_tarjeta(
        xnumero NUMBER,
        xentidad VARCHAR,
        xvencimiento DATE) IS
    BEGIN
        UPDATE tarjetas SET numero = xnumero, entidad = xentidad, vencimiento = xvencimiento;
    END;
    PROCEDURE DEL_tarjeta(
        xnumero NUMBER) IS
    BEGIN
        DELETE FROM tarjetas WHERE numero = xnumero;
    END;
END;
/
CREATE OR REPLACE PACKAGE PA_analistaClientes AS
    PROCEDURE AD_clientes(
        xnumeroTarjeta NUMBER,
        xdireccionUbicacion VARCHAR,
        xidioma VARCHAR);
    PROCEDURE UP_clientes(
        xnumeroTarjeta NUMBER,
        xdireccionUbicacion VARCHAR,
        xidioma VARCHAR);
    PROCEDURE DEL_clientes(
        xid NUMBER);
END;
/
CREATE OR REPLACE PACKAGE BODY PA_analistaClientes AS
    PROCEDURE AD_clientes(
        xnumeroTarjeta NUMBER,
        xdireccionUbicacion VARCHAR,
        xidioma VARCHAR) IS 
    BEGIN
    INSERT INTO clientes(numeroTarjeta, direccionUbicacion, idioma) VALUES(xnumeroTarjeta, xdireccionUbicacion, xidioma);
    END;
    PROCEDURE UP_clientes(
        xnumeroTarjeta NUMBER,
        xdireccionUbicacion VARCHAR,
        xidioma VARCHAR) IS
    BEGIN
        UPDATE clientes SET numeroTarjeta = xnumeroTarjeta, direccionUbicacion = xdireccionUbicacion, idioma = xidioma;
    END;
    PROCEDURE DEL_clientes(
        xid NUMBER) IS
    BEGIN
        DELETE FROM clientes WHERE id = xid;
    END;
END;

--CRUDok
EXEC PC_solicitudes.AD_solicitudes(to_date('20/09/21', 'DD/MM/YY'), 'P', 200, 'A', 'descri');
EXEC PC_vehiculos.AD_vehiculos('abc123', 12, 2012, 'V', '123456789');
EXEC PC_vehiculos.EL_vehiculos('abc123');
EXEC PC_vehiculos.UP_vehiculos('O');
--CRUDNoOk
EXEC PC_solicitudes.AD_solicitudes('abc123'); --Faltan datos
EXEC PC_vehiculos.UP_vehiculos(123);--Es un entero, el esetado debe ser VARCHAR(1)
EXEC PC_vehiculos.UP_vehiculos(to_date('20/09/21', 'DD/MM/YY'), 'desc'); --Mas datos de los necesarios

--SeguridadOk
EXEC PA_cliente.AD_solicitudes(to_date('20/09/21', 'DD/MM/YY'), 'desc');

--SeguridadNoOk


CREATE ROLE CL;
CREATE ROLE ACL;

GRANT EXECUTE
ON PA_cliente
TO CL;

GRANT EXECUTE
ON PA_analistaClientes
TO ACL;

GRANT CL TO BD2165345;

REVOKE EXECUTE ON PA_cliente FROM CL;
REVOKE EXECUTE ON PA_analistaClientes FROM ACL;
DROP ROLE CL;
DROP ROLE ACL;

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

