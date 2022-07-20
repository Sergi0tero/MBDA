--Tablas
CREATE TABLE Usuarios (
id NUMBER NOT NULL,
nombre VARCHAR(40) NOT NULL,
genero VARCHAR(10),
correo VARCHAR(40),
fechaNacimiento DATE NOT NULL);

CREATE TABLE Artistas (
idArtista NUMBER NOT NULL,
nombre VARCHAR(30) NOT NULL,
nacionalidad VARCHAR(30) NOT NULL,
fechaNacimiento DATE NOT NULL,
genero VARCHAR(10),
banda VARCHAR(30) NOT NULL);

CREATE TABLE BusquedaArtXGeneros (
artista NUMBER NOT NULL,
genero VARCHAR(30) NOT NULL);

CREATE TABLE BusquedaArtistas (
artista NUMBER NOT NULL,
usuario NUMBER NOT NULL);

CREATE TABLE Generos (
nombre VARCHAR(30) NOT NULL,
origenCultural VARCHAR(10),
descripcionGenero VARCHAR(50));

CREATE TABLE BusquedaGeneros (
usuario NUMBER NOT NULL,
genero VARCHAR(30) NOT NULL);

CREATE TABLE Bandas (
nombre VARCHAR(30) NOT NULL,
integrante INT NOT NULL,
descripcionBanda VARCHAR(50));

CREATE TABLE BusquedaBandas (
usuario NUMBER NOT NULL,
banda VARCHAR(30) NOT NULL);

CREATE TABLE BusquedaBandaXGeneros (
genero VARCHAR(30) NOT NULL,
banda VARCHAR(30) NOT NULL);

CREATE TABLE Canciones (
nombre VARCHAR(50) NOT NULL,
version NUMBER NOT NULL,
artista NUMBER NOT NULL,
banda VARCHAR(30) NOT NULL,
genero VARCHAR(30) NOT NULL);

CREATE TABLE Epocas (
fecha NUMBER NOT NULL,
cancion VARCHAR(50) NOT NULL,
version INT NOT NULL,
descripcionEpoca VARCHAR(50));


--Pks

ALTER TABLE Usuarios ADD CONSTRAINT Pk_Usuarios_id
    PRIMARY KEY (id);

ALTER TABLE Artistas ADD CONSTRAINT Pk_Artistas_idArtista
    PRIMARY KEY (idArtista);

ALTER TABLE BusquedaArtXGeneros ADD CONSTRAINT Pk_BusArtXGen_artista_genero
    PRIMARY KEY (artista, genero);

ALTER TABLE BusquedaArtistas ADD CONSTRAINT Pk_BusquedaArtistas_artista
    PRIMARY KEY (artista);

ALTER TABLE Generos ADD CONSTRAINT Pk_Generos_nombre
    PRIMARY KEY (nombre);

ALTER TABLE BusquedaGeneros ADD CONSTRAINT Pk_BusquedaGeneros_genero
    PRIMARY KEY (genero);

ALTER TABLE Bandas ADD CONSTRAINT Pk_Bandas_nombre
    PRIMARY KEY (nombre);

ALTER TABLE BusquedaBandas ADD CONSTRAINT Pk_BusquedaBandas_banda
    PRIMARY KEY (banda);

ALTER TABLE BusquedaBandaXGeneros ADD CONSTRAINT Pk_BusBanXGen_genero_banda
    PRIMARY KEY (genero, banda);

ALTER TABLE Canciones ADD CONSTRAINT Pk_Canciones_nombre_version
    PRIMARY KEY (nombre, version);

ALTER TABLE Epocas ADD CONSTRAINT Pk_Epocas_nombre_cancion
    PRIMARY KEY (fecha, cancion);

--Fks


ALTER TABLE Artistas ADD CONSTRAINT fk_Artistas_Bandas
    FOREIGN KEY (banda)
    REFERENCES Bandas (nombre);
    
ALTER TABLE BusquedaBandas ADD CONSTRAINT fk_BusquedaBandas_Bandas
    FOREIGN KEY (banda)
    REFERENCES Bandas (nombre);

ALTER TABLE BusquedaBandas ADD CONSTRAINT fk_BusquedaBandas_Usuarios
    FOREIGN KEY (usuario)
    REFERENCES Usuarios (id);

ALTER TABLE BusquedaBandaXGeneros ADD CONSTRAINT fk_BusBandaXGen_Generos
    FOREIGN KEY (genero)
    REFERENCES Generos (nombre);

ALTER TABLE BusquedaBandaXGeneros ADD CONSTRAINT fk_BusBandaXGen_Bandas
    FOREIGN KEY (banda)
    REFERENCES Bandas (nombre);

ALTER TABLE BusquedaArtistas ADD CONSTRAINT fk_BusArtis_Usuarios
    FOREIGN KEY (usuario)
    REFERENCES Usuarios (id);

ALTER TABLE BusquedaArtistas ADD CONSTRAINT fk_BusArtis_Artistas
    FOREIGN KEY (artista)
    REFERENCES Artistas (idArtista);
    
ALTER TABLE BusquedaArtXGeneros ADD CONSTRAINT fk_BusArtXGen_Artista
    FOREIGN KEY (artista)
    REFERENCES Artistas (idArtista);

ALTER TABLE BusquedaArtXGeneros ADD CONSTRAINT fk_BusArtXGen_Generos
    FOREIGN KEY (genero)
    REFERENCES Generos (nombre);

ALTER TABLE Canciones ADD CONSTRAINT fk_Canciones_Artistas
    FOREIGN KEY (artista)
    REFERENCES Artistas (idArtista);

ALTER TABLE Canciones ADD CONSTRAINT fk_Canciones_Bandas
    FOREIGN KEY (banda)
    REFERENCES Bandas (nombre);

ALTER TABLE Canciones ADD CONSTRAINT fk_Canciones_Generos
    FOREIGN KEY (genero)
    REFERENCES Generos (nombre);
    
ALTER TABLE BusquedaGeneros ADD CONSTRAINT fk_BusquedaGeneros_Usuarios
    FOREIGN KEY (usuario)
    REFERENCES Usuarios (id);

ALTER TABLE BusquedaGeneros ADD CONSTRAINT fk_BusquedaGeneros_Generos
    FOREIGN KEY (genero)
    REFERENCES Generos (nombre);
 
ALTER TABLE Epocas ADD CONSTRAINT fk_Epocas_Canciones
    FOREIGN KEY (cancion,version)
    REFERENCES Canciones (nombre,version);


--Atributos
ALTER TABLE Usuarios ADD CONSTRAINT CK_Usuarios_genero
    CHECK (genero IN ('hombre','mujer','otro'));
ALTER TABLE Usuarios ADD CONSTRAINT CK_Usuarios_correo
    CHECK (correo LIKE '%@%.%');
ALTER TABLE Epocas ADD CONSTRAINT CK_Epocas_fecha
    CHECK (1899 < fecha AND fecha < 2022);
ALTER TABLE Canciones ADD CONSTRAINT CK_Canciones_version
    CHECK (version>-1 AND version<16);


--Poblar

INSERT INTO Usuarios VALUES(1000181894, 'Sergio Otero', 'hombre', 'sergiootero@mail.com', to_date('26-02-2002', 'DD-MM-YYYY'));
INSERT INTO Usuarios VALUES(1000181895, 'Insertar Nombre Creible', 'otro', 'nosequieneseste@mail.com', to_date('27-02-2002', 'DD-MM-YYYY'));

INSERT INTO Generos VALUES('HIP HOP', NULL, 'EMINEM');
INSERT INTO Generos VALUES('Rock', 'Ska-P', NULL);

INSERT INTO BusquedaGeneros VALUES(1000181894,'HIP HOP' );
INSERT INTO BusquedaGeneros VALUES('Rock', 'Ska-P', NULL);
--Tuplas

ALTER TABLE Artistas ADD CONSTRAINT CK_Art_fechaI_fechaN
    CHECK (fechaNacimiento<fechaInicio);
    
ALTER TABLE Epocas ADD CONSTRAINT CK_Epoc_fechaEV_fechaE
    CHECK (fechaEpocaVersion = fechaEpoca );

