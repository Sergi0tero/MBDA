CREATE TABLE solicitudes(
codigo NUMBER(9) NOT NULL,
fechaCreacion TIMESTAMP NOT NULL,
fechaViaje TIMESTAMP,
plataforma VARCHAR(1) NOT NULL,
precio NUMBER(5) NOT NULL,
estado VARCHAR(1),
descripcion XMLTYPE);

ALTER TABLE solicitudes ADD CONSTRAINT CK_solicitudes_codigo
    CHECK(codigo>0);
ALTER TABLE solicitudes ADD CONSTRAINT CK_solicitudes_precio
    CHECK(precio>0);
ALTER TABLE solicitudes ADD CONSTRAINT CK_solicitudes_estado
    CHECK(estado IN ('P','A','C','F'));
    
--PoblarOK
INSERT INTO solicitudes VALUES(123456789, '26-03-2021-6:30', '26-03-2021-7:30', 'D', 200, 'A', 
'<descripciones>
	<direccionOrigen direccion = "Cra 1b #21-64"> </direccionOrigen>
	<direccionDestino direccion = "Cra 2b #12-46"> </direccionDestino>
	<requerimientos>
		<tipo vehiculo = "Honda" Musica = "Hip Hop" ruta = "Variante Chia"> </tipo>
		<descripcion> llamar a la casa 21 </descripcion>
	</requerimientos>
</descripciones>');

INSERT INTO solicitudes VALUES(223456789, '26-03-2021-6:30', '26-03-2021-7:30', 'J', 500, 'P', 
'<descripciones>
	<direccionOrigen direccion = "Cra 3b #31-64"> </direccionOrigen>
	<direccionDestino direccion = "Cra 4b #13-46"> </direccionDestino>
	<requerimientos>
		<tipo vehiculo = "Mercedes Benz" Musica = "Rock" ruta = "Variante Cajica"> </tipo>
	</requerimientos>
</descripciones>');

--PoblarNOoK
INSERT INTO solicitudes VALUES(-1236789, '16-04-2021-6:30', '26-03-2020-7:30', 'D', 200, 'P', 
'<descripciones>
    <direccionOrigen direccion = "1"> </direccionOrigen>
    <direccionDestino direccion = "Cra 2b #12-46"> </direccionDestino>
    <requerimientos>
        <tipo vehiculo = "Honda" Musica = "Hip Hop" ruta = "Variante Chia"> </tipo>
        <descripcion> llamar a la casa 21 </descripcion>
    </requerimientos>
</descripciones>');

INSERT INTO solicitudes VALUES(346789, '24-03-2021-6:30', '26-03-2021-7:30', 'J', 500, 'H', 
'<descripciones>
    <direccionOrigen direccion = "Cra 3b #31-64"> </direccionOrigen>
    <direccionDestino direccion = "Cra 4b #13-46"> </direccionDestino>
    <requerimientos>
        <tipo vehiculo = "Mercedes Benz" Musica = "Rock" ruta = "Variante Cajica"> </tipo>
    </requerimientos>
</descripciones>');


-- Extendiendo atributo TRequerimiento (se añade la etiqueta nombre)
INSERT INTO solicitudes VALUES(323456789, '26-03-2021-6:30', '26-03-2021-7:30', 'J', 800, 'C', 
'<descripciones>
	<direccionOrigen direccion = "Cra 5b #32-64"> </direccionOrigen>
	<direccionDestino direccion = "Cra 6b #42-96"> </direccionDestino>
    <nombre>Sergio Otero</nombre>
	<requerimientos>
		<tipo vehiculo = "BMW" Musica = "POP" ruta = "Autopista"> </tipo>
		<descripcion> llamar al apartamento 401 </descripcion>
	</requerimientos>
</descripciones>');

--Consultas
---Consutlar viajes en los que se pidio musica
SELECT codigo, fechaCreacion, precio, EXTRACT(descripcion, '/descripciones/requerimientos/tipo/@musica') FROM solicitudes;
---Consultar viajes realizados que tenian descripcion
SELECT codigo, EXTRACT(descripcion, '/descripciones/requerimientos/tipo/@ruta') FROM solicitudes
WHERE EXTRACT(descripcion, '/descripciones/requerimientos/descripcion') IS NOT NULL;
---Consulta del TRequerimiento extendido, Consultar el nombre del cliente
SELECT codigo, EXTRACT(descripcion, '/descripciones/nombre/text()') FROM solicitudes
WHERE EXTRACT(descripcion, '/descripciones/nombre') IS NOT NULL;
--XTable
DROP TABLE solicitudes CASCADE CONSTRAINTS;