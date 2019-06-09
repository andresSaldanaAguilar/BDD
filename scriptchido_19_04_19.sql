--triggers, procedures

delimiter $
create procedure e1(in id int, in ns varchar(70))
begin
select * from cliente where idcliente=id;

update cliente set sucursal=ns
where idcliente=id;

select * from cliente where idcliente=id;
end $


after -> old
before -> new

create trigger t1
after update on cliente 
for each row
insert into historial (nombrec,sucursalc,fecha,usuario)
values (old.nombre, old.sucursal, now(), current_user());

call e1(124,"EKT CABO SAN LUCAS");
call e1(132,"EKT MEGA COLIMA");

curdate()

--Transactions

begin;
rollback;
commit;


--Views

drop view mivista4;
create view mivista4 as
select s.nombre, s.email, r.nombre as servicio 
from sucursal s, sucservicio ss, servicio r
where r.nombre = "Centro Llantero"
and r.idServicio = ss.idServicio
and s.idsuc=ss.idsuc
order by 1;
select * from  mivista4;


--Table

create table socio(
    idsocio int not null primary key auto_increment,
    nombre varchar(30),
    ap varchar(40),
    am varchar(40)
);
