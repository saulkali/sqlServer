select dbo.Suma(2,2);
select dbo.ObtenerGenero('JCMA980909HDGRRL00');
select dbo.ObtenerGenero('MBSO980909MDGRRL0U');
select dbo.ObtenerFechaNacimiento('JCMA980909HDGRRL00');
select dbo.Calculadora(100,10,'%')
print datediff()

select dbo.ObtenerIdEstado('JCMA980909HDGRRL00');
select * from Estados;

select dbo.ObtenerHonorarios(2,1);

select dbo.ObtenerEdad('1998-09-09','2022-09-09')

select dbo.Factorial(4)
select dbo.ReembolsoQuincenal(20000)

select dbo.ImpuestosInstructores(2,1)


select dbo.ConviertePalabrasMayuscula('    este es otro parrafo     encargado');

select dbo.DescuentoReembolso(22000,2)