--TuplasOK
INSERT INTO Artistas VALUES('Eminem','estadounidense',TO_DATE('01-01-1999','DD-MM-YYYY'),'hip hop',NULL,TO_DATE('01-02-1999','DD-MM-YYYY'));
INSERT INTO Epocas VALUES(TO_DATE('01-01-1990','DD-MM-YYYY'),'beautiful',1,TO_DATE('01-01-1995','DD-MM-YYYY'),TO_DATE('01-01-1995','DD-MM-YYYY'));



--Acciones
ALTER TABLE Artistas DROP CONSTRAINT fk_Artistas_Bandas;
ALTER TABLE Artistas ADD CONSTRAINT fk_Artistas_Bandas FOREIGN KEY (banda)
REFERENCES Bandas (nombre)
ON DELETE CASCADE;

ALTER TABLE BusquedaBandas DROP CONSTRAINT fk_BusquedaBandas_Bandas;
ALTER TABLE BusquedaBandas ADD CONSTRAINT fk_BusquedaBandas_Bandas FOREIGN KEY (banda)
REFERENCES Bandas (nombre)
ON DELETE CASCADE;

ALTER TABLE BusquedaBandas DROP CONSTRAINT fk_BusquedaBandas_Usuarios;
ALTER TABLE BusquedaBandas ADD CONSTRAINT fk_BusquedaBandas_Usuarios FOREIGN KEY (usuario)
REFERENCES Usuarios (id)
ON DELETE CASCADE;

ALTER TABLE BusquedaBandaXGeneros DROP CONSTRAINT fk_BusBandaXGen_Generos;
ALTER TABLE BusquedaBandaXGeneros ADD CONSTRAINT fk_BusBandaXGen_Generos FOREIGN KEY (genero)
REFERENCES Generos (nombre)
ON DELETE CASCADE;

ALTER TABLE BusquedaBandaXGeneros DROP CONSTRAINT fk_BusBandaXGen_Bandas;
ALTER TABLE BusquedaBandaXGeneros ADD CONSTRAINT fk_BusBandaXGen_Bandas FOREIGN KEY (banda)
REFERENCES Bandas (nombre)
ON DELETE CASCADE;

ALTER TABLE BusquedaArtistas DROP CONSTRAINT fk_BusArtis_Usuarios;
ALTER TABLE BusquedaArtistas ADD CONSTRAINT fk_BusArtis_Usuarios FOREIGN KEY (usuario)
REFERENCES Usuarios (id)
ON DELETE CASCADE;

ALTER TABLE BusquedaArtistas DROP CONSTRAINT fk_BusArtis_Artistas;
ALTER TABLE BusquedaArtistas ADD CONSTRAINT fk_BusArtis_Artistas FOREIGN KEY (artista)
REFERENCES Artistas (idArtista)
ON DELETE CASCADE;

ALTER TABLE BusquedaArtXGeneros DROP CONSTRAINT fk_BusArtXGen_Artista;
ALTER TABLE BusquedaArtXGeneros ADD CONSTRAINT fk_BusArtXGen_Artista FOREIGN KEY (artista)
REFERENCES Artistas (idArtista)
ON DELETE CASCADE;

ALTER TABLE BusquedaArtXGeneros DROP CONSTRAINT fk_BusArtXGen_Generos;
ALTER TABLE BusquedaArtXGeneros ADD CONSTRAINT fk_BusArtXGen_Generos FOREIGN KEY (genero)
REFERENCES Generos (nombre)
ON DELETE CASCADE;

ALTER TABLE Canciones DROP CONSTRAINT fk_Canciones_Artistas;
ALTER TABLE Canciones ADD CONSTRAINT fk_Canciones_Artistas FOREIGN KEY (artista)
REFERENCES Artistas (idArtista)
ON DELETE CASCADE;

ALTER TABLE Canciones DROP CONSTRAINT fk_Canciones_Bandas;
ALTER TABLE Canciones ADD CONSTRAINT fk_Canciones_Bandas FOREIGN KEY (banda)
REFERENCES Bandas (nombre)
ON DELETE CASCADE;

ALTER TABLE Canciones DROP CONSTRAINT fk_Canciones_Generos;
ALTER TABLE Canciones ADD CONSTRAINT fk_Canciones_Generos FOREIGN KEY (genero)
REFERENCES Generos (nombre)
ON DELETE CASCADE;

ALTER TABLE BusquedaGeneros DROP CONSTRAINT fk_BusquedaGeneros_Usuarios;
ALTER TABLE BusquedaGeneros ADD CONSTRAINT fk_BusquedaGeneros_Usuarios FOREIGN KEY (usuario)
REFERENCES Usuarios (id)
ON DELETE CASCADE;

ALTER TABLE BusquedaGeneros DROP CONSTRAINT fk_BusquedaGeneros_Generos;
ALTER TABLE BusquedaGeneros ADD CONSTRAINT fk_BusquedaGeneros_Generos FOREIGN KEY (genero)
REFERENCES Generos (nombre)
ON DELETE CASCADE;

ALTER TABLE Epocas DROP CONSTRAINT fk_Epocas_Canciones;
ALTER TABLE Epocas ADD CONSTRAINT fk_Epocas_Canciones FOREIGN KEY (cancion, version)
REFERENCES Canciones (nombre, version)
ON DELETE CASCADE;

--AccionesOK

DELETE FROM Artistas WHERE banda LIKE NULL ;
DELETE FROM BusquedaBandas WHERE banda LIKE NULL ;
DELETE FROM BusquedaBandas WHERE usuario LIKE NULL ;
DELETE FROM BusquedaBandaXGeneros WHERE genero LIKE NULL ;
DELETE FROM BusquedaBandaXGeneros WHERE banda LIKE NULL ;
DELETE FROM BusquedaArtistas WHERE usuario LIKE NULL ;
DELETE FROM BusquedaArtistas WHERE artista LIKE NULL ;
DELETE FROM BusquedaArtXGeneros WHERE artista LIKE NULL ;
DELETE FROM BusquedaArtXGeneros WHERE genero LIKE NULL ;
DELETE FROM Canciones WHERE artista LIKE NULL ;
DELETE FROM Canciones WHERE banda LIKE NULL ;
DELETE FROM Canciones WHERE genero LIKE NULL ;
DELETE FROM BusquedaGeneros WHERE usuario LIKE NULL ;
DELETE FROM BusquedaGeneros WHERE genero LIKE NULL ;
DELETE FROM Epocas WHERE cancion LIKE NULL and version LIKE NULL ;

--Disparadores
/
CREATE OR REPLACE TRIGGER Usuarios_id
BEFORE INSERT ON Usuarios
FOR EACH ROW
BEGIN
    SELECT COUNT(id) + 1 INTO :NEW.id FROM Usuarios;
END Usuarios_id;
/
CREATE OR REPLACE TRIGGER Artistas_id
BEFORE INSERT ON Artistas
FOR EACH ROW
BEGIN
    SELECT COUNT(idArtista) + 1 INTO :NEW.idArtista FROM Artistas;
END Artistas_id;
/
CREATE OR REPLACE TRIGGER Del_usiariosId
BEFORE DELETE OR UPDATE OF id ON Usuarios
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20020, 'No se puede eliminar la id de los usuarios');
END Del_usiariosId;
/


-------PAQUETES ACTORES
CREATE OR REPLACE PACKAGE PA_Cantante AS
    PROCEDURE AD_Cancion(
        xnombre VARCHAR,
        xversion NUMBER,
        xartista NUMBER,
        xbanda VARCHAR,
        xgenero VARCHAR);
    FUNCTION CO_Cancion
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PA_Cantante AS
    PROCEDURE AD_Cancion(
        xnombre VARCHAR,
        xversion NUMBER,
        xartista NUMBER,
        xbanda VARCHAR,
        xgenero VARCHAR) IS 
    BEGIN
        INSERT INTO Canciones(nombre, version, artista, banda, genero)
        VALUES(xnombre, xversion, xartista, xbanda, xgenero);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al insertar los usuarios');
    END;
    FUNCTION CO_Cancion
        RETURN SYS_REFCURSOR IS CO_CANCION_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_CANCION_INF FOR
            SELECT * FROM Canciones;
            RETURN CO_CANCION_INF;
        END;
