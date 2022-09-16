-- paso 1 --
-- cambiar los alumnos propedeuticos a capacitacion
update 
    Alumnos 
set 
    idEstatus = 3 
where 
    idEstatus = 2;

-- paso 2 --
-- convertir el primer apellido del alumno en mayusculas
update 
    Alumnos
set
    primerApellido = upper(primerApellido);
-- paso 3 --
-- convertir la primera letra del segundo apellido en mayuscula
update 
    Alumnos
set
    segundoApellido = stuff(lower(segundoApellido),1,1,upper(left(segundoApellido,1)));

select * from Alumnos;

-- paso 4 --
-- actualizar el numero de telefono de los instructores con la lada 55 si su curp indican ser de DF
update
    Instructores
set 
    telefono = stuff(telefono,1,2,'55')
where
    upper(SUBSTRING(curp,12,2)) = 'DF'

select * from Instructores;
-- paso 5 -- 
-- aumentar 10 puntos a los alumnos de  hidalgo [id=12] y oaxaca [id=19] sin excederse del 100
update 
    CursosAlumnos
set 
    calificacion = datos.nuevaCalificacion
from 
    CursosAlumnos
inner join(
    select 
        idAlumno,
        calificacion,
        case 
            when calificacion between 91 and 99 then ((100 - calificacion) + calificacion)
            when calificacion = 100 then calificacion
            else (10 + calificacion)
        end as [nuevaCalificacion]
    from 
        CursosAlumnos 
    inner join Alumnos on idAlumno = Alumnos.id
    inner join Cursos on idCurso = Cursos.id
    where 
        (Alumnos.idEstadoOrigen = 12
            or
        Alumnos.idEstadoOrigen = 19)
            and
        month(Cursos.fechaInicio) = 5
            and
        year(fechaInicio) = 2021
        
) as datos on CursosAlumnos.idAlumno = datos.idAlumno;

-- paso 6 --
-- subir el 10% de la cuota de los instructores que imparten el curso .NET (ciencia de datos 'id = 3')
update 
    Instructores
set 
    Instructores.cuotaHora = datos.[cuotaHora 10%]
from 
    Instructores
inner join (
    select 
        Instructores.id as [idInstructor],
        Instructores.cuotaHora,
        Instructores.cuotaHora + (Instructores.cuotaHora * 0.10) as [cuotaHora 10%],
        CatCursos.id as [idCatCurso],
        CatCursos.nombre as [Curso]
    from CursosInstructores
    inner join Instructores on idInstructor=Instructores.id
    inner join Cursos on idcurso = Cursos.id 
    inner join CatCursos on Cursos.idCatCurso = CatCursos.id
    where CatCursos.id = 3
) as datos on datos.idInstructor = Instructores.id;

-- paso 7 --
-- problema 1 -> copear la tabla alumnos a una nueva tabla llamada AlumnosTodos
-- problema 2 -> copear solo los alumnos de hidalgo a nueva nueva tabla llamada AlumnosHgo
-- problema 3 -> en la tabla AlumnosHgo cambiar los primeros digitos telefonico por '77'

-- problema 1
select 
    * 
into EjerciciosTich.dbo.AlumnosTodos
from Alumnos;
-- problema 2
select 
    *
into 
    EjerciciosTich.dbo.AlumnosHgo
from 
    Alumnos
where Alumnos.idEstadoOrigen = 12;
--problema 3
update
    EjerciciosTich.dbo.AlumnosHgo
set
    telefono = stuff(telefono,1,2,'77')
select * from EjerciciosTich.dbo.AlumnosHgo;

-- problema 4
update 
    EjerciciosTich.dbo.AlumnosTodos
set 
    telefono = AlunmHgo.telefono
from 
    EjerciciosTich.dbo.AlumnosTodos
inner join(
    select id,telefono from EjerciciosTich.dbo.AlumnosHgo
) as AlunmHgo on AlunmHgo.id = AlumnosTodos.id;