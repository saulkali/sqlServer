-- paso 1 --
select 
    Estados.nombre,
    count(Alumnos.nombre) as [total alumnos] 
from Alumnos
inner join Estados on idEstadoOrigen = Estados.id
group by Estados.nombre;


-- paso 2 --
select 
    EstatusAlumnos.nombre as [Estatus],
    count(Alumnos.nombre) as [Total de alumnos] 
from Alumnos
inner join EstatusAlumnos on idEstatus = EstatusAlumnos.id
group by EstatusAlumnos.nombre
order by EstatusAlumnos.nombre;

-- paso 3 --
select 
    'Calificaciones de Alumnos' as [Resumen Calificaciones],
    count(Alumnos.nombre) as [Tot],
    max(CursosAlumnos.calificacion) as [Maxima],
    min(CursosAlumnos.calificacion) as [Minima],
    avg(CursosAlumnos.calificacion) as [promedio]
from CursosAlumnos
inner join Alumnos on idAlumno = Alumnos.id;

-- paso 4 --
select 
    CatCursos.nombre as [Curso],
    Cursos.fechaInicio as [Fecha Inicio],
    Cursos.fechaTermino as [Fecha Terminacion],
    count (Alumnos.nombre) as [Total Alumnos],
    max(CursosAlumnos.calificacion) as [Maxima],
    min(CursosAlumnos.calificacion) as [Minima],
    avg(CursosAlumnos.calificacion) as [Promedio]
from CursosAlumnos
inner join Cursos on idCurso = Cursos.id
inner join CatCursos on idCatCurso = CatCursos.id
inner join Alumnos on idAlumno = Alumnos.id
group by CatCursos.nombre, Cursos.fechaInicio, Cursos.fechaTermino
order by CatCursos.nombre;

-- paso 5 --
select 
    Estados.nombre as [Estado],
    count(Alumnos.nombre) as [Total],
    max(CursosAlumnos.calificacion) as [Maxima],
    min(CursosAlumnos.calificacion) as [Minima],
    avg(CursosAlumnos.calificacion) as [Promedio]
from CursosAlumnos
inner join Alumnos on idAlumno = Alumnos.id
inner join Estados on Alumnos.idEstadoOrigen = Estados.id
group by Estados.nombre
having avg(CursosAlumnos.calificacion) > 60
order by Estados.nombre;