END;
/
CREATE OR REPLACE PACKAGE PA_EmpleadoSpotify AS
    PROCEDURE AD_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE);
    PROCEDURE UP_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE);
    PROCEDURE DEL_Usuarios(
        xid NUMBER);
    PROCEDURE AD_Bandas(
        xnombre VARCHAR,
        xintegrante INT ,
        xdescripcionBanda VARCHAR);
    PROCEDURE AD_Artistas(
        xnombre VARCHAR,
        xnacionalidad VARCHAR,
        xfechaNacimiento DATE,
        xgenero VARCHAR,
        xbanda VARCHAR);
    PROCEDURE AD_Generos(
        xnombre VARCHAR,
        xorigenCultural VARCHAR,
        xdescripcionGenero VARCHAR);
    PROCEDURE AD_Epocas(
        fecha NUMBER,
        cancion VARCHAR,
        version INT,
        descripcionEpoca VARCHAR);
    FUNCTION CO_Usuario
        RETURN SYS_REFCURSOR;
    FUNCTION CO_Banda
        RETURN SYS_REFCURSOR;
    FUNCTION CO_artista
        RETURN SYS_REFCURSOR;
    FUNCTION CO_Genero
        RETURN SYS_REFCURSOR;
    FUNCTION CO_Epoca
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PA_EmpleadoSpotify AS
    PROCEDURE AD_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE) IS 
    BEGIN
        INSERT INTO Usuarios(nombre, genero, correo, fechaNacimiento)
        VALUES(xnombre, xgenero, xcorreo, xfechaNacimiento);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20004,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20004, 'Ocurrio un error al insertar los usuarios');
    END;
    PROCEDURE UP_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE) IS 
    BEGIN
        UPDATE Usuarios SET nombre = xnombre, genero = xgenero, correo = xcorreo, fechaNacimiento = xfechaNacimiento;
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al actualizar los usuarios');
    END;
    PROCEDURE DEL_Usuarios(
        xid NUMBER) IS
    BEGIN
        DELETE FROM Usuarios WHERE id = xid;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al borrar los usuarios');
    END;
    PROCEDURE AD_Bandas(
        xnombre VARCHAR,
        xintegrante INT ,
        xdescripcionBanda VARCHAR) IS
    BEGIN
        INSERT INTO Bandas(nombre, integrante, descripcionBanda)
            VALUES(xnombre, xintegrante, xdescripcionBanda);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al insertar los usuarios');
    END;
    PROCEDURE AD_Artistas(
        xnombre VARCHAR,
        xnacionalidad VARCHAR,
        xfechaNacimiento DATE,
        xgenero VARCHAR,
        xbanda VARCHAR) IS
    BEGIN
        INSERT INTO Artistas(nombre, nacionalidad, fechaNacimiento, genero, banda)
            VALUES(xnombre, xnacionalidad, xfechaNacimiento, xgenero, xbanda);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al insertar los usuarios');
    END;
    PROCEDURE AD_Generos(
        xnombre VARCHAR,
        xorigenCultural VARCHAR,
        xdescripcionGenero VARCHAR) IS
    BEGIN
        INSERT INTO Generos(nombre, origenCultural, descripcionGenero)
            VALUES(xnombre, xorigenCultural, xdescripcionGenero);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al insertar los usuarios');
    END;
    PROCEDURE AD_Epocas(
        fecha NUMBER,
        cancion VARCHAR,
        version INT,
        descripcionEpoca VARCHAR) IS
    BEGIN
        INSERT INTO Epocas(fecha, cancion, version, descripcionEpoca)
            VALUES(xfecha, xcancion, xversion, xdescripcionEpoca);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al insertar los usuarios');
    END;
    FUNCTION CO_Usuario
        RETURN SYS_REFCURSOR IS CO_USUARIO_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_USUARIO_INF FOR
            SELECT * FROM Usuarios;
            RETURN CO_USUARIO_INF;
        END;
    FUNCTION CO_Banda
        RETURN SYS_REFCURSOR IS CO_BANDA_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_BANDA_INF FOR
            SELECT * FROM Bandas;
            RETURN CO_BANDA_INF;
        END;
    FUNCTION CO_artista
        RETURN SYS_REFCURSOR IS CO_ARTISTA_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_ARTISTA_INF FOR
            SELECT * FROM Artistas;
            RETURN CO_ARTISTA_INF;
        END;
    FUNCTION CO_Genero
        RETURN SYS_REFCURSOR IS CO_GENERO_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_GENERO_INF FOR
            SELECT * FROM Generos;
            RETURN CO_GENERO_INF;
        END;
    FUNCTION CO_Epoca
        RETURN SYS_REFCURSOR IS CO_EPOCA_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_EPOCA_INF FOR
            SELECT * FROM Epocas;
            RETURN CO_EPOCA_INF;
        END;
END;
/

----PAQUETES COMPONENTES
CREATE OR REPLACE PACKAGE PC_Canciones AS
    PROCEDURE AD_Canciones(
        xnombre VARCHAR,
        xversion NUMBER,
        xartista NUMBER,
        xbanda VARCHAR,
        xgenero VARCHAR);
    FUNCTION CO_Canciones
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PC_Canciones AS
    PROCEDURE AD_Canciones(
        xnombre VARCHAR,
        xversion NUMBER,
        xartista NUMBER,
        xbanda VARCHAR,
        xgenero VARCHAR) IS 
    BEGIN
        INSERT INTO Canciones(nombre, version, artista, banda, genero)
        VALUES(xnombre, xversion, xartista, xbanda, xgenero);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al insertar los usuarios');
    END;
    FUNCTION CO_Canciones
        RETURN SYS_REFCURSOR IS CO_CANCION_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_CANCION_INF FOR
            SELECT * FROM Canciones;
            RETURN CO_CANCION_INF;
        END;
END;
/
CREATE OR REPLACE PACKAGE PC_Generos AS
    PROCEDURE AD_Generos(
        xnombre VARCHAR,
        xorigenCultural VARCHAR,
        xdescripcionGenero VARCHAR);
    FUNCTION CO_Genero
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PC_Generos AS
    PROCEDURE AD_Generos(
        xnombre VARCHAR,
        xorigenCultural VARCHAR,
        xdescripcionGenero VARCHAR) IS
    BEGIN
        INSERT INTO Generos(nombre, origenCultural, descripcionGenero)
            VALUES(xnombre, xorigenCultural, xdescripcionGenero);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al insertar los usuarios');
    END;
    FUNCTION CO_Genero
        RETURN SYS_REFCURSOR IS CO_GENERO_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_GENERO_INF FOR
            SELECT * FROM Generos;
            RETURN CO_GENERO_INF;
        END;
END;
/
CREATE OR REPLACE PACKAGE PC_Epocas AS
    PROCEDURE AD_Epocas(
        fecha NUMBER,
        cancion VARCHAR,
        version INT,
        descripcionEpoca VARCHAR);
    FUNCTION CO_Epoca
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PC_Epocas AS
    PROCEDURE AD_Epocas(
        fecha NUMBER,
        cancion VARCHAR,
        version INT,
        descripcionEpoca VARCHAR) IS
    BEGIN
        INSERT INTO Epocas(fecha, cancion, version, descripcionEpoca)
            VALUES(xfecha, xcancion, xversion, xdescripcionEpoca);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al insertar los usuarios');
    END;
    FUNCTION CO_Epoca
        RETURN SYS_REFCURSOR IS CO_EPOCA_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_EPOCA_INF FOR
            SELECT * FROM Epocas;
            RETURN CO_EPOCA_INF;
        END;
