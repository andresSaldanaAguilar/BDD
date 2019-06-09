%%Practica 1
drop database practica1BDD;
create database practica1BDD;
use practica1BDD;

create table proveedor(
    idProveedor int not null primary key,
    nombre varchar(20),
    dir varchar (200)
);

create table sucursal(
    idSucursal int not null primary key,
    nombre varchar(30),
    tel int,
    dir varchar(200)
);

create table producto(
    idProducto int not null primary key,
    nombre varchar(30),
    contNeto double,
    idProv int,
    foreign key(idProv) references
    proveedor(idProveedor) on delete cascade on update cascade
);

create table presentacion(
    idProducto int not null,
    presentacion varchar(30) not null,
    primary key(idProducto, presentacion),
    foreign key(idProducto) references
    producto(idProducto) on delete cascade on update cascade
);


insert into sucursal 
select idclub,nombre,tel,direccion from sams.club;

insert into proveedor (idProveedor,nombre)
select idProveedor,nombre from sams.proveedor;

alter table producto modify column nombre varchar(45);

insert into producto (idProducto,nombre,idProv)
select idProducto, nombre, idProveedor from sams.producto;

%%parte 1

Resolver las siguientes consultas

1.-¿Como se llaman los gerentes del club de tepeyac?

select g.nombre from gerente g, club c
where g.idclub=c.idclub
and c.nombre like "tepeyac%"
order by g.nombre;

2.-¿Como se llaman las sucursales existentes en el edomex?

select c.nombre from club c, estado e 
where e.idedo=c.idedo
and e.nombre like "M_xico%"
order by c.nombre;

3.-¿Que proovedores suministran productos al club toreo?

select p.nombre from proveedor p, proveedorsams x, club c
where p.idproveedor=x.idproveedor
and x.idclub=c.idclub
and c.nombre="Toreo"
order by p.nombre;

4.-¿Que servicios tiene el club pachuca?

select s.nombre from servicio s,
servicioclub x, club c
where s.idservicio=x.idservicio
and x.idclub=c.idclub
and c.nombre="Pachuca"
order by s.nombre;

5.-¿Mostrar el nombre completo de los socios que se apellidan
hernandez y en que club fueron dados de alta?

select s.nombre, c.nombre from 
socio s, club c, socioclub x
where s.idsocio=x.idsocio
and x.idclub=c.idclub
and (s.nombre like "Hern_ndez%" or
s.nombre like "% Hern_ndez%")
order by c.nombre, s.nombre;