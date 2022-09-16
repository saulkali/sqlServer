-- paso 1 --
-- realizar funcion que resiva dos parametros y realize la suma def(n1,n2):float = return n1+n2
create or alter function Suma(
    @numero1 float,
    @numero2 float
)
returns float
begin
    return @numero1 + @numero2
end

go


-- paso 2 --
-- obtener genero mediante curp
create or alter function ObtenerGenero(
    @curp varchar(18)
)
returns varchar(10)
begin
    declare @clave varchar(1)
    set @clave = substring(@curp,11,1)
    return iif(@clave like 'H','hombre','mujer')
end

go
-- paso 3 --
-- obtener fecha de nacimiento desde curp, donde deba identificar si pertenece al año 1900 o 2000
create or alter function ObtenerFechaNacimiento(
    @curp varchar(18)
)
returns date
begin
    declare @digitosCurpFecha varchar(6) set @digitosCurpFecha = substring(@curp,5,6)
    return cast(@digitosCurpFecha as date)
end

go

-- paso 4 --
-- obtener tabla del estado mediante la curp
create or alter function ObtenerIdEstado(
    @curp varchar(18)
)
returns int
begin
    declare @claveFederativa varchar(4) set @claveFederativa = SUBSTRING(@curp,12,2) 

    declare @idEst int select @idEst = Estados.id from Estados where Estados.clave = @claveFederativa;
    
    return @idEst
end
go
-- paso 5 --
--realizar function llamada calculadios donde resive 2 numero y el operador teniendo el cuidado de no dividir entre 0

create or alter function Calculadora(
    @numero1 decimal,
    @numero2 decimal,
    @operador varchar(1)
)
returns decimal
begin
    declare @resultado float set @resultado = 0
    return 
        case 
            when @operador = '*' then @numero1 * @numero2
            when @operador = '+' then @numero1 + @numero2
            when @operador = '-' then @numero1 - @numero2
            when @operador = '/' and @numero2 != 0 then @numero1 / @numero2
            when @operador = '%' and @numero2 != 0 then @numero1 % @numero2
            else @resultado
        end 
end

go

-- paso 6 --
-- Realizar una función llamada GetHonorarios que calcule el importe a pagar a un 
-- determinado instructor y curso, por lo que la función recibirá como parámetro el id 
-- del instructor y el id del curso.
create or alter function ObtenerHonorarios(
    @idInstructor smallint,
    @idCurso smallint
)
returns float 
begin
    declare @precio float
    select 
        @precio = Instructores.cuotaHora * CatCursos.horas
    from CursosInstructores
    inner join Instructores on idInstructor = Instructores.id
    inner join Cursos on CursosInstructores.idcurso =  Cursos.id 
    inner join CatCursos on Cursos.idCatCurso = CatCursos.id
    where Instructores.id = @idInstructor and CursosInstructores.idcurso = @idCurso
    return @precio
end 


go
-- paso 7 --
-- Crear la función GetEdad la cual reciba como parámetros la fecha de nacimiento y 
-- la fecha a la que se requiere realizar el cálculo de la edad. Los años deberán se 
-- cumplidos, considerando mes y día
create or alter function ObtenerEdad(
    @fechaNacimieto date,
    @fechaCalculo date
)
returns int 
begin 
    declare @edad int
    select @edad = (
        (
            ( 365 * year(@fechaCalculo))-(365*(year(@fechaNacimieto)))) + 
            (month(@fechaCalculo) - month(@fechaNacimieto)) * 30 +
            (day(@fechaCalculo) -  day(@fechaNacimieto))
        ) / 365
    return @edad
end
go 

-- paso 8 --
--Crear la función Factorial la cual reciba como parámetros un número entero y 
--regrese como resultado el factorial.
create or alter function Factorial(
    @numero float
)
returns float 
begin
    declare @resultado float set @resultado = 1
    while(@numero != 0) 
    begin
        set @resultado = @resultado * @numero
        set @numero = @numero - 1
    end
    return @resultado
end

go
-- paso 9 --
-- Crear la función ReembolsoQuincenal la cual reciba como parámetros un 
-- SueldoMensual y regrese como resultado el Importe de Reembolso quincenal, 
-- considerando que el importe total a reembolsar es igual a dos meses y medio de 
-- sueldo, y el periodo de reembolso es de 6 meses
create or alter function ReembolsoQuincenal(
    @sueldoMensual float 
)
returns float
begin 
    declare @reembolso float set @reembolso = @sueldoMensual * 2.5
    declare @quincenal float set @quincenal = (@reembolso / 12)
    return @quincenal
end 