END;
/
CREATE OR REPLACE PACKAGE PC_Artistas AS
    PROCEDURE AD_Artistas(
        xnombre VARCHAR,
        xnacionalidad VARCHAR,
        xfechaNacimiento DATE,
        xgenero VARCHAR,
        xbanda VARCHAR);
    FUNCTION CO_artista
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PC_Artistas AS
    PROCEDURE AD_Artistas(
        xnombre VARCHAR,
        xnacionalidad VARCHAR,
        xfechaNacimiento DATE,
        xgenero VARCHAR,
        xbanda VARCHAR) IS
    BEGIN
        INSERT INTO Artistas(nombre, nacionalidad, fechaNacimiento, genero, banda)
            VALUES(xnombre, xnacionalidad, xfechaNacimiento, xgenero, xbanda);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al insertar los usuarios');
    END;
    FUNCTION CO_artista
        RETURN SYS_REFCURSOR IS CO_ARTISTA_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_ARTISTA_INF FOR
            SELECT * FROM Artistas;
            RETURN CO_ARTISTA_INF;
        END;
END;
/
CREATE OR REPLACE PACKAGE PC_Usuarios AS
    PROCEDURE AD_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE);
    PROCEDURE UP_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE);
    PROCEDURE DEL_Usuarios(
        xid NUMBER);
    FUNCTION CO_Usuario
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PC_Usuarios AS
    PROCEDURE AD_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE) IS 
    BEGIN
        INSERT INTO Usuarios(nombre, genero, correo, fechaNacimiento)
        VALUES(xnombre, xgenero, xcorreo, xfechaNacimiento);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20004,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20004, 'Ocurrio un error al insertar los usuarios');
    END;
    PROCEDURE UP_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE) IS 
    BEGIN
        UPDATE Usuarios SET nombre = xnombre, genero = xgenero, correo = xcorreo, fechaNacimiento = xfechaNacimiento;
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al actualizar los usuarios');
    END;
    PROCEDURE DEL_Usuarios(
        xid NUMBER) IS
    BEGIN
        DELETE FROM Usuarios WHERE id = xid;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al borrar los usuarios');
    END;
    FUNCTION CO_Usuario
        RETURN SYS_REFCURSOR IS CO_USUARIO_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_USUARIO_INF FOR
            SELECT * FROM Usuarios;
            RETURN CO_USUARIO_INF;
        END;
END;
/
CREATE OR REPLACE PACKAGE PC_Bandas AS
    PROCEDURE AD_Bandas(
        xnombre VARCHAR,
        xintegrante INT ,
        xdescripcionBanda VARCHAR);
    FUNCTION CO_Banda
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PC_Bandas AS
    PROCEDURE AD_Bandas(
        xnombre VARCHAR,
        xintegrante INT ,
        xdescripcionBanda VARCHAR) IS
    BEGIN
        INSERT INTO Bandas(nombre, integrante, descripcionBanda)
            VALUES(xnombre, xintegrante, xdescripcionBanda);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al insertar los usuarios');
    END;
    FUNCTION CO_Banda
        RETURN SYS_REFCURSOR IS CO_BANDA_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_BANDA_INF FOR
            SELECT * FROM Bandas;
            RETURN CO_BANDA_INF;
        END;
END;

--------------------------------------CRUDok
EXEC PC_solicitudes.AD_solicitudes(to_date('20/09/21', 'DD/MM/YY'), 'P', 200, 'A', 'descri');
EXEC PC_vehiculos.AD_vehiculos('abc123', 12, 2012, 'V', '123456789');
EXEC PC_vehiculos.EL_vehiculos('abc123');
EXEC PC_vehiculos.UP_vehiculos('O');
EXEC PC_vehiculos.UP_vehiculos('P');
---------------------------------------CRUDNoOk
EXEC PC_solicitudes.AD_solicitudes('abc123'); --Faltan datos
EXEC PC_vehiculos.UP_vehiculos(123);--Es un entero, el esetado debe ser VARCHAR(1)
EXEC PC_vehiculos.UP_vehiculos(to_date('20/09/21', 'DD/MM/YY'), 'desc'); --Mas datos de los necesarios

------------------------------------SeguridadOk

--PA_EmpleadoSpotify
EXEC PA_EmpleadoSpotify.AD_Usuarios('andres','hombre','andres27@hotmail.com',to_date('20/09/21', 'DD/MM/YY'));
EXEC PA_EmpleadoSpotify.UP_Usuarios('santiago','mujer','santiago27@hotmail.com',to_date('21/09/21', 'DD/MM/YY'));
EXEC PA_EmpleadoSpotify.DEL_Usuarios(312323);
EXEC PA_EmpleadoSpotify.AD_Bandas('andrest', 2, 'hola mundo');
EXEC PA_EmpleadoSpotify.AD_Artistas('pedro','frances',to_date('22/09/21', 'DD/MM/YY'),'hombre','zapato');
EXEC PA_EmpleadoSpotify.AD_Generos('rock','alemania','descripcion');
EXEC PA_EmpleadoSpotify.AD_Epocas(1876,'hombre',3,'muy tranquila');
--PA_Cantante
EXEC PA_Cantante.AD_Cancion('cancion',2,'yesid','the beatles','rock');



-------------------------------------SeguridadNoOk
--PA_EmpleadoSpotify
EXEC PA_EmpleadoSpotify.AD_Usuarios(3,'hombre','andres27@hotmail.com',to_date('20/09/21', 'DD/MM/YY'));
EXEC PA_EmpleadoSpotify.UP_Usuarios('santiago',7,'santiago27@hotmail.com',to_date('21/09/21', 'DD/MM/YY'));
EXEC PA_EmpleadoSpotify.DEL_Usuarios('312323');
EXEC PA_EmpleadoSpotify.AD_Bandas(2342, 2, 'hola mundo');
EXEC PA_EmpleadoSpotify.AD_Artistas('pedro',frances,to_date('22/09/21', 'DD/MM/YY'),'hombre','zapato');
EXEC PA_EmpleadoSpotify.AD_Generos(45,'alemania','descripcion');
EXEC PA_EmpleadoSpotify.AD_Epocas(1876,hombre,3,'muy tranquila');
--PA_Cantante
EXEC PA_Cantante.AD_Cancion(65,2,'yesid','the beatles','rock');


CREATE ROLE ES;
CREATE ROLE CA;

GRANT EXECUTE
ON PA_EmpleadoSpotify
TO ES;

GRANT EXECUTE
ON PA_Cantante
TO CA;

REVOKE EXECUTE ON PA_EmpleadoSpotify FROM ES;
REVOKE EXECUTE ON PA_Cantante FROM CA;
DROP ROLE ES;
DROP ROLE CA;


--XPoblar

DELETE FROM Usuarios;
DELETE FROM Artistas;
DELETE FROM Generos;
DELETE FROM Bandas;
DELETE FROM Albumes;
DELETE FROM Canciones;
DELETE FROM Epocas;


--XDisparadores
DROP TRIGGER Usuarios_id;
DROP TRIGGER Artistas_id;
DROP TRIGGER Del_UsuariosId;


---XPaquetes
DROP PACKAGE PA_Cantante;
DROP PACKAGE PA_EmpleadoSpotify;

DROP PACKAGE PC_Canciones;
DROP PACKAGE PC_Generos;
DROP PACKAGE PC_Epocas;
DROP PACKAGE PC_Artistas;
DROP PACKAGE PC_Usuarios;
DROP PACKAGE PC_Bandas;

--XTablas

DROP TABLE Usuarios CASCADE CONSTRAINTS;
DROP TABLE Artistas CASCADE CONSTRAINTS;
DROP TABLE BusquedaArtXGeneros CASCADE CONSTRAINTS;
DROP TABLE BusquedaArtistas CASCADE CONSTRAINTS;
DROP TABLE Generos CASCADE CONSTRAINTS;
DROP TABLE BusquedaGeneros CASCADE CONSTRAINTS;
DROP TABLE Bandas CASCADE CONSTRAINTS;
DROP TABLE BusquedaBandas CASCADE CONSTRAINTS;
DROP TABLE BusquedaBandaXGeneros CASCADE CONSTRAINTS;
DROP TABLE Canciones CASCADE CONSTRAINTS;
DROP TABLE Epocas CASCADE CONSTRAINTS;
CREATE TABLE Usuarios (
id NUMBER NOT NULL,
nombre VARCHAR(40) NOT NULL,
genero VARCHAR(10),
correo VARCHAR(40),
fechaNacimiento DATE NOT NULL);

