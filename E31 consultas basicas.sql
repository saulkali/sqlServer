-- consultas sencillas en mysql
-- Ejercicio 1
--  23 - agosto - 2022

-- punto 1
select 
    primerApellido as [Apellido Paterno], 
    segundoApellido as [Apellidos Materno],
    nombre,
    telefono,
    correo 
from Alumnos;

-- punto 2
select 
    nombre,
    primerApellido as [Apellido Paterno],
    segundoApellido as [Apellido Materno],
    rfc,
    cuotaHora as [Cuaota Por Hora] 
from Instructores;
-- punto 3
select 
    clave,
    nombre,
    descripcion,
    horas
    from CatCursos;
-- punto 4
select
    top(5)
    id,
    CONCAT(nombre,primerApellido, segundoApellido) as [Nombre Completo],
    fechaNacimiento as Edad
    from Alumnos order by fechaNacimiento desc;

-- punto 5 
create database Ejercicios;
select * into Ejercicios.dbo.Alumnos from InstitutoTich.dbo.Alumnos;
select * into Ejercicios.dbo.Instructores from InstitutoTich.dbo.Instructores;

