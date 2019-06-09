con base al nombre del club conocer los gerentes asociados a el 

delimiter #
create procedure c1(in s varchar(15))
begin
    select g.nombre 
    from gerente g, club c
    where g.idclub=c.idclub
    and c.nombre like concat(s,"%")
    order by g.nombre;
end #

con base al nombre del club mostrar los servicios que provee

delimiter #
create procedure c2(in s varchar(15))
begin
    select x.nombre
    from club c, servicio x, servicioclub sc
    where c.idclub=sc.idclub
    and sc.idservicio = x.idservicio
    and c.nombre like concat(s,"%")
    order by x.nombre;
end #

con base al nombre del proveedor mostrar los productos que suministra

delimiter #
create procedure c3(in s varchar(15))
begin
    select p.nombre
    from proveedor d, producto p
    where p.idproveedor = d.idproveedor
    and d.nombre like concat(s,"%")
    order by p.nombre;
end #

con base a un estado, mostrar el nombre y tel de los clubes exitentes en dicho estado

delimiter #
create procedure c4(in s varchar(15))
begin
    select c.nombre, c.tel
    from club c, estado e
    where c.idedo=e.idedo
    and e.nombre like concat(s,"%")
    order by c.nombre;
end #

con base a un cp, mostrar el nombre del club y el estado donde se ubica

delimiter #
create procedure c5(in cp int)
begin
    select c.nombre, e.nombre
    from club c, estado e
    where c.direccion like concat("%",cp)
    and c.idedo = e.idedo
    order by c.nombre;
end #

actualizar el tel de un socio determinado

delimiter #
create procedure c6(in id int, in s varchar(20))
begin
    select *
    from socio
    where idsocio = id;

    update socio 
    set tel = s
    where idsocio = id;

    select *
    from socio
    where idsocio = id;
end #

dar de alta un proveedor

delimiter #
create procedure c7(in id int, in n varchar (45), in t varchar (25))
begin
    insert into proveedor
    values(id,n,t);

    select *
    from proveedor
    where idproveedor = id;
end #

reasignar a un gerente a un club determinado

delimiter #
create procedure c8(in idg int, in nc varchar (20))
begin
    select g.nombre, c.nombre
    from gerente g, club c
    where g.idclub=c.idclub
    and g.idgerente=idg;

    update gerente 
    set idclub=(select idclub from club where nombre like concat(nc,"%"))
    where idgerente=idg;

    select g.nombre, c.nombre
    from gerente g, club c
    where g.idclub=c.idclub
    and g.idgerente=idg;
end #