CREATE TABLE Artistas (
idArtista NUMBER NOT NULL,
nombre VARCHAR(30) NOT NULL,
nacionalidad VARCHAR(30) NOT NULL,
fechaNacimiento DATE NOT NULL,
genero VARCHAR(10),
banda VARCHAR(30) NOT NULL);

CREATE TABLE BusquedaArtXGeneros (
artista NUMBER NOT NULL,
genero VARCHAR(30) NOT NULL);

CREATE TABLE BusquedaArtistas (
artista NUMBER NOT NULL,
usuario NUMBER NOT NULL);

CREATE TABLE Generos (
nombre VARCHAR(30) NOT NULL,
origenCultural VARCHAR(10),
descripcionGenero VARCHAR(50));

CREATE TABLE BusquedaGeneros (
usuario NUMBER NOT NULL,
genero VARCHAR(30) NOT NULL);

CREATE TABLE Bandas (
nombre VARCHAR(30) NOT NULL,
integrante INT NOT NULL,
descripcionBanda VARCHAR(50));

CREATE TABLE BusquedaBandas (
usuario NUMBER NOT NULL,
banda VARCHAR(30) NOT NULL);

CREATE TABLE BusquedaBandaXGeneros (
genero VARCHAR(30) NOT NULL,
banda VARCHAR(30) NOT NULL);

CREATE TABLE Canciones (
nombre VARCHAR(50) NOT NULL,
version NUMBER NOT NULL,
artista NUMBER NOT NULL,
banda VARCHAR(30) NOT NULL,
genero VARCHAR(30) NOT NULL);

CREATE TABLE Epocas (
fecha NUMBER NOT NULL,
cancion VARCHAR(50) NOT NULL,
version INT NOT NULL,
descripcionEpoca VARCHAR(50));


--Pks

ALTER TABLE Usuarios ADD CONSTRAINT Pk_Usuarios_id
    PRIMARY KEY (id);

ALTER TABLE Artistas ADD CONSTRAINT Pk_Artistas_idArtista
    PRIMARY KEY (idArtista);

ALTER TABLE BusquedaArtXGeneros ADD CONSTRAINT Pk_BusArtXGen_artista_genero
    PRIMARY KEY (artista, genero);

ALTER TABLE BusquedaArtistas ADD CONSTRAINT Pk_BusquedaArtistas_artista
    PRIMARY KEY (artista);

ALTER TABLE Generos ADD CONSTRAINT Pk_Generos_nombre
    PRIMARY KEY (nombre);

ALTER TABLE BusquedaGeneros ADD CONSTRAINT Pk_BusquedaGeneros_genero
    PRIMARY KEY (genero);

ALTER TABLE Bandas ADD CONSTRAINT Pk_Bandas_nombre
    PRIMARY KEY (nombre);

ALTER TABLE BusquedaBandas ADD CONSTRAINT Pk_BusquedaBandas_banda
    PRIMARY KEY (banda);

ALTER TABLE BusquedaBandaXGeneros ADD CONSTRAINT Pk_BusBanXGen_genero_banda
    PRIMARY KEY (genero, banda);

ALTER TABLE Canciones ADD CONSTRAINT Pk_Canciones_nombre_version
    PRIMARY KEY (nombre, version);

ALTER TABLE Epocas ADD CONSTRAINT Pk_Epocas_nombre_cancion
    PRIMARY KEY (fecha, cancion);

--Fks


ALTER TABLE Artistas ADD CONSTRAINT fk_Artistas_Bandas
    FOREIGN KEY (banda)
    REFERENCES Bandas (nombre);
    
ALTER TABLE BusquedaBandas ADD CONSTRAINT fk_BusquedaBandas_Bandas
    FOREIGN KEY (banda)
    REFERENCES Bandas (nombre);

ALTER TABLE BusquedaBandas ADD CONSTRAINT fk_BusquedaBandas_Usuarios
    FOREIGN KEY (usuario)
    REFERENCES Usuarios (id);

ALTER TABLE BusquedaBandaXGeneros ADD CONSTRAINT fk_BusBandaXGen_Generos
    FOREIGN KEY (genero)
    REFERENCES Generos (nombre);

ALTER TABLE BusquedaBandaXGeneros ADD CONSTRAINT fk_BusBandaXGen_Bandas
    FOREIGN KEY (banda)
    REFERENCES Bandas (nombre);

ALTER TABLE BusquedaArtistas ADD CONSTRAINT fk_BusArtis_Usuarios
    FOREIGN KEY (usuario)
    REFERENCES Usuarios (id);

ALTER TABLE BusquedaArtistas ADD CONSTRAINT fk_BusArtis_Artistas
    FOREIGN KEY (artista)
    REFERENCES Artistas (idArtista);
    
ALTER TABLE BusquedaArtXGeneros ADD CONSTRAINT fk_BusArtXGen_Artista
    FOREIGN KEY (artista)
    REFERENCES Artistas (idArtista);

ALTER TABLE BusquedaArtXGeneros ADD CONSTRAINT fk_BusArtXGen_Generos
    FOREIGN KEY (genero)
    REFERENCES Generos (nombre);

ALTER TABLE Canciones ADD CONSTRAINT fk_Canciones_Artistas
    FOREIGN KEY (artista)
    REFERENCES Artistas (idArtista);

ALTER TABLE Canciones ADD CONSTRAINT fk_Canciones_Bandas
    FOREIGN KEY (banda)
    REFERENCES Bandas (nombre);

ALTER TABLE Canciones ADD CONSTRAINT fk_Canciones_Generos
    FOREIGN KEY (genero)
    REFERENCES Generos (nombre);
    
ALTER TABLE BusquedaGeneros ADD CONSTRAINT fk_BusquedaGeneros_Usuarios
    FOREIGN KEY (usuario)
    REFERENCES Usuarios (id);

ALTER TABLE BusquedaGeneros ADD CONSTRAINT fk_BusquedaGeneros_Generos
    FOREIGN KEY (genero)
    REFERENCES Generos (nombre);
 
ALTER TABLE Epocas ADD CONSTRAINT fk_Epocas_Canciones
    FOREIGN KEY (cancion,version)
    REFERENCES Canciones (nombre,version);


--Atributos
ALTER TABLE Usuarios ADD CONSTRAINT CK_Usuarios_genero
    CHECK (genero IN ('hombre','mujer','otro'));
ALTER TABLE Usuarios ADD CONSTRAINT CK_Usuarios_correo
    CHECK (correo LIKE '%@%.%');
ALTER TABLE Epocas ADD CONSTRAINT CK_Epocas_fecha
    CHECK (1899 < fecha AND fecha < 2022);
ALTER TABLE Canciones ADD CONSTRAINT CK_Canciones_version
    CHECK (version>-1 AND version<16);


--Poblar

INSERT INTO Usuarios VALUES(1000181894, 'Sergio Otero', 'hombre', 'sergiootero@mail.com', to_date('26-02-2002', 'DD-MM-YYYY'));
INSERT INTO Usuarios VALUES(1000181895, 'Insertar Nombre Creible', 'otro', 'nosequieneseste@mail.com', to_date('27-02-2002', 'DD-MM-YYYY'));

INSERT INTO Generos VALUES('HIP HOP', NULL, 'EMINEM');
INSERT INTO Generos VALUES('Rock', 'Ska-P', NULL);

INSERT INTO BusquedaGeneros VALUES(1000181894,'HIP HOP' );
INSERT INTO BusquedaGeneros VALUES('Rock', 'Ska-P', NULL);
--Tuplas

ALTER TABLE Artistas ADD CONSTRAINT CK_Art_fechaI_fechaN
    CHECK (fechaNacimiento<fechaInicio);
    
ALTER TABLE Epocas ADD CONSTRAINT CK_Epoc_fechaEV_fechaE
    CHECK (fechaEpocaVersion = fechaEpoca );

