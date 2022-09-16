-- paso 1 --
select 
    * 
from Alumnos 
where lower(Alumnos.primerApellido) in ('mendoza') or lower(Alumnos.segundoApellido) in ('mendoza');

-- paso 2 --
select 
    concat(Alumnos.nombre,' ',primerApellido,' ',segundoApellido) as [Nombre Completo],
    EstatusAlumnos.nombre as [Estatus]
from Alumnos
inner join EstatusAlumnos on idEstatus = EstatusAlumnos.id
where EstatusAlumnos.id like 3;

-- paso 3 --
select 
    concat(nombre,' ',primerApellido,' ',segundoApellido) as [Nombre Completo],
    datediff(month, fechaNacimiento,getdate())/12 as [Edad]
from Instructores
where (datediff(month, fechaNacimiento,getdate())/12)  > 30;

-- paso 4 --
select 
    concat(nombre,' ', primerApellido , ' ', segundoApellido) as [ Nombre Completo],
    datediff(month, fechaNacimiento,getdate())/12 as [ Edad ]
from Alumnos
where (datediff(month, fechaNacimiento,getdate())/12) between 20 and 25;

-- paso 5 --
select 
    concat(Alumnos.nombre,' ',primerApellido,' ',segundoApellido) as [Nombre Completo],
    Estados.nombre as [Estado],
    EstatusAlumnos.nombre as [Estatus]
from Alumnos
inner join Estados on idEstadoOrigen = Estados.id
inner join EstatusAlumnos on idEstatus = EstatusAlumnos.id
where 
    (idEstadoOrigen like 19) and (idEstatus like 3) or (idEstadoOrigen like 4) and (idEstatus like 1);

-- paso 6 --
select 
    concat(Alumnos.nombre,' ',primerApellido,' ',segundoApellido) as [Nombre Completo],
    correo
from Alumnos
where correo like '%gmail%';

-- paso 7 --
select 
    concat(Alumnos.nombre,' ',primerApellido,' ',segundoApellido) as [Nombre Completo],
    fechaNacimiento
from Alumnos
where month(fechaNacimiento) like 3;

-- paso 8 --
select 
    concat(Alumnos.nombre,' ',primerApellido,' ',segundoApellido) as [Nombre Completo],
    datediff(month, fechaNacimiento, getdate())/12 as [Edad Actual],
    datediff(month,fechaNacimiento, dateadd(year,5,getdate()))/12 as [Edad dentro 5 años]
from Alumnos
where datediff(month,fechaNacimiento, dateadd(year,5,getdate()))/12 > 30;

-- paso 9 --
select 
    concat(Alumnos.nombre,' ',primerApellido,' ',segundoApellido) as [Nombre Completo],
    len(nombre) as [Caracteres]
from Alumnos
where len(nombre) >10;

-- paso 10 --
select 
    curp,
    right(curp,1) as [Ultimo caracter]
from Alumnos
where isnumeric(right(curp,1)) like 1;

-- paso 11 --
select 
    concat(Alumnos.nombre,' ',Alumnos.primerApellido,' ',Alumnos.segundoApellido) as [Nombre Completo],
    avg(calificacion) as [Calificacion]
from CursosAlumnos
inner join Alumnos on idAlumno = Alumnos.id
group by Alumnos.nombre, Alumnos.primerApellido, Alumnos.segundoApellido,calificacion
having avg(calificacion) > 80;

-- paso 12 --
select
    concat(Alumnos.nombre,' ',Alumnos.primerApellido,' ',Alumnos.segundoApellido) as [Nombre Completo],
    sueldo,
    EstatusAlumnos.nombre as [Estatus]
from Alumnos
inner join EstatusAlumnos on idEstatus = EstatusAlumnos.id
where 
    (idEstatus like 6)
        or
    (idEstatus like 5) 
        and 
    (sueldo > 15000);

-- paso 13 --
select 
    concat(nombre,' ',Alumnos.primerApellido,' ',Alumnos.segundoApellido) as [Nombre Completo],
    year(fechaNacimiento) as [Año de nacimiento]
from Alumnos
where 
    (year(fechaNacimiento) between 1990 and 1995) 
        and 
    (lower(primerApellido) like 'b%' or lower(primerApellido) like 'c%' or lower(primerApellido) like 'z%');

-- paso 14 --
select
    concat(nombre,' ',Alumnos.primerApellido,' ',Alumnos.segundoApellido) as [Nombre Completo],
    curp,
    fechaNacimiento,
    concat('19',SUBSTRING(curp,5,2),'-',SUBSTRING(curp,7,2),'-',SUBSTRING(curp,9,2)) as[fechaNacimiento Por curp]
from Alumnos
where fechaNacimiento not like concat('19',SUBSTRING(curp,5,2),'-',SUBSTRING(curp,7,2),'-',SUBSTRING(curp,9,2));

-- paso 15 --
select 
    concat(nombre,' ',Alumnos.primerApellido,' ',Alumnos.segundoApellido) as [Nombre Completo],
    datediff(month,fechaNacimiento,getdate())/12 as [Edad Actual],
    month(fechaNacimiento) as [Mes de nacimiento]
from Alumnos
where 
    (lower(primerApellido) like 'a%')
    and
    (datediff(month,fechaNacimiento,getdate())/12 between 21 and 30)
    and
    (month(fechaNacimiento) like 4);

-- paso 16 --
select 
    concat(nombre,' ',Alumnos.primerApellido,' ',Alumnos.segundoApellido) as [Nombre Completo]
from Alumnos
where lower(nombre) like '%luis%';

-- paso 17 --
select
    CatCursos.nombre as [Curso],
    year(Cursos.fechaInicio) as [Año De Inicio],
    year(Cursos.fechaTermino) as [Año finalizado],
    Cursos.fechaInicio,
    Cursos.fechaTermino,
    count(Alumnos.nombre) as [total de alumnos],
    min(CursosAlumnos.calificacion) as [Minimo],
    max(CursosAlumnos.calificacion) as [Maximo],
    avg(CursosAlumnos.calificacion) as [Promedio]
from CursosAlumnos
inner join Cursos on idCurso = Cursos.id
inner join CatCursos on idCatCurso = CatCursos.id
inner join Alumnos on idAlumno = Alumnos.id
group by 
    CatCursos.nombre,
    Cursos.fechaInicio,
    Cursos.fechaTermino
having year(Cursos.fechaInicio) like 2021
order by CatCursos.nombre;

-- paso 18 --
select 
    Estados.nombre as [Estado],
    count(Alumnos.nombre) as [Total de alumnos],
    avg(CursosAlumnos.calificacion) as [Calificacion Promedio],
    avg(Alumnos.sueldo) as [Sueldo Promedio]
from CursosAlumnos
inner join Alumnos on idAlumno = Alumnos.id
inner join Estados on Alumnos.idEstadoOrigen = Estados.id
where CursosAlumnos.calificacion > 60
group by 
    Estados.nombre
having 
    avg(CursosAlumnos.calificacion) > 60
        and
    count(Alumnos.id) >1;