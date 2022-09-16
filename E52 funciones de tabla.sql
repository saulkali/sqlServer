-- paso 1 --
-- Hacer una función valuada en tabla que obtenga la tabla de amortización de los 
-- Reembolsos quincenales que un participante tiene que realizar en 6 meses
create or alter function CalculoReembolsoQuincenal(
    @sueldo decimal(9,2)
)
returns @tablaPagos table  (
    Quincena int identity(1,1),
    saldoAnterior decimal(9,2),
    pagoQuincenal decimal(9,2),
    saldoNuevo decimal(9,2)
)
begin
    declare @contador int set @contador = 1
    declare @pagosQuin decimal(9,2) set @pagosQuin = @sueldo / 12
    declare @salAnterior decimal(9,2) set @salAnterior = @sueldo
    declare @salNuevo decimal(9,2) set @salNuevo = @salAnterior - @pagosQuin

    while(@contador <= 12)
    begin
        insert into @tablaPagos 
            select 
                @salAnterior as saldoAnterior,
                @pagosQuin as pagoQuincenal,
                @salNuevo as saldoNuevo
        set @contador = @contador +1
        set @salAnterior = @salNuevo
        set @salNuevo = @salAnterior - @pagosQuin
    end
    return
end

go 

-- paso 2 --
-- Hacer una función valuada en tabla que obtenga la tabla de amortización de los 
-- préstamos posibles que se le pueden hacer a un instructor. 
-- La función recibirá como parámetro el id del instructor 
-- El importe del préstamo será 200 veces la cuota por hora
-- El porcentaje de interés será el 24% anual cuando la cuota por hora sea superior a 
-- 200
-- Para el resto será de 18%
-- El pago mensual será el equivalente a 25 horas
create or alter function PrestamosInstructores(
    @idInstructor int 
)
returns @tablaPrestamos table(
    mes int identity(1,1),
    saldoAnterior decimal(9,2),
    intereses decimal(9,2),
    pagoMensual decimal(9,2),
    saldoNuevo decimal(9,2)
)
begin
    declare @cuotaHora decimal(9,2) 
    select @cuotaHora = cuotaHora  
    from Instructores where id = @idInstructor

    declare @prestamo decimal(9,2) 
    set @prestamo = @cuotaHora * 200

    declare @pagoMensual decimal(9,2) 
    set @pagoMensual = @cuotaHora * 25

    declare @salAnterior decimal(9,2) set @salAnterior = 1
    declare @intereses decimal(9,2) set @intereses = 0

    while(@salAnterior > 0)
    begin 
        set @intereses = iif(@cuotaHora > 200,(@prestamo * 0.24/12),(@prestamo * 0.18/12))
        if(@prestamo<@pagoMensual)
            set @pagoMensual = @prestamo + @intereses
        set @salAnterior = @prestamo - (@pagoMensual - @intereses)
        insert into @tablaPrestamos 
        select 
            @prestamo as saldoAnterior,
            @intereses as intereses,
            @pagoMensual as pagoMensual,
            @salAnterior as saldoNuevo
        set @prestamo = @salAnterior
    end
    return
end 

go 
select * from PrestamosInstructores(2);
select * from Instructores where id = 1;