--TuplasOK
INSERT INTO Artistas VALUES('Eminem','estadounidense',TO_DATE('01-01-1999','DD-MM-YYYY'),'hip hop',NULL,TO_DATE('01-02-1999','DD-MM-YYYY'));
INSERT INTO Epocas VALUES(TO_DATE('01-01-1990','DD-MM-YYYY'),'beautiful',1,TO_DATE('01-01-1995','DD-MM-YYYY'),TO_DATE('01-01-1995','DD-MM-YYYY'));



--Acciones
ALTER TABLE Artistas DROP CONSTRAINT fk_Artistas_Bandas;
ALTER TABLE Artistas ADD CONSTRAINT fk_Artistas_Bandas FOREIGN KEY (banda)
REFERENCES Bandas (nombre)
ON DELETE CASCADE;

ALTER TABLE BusquedaBandas DROP CONSTRAINT fk_BusquedaBandas_Bandas;
ALTER TABLE BusquedaBandas ADD CONSTRAINT fk_BusquedaBandas_Bandas FOREIGN KEY (banda)
REFERENCES Bandas (nombre)
ON DELETE CASCADE;

ALTER TABLE BusquedaBandas DROP CONSTRAINT fk_BusquedaBandas_Usuarios;
ALTER TABLE BusquedaBandas ADD CONSTRAINT fk_BusquedaBandas_Usuarios FOREIGN KEY (usuario)
REFERENCES Usuarios (id)
ON DELETE CASCADE;

ALTER TABLE BusquedaBandaXGeneros DROP CONSTRAINT fk_BusBandaXGen_Generos;
ALTER TABLE BusquedaBandaXGeneros ADD CONSTRAINT fk_BusBandaXGen_Generos FOREIGN KEY (genero)
REFERENCES Generos (nombre)
ON DELETE CASCADE;

ALTER TABLE BusquedaBandaXGeneros DROP CONSTRAINT fk_BusBandaXGen_Bandas;
ALTER TABLE BusquedaBandaXGeneros ADD CONSTRAINT fk_BusBandaXGen_Bandas FOREIGN KEY (banda)
REFERENCES Bandas (nombre)
ON DELETE CASCADE;

ALTER TABLE BusquedaArtistas DROP CONSTRAINT fk_BusArtis_Usuarios;
ALTER TABLE BusquedaArtistas ADD CONSTRAINT fk_BusArtis_Usuarios FOREIGN KEY (usuario)
REFERENCES Usuarios (id)
ON DELETE CASCADE;

ALTER TABLE BusquedaArtistas DROP CONSTRAINT fk_BusArtis_Artistas;
ALTER TABLE BusquedaArtistas ADD CONSTRAINT fk_BusArtis_Artistas FOREIGN KEY (artista)
REFERENCES Artistas (idArtista)
ON DELETE CASCADE;

ALTER TABLE BusquedaArtXGeneros DROP CONSTRAINT fk_BusArtXGen_Artista;
ALTER TABLE BusquedaArtXGeneros ADD CONSTRAINT fk_BusArtXGen_Artista FOREIGN KEY (artista)
REFERENCES Artistas (idArtista)
ON DELETE CASCADE;

ALTER TABLE BusquedaArtXGeneros DROP CONSTRAINT fk_BusArtXGen_Generos;
ALTER TABLE BusquedaArtXGeneros ADD CONSTRAINT fk_BusArtXGen_Generos FOREIGN KEY (genero)
REFERENCES Generos (nombre)
ON DELETE CASCADE;

ALTER TABLE Canciones DROP CONSTRAINT fk_Canciones_Artistas;
ALTER TABLE Canciones ADD CONSTRAINT fk_Canciones_Artistas FOREIGN KEY (artista)
REFERENCES Artistas (idArtista)
ON DELETE CASCADE;

ALTER TABLE Canciones DROP CONSTRAINT fk_Canciones_Bandas;
ALTER TABLE Canciones ADD CONSTRAINT fk_Canciones_Bandas FOREIGN KEY (banda)
REFERENCES Bandas (nombre)
ON DELETE CASCADE;

ALTER TABLE Canciones DROP CONSTRAINT fk_Canciones_Generos;
ALTER TABLE Canciones ADD CONSTRAINT fk_Canciones_Generos FOREIGN KEY (genero)
REFERENCES Generos (nombre)
ON DELETE CASCADE;

ALTER TABLE BusquedaGeneros DROP CONSTRAINT fk_BusquedaGeneros_Usuarios;
ALTER TABLE BusquedaGeneros ADD CONSTRAINT fk_BusquedaGeneros_Usuarios FOREIGN KEY (usuario)
REFERENCES Usuarios (id)
ON DELETE CASCADE;

ALTER TABLE BusquedaGeneros DROP CONSTRAINT fk_BusquedaGeneros_Generos;
ALTER TABLE BusquedaGeneros ADD CONSTRAINT fk_BusquedaGeneros_Generos FOREIGN KEY (genero)
REFERENCES Generos (nombre)
ON DELETE CASCADE;

ALTER TABLE Epocas DROP CONSTRAINT fk_Epocas_Canciones;
ALTER TABLE Epocas ADD CONSTRAINT fk_Epocas_Canciones FOREIGN KEY (cancion, version)
REFERENCES Canciones (nombre, version)
ON DELETE CASCADE;

--AccionesOK

DELETE FROM Artistas WHERE banda LIKE NULL ;
DELETE FROM BusquedaBandas WHERE banda LIKE NULL ;
DELETE FROM BusquedaBandas WHERE usuario LIKE NULL ;
DELETE FROM BusquedaBandaXGeneros WHERE genero LIKE NULL ;
DELETE FROM BusquedaBandaXGeneros WHERE banda LIKE NULL ;
DELETE FROM BusquedaArtistas WHERE usuario LIKE NULL ;
DELETE FROM BusquedaArtistas WHERE artista LIKE NULL ;
DELETE FROM BusquedaArtXGeneros WHERE artista LIKE NULL ;
DELETE FROM BusquedaArtXGeneros WHERE genero LIKE NULL ;
DELETE FROM Canciones WHERE artista LIKE NULL ;
DELETE FROM Canciones WHERE banda LIKE NULL ;
DELETE FROM Canciones WHERE genero LIKE NULL ;
DELETE FROM BusquedaGeneros WHERE usuario LIKE NULL ;
DELETE FROM BusquedaGeneros WHERE genero LIKE NULL ;
DELETE FROM Epocas WHERE cancion LIKE NULL and version LIKE NULL ;

--Disparadores
/
CREATE OR REPLACE TRIGGER Usuarios_id
BEFORE INSERT ON Usuarios
FOR EACH ROW
BEGIN
    SELECT COUNT(id) + 1 INTO :NEW.id FROM Usuarios;
END Usuarios_id;
/
CREATE OR REPLACE TRIGGER Artistas_id
BEFORE INSERT ON Artistas
FOR EACH ROW
BEGIN
    SELECT COUNT(idArtista) + 1 INTO :NEW.idArtista FROM Artistas;
END Artistas_id;
/
CREATE OR REPLACE TRIGGER Del_usiariosId
BEFORE DELETE OR UPDATE OF id ON Usuarios
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20020, 'No se puede eliminar la id de los usuarios');
END Del_usiariosId;
/


-------PAQUETES ACTORES
CREATE OR REPLACE PACKAGE PA_Cantante AS
    PROCEDURE AD_Cancion(
        xnombre VARCHAR,
        xversion NUMBER,
        xartista NUMBER,
        xbanda VARCHAR,
        xgenero VARCHAR);
    FUNCTION CO_Cancion
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PA_Cantante AS
    PROCEDURE AD_Cancion(
        xnombre VARCHAR,
        xversion NUMBER,
        xartista NUMBER,
        xbanda VARCHAR,
        xgenero VARCHAR) IS 
    BEGIN
        INSERT INTO Canciones(nombre, version, artista, banda, genero)
        VALUES(xnombre, xversion, xartista, xbanda, xgenero);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al insertar los usuarios');
    END;
    FUNCTION CO_Cancion
        RETURN SYS_REFCURSOR IS CO_CANCION_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_CANCION_INF FOR
            SELECT * FROM Canciones;
            RETURN CO_CANCION_INF;
        END;
