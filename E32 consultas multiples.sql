--paso 1
select 
    nombre,
    primerApellido as [Apellido Paterno],
    segundoApellido as [Apellido Materno],
    rfc,
    cuotaHora as [Cuota por hora],
    IIF(activo>0,'activo','Inactivo') as Estado
from Instructores;

-- paso 2
select
    nombre as Curso, 
    horas,
    fechaInicio,
    fechaTermino

    from Cursos inner join CatCursos on idCatCurso = CatCursos.id;

-- paso 3
select 
    Alumnos.nombre,
    primerApellido,
    segundoApellido,
    curp,
    Estados.nombre as Estado,
    EstatusAlumnos.nombre as Estatus
    from Alumnos inner join Estados on idEstadoOrigen = Estados.id inner join EstatusAlumnos on idEstatus = EstatusAlumnos.id;

-- paso 4
select 
    CONCAT(Instructores.nombre, ' ',primerApellido, ' ',segundoApellido) as [Nombre Completo],
    cuotaHora as [Cuota Por Hora],
    CatCursos.nombre as [Nombre Del Curso],
    fechaInicio,
    fechaTermino
from CursosInstructores 
inner join Instructores on idInstructor = Instructores.id
inner join Cursos on idcurso = Cursos.id
inner join CatCursos on idCatCurso = CatCursos.id;

-- paso 5
select 
    Alumnos.nombre,
    Alumnos.primerApellido,
    Alumnos.segundoApellido,
    Estados.nombre as [Estado],
    CatCursos.nombre as [Curso],
    CursosAlumnos.fechaInscripcion,
    Cursos.fechaInicio,
    Cursos.fechaTermino,
    CursosAlumnos.calificacion
from CursosAlumnos
inner join Alumnos on idAlumno = Alumnos.id
inner join Cursos on idCurso = Cursos.id
inner join Estados on Alumnos.idEstadoOrigen = Estados.id
inner join CatCursos on Cursos.idCatCurso = CatCursos.id;

-- paso 6
select 
    Alumnos.nombre,
    CONCAT(Alumnos.primerApellido,' ',Alumnos.segundoApellido) as Apellidos,
    CatCursos.nombre as [Nombre Curso],
    Cursos.fechaInicio,
    Cursos.fechaTermino,
    CursosAlumnos.calificacion
from CursosAlumnos
inner join Alumnos on idAlumno = Alumnos.id
inner join Cursos on idCurso = Cursos.id
inner join CatCursos on Cursos.idCatCurso = CatCursos.id order by CursosAlumnos.calificacion desc;

-- paso 7
select * from Cursos;
select * from CatCursos;

select 
    CatCursos.clave,
    CatCursos.nombre,
    CatCursos.horas,
    isnull(PreRequisito.nombre,'sin prerequistos') as [PreRequisito]
from Cursos
inner join CatCursos on idCatCurso = CatCursos.id
left join CatCursos PreRequisito on CatCursos.idPreRequisito = PreRequisito.id;

-- paso 8
select 
    Alumnos.id,
    Alumnos.nombre,
    Alumnos.primerApellido,
    Alumnos.segundoApellido,
    CatCursos.nombre as [Curso],
    Cursos.fechaInicio,
    Cursos.fechaTermino,
    CursosAlumnos.calificacion,
    case 
        when CursosAlumnos.calificacion between 90 and 100 then 'Excelente'
        when CursosAlumnos.calificacion between 70 and 89 then 'Bien'
        when CursosAlumnos.calificacion between 60 and 69 then 'suficiente'
        else 'N/A'
    end as Nivel
from CursosAlumnos
inner join Cursos on idCurso = Cursos.id
inner join Alumnos on idAlumno = Alumnos.id
inner join CatCursos on Cursos.idCatCurso = CatCursos.id;