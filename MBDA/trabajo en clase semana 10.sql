CREATE TABLE clientes (
tid INT NOT NULL,
nid INT NOT NULL,
nombre VARCHAR(20),
correo VARCHAR(10),
telefonos VARCHAR(10),
recomienda)

CREATE TABLE facturas (
numero INT NOT NULL,
fecha DATE,
tid INT,
nid INT)

CREATE TABLE telefonos(
tod INT NOT NULL,
nid INT NOT NULL,
numero INT)

ALTER TABLE clientes
ADD CONSTRAINT Pk_clientes
PRIMARY KEY (tid, nid);

ALTER TABLE telefonos
ADD CONSTRAINT Pk_telefonos
PRIMARY KEY (numero);

ALTER TABLE facturass
ADD CONSTRAINT fk_facturas_clientes
FOREIGN KEY (tid , nid)
REFERENCES clientes (tid, nid);

ALTER TABLE telefonos
ADD CONSTRAINT fk_telefonos_clientes
FOREIGN KEY (tid , nid)
REFERENCES clientes (tid, nid);
-------
ALTER TABLE clientes
ADD CONSTRAINT fk_clientes_clientes
FOREIGN KEY 
--------
ALTER TABLE clientes
ADD CONSTRAINT Uk_clientes
UNIQUE KEY correo

CREATE TRIGGER delete_cliente
BEFORE DELETE ON clientes
BEGIN
	IF :OLD.tid IN COUNT(
		SELECT tid, nid, COUNT(facturas.numero) = 0
		FROM clientes
		JOIN facturas
		GROUP BY tid, nid)
	DELETE 