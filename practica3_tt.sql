1. Dar de alta tu tt

insert into tt
values ("2019B19001", "Sistema de monitoreo de sistemas fotovoltaicos.");

select * from tt where noTT="2019B19001";

2. Asignar tus 3 sinodales correspondientes

insert into sinodalia (idsinodalia,nott,s1,s2,s3)
values (5010,"2019B19001",
(select idProf from profesor where nombre like "Martha Ro%" and apPaterno like "Corder%"),
(select idProf from profesor where nombre like "Jos_% Jaime" and apPaterno like "L_pez%"),
(select idProf from profesor where nombre like "Idali%" and apPaterno like "Maldo%"));

select p.nombre, p.apPaterno, p.apMaterno, s.noTT
from profesor p, sinodalia s
where s.noTT like "2019B19001"
and (s.s1 = p.idProf or s.s2 = p.idProf or s.s3 = p.idProf )
order by p.nombre;

3. Mostrar los tts que se presentaron en el año 2010

select t.*, p.fecha 
from tt t, presentacion p
where t.nott=p.nott
and p.fecha like "2010%"
order by p.fecha;

4. Mostrar la info correspondiente a los tts dirigidos por Andrés Ortigoza

select t.*
from tt t, dirige d, profesor p
where t.nott=d.nott
and d.idProf=p.idProf
and p.nombre like "Andr%"
and p.apPaterno like "Ortig%"
order by t.nott;

5. Cuales son los tts que ha sido revisor la profesora Fabiola Ocampo?

select s.nott
from sinodalia s, profesor p
where p.idProf=s.revisor
and p.nombre like "Fabiol%"
and p.apPaterno like "Ocam%"
order by 1;

6. Mostrar el no de tt de aquellos tts que ha sido sinodal el profesor Ukranio

select s.nott, p.nombre, p.apPaterno, p.apMaterno
from sinodalia s, profesor p
where (p.idProf=s.s1 or p.idProf=s.s2 or p.idProf=s.s3)
and p.nombre like "Ukran%"
and p.apPaterno like "Coroni%"
order by 3;

7. Mostrar la calificacion de los sinodales de los tts que han sido remediales anexar el nombre de sus directores.

select t.nott, p.nombre, p.apPaterno, p.apMaterno, x.califsinodales
from tt t, profesor p, presentacion x, dirige d
where t.nott = x.nott
and d.nott = t.nott
and d.idProf = p.idProf
and x.tipo like "TT R"
order by 1;

Crear vistas

1. Mostrar el nombre y el grado de los profesores, ademas anexar la institucion

drop view v1;

create view v1 as 
select p.*, ge.descripcion, gp.institucion
from profesor p, gradoEstudios ge, gradoProf gp
where p.idProf = gp.idProf
and gp.idGrado=ge.idGrado
order by p.apPaterno;

select * from v1;

2. Mostrar el no. de tt de aquellos tts que han reprobado, es decir que al calificacion de los sinodales sea menor a 8

drop view v2;

create view v2 as 
select t.nott
from tt t, presentacion p
where t.nott = p.nott
and p.califsinodales < 8
order by t.noTT;

select * from v2;

3. Mostrar aquellos tts que se presentan en noviembre del año 2009

drop view v3;

create view v3 as
select t.*, p.fecha
from tt t, presentacion p
where p.fecha like "2010-11%"
and t.nott = p.nott;

select * from v3;

4. Mostrar el dictamen de los tts que ha dirigido el profe euler

drop view v4;

create view v4 as 
select p.dictamen, t.titulo, x.nombre
from profesor x, tt t, presentacion p, dirige d
where x.nombre like "EUL%"
and d.idProf = x.idProf
and t.nott = d.nott
and p.nott = t.nott;

select * from v4;

5. Mostrar los sinodales de la consulta anterior

drop view v5;

create view v5 as

select x.*
from profesor x, tt t, dirige d, sinodalia s, presentacion p
where d.idProf=(select idProf from profesor where nombre like "Eule%")
and d.nott=t.nott
and t.nott = s.nott
and p.nott = t.nott
and (x.idProf=s.s1 or x.idProf=s.s2 or x.idProf=s.s3)
order by x.nombre;

select * from v5;




