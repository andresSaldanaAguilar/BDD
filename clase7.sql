-- 1. L. Conocer los socios que esten ubicados en Monterrey (quitar dirección).
delimiter #
create procedure l1()
begin 
    select s.idsocio, s.nombre, s.tel, s.email from socio s, sociomix sm, mixup m 
    where s.idsocio=sm.idsocio 
    and sm.idmixup=m.idmixup 
    and m.ubicacion like "Monterre%"
    order by s.nombre;
end #

delimiter #
create procedure l3()
begin 
    select s.idsocio, s.nombre, s.tel, s.email from socio s
    where  s.idsocio > 235
    order by s.idsocio;
end #

-- 2. Agregar a un socio (id, nombre)
delimiter #
create procedure l2(in id int, in n varchar(60))
begin 
    insert into socio(idSocio, nombre) 
    values (id,n);
    select * from socio where idSocio = id;
end #

-- Transacciones  ----> Poner begin; en la terminal
-- begin 
--    l(x)
--    e(x)
-- rollback
-- l(x)

