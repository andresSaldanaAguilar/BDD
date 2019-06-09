1. Modificar la PK 
--evitar problemas con la restriccion
set foreign_key_checks=0; 
alter table cliente modify column idcliente int auto_increment;


2.Crear la relaicon spcio

Socio(idsocio, nombre, ap, am);

create table socio(
    idsocio int not null primary key auto_increment,
    nombre varchar(30),
    ap varchar(40),
    am varchar(40)
);


3.Crear la relacion empleado

create table empleado(
    idempleado int not null primary key auto_increment,
    nombre varchar(30),
    ap varchar(40),
    am varchar(40)
);

4.-Llenar la relacion empleado con los datos que tiene la relacion cliente

insert into empleado(nombre, ap, am)
select nombre, appaterno, apmaterno
from cliente;

5.-Crear un sp que permite dar de alta a un cliente determinado

delimiter #
create procedure e1(in n varchar(40), in p varchar(40), in m varchar(40))
begin 
insert into  cliente (nombre,appaterno,apmaterno) values (n,p,m);

select * from cliente where nombre= n and appaterno=p;
end #

call e1("pancho","perez","perez");

6.-Crear un trigger que permita realizar las siguientes acciones cuando damos de alta a un cliente
a) crear una copia de cliente en socio
b) actualizar el pago (fecha) del cliente
c) eliminar a un emepleado

delimiter #

create trigger t1
after insert on cliente 
for each row 
begin
insert into socio(nombre, ap, am)
values(new.nombre, new.appaterno, new.apmaterno);

update pago set fechaPago=curdate()
where idcliente=(new.idcliente);

delete from empleado where idempleado=(new.idcliente-50);

end#


7.-Crear un trigger para verificar la fecha que se actualizo, crear la siguiente relacion

create table bitacoraFecha(
    id int not null primary key auto_increment,
    usuario varchar(60),
    valorPrevio date,
    Fecha datetime,
    fechaPago date
);

create trigger t2
after update on pago
for each row
insert into bitacoraFecha(usuario, valorPrevio, fecha, fechaPago)
values(current_user(), old.fechaPago, now(), new.fechaPago);

