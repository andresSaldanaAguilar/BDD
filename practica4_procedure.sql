//
//
1. con base al apellido paterno de un gerente mostrar el 
club donde se encuentra adscrito

delimiter #
create procedure p1 (in ap varchar(30))
begin 
select g.nombre, c.nombre
from gerente g, club c
where g.idclub=c.idclub
and g.nombre like CONCAT(ap,"%")
order by c.nombre, g.nombre;
end #

2. con base al nombre e un club mostrar los servicios que
tiene

delimiter #
create procedure p2 (in x varchar(30))
begin 
select s.nombre
from servicio s, servicioclub sc, club c
where c.idclub=sc.idclub
and sc.idservicio=s.idservicio 
and c.nombre like CONCAT(x,"%")
order by s.nombre;
end #

3. considerar el nombre del club y mostrar el nombre de sus gerentes

delimiter #
create procedure p3 (in l varchar(30))
begin 
select g.nombre
from gerente g, club c
where g.idclub=c.idclub
and c.nombre like CONCAT(l,"%")
order by g.nombre;
end #

4. mostrar los clubes y su tel, de acuerdo a un estado
determinado

delimiter #
create procedure p4 (in s varchar(30))
begin 
select c.nombre, c.tel
from club c, estado e
where c.idedo=e.idedo
and e.nombre like CONCAT(s,"%")
order by c.nombre;
end #

5. mostrar los productos y precio unitario de un proveedor
determinado

delimiter #
create procedure p5 (in v varchar(30))
begin 
select p.nombre, p.preciounitario
from producto p, proveedor d
where p.idproveedor=d.idproveedor
and d.nombre like CONCAT(v,"%")
order by p.preciounitario, p.nombre;
end #

6. con base a un club, mostrar el nombre y telefono de los socios

delimiter #
create procedure p6 (in b varchar(30))
begin 
select s.nombre, s.tel
from club c, socio s, socioclub x
where c.idclub=x.idclub
and x.idsocio=s.idsocio
and c.nombre like CONCAT(b,"%")
order by s.nombre;
end #

7. con base al appaterno de los socios mostrar el club en el que se
encuentran registrados

delimiter #
create procedure p7(in x varchar(30))
begin 
select c.nombre as club
from club c, socio s, socioclub x
where c.idclub=x.idclub
and x.idsocio=s.idsocio
and s.nombre like CONCAT("%",x,"%")
order by s.nombre;
end #

8. de acuerdo a un identificador del producto, mostrar el nombre del proveedor
y su p.u

delimiter #
create procedure p8(in cl int)
begin 
select p.nombre, x.nombre
from producto p, proveedor x
where p.idproveedor=x.idproveedor
and p.idproducto=cl;
end #

9.con base a un codigo postal, mostrar los datos correspondientes de un club

delimiter #
create procedure p9(in cp int)
begin 
select *
from club
where direccion like concat("%",cp,"%");
end #

10. con base al nombre del club, indicar que proveedores suministran productos

delimiter #
create procedure p10(in c varchar(30))
begin 
select p.nombre
from club c, proveedorsams ps, proveedor p
where c.nombre like CONCAT(c,"%")
and c.idclub=ps.idclub
and ps.idproveedor=p.idproveedor;
end #



