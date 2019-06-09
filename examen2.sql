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

select count(*) from libros
  where editorial='Planeta';


drop view mivista5;
create view mivista5 as
select s.nombre, s.appaterno, s.apmaterno, r.nombre as nombre_sucursal, sm.fechaalta
from socio s, sociomembresia sm, sucursal r
where sm.fechaalta like "2017-05-%"
and sm.idsuc=r.idsuc
and sm.idsocio=s.idsocio
order by 1;
select * from  mivista5;











////////////////////////

drop view mivista1;
create view mivista1 as
select c.numerocuenta, pm.rfc, pm.nombreresponsable, pm.apellidopaterno, pm.apellidomaterno
from cuenta c, personamoral pm, banco b
where (pm.apellidomaterno like "L_pez" or pm.apellidopaterno like "L_pez")
and c.numerocuenta = b.numerocuenta
and pm.clavebanco = b.clavebanco
order by pm.nombreresponsable;
select * from  mivista1;






select c.rfc,  pf.nombre, pf.apellidopaterno
from cliente c, documento d, personafisica pf, tipocliente tc
where (d.escrituras like "Si")
and d.clavedocumento = c.clavedocumento 
and c.rfc = tc.rfc
and tc.rfc = pf.rfc 

UNION

select c.rfc,  pm.nombreresponsable, pm.apellidopaterno
from cliente c, documento d, personamoral pm, tipocliente tc
where (d.escrituras like "Si")
and d.clavedocumento = c.clavedocumento 
and c.rfc = tc.rfc
and tc.rfc = pm.rfc ;





select d.ine, c.rfc
from documento d, cliente c, tipocliente tc, personamoral pm, banco b
where b.nombre like "inbursa"
and d.clavedocumento = c.clavedocumento
and c.rfc = tc.rfc
and tc.rfc = pm.rfc
and b.clavebanco = pm.clavebanco

UNION

select d.ine, c.rfc
from documento d, cliente c, tipocliente tc, personafisica pf, banco b
where b.nombre like "inbursa"
and d.clavedocumento = c.clavedocumento
and c.rfc = tc.rfc
and tc.rfc = pf.rfc
and b.clavebanco = pf.clavebanco;




select c.numerocuenta,  pf.nombre, pf.apellidopaterno, pf.apellidomaterno
from personafisica pf, banco b, cuenta c
where (pf.apellidomaterno like "%Aguilar%" or pf.apellidopaterno like "%Aguilar%")
and pf.clavebanco = b.clavebanco  
and b.numerocuenta = c.numerocuenta;





select c.rfc,  pf.nombre, pf.apellidopaterno
from cliente c, documento d, personafisica pf, tipocliente tc
where (tc.cp > 53999 and tc.cp > 55000)
and c.rfc = tc.rfc
and tc.rfc = pf.rfc 

UNION

select c.rfc,  pm.nombreresponsable, pm.apellidopaterno
from cliente c, documento d, personamoral pm, tipocliente tc
where (tc.cp > 53999 and tc.cp > 55000)
and c.rfc = tc.rfc
and tc.rfc = pm.rfc ;





drop procedure c1;
delimiter #
create procedure c1(in n varchar (45))
begin
    select c.numerocuenta, tc.email
    from cuenta c, banco b, tipocliente tc, personafisica pf
     where b.nombre like concat("%",n)
    and b.numerocuenta=c.numerocuenta
    and pf.clavebanco = b.clavebanco
    and tc.rfc = pf.rfc

    UNION


    select c.numerocuenta, tc.email
    from cuenta c, banco b, tipocliente tc, personamoral pm
    where b.nombre like concat("%",n)
    and b.numerocuenta=c.numerocuenta
    and pm.clavebanco = b.clavebanco
    and tc.rfc = pm.rfc;
end #
delimiter ;
call c1("inbursa");


drop procedure c2;
delimiter #
create procedure c2(in n varchar (45))
begin
    select pm.nombreresponsable
    from producto p, historial h, cliente c, tipocliente tc, personamoral pm
    where p.marca like concat("%",n)
    and p.idproducto = h.idproducto
    and c.idcliente = h.idcliente
    and c.rfc = tc.rfc 
    and tc.rfc = pm.rfc

    UNION

    select pf.nombre
    from producto p, historial h, cliente c, tipocliente tc, personafisica pf
    where p.marca like concat("%",n)
    and p.idproducto = h.idproducto
    and c.idcliente = h.idcliente
    and c.rfc = tc.rfc 
    and tc.rfc = pf.rfc;

end #
delimiter ;
call c2("Oster");


drop procedure c3;
delimiter #
create procedure c3(in n varchar (45))
begin

    select pf.nombre, d.*
    from documento d, cliente c, tipocliente tc, personafisica pf
    where pf.apellidopaterno like concat("%",n)
    and c.clavedocumento = d.clavedocumento
    and c.rfc = tc.rfc 
    and tc.rfc = pf.rfc;

end #
delimiter ;
call c3("alonso");


drop procedure c5;
delimiter #
create procedure c5(in n varchar (45))
begin

    select b.nombre, pm.rfc
    from personamoral pm, cuenta cu, banco b
    where cu.numerocuenta like concat("%",n)
    and cu.numerocuenta = b.numerocuenta
    and b.clavebanco = pm.clavebanco

    union 

    select b.nombre, pf.rfc
    from personafisica pf, cuenta cu, banco b
    where cu.numerocuenta like concat("%",n)
    and cu.numerocuenta = b.numerocuenta
    and b.clavebanco = pf.clavebanco;

end #
delimiter ;
call c5("00160752265");


drop procedure c15;
delimiter #
create procedure c15(in id varchar (45) ,in n int)
begin

    update producto
    set precio = n 
    where idproducto like concat("%",id); 
    
    select * from producto where idproducto like concat("%",id);

end #
delimiter ;
call c15("PA1097",10.0);


drop procedure c14;
delimiter #
create procedure c14(in id varchar (45))
begin

    select * from producto where idproducto like concat("%",id);

    DELETE FROM producto
    where idproducto like concat("%",id); 
    
    select * from producto where idproducto like concat("%",id);

end #
delimiter ;
call c14("PT1055");


drop procedure c12;
delimiter #
create procedure c12(in e int, in m varchar (45))
begin

    select * from producto where marca like concat("%",m);

    update producto
    set existencia= e
    where marca like concat("%",m);
    
    select * from producto where marca like concat("%",m);

end #
delimiter ;
call c12(12,"oster");



drop procedure c11;
delimiter #
create procedure c11(in id int, clave in varchar(20),nombre in varchar(20))
begin

    select * from producto where marca like concat("%",m);

    update producto
    set existencia= e
    where marca like concat("%",m);
    
    select * from producto where marca like concat("%",m);

end #
delimiter ;
call c11(12,"oster");