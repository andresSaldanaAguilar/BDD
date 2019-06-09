--Mixup

-- 1. Conocer los socios que esten ubicados en Monterrey. (quitar dirección).

DELIMITER /
CREATE PROCEDURE sp1()
BEGIN
SELECT s.idSocio, s.nombre, s.tel, s.email
FROM socio s, sociomix sm, mixup m
WHERE s.idSocio = sm.idSocio
AND sm.idmixUp = m.idmixUp
AND m.ubicacion LIKE "Monterre%"
ORDER BY s.nombre; 
END /

-- 2. Agregar un socio. (id, nombre)

DELIMITER /
CREATE PROCEDURE e1(IN id INT, IN n VARCHAR(60))
BEGIN
INSERT INTO socio (idSocio,nombre) VALUES (id,n);
SELECT * FROM socio WHERE idSocio = id;
END /

-- TRANSACCIONES

-- En terminal negra.
--Con el sp1 y con el e1 damos de alta a otro socio

CALL e1(3001,"AEMC");

--y luego modificamos el sp1 de la siguiente manera:

DELIMITER /
CREATE PROCEDURE l2()
BEGIN
SELECT idSocio, nombre, tel, email
FROM socio
WHERE idSocio BETWEEN 235 AND 4000
ORDER BY nombre; 
END /

--luego agrego otro

CALL e1(3002,"El Chacho");

-- luego consulto con sp2 otra vez.

---------> PRIMER PARTE DE LAS TRANSACCIONES

--ESTA ES LA TRANSACCIÓN 1.
SELECT * FROM socio
END // 

BEGIN;
l(x) -> l2
e(x) -> e1( , )
l(x) -> l2
--rollback
l(x) -> l2

-- Transacción 2.

BEGIN;
l(x) -> l2
e(x) -> e1( , )
l(x) -> l2
-- Fallo de sistema (cerrar terminal);
l(x) -> l2

--Transacción 3.

BEGIN;
l2;
e1;
l2;
COMMIT;
l2;
--* Debe aparecer el chacho.

--Transacción 4.

BEGIN;
l2;
e1;
l2;
COMMIT;
FALLO de sistema; (cerrar terminal);
l2;
--*Y tiene que aparecer el chacho y la chachita.

 -- HACERLO CON la tabla MIXUP de tarea

----------------------------------------
EXAMENES
Ex. teórico - 30 Mayo
Ex. práctico 1 - 20 Mayo
Ex. práctico 2 - 27 Mayo
Proyecto - 27 al 31 Mayo
----------------------------------------

---------> SEGUNDA PARTE DE LAS TRANSACCIONES

--Transacción 1
-- LOCK TABLES nombreRelacion read/write;

--En una terminal
BEGIN;
LOCK TABLES socio read; (bloqueo compartido es omitido)
l2;

BEGIN;
b_lectura (socio);
l2;(socio)
l(mixup) No se puede
l(articulo) No se puede

--En otra terminal
l(socio)
l(mixup)
l(articulo)
Se pueden leer todas;

--Luego en la primer terminal
 LOCK TABLES articulo read;
 no puedo leer asocion¿do ni departamento
con un SELECT * FROM

-- En la otra terminal 
Si se puede leer.

--CON UNLOCK TABLES

-- En la negra (primer terminal)
LOCK TABLES socio write;

Para la transacción 3
bloqueo de escritura en socio
e1 profe SI
l2 SI
l(mixup) NO
l(articulo) NO

-- En la roja (segunda terminal) 
l2;
e1;

Y se queda en espera.

--Luego abrimos otra terminal (azul). (Tercer terminal)

SELECT * FROM departamento; l(mixup)
SELECT * FROM articulo; l(articulo)
CALL e1(3005,"Alumnos"); e1()

--En la terminal 2 (roja)
CALL l2; Queda en espera.
