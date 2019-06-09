select d.nombre
from sucursal s, departamento d, sucdepartamento sd
where s.nombre like "Saltillo"
and s.idsuc=sd.idsuc
and d.idDepto=sd.idDepto;

select s.nombre, s.appaterno, s.apmaterno
from socio s, sociomembresia sm, sucursal x
where x.nombre like "Interlomas"
and x.idsuc=sm.idsuc
and s.idsocio=sm.idsocio;

select p.nombre
from producto p, subcategoria sc, categoria c
where p.nombre like "%Asado%"
and p.idsubcat=sc.idsubcat
and c.idcat=sc.idcat;

select p.idproducto, p.nombre as nom_prod, p.marca, c.nombre 
from producto p, subcategoria sc, categoria c
where (p.idproducto=104 or p.idproducto=200 or p.idproducto=944)
and p.idsubcat=sc.idsubcat
and sc.idcat=c.idcat;

select s.nombre
from sucursal s, sucservicio ss, servicio x
where x.nombre like "%Deli%"
and x.idservicio=ss.idservicio
and s.idsuc=ss.idsuc;

select s.nombre, e.nombre, sm.fechaalta
from sucursal s, estado e, sociomembresia sm
where sm.fechaalta like "%2016-07-11%"
and sm.idsuc=s.idsuc
and s.idedo=e.idedo;

select t.tel
from estado e, sucursal s, telsuc t
where e.nombre like "%Nuevo Le_n%"
and e.idedo=s.idedo
and s.idsuc=t.idsuc;

select count(*)
from socio s, sociomembresia sm, sucursal x
where (x.nombre like "%Cuernavaca%" or x.nombre like "%Xalapa%" or x.nombre like "%Mexicali%")
and x.idsuc=sm.idsuc
and s.idsocio=sm.idsocio;

select s.nombre, sm.fechaalta
from sucursal s, socio x, sociomembresia sm
where x.genero like "F"
and x.idsocio=sm.idsocio
and s.idsuc=sm.idsuc;

select p.nombre 
from producto p, subcategoria s
where s.nombre like "Sillas"
and p.idsubcat=s.idsubcat;

create view v1 as 
select s.nombre, s.appaterno, s.apmaterno, t.nombre as tipo
from socio s, sociomembresia sm, tipomembresia t
where s.appaterno like "Cervantes"
and s.idsocio=sm.idsocio
and t.idtipomem=sm.idtipomem;
select * from v1;
drop view v1;

create view v1 as 
select s.nombre, s.appaterno, s.apmaterno, x.nombre as ssucursal
from socio s, sociomembresia sm, tipomembresia t, sucursal x
where t.nombre like "dorada"
and t.idtipomem=sm.idtipomem
and s.idsocio=sm.idsocio
and x.idsuc=sm.idsuc;
select * from v1;
drop view v1;

create view v1 as 
select p.nombre 
from departamento d, producto p, subcategoria s, categoria c
where d.nombre like "Vinos y Licores"
and d.idDepto=c.idDepto
and c.idcat=s.idcat
and s.idsubcat=p.idsubcat;
select * from v1;
drop view v1;

create view v1 as 
select p.nombre, d.nombre as depto
from departamento d, producto p, subcategoria s, categoria c
where p.nombre like "%Disney%"
and d.idDepto=c.idDepto
and c.idcat=s.idcat
and s.idsubcat=p.idsubcat;
select * from v1;
drop view v1;



