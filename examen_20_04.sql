--6.

DELIMITER /
CREATE PROCEDURE sp6(IN id INT, IN n VARCHAR(60))
BEGIN
INSERT INTO cliente (idcliente, nombre) VALUES (id, n);
SELECT * FROM cliente WHERE idcliente = id;
END /


call sp6(164,"Juan Daniel");
--7.

DELIMITER /
CREATE PROCEDURE sp7(IN id INT, IN m DOUBLE)
BEGIN
update credito set monto=m
where idcredito = (select idcredito from pago where idcliente=id);
SELECT * FROM credito;
END /

call sp7(2,3445);

--8.

DELIMITER /
CREATE PROCEDURE sp8(IN id INT)
BEGIN
SELECT * FROM cliente WHERE idcliente = id;
update cliente set salario=salario+(salario*.30)
where idcliente = id;
SELECT * FROM cliente WHERE idcliente = id;
END /

call sp8(3);

--9.

DELIMITER /
CREATE PROCEDURE sp9(IN f varchar(60))
BEGIN
SELECT c.nombre, pr.nombre, pr.precioUnitario
FROM cliente c, pago p, producto pr 
WHERE p.fechapago like concat("%",f)
AND p.idproducto = pr.idproducto
AND c.idcliente = p.idcliente;
END /

delimiter ;

call sp9("2010-03-31");


--10.

DELIMITER /
CREATE PROCEDURE sp10(IN c INT)
BEGIN
SELECT pr.nombre, pr.marca
FROM categoria c, subcategoria sc, producto pr 
WHERE c.idcategoria = c
AND c.idcategoria = sc.idcategoria
AND sc.idsubcategoria = pr.idsubcategoria;
END /

delimiter ;

call sp10(4);


--11.

DELIMITER /
CREATE PROCEDURE sp11(IN n varchar(60))
BEGIN
SELECT pr.nombre, pr.descripcion, sc.nombre
FROM subcategoria sc, producto pr 
WHERE pr.marca like concat("%",n)
AND sc.idsubcategoria = pr.idsubcategoria;
END /

delimiter ;

call sp11("SONY");


--12.

SELECT t.nombre, t.cp
FROM tienda t
WHERE t.estado like concat("%chiapas%");


--13.

update credito 
set monto=monto+(monto*0.30)
from pago p, tienda t, credito c
where t.nombre like "%Prestada Prenda Jesus%"
and t.idtienda = p.idtienda
and p.idcredito = c.idcredito;
SELECT * FROM credito;


--14.

select * 
from producto 
where marca like "%sin marc%";


--15.

select count(*) from tienda where estado like "Colima";


--16.

select c.nombre , c.apPaterno , c.apMaterno , p.fechapago
from cliente c , pago p , tienda t
where c.idcliente = p.idcliente
and p.idtienda = t.idtienda
and t.estado like "%colima%";

--17.


alter table pago add column montopago double default 1000;

--18.
create view mivista1 as
select c.nombre, c.appaterno, c.apmaterno, cr.monto
from cliente c, pago p,tienda t, credito cr
where t.nombre like "%KT TECATE%"
and t.idtienda = p.idtienda
and p.idcliente = c.idcliente
and cr.idcredito = p.idcredito;
select * from  mivista1;


--19.
create view mivista2 as
select *
from producto
where preciounitario > 4500 and preciounitario < 5500;
select * from  mivista2;


--20

create view mivista3 as
select c.*
from pago p, cliente c
where p.fechapago like concat("2010-03-10")
and p.idcliente = c.idcliente;
select * from  mivista3;