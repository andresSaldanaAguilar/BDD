1.-Conocer el nombre completo de las socias

select nombre, appaterno, apmaterno
from socio
where genero="F"
order by 2;

alter table tabla change column nombre_viejo nombre_nuevo varchar(30);

2.-Para la conssulta anterior mostrar el tipode membresia que tienen lass socias  y la fecha de alta

select s.nombre, s.apmaterno, s.apmaterno, t.nombre, x.fechaalta
from socio s, sociomembresia x, tipomembresia t
where t.idTipoMem=x.idTipoMem
and x.idsocio=s.idsocio
and s.genero="F"
order by 4,2;

3.-Proyectar marca en productos

select distinct marca from producto 
order by marca;

select marca from producto
group by marca;

4.-Mostrar el nombre y precio unitario de los productoss que pertenecen a la categoria vinos

select p.nombre, p.preciounitario 
from producto p, subcategoria s, categoria c
where p.idsubcat = s.idsubcat
and s.idcat = c.idcat
and c.nombre = "Vinos"
order by 2,1;

5.-Mostrar el nombre y email de las sucursales en la CDMX

select s.nombre, s.email from sucursal s, estado e
where s.idedo=e.idedo
and e.nombre like "Ciuda% M_xi%";

6.-Mostrar que sservicios oferta el club

select s.nombre from
servicio s, sucservicio x, sucursal r
where r.idsuc = x.idsuc
and x.idServicio = s.idServicio
and r.nombre like "Monterr% Vall%"
order by 1;

7.-Cuales son los telefonos de las sucursales existentes en el edo de mexico

select s.nombre, t.tel
from sucursal s, telsuc t, estado e
where s.idsuc=t.idsuc
and s.idedo=e.idedo
and e.nombre like "M_xic%"
order by 1;

8.-Que productos pertenecen a la categoria negocio y papeleria

select p.nombre
from producto p, subcategoria s, categoria c, departamento d
where p.idsubcat = s.idsubcat
and s.idcat = c.idcat
and c.idDepto=d.idDepto
and d.nombre like "Negocio% Papele%"
order by 1;

9.-Que socios tienen la membresia negocio

select s.nombre, s.apmaterno, s.apmaterno
from socio s, sociomembresia x, tipomembresia t
where t.idTipoMem=x.idTipoMem
and x.idsocio=s.idsocio
and t.nombre like "De Neg%"
order by 2;

Parte II Crear lass siguientes vistas

1.-Que muestre los socios que tienen una membresia dorada para la sucursal morelia

create view mivista1 as 
select s.nombre, s.appaterno, s.apmaterno
from socio s, sociomembresia sm, tipomembresia tm, sucursal c
where s.idsocio=sm.idsocio
and sm.idTipoMem=tm.idTipoMem
and sm.idsuc=c.idsuc
and tm.nombre like "Dorad%"
and c.nombre like "Morel%"
order by 2;

drop view mivista1;
desc mivista1;
select * from  mivista1;

2.-Mostrar el nombre completo de los socios y la sucursal que pertenecen
para aquellos socios que se apellidan maya

drop view mivista2;
create view mivista2 as 
select s.nombre, s.appaterno, s.apmaterno, c.nombre as nombresocio
from socio s, sociomembresia sm, sucursal c
where s.idsocio=sm.idsocio
and sm.idsuc=c.idsuc
and ( s.appaterno like "Maya%" or s.apmaterno like "Maya%")
order by 4,2;
select * from  mivista2;

3.-Los productos de la categoria musica, incluir su marca y p.u

drop view mivista3;
create view mivista3 as
select p.nombre, p.marca, p.preciounitario
from categoria c, subcategoria s, producto p
where c.nombre like "%sica"
and c.idcat=s.idcat
and p.idsubcat=s.idsubcat
order by 1;
select * from  mivista3;

4.-El nombre de las sucursales que ofertan el servicio centro llantero, incluir el correo
electronico

drop view mivista4;
create view mivista4 as
select s.nombre, s.email, r.nombre as servicio 
from sucursal s, sucservicio ss, servicio r
where r.nombre = "Centro Llantero"
and r.idServicio = ss.idServicio
and s.idsuc=ss.idsuc
order by 1;
select * from  mivista4;

5.-Mostrar el nombre completo y la sucursal para aquellos socios que se dieron de alta en el mes de mayo del 2017

drop view mivista5;
create view mivista5 as
select nc.numerocuenta, pm.rfc, pm.nombreresponsable, pm.apellidopaterno, pm.apellidomaterno
from socio s, sociomembresia sm, sucursal r
where sm.fechaalta like "2017-05-%"
and sm.idsuc=r.idsuc
and sm.idsocio=s.idsocio
order by 1;
select * from  mivista5;