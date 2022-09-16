select 'Alumno' as 
    Tipo,
    nombre,
    primerApellido,
    segundoApellido,
    month(fechaNacimiento) as mes,
    day(fechaNacimiento) as dia
from Alumnos
union
select 'instructor' as 
    Tipo,
    nombre,
    primerApellido,
    segundoApellido,
    month(fechaNacimiento) as mes,
    day(fechaNacimiento) as mes
from Instructores;