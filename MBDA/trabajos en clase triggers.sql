CREATE TRIGGER num_precio
BEFORE INSERT ON envios 
FOR EACH ROW
BEGIN
	SELECT COUNT(numero) + 1 INTO NEW.numero FROM envios;
	SELECT precio INTO :NEW.precio FROM partes WHERE p# = :NEW.parte;
END num_precio;



CREATE TRIGGER delete_envios
BEFORE DELETE ON envios
BEGIN
	RAISE_APLICATION_ERROR(-20020, 'No se pueden eliminar envios')
END delete_envios;



CREATE TRIGGER update_partes
BEFORE UPDATE partes
FOR EACH ROW
WHEN OLD.precio >= new.precio
BEGIN
	:NEW.precio = :OLD.precio;
END update_partes;



PUNTO 1  CRUD CLIENTES