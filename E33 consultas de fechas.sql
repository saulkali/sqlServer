select * from Alumnos;
-- paso 1
select 
    id,
    nombre,
    primerApellido,
    segundoApellido,
    fechaNacimiento,
    getdate() as [Hoy],
    DATEDIFF(year,fechaNacimiento,getdate()) as [Edad],
    DATEDIFF(year,fechaNacimiento ,dateadd(month, 5 , getdate()))
    from Alumnos;