END;
/
CREATE OR REPLACE PACKAGE PA_EmpleadoSpotify AS
    PROCEDURE AD_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE);
    PROCEDURE UP_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE);
    PROCEDURE DEL_Usuarios(
        xid NUMBER);
    PROCEDURE AD_Bandas(
        xnombre VARCHAR,
        xintegrante INT ,
        xdescripcionBanda VARCHAR);
    PROCEDURE AD_Artistas(
        xnombre VARCHAR,
        xnacionalidad VARCHAR,
        xfechaNacimiento DATE,
        xgenero VARCHAR,
        xbanda VARCHAR);
    PROCEDURE AD_Generos(
        xnombre VARCHAR,
        xorigenCultural VARCHAR,
        xdescripcionGenero VARCHAR);
    PROCEDURE AD_Epocas(
        fecha NUMBER,
        cancion VARCHAR,
        version INT,
        descripcionEpoca VARCHAR);
    FUNCTION CO_Usuario
        RETURN SYS_REFCURSOR;
    FUNCTION CO_Banda
        RETURN SYS_REFCURSOR;
    FUNCTION CO_artista
        RETURN SYS_REFCURSOR;
    FUNCTION CO_Genero
        RETURN SYS_REFCURSOR;
    FUNCTION CO_Epoca
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PA_EmpleadoSpotify AS
    PROCEDURE AD_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE) IS 
    BEGIN
        INSERT INTO Usuarios(nombre, genero, correo, fechaNacimiento)
        VALUES(xnombre, xgenero, xcorreo, xfechaNacimiento);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20004,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20004, 'Ocurrio un error al insertar los usuarios');
    END;
    PROCEDURE UP_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE) IS 
    BEGIN
        UPDATE Usuarios SET nombre = xnombre, genero = xgenero, correo = xcorreo, fechaNacimiento = xfechaNacimiento;
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al actualizar los usuarios');
    END;
    PROCEDURE DEL_Usuarios(
        xid NUMBER) IS
    BEGIN
        DELETE FROM Usuarios WHERE id = xid;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al borrar los usuarios');
    END;
    PROCEDURE AD_Bandas(
        xnombre VARCHAR,
        xintegrante INT ,
        xdescripcionBanda VARCHAR) IS
    BEGIN
        INSERT INTO Bandas(nombre, integrante, descripcionBanda)
            VALUES(xnombre, xintegrante, xdescripcionBanda);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al insertar los usuarios');
    END;
    PROCEDURE AD_Artistas(
        xnombre VARCHAR,
        xnacionalidad VARCHAR,
        xfechaNacimiento DATE,
        xgenero VARCHAR,
        xbanda VARCHAR) IS
    BEGIN
        INSERT INTO Artistas(nombre, nacionalidad, fechaNacimiento, genero, banda)
            VALUES(xnombre, xnacionalidad, xfechaNacimiento, xgenero, xbanda);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al insertar los usuarios');
    END;
    PROCEDURE AD_Generos(
        xnombre VARCHAR,
        xorigenCultural VARCHAR,
        xdescripcionGenero VARCHAR) IS
    BEGIN
        INSERT INTO Generos(nombre, origenCultural, descripcionGenero)
            VALUES(xnombre, xorigenCultural, xdescripcionGenero);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al insertar los usuarios');
    END;
    PROCEDURE AD_Epocas(
        fecha NUMBER,
        cancion VARCHAR,
        version INT,
        descripcionEpoca VARCHAR) IS
    BEGIN
        INSERT INTO Epocas(fecha, cancion, version, descripcionEpoca)
            VALUES(xfecha, xcancion, xversion, xdescripcionEpoca);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al insertar los usuarios');
    END;
    FUNCTION CO_Usuario
        RETURN SYS_REFCURSOR IS CO_USUARIO_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_USUARIO_INF FOR
            SELECT * FROM Usuarios;
            RETURN CO_USUARIO_INF;
        END;
    FUNCTION CO_Banda
        RETURN SYS_REFCURSOR IS CO_BANDA_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_BANDA_INF FOR
            SELECT * FROM Bandas;
            RETURN CO_BANDA_INF;
        END;
    FUNCTION CO_artista
        RETURN SYS_REFCURSOR IS CO_ARTISTA_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_ARTISTA_INF FOR
            SELECT * FROM Artistas;
            RETURN CO_ARTISTA_INF;
        END;
    FUNCTION CO_Genero
        RETURN SYS_REFCURSOR IS CO_GENERO_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_GENERO_INF FOR
            SELECT * FROM Generos;
            RETURN CO_GENERO_INF;
        END;
    FUNCTION CO_Epoca
        RETURN SYS_REFCURSOR IS CO_EPOCA_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_EPOCA_INF FOR
            SELECT * FROM Epocas;
            RETURN CO_EPOCA_INF;
        END;
END;
/

----PAQUETES COMPONENTES
CREATE OR REPLACE PACKAGE PC_Canciones AS
    PROCEDURE AD_Canciones(
        xnombre VARCHAR,
        xversion NUMBER,
        xartista NUMBER,
        xbanda VARCHAR,
        xgenero VARCHAR);
    FUNCTION CO_Canciones
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PC_Canciones AS
    PROCEDURE AD_Canciones(
        xnombre VARCHAR,
        xversion NUMBER,
        xartista NUMBER,
        xbanda VARCHAR,
        xgenero VARCHAR) IS 
    BEGIN
        INSERT INTO Canciones(nombre, version, artista, banda, genero)
        VALUES(xnombre, xversion, xartista, xbanda, xgenero);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al insertar los usuarios');
    END;
    FUNCTION CO_Canciones
        RETURN SYS_REFCURSOR IS CO_CANCION_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_CANCION_INF FOR
            SELECT * FROM Canciones;
            RETURN CO_CANCION_INF;
        END;
END;
/
CREATE OR REPLACE PACKAGE PC_Generos AS
    PROCEDURE AD_Generos(
        xnombre VARCHAR,
        xorigenCultural VARCHAR,
        xdescripcionGenero VARCHAR);
    FUNCTION CO_Genero
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PC_Generos AS
    PROCEDURE AD_Generos(
        xnombre VARCHAR,
        xorigenCultural VARCHAR,
        xdescripcionGenero VARCHAR) IS
    BEGIN
        INSERT INTO Generos(nombre, origenCultural, descripcionGenero)
            VALUES(xnombre, xorigenCultural, xdescripcionGenero);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al insertar los usuarios');
    END;
    FUNCTION CO_Genero
        RETURN SYS_REFCURSOR IS CO_GENERO_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_GENERO_INF FOR
            SELECT * FROM Generos;
            RETURN CO_GENERO_INF;
        END;
END;
/
CREATE OR REPLACE PACKAGE PC_Epocas AS
    PROCEDURE AD_Epocas(
        fecha NUMBER,
        cancion VARCHAR,
        version INT,
        descripcionEpoca VARCHAR);
    FUNCTION CO_Epoca
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PC_Epocas AS
    PROCEDURE AD_Epocas(
        fecha NUMBER,
        cancion VARCHAR,
        version INT,
        descripcionEpoca VARCHAR) IS
    BEGIN
        INSERT INTO Epocas(fecha, cancion, version, descripcionEpoca)
            VALUES(xfecha, xcancion, xversion, xdescripcionEpoca);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al insertar los usuarios');
    END;
    FUNCTION CO_Epoca
        RETURN SYS_REFCURSOR IS CO_EPOCA_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_EPOCA_INF FOR
            SELECT * FROM Epocas;
            RETURN CO_EPOCA_INF;
        END;
END;
/
CREATE OR REPLACE PACKAGE PC_Artistas AS
    PROCEDURE AD_Artistas(
        xnombre VARCHAR,
        xnacionalidad VARCHAR,
        xfechaNacimiento DATE,
        xgenero VARCHAR,
        xbanda VARCHAR);
    FUNCTION CO_artista
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PC_Artistas AS
    PROCEDURE AD_Artistas(
        xnombre VARCHAR,
        xnacionalidad VARCHAR,
        xfechaNacimiento DATE,
        xgenero VARCHAR,
        xbanda VARCHAR) IS
    BEGIN
        INSERT INTO Artistas(nombre, nacionalidad, fechaNacimiento, genero, banda)
            VALUES(xnombre, xnacionalidad, xfechaNacimiento, xgenero, xbanda);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al insertar los usuarios');
    END;
    FUNCTION CO_artista
        RETURN SYS_REFCURSOR IS CO_ARTISTA_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_ARTISTA_INF FOR
            SELECT * FROM Artistas;
            RETURN CO_ARTISTA_INF;
        END;
