-- paso 1
select 
    id,
    upper(nombre),
    upper(primerApellido),
    upper(segundoApellido),
    fechaNacimiento,
    getdate() as [Hoy],
    DATEDIFF(MONTH,fechaNacimiento,getdate())/12 as [Edad],
    DATEDIFF(month,fechaNacimiento ,dateadd(month, 5 , getdate()))/12 as [Edad dentro de  5 meses]
from Alumnos;

--paso 2
select 
    id,
    nombre,
    primerApellido,
    segundoApellido,
    fechaNacimiento,
    curp,
    CONCAT('19',substring(curp,5,2),'-',substring(curp,7,2),'-',substring(curp,9,2)) as [Fecha Por Curp]
    
from Alumnos;

--paso 3
select
    *,
    iif(substring(curp,11,1)in ('M'),'Mujer','Hombre') 
from Alumnos;
--paso 4
select 
    id,
    nombre,
    primerApellido,
    segundoApellido,
    fechaNacimiento,
    correo,
    replace(correo,'gmail','hotmail') as [Correo Hotmail]
from Alumnos;