go
-- paso 10 -- 
-- Realizar una función que calcule el impuesto que debe pagar un instructor para un 
-- determinado curso. De tal manera que la función recibirá id de un instructor y el id 
-- del curso correspondiente.
-- El cálculo del impuesto se realiza de la siguiente forma: 
-- Determinar el porcentaje que aplicará dependiendo del estado de nacimiento
--        Chiapas = 5 %
--        Sonora = 10 %
--        Veracruz = 7 %
--        El resto del país 8 %
-- El impuesto se obtendrá aplicando el porcentaje al total de la cuota por hora por la 
-- cantidad de horas del curso
-- El Estado de Origen se obtendrá de la posición 12 y 13 del curp de acuerdo con la 
-- siguiente tabla
create or alter function ImpuestosInstructores(
    @idInstructor smallint,
    @idCurso smallint
)
returns float 
begin
    declare @precio float
    declare @claveFederativa varchar(4)
    select 
        @claveFederativa = substring(Instructores.curp,12,2)
    from Instructores where Instructores.id = @idInstructor
    select 
        @precio = 
        case    
            when @claveFederativa = 'CS' then (Instructores.cuotaHora * CatCursos.horas ) + (Instructores.cuotaHora * CatCursos.horas) * 0.05
            when @claveFederativa = 'CR' then (Instructores.cuotaHora * CatCursos.horas ) + (Instructores.cuotaHora * CatCursos.horas) * 0.10
            when @claveFederativa = 'VZ' then  + (Instructores.cuotaHora * CatCursos.horas) * 0.07
            else (Instructores.cuotaHora * CatCursos.horas ) + (Instructores.cuotaHora * CatCursos.horas) * 0.08
        end
    from CursosInstructores
    inner join Instructores on idInstructor = Instructores.id
    inner join Cursos on @idCurso = Cursos.id
    inner join CatCursos on Cursos.idCatCurso = CatCursos.id
    where Instructores.id = @idInstructor and CursosInstructores.idcurso = @idCurso
    return @precio
end 

go
-- paso 11 --
-- Haciendo uso de la función GetEdad, obtener una relación de alumnos con la edad 
-- a la fecha de inscripción, y la edad actual. De aquellos alumnos que actualmente 
-- tengan más de 25 años.
select 
    fechaInscripcion,
    dbo.ObtenerEdad(fechaNacimiento,getdate()) as [Edad actual],
    dbo.ObtenerEdad(fechaNacimiento,fechaInscripcion) as [edad fecha inscripcion]
from CursosAlumnos
inner join Alumnos on idAlumno = Alumnos.id
where dbo.ObtenerEdad(fechaNacimiento,getdate()) > 25

go
-- paso 12 --
-- Realizar una función que determine el porcentaje a descontar en los reembolsos, 
-- con base a la cantidad de meses en que se realizará el reembolso y el sueldo 
-- mensual logrado, de acuerdo al siguiente procedimiento:
--       a. El porcentaje de descuento será en función de la cantidad de 
--          mensualidades en que se realizará el reembolso.
--       b. La cantidad máximo de meses para realizar el reembolso es de 6 meses
--       c. El porcentaje máximo de descuento a otorgar será el que resulte el sueldo 
--          mensual entre 1,000
--       i. Ejemplo : Si el sueldo mensual es de 20,000 pesos el descuento 
--          será del 20 %
--       d. El porcentaje máximo de descuento será otorgado si el reembolso total se 
--          realiza cuando le corresponde efectuar la primera parcialidad de dicho 
--          reembolso
--       e. Los porcentaje de descuento a otorgar disminuirá inversamente 
--          proporcional a la cantidad de meses en que se cubrirá totalmente el 
--          reembolso, de tal forma que si el reembolso se cubre en la mitad del 
--          periodo máximo (3 meses = 6 meses /2), el porcentaje a descontar será la 
--          mitad del porcentaje máximo ( en el ejemplo 10% = 20% / 2), y si el 
--          reembolso se realiza en el máximo del plazo, el descuento a otorgar será 
--          cero.
create or alter function DescuentoReembolso(
    @sueldo float,
    @meses int
)
returns float
begin
    declare @porcentajeSueldo float select @porcentajeSueldo = @sueldo/1000
    declare @descuento float set @descuento = 0

    select @descuento =
        case
            when @meses = 1 then  (@porcentajeSueldo * 1)
            when @meses = 2 then (@porcentajeSueldo * 0.75)
            when @meses = 3 then (@porcentajeSueldo * 0.50)
            when @meses = 4 then (@porcentajeSueldo * 0.25)
            else 0
        end 
    return @descuento
end

go
-- paso 13 --
-- Hacer una función que convierta a mayúsculas la primera letra de cada palabra de 
-- un cadena de caracteres recibida.
create or alter function ConviertePalabrasMayuscula(
    @texto varchar(100)
)
returns varchar(100)
begin
    declare @textoSinEspacios varchar(100) set @textoSinEspacios = trim(@texto)
    declare @isSpace int set @isSpace = 0
    declare @cadena varchar(100)
    declare @counter int set @counter = 1

    set @cadena = concat(@cadena,upper(substring(@textoSinEspacios,@counter,1))) 
    set @counter = @counter + 1
    while(@counter <= len(@textoSinEspacios))
    begin 
        declare @caracter varchar(1) set @caracter = substring(@textoSinEspacios,@counter,1)
        if(@isSpace = 1)
        begin
            set @caracter = upper(@caracter)
            set @isSpace = 0
        end 
            
        if(@caracter = ' ')
            set @isSpace = 1
        set @counter = @counter + 1 
        set @cadena = concat(@cadena, @caracter)
    end
    return @cadena
end    