END;
/
CREATE OR REPLACE PACKAGE PC_Usuarios AS
    PROCEDURE AD_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE);
    PROCEDURE UP_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE);
    PROCEDURE DEL_Usuarios(
        xid NUMBER);
    FUNCTION CO_Usuario
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PC_Usuarios AS
    PROCEDURE AD_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE) IS 
    BEGIN
        INSERT INTO Usuarios(nombre, genero, correo, fechaNacimiento)
        VALUES(xnombre, xgenero, xcorreo, xfechaNacimiento);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20004,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20004, 'Ocurrio un error al insertar los usuarios');
    END;
    PROCEDURE UP_Usuarios(
        xnombre VARCHAR,
        xgenero VARCHAR,
        xcorreo VARCHAR,
        xfechaNacimiento DATE) IS 
    BEGIN
        UPDATE Usuarios SET nombre = xnombre, genero = xgenero, correo = xcorreo, fechaNacimiento = xfechaNacimiento;
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al actualizar los usuarios');
    END;
    PROCEDURE DEL_Usuarios(
        xid NUMBER) IS
    BEGIN
        DELETE FROM Usuarios WHERE id = xid;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al borrar los usuarios');
    END;
    FUNCTION CO_Usuario
        RETURN SYS_REFCURSOR IS CO_USUARIO_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_USUARIO_INF FOR
            SELECT * FROM Usuarios;
            RETURN CO_USUARIO_INF;
        END;
END;
/
CREATE OR REPLACE PACKAGE PC_Bandas AS
    PROCEDURE AD_Bandas(
        xnombre VARCHAR,
        xintegrante INT ,
        xdescripcionBanda VARCHAR);
    FUNCTION CO_Banda
        RETURN SYS_REFCURSOR;
END;
/
CREATE OR REPLACE PACKAGE BODY PC_Bandas AS
    PROCEDURE AD_Bandas(
        xnombre VARCHAR,
        xintegrante INT ,
        xdescripcionBanda VARCHAR) IS
    BEGIN
        INSERT INTO Bandas(nombre, integrante, descripcionBanda)
            VALUES(xnombre, xintegrante, xdescripcionBanda);
        COMMIT;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RAISE_APPLICATION_ERROR(-20003,'Verificar los tipos de valores ingresados');
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003,'Ocurrio un error al insertar los usuarios');
    END;
    FUNCTION CO_Banda
        RETURN SYS_REFCURSOR IS CO_BANDA_INF SYS_REFCURSOR;
        BEGIN
        OPEN CO_BANDA_INF FOR
            SELECT * FROM Bandas;
            RETURN CO_BANDA_INF;
        END;
END;

--------------------------------------CRUDok
EXEC PC_solicitudes.AD_solicitudes(to_date('20/09/21', 'DD/MM/YY'), 'P', 200, 'A', 'descri');
EXEC PC_vehiculos.AD_vehiculos('abc123', 12, 2012, 'V', '123456789');
EXEC PC_vehiculos.EL_vehiculos('abc123');
EXEC PC_vehiculos.UP_vehiculos('O');
EXEC PC_vehiculos.UP_vehiculos('P');
---------------------------------------CRUDNoOk
EXEC PC_solicitudes.AD_solicitudes('abc123'); --Faltan datos
EXEC PC_vehiculos.UP_vehiculos(123);--Es un entero, el esetado debe ser VARCHAR(1)
EXEC PC_vehiculos.UP_vehiculos(to_date('20/09/21', 'DD/MM/YY'), 'desc'); --Mas datos de los necesarios

------------------------------------SeguridadOk

--PA_EmpleadoSpotify
EXEC PA_EmpleadoSpotify.AD_Usuarios('andres','hombre','andres27@hotmail.com',to_date('20/09/21', 'DD/MM/YY'));
EXEC PA_EmpleadoSpotify.UP_Usuarios('santiago','mujer','santiago27@hotmail.com',to_date('21/09/21', 'DD/MM/YY'));
EXEC PA_EmpleadoSpotify.DEL_Usuarios(312323);
EXEC PA_EmpleadoSpotify.AD_Bandas('andrest', 2, 'hola mundo');
EXEC PA_EmpleadoSpotify.AD_Artistas('pedro','frances',to_date('22/09/21', 'DD/MM/YY'),'hombre','zapato');
EXEC PA_EmpleadoSpotify.AD_Generos('rock','alemania','descripcion');
EXEC PA_EmpleadoSpotify.AD_Epocas(1876,'hombre',3,'muy tranquila');
--PA_Cantante
EXEC PA_Cantante.AD_Cancion('cancion',2,'yesid','the beatles','rock');



-------------------------------------SeguridadNoOk
--PA_EmpleadoSpotify
EXEC PA_EmpleadoSpotify.AD_Usuarios(3,'hombre','andres27@hotmail.com',to_date('20/09/21', 'DD/MM/YY'));
EXEC PA_EmpleadoSpotify.UP_Usuarios('santiago',7,'santiago27@hotmail.com',to_date('21/09/21', 'DD/MM/YY'));
EXEC PA_EmpleadoSpotify.DEL_Usuarios('312323');
EXEC PA_EmpleadoSpotify.AD_Bandas(2342, 2, 'hola mundo');
EXEC PA_EmpleadoSpotify.AD_Artistas('pedro',frances,to_date('22/09/21', 'DD/MM/YY'),'hombre','zapato');
EXEC PA_EmpleadoSpotify.AD_Generos(45,'alemania','descripcion');
EXEC PA_EmpleadoSpotify.AD_Epocas(1876,hombre,3,'muy tranquila');
--PA_Cantante
EXEC PA_Cantante.AD_Cancion(65,2,'yesid','the beatles','rock');


CREATE ROLE ES;
CREATE ROLE CA;

GRANT EXECUTE
ON PA_EmpleadoSpotify
TO ES;

GRANT EXECUTE
ON PA_Cantante
TO CA;

REVOKE EXECUTE ON PA_EmpleadoSpotify FROM ES;
REVOKE EXECUTE ON PA_Cantante FROM CA;
DROP ROLE ES;
DROP ROLE CA;


--XPoblar

DELETE FROM Usuarios;
DELETE FROM Artistas;
DELETE FROM Generos;
DELETE FROM Bandas;
DELETE FROM Albumes;
DELETE FROM Canciones;
DELETE FROM Epocas;


--XDisparadores
DROP TRIGGER Usuarios_id;
DROP TRIGGER Artistas_id;
DROP TRIGGER Del_UsuariosId;


---XPaquetes
DROP PACKAGE PA_Cantante;
DROP PACKAGE PA_EmpleadoSpotify;

DROP PACKAGE PC_Canciones;
DROP PACKAGE PC_Generos;
DROP PACKAGE PC_Epocas;
DROP PACKAGE PC_Artistas;
DROP PACKAGE PC_Usuarios;
DROP PACKAGE PC_Bandas;

--XTablas

DROP TABLE Usuarios CASCADE CONSTRAINTS;
DROP TABLE Artistas CASCADE CONSTRAINTS;
DROP TABLE BusquedaArtXGeneros CASCADE CONSTRAINTS;
DROP TABLE BusquedaArtistas CASCADE CONSTRAINTS;
DROP TABLE Generos CASCADE CONSTRAINTS;
DROP TABLE BusquedaGeneros CASCADE CONSTRAINTS;
DROP TABLE Bandas CASCADE CONSTRAINTS;
DROP TABLE BusquedaBandas CASCADE CONSTRAINTS;
DROP TABLE BusquedaBandaXGeneros CASCADE CONSTRAINTS;
DROP TABLE Canciones CASCADE CONSTRAINTS;
DROP TABLE Epocas CASCADE CONSTRAINTS;
