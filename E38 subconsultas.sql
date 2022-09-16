-- paso 1 --
-- extraer al alumno con el nombre mas largo
select 
    nombre,
    len(nombre) as [Caracteres]
from Alumnos
where len(nombre) >= all (select len(nombre) from Alumnos);

-- paso 2 --
-- extraer a los alumnos mas jovenes
select 
    nombre,
    fechaNacimiento
from Alumnos
where fechaNacimiento >= all(select fechaNacimiento from Alumnos);

-- paso 3 --
-- extraer los alumnos que obtuvieron la calificacion maxima 100
select 
    Alumnos.nombre as [nombre],
    Alumnos.primerApellido,
    Alumnos.segundoApellido,
    CatCursos.nombre as [Curso],
    Cursos.fechaInicio,
    Cursos.fechaTermino,
    CursosAlumnos.calificacion
from CursosAlumnos
inner join Alumnos on idAlumno = Alumnos.id
inner join Cursos on idCurso = Cursos.id
inner join CatCursos on Cursos.idCatCurso = CatCursos.id
where CursosAlumnos.calificacion >= some (select calificacion from CursosAlumnos where calificacion >= 100);

-- paso 4 --
select 
    CatCurs.nombre as [Curso],
    Curs.fechaInicio,
    Curs.fechaTermino,
    count(Alu.id) as [Total de alumnos],
    min(CursosAlumnos.calificacion) as [Minimo],
    max(CursosAlumnos.calificacion) as [Maximo],
    avg(CursosAlumnos.calificacion) as [Promedio]
from CursosAlumnos
inner join (select id,nombre from Alumnos) as Alu on idAlumno=Alu.id
inner join (select id,idCatCurso,fechaInicio,fechaTermino from Cursos) as Curs on idCurso = Curs.id
inner join (select id,nombre from CatCursos)  as CatCurs on Curs.idCatCurso = CatCurs.id
group by 
    CatCurs.nombre,
    Curs.fechaInicio,
    Curs.fechaTermino;

-- paso 5 --
-- obtener una consulta de los alumnos que tienen una calificacion igual o menor que el del promedio de calificaciones
select
    Alumnos.nombre,
    calificacion
from CursosAlumnos
inner join Alumnos on CursosAlumnos.idAlumno = Alumnos.id 
where CursosAlumnos.calificacion >= some(select avg(calificacion) from CursosAlumnos);

select 
    avg(calificacion) as [Promedio]
from CursosAlumnos;