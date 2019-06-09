con base al nombre del club conocer los gerentes asociados a el 

delimiter #
create procedure ctest(in s varchar(15))
begin
    select g.nombre
    from gerente g, club c
    where c.nombre like concat("%",s)
    and g.idclub = c.idclub
    order by g.nombre;
end #
delimiter ; 
drop procedure ctest;
call ctest();


con base a un cp, mostrar el nombre del club y el estado donde se ubica

delimiter #
create procedure ctest(in cp int)
begin
    select c.nombre, e.nombre
    from club c, estado e
    where c.direccion like concat("%",cp,"%")
    and c.idedo = e.idedo
    order by c.nombre;
end #
delimiter ; 
drop procedure ctest;
call ctest();

actualizar el tel de un socio determinado

delimiter #
create procedure ctest(in id int, in s varchar(20))
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
drop procedure ctest;
delimiter ; 
call ctest();

dar de alta un proveedor

delimiter #
create procedure ctest(in id int, in nombre varchar(45),in tel varchar(25))
begin

    insert into proveedor
    values(id,nombre,tel);

    select *
    from proveedor
    where idproveedor = id;

end #
drop procedure ctest;
delimiter ; 
call ctest();


reasignar a un gerente a un club determinado

delimiter #
create procedure ctest(in id int, in nombre varchar(20))
begin

  

    update gerente 
        set idclub = (select idclub from club where nombre like concat(nombre,"%"))
        where idgerente = id;
 

end #
drop procedure ctest;
delimiter ; 
call ctest();

