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


drop view mivista2;
create view mivista2 as 
select s.nombre, s.appaterno, s.apmaterno, c.nombre as nombresocio
from socio s, sociomembresia sm, sucursal c
where s.idsocio=sm.idsocio
and sm.idsuc=c.idsuc
and ( s.appaterno like "Maya%" or s.apmaterno like "Maya%")
order by 4,2;
select * from  mivista2;


1.
drop view mivista1;
create view mivista1 as 
select p.nombre as nombregrupo, p.appaterno, p.apmaterno, g.nombre 
from profesor p, profesorgrupo pg, grupo g
where p.idprofesor = pg.profesor_idprofesor
and g.idgrupo = pg.grupos_idgrupo
order by p.nombre;
select * from  mivista1;


2.
drop view mivista2;
create view mivista2 as 
select m.nombre as nombremateria, p.appaterno, p.apmaterno, p.nombre
from profesor p, profesorgrupo pg, materia m
where p.idprofesor = pg.profesor_idprofesor
and pg.materia_idmateria = m.idmateria
order by 4,2;
select * from  mivista2;


3.
drop view mivista3;
create view mivista3 as 
select COUNT(calificacion), calificacion
from alumnoevaluacion
group by calificacion;
select * from  mivista3;

4.
drop view mivista4;
create view mivista4 as 
select  a.appaterno, a.apmaterno, a.nombre, a.email
from alumno a, alumnogrupo ag, grupo g, profesorgrupo pg, profesor p
where p.nombre like "ALEJANDRO" and p.appaterno like "CENTENO"
and a.boleta = ag.alumno_boleta
and ag.grupos_idgrupo = g.idgrupo
and g.idgrupo = pg.grupos_idgrupo
and pg.profesor_idprofesor = p.idprofesor
order by a.nombre;
select * from  mivista4;

5. 
drop view mivista5;
create view mivista5 as 
select  p.appaterno, p.apmaterno, p.nombre, p.especialidad
from grupo g, profesorgrupo pg, profesor p
where g.nombre like "GRUPO115"
and g.idgrupo = pg.grupos_idgrupo
and pg.profesor_idprofesor = p.idprofesor
order by p.nombre;
select * from  mivista5;

6.
drop procedure c1;
delimiter #
create procedure c1(in s varchar (45))
begin

    select m.nombre 
    from grupo g, profesorgrupo pg, materia m 
    where g.nombre like concat("%",s)
    and g.idgrupo = pg.grupos_idgrupo
    and m.idmateria = pg.materia_idmateria;

end #
delimiter ;
call c1("GRUPO112");


7.
drop procedure c2;
delimiter #
create procedure c2(in s varchar (45))
begin

    select g.nombre
    from alumno a, alumnogrupo ag, grupo g
    where ( a.appaterno like concat("%",s) or a.apmaterno like concat("%",s) )
    and a.boleta = ag.alumno_boleta 
    and ag.grupos_idgrupo = g.idgrupo
    group by g.nombre;

end #
delimiter ;
call c2("Perez");

8.
drop procedure c3;
delimiter #
create procedure c3(in s varchar (45))
begin

    select p.nombre, p.appaterno, p.apmaterno
    from profesor p, profesorgrupo pg, materia m
    where m.nombre like concat("%",s)
    and p.idprofesor = pg.profesor_idprofesor
    and pg.materia_idmateria = m.idmateria;

end #
delimiter ;
call c3("Ingles");

9.
drop procedure c4;
delimiter #
create procedure c4(in s varchar (45),in mail varchar (45))
begin

    select * from alumno where boleta like concat("%",s);
 
    update alumno
    set email = mail
    where boleta like concat("%",s);

    select * from alumno where boleta like concat("%",s);

end #
delimiter ;
call c4("2013639794","ejemplo");


10.
drop procedure c5;
delimiter #
create procedure c5(in s varchar (45),in c int)
begin

    select * from grupo where nombre like concat("%",s);
 
    update grupo
    set cupo = c
    where nombre like concat("%",s);

    select * from grupo where nombre like concat("%",s);

end #
delimiter ;
call c5("GRUPO111",123);


11.
drop procedure c6;
delimiter #
create procedure c6(in s varchar (45))
begin

    select a.nombre, a.appaterno, a.apmaterno, ae.calificacion
    from alumno a, alumnoevaluacion ae, evaluacion e
    where a.boleta like concat("%",s)
    and a.boleta = ae.alumno_boleta
    and e.idevaluacion = ae.evaluaciones_idevaluacion;

end #
delimiter ;
call c6("2013639794");


12.
drop procedure c6;
delimiter #
create procedure c6(in s varchar (45))
begin
    select count(appaterno)
    from alumno
    where (appaterno like concat("%",s) or apmaterno like concat("%",s));
    end #
delimiter ;
call c6("Carranza");


13.
drop procedure c6;
delimiter #
create procedure c6()
begin
    insert into materia values (44,"besos de 3");
    insert into materia values (45,"besos de 4");
    insert into materia values (46,"besos de 5");
    end #
delimiter ;
call c6();


14.
drop procedure c6;
delimiter #
create procedure c6()
begin

    select count(calificacion)
    from alumnoevaluacion
    where calificacion = 8;

end #
delimiter ;
call c6();


15.
drop procedure c6;
delimiter #
create procedure c6()
begin

    select a.nombre, a.appaterno
    from alumnoevaluacion ae, alumno a
    where ae.calificacion = 8
    and a.boleta = ae.alumno_boleta;

end #
delimiter ;
call c6();


16.
drop procedure c7;
delimiter #
create procedure c7()
begin

    DELETE FROM alumno WHERE (apmaterno like "Mota" or appaterno like "Mota");

end #
delimiter ;
call c7();