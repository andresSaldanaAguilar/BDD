create database db1;
use db1;

create table cliente(
    idCliente int not null primary key auto_increment,
    nombre varchar(70),
    sucursal varchar(60)
);

create table historial(
    idHistorial int not null primary key auto_increment,
    nombrec varchar(70),
    sucursalc varchar(60),
    fecha datetime,
    usuario varchar(60)
);


 

insert into cliente(nombre, sucursal) 
select concat(c.apPaterno," ",c.apMaterno," ",c.nombre),
t.nombre from ele.cliente c, ele.pago p, ele.tienda t
where c.idcliente=p.idcliente
and p.idtienda = t.idtienda;

Crear un SP que permita actualizar la sucursal de un cliente.....

delimiter $
create procedure e1(in id int, in ns varchar(70))
begin
select * from cliente where idcliente=id;

update cliente set sucursal=ns
where idcliente=id;

select * from cliente where idcliente=id;
end $

Crear un trigger que permita llevar la relacion historial cada vez que se 
lleva al cabo una actualzacion de cliente

after -> old
before -> new

create trigger t1
after update on cliente 
for each row
insert into historial (nombrec,sucursalc,fecha,usuario)
values (old.nombre, old.sucursal, now(), current_user());

call e1(124,"EKT CABO SAN LUCAS");
call e1(132,"EKT MEGA COLIMA");

crear la relacion producto2 y cada ves que se agregue un producto, agregarlo a la relacion p2

create table producto2(
    idproducto int not null primary key,
    nombre varchar(100),
    descripcion varchar(400),
    pu double,
    marca varchar(45),
    idSubcategoria int
);

delimiter $
create procedure e2(in id int, in n varchar(100), in d varchar(400),
in pu double, in m varchar(45), in  ns varchar(60))
begin
insert into producto
values(id,n,d,pu,m,(select idsubcategoria from subcategoria where nombre like concat(ns,"%")));

select * from producto 
where idproducto=id;
end $


--db1
create trigger t2
after insert on producto
for each row

insert into ele.producto2
values (new.idproducto, new.nombre, new.descripcion, new.precioUnitario, new.marca, new.idSubcategoria);


--en elektra
create trigger t2
after insert on producto
for each row

insert into producto2
values (new.idproducto, new.nombre, new.descripcion, new.precioUnitario, new.marca, new.idSubcategoria);




