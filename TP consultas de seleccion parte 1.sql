-- Consulta
-- 1 - Listar todos los campos de todos los libros
select * from Libros

-- 2 - Listar todos los campos de todos los autores
select * from Autores

-- 3 - Listar el título y el año de publicación de todos los libros
select Titulo,Año from Libros

-- 4 - Listar todos los campos de todos los autores y una columna con el año de nacimiento.
Select *, Year(FechaNac) As [AñoNacimiento] From Autores
-- Select *, DATENAME(WEEKDAY, fechanac) as NombreMes From Autores

-- 5 - Listar el apellido, nombre, el sexo y el año de nacimiento de los autores
Select Apellidos,Nombres,Sexo,year(FechaNac) As AñoNacimiento from Autores

-- 6 - Listar todos los campos de todos los libros cuyas editoriales sean 1, 5 o 17
Select * From Libros Where IDEditorial = 1 Or IDEditorial = 2 Or IDEditorial = 3
Select * From Libros Where IDEditorial >= 1 and IDEditorial <= 3
Select * From Libros Where IDEditorial Between 1 and 3

-- 7 - Listar todos los campos de todos los libros cuyos idiomas sean 3 o 4
select * from libros where IDIdioma in (3,4)

-- 8 - Listar todos los campos de todos los libros cuyas editoriales no sean 4, 5 o 6
Select * From Libros Where IDEditorial Not In (4, 5, 6)

-- 9 - Listar todos los campos de todos los libros cuyos idiomas no sean 1, 2 o 3
Select * from Libros where IDIdioma not in(1,2,3)

-- 10 - Listar todos los campos de todos los libros cuyo precio sea mayor a $1000
Select * from Libros where Precio > 1000

-- 11 - Listar todos los campos de todos los libros cuyo precio se encuentre entre $1000 y $5000
Select * From Libros Where Precio Between 1000 and 5000

-- 12 - Listar todos los campos de todos los libros cuya cantidad de páginas sea menor a 500
Select * from Libros where Paginas < 500
-- 13 - Listar todos los campos de todos los libros cuyo título contenga 'Historia'
Select * From Libros Where Titulo like '%Historia%'
-- Obtiene todos los libros cuyo título contenga una comilla simple
Select * From Libros Where Titulo like '%''%'

-- Obtener sólo la fecha actual
Select Cast(getdate() as date) as FechaActual
select CONVERT(date,getdate()) as FechaActual

-- 14 - Listar todos los campos de todos los libros cuyo título contenga 'Rey'
select * from Libros where titulo like '%Rey%'

-- 15 - Listar las páginas de todos los libros cuyo título contenga 'Rey'
select paginas from Libros where titulo like '%Rey%'

-- 16 - Listar las páginas, sin duplicados, de todos los libros cuyo título contenga 'Rey'
Select distinct paginas from Libros where titulo like '%Rey%'

-- 17 - Listar todos los campos de todos los libros cuyo título contenga 'Economía'. Ver qué ocurre si se realiza la búsqueda con el término 'Economia'.
Select * from Libros where Titulo like '%Economía%'  
Select * from Libros where Titulo  COLLATE SQL_Latin1_General_Cp1_CI_AI like '%Economia%'  
-- 18 - Listar todos los campos de todos los libros que no posean Editorial.
Select * From Libros where IDEditorial IS NULL

-- 19 - Listar todos los campos de todos los libros que posean Editorial
Select * From Libros where IDEditorial IS NOT NULL

-- 20 - Listar todos los campos de todos los libros que no posean Editorial y que su precio sea mayor a $1000.
select * from libros where IDEditorial IS NOT NULL and precio > 1000

-- 21 - Listar el título, el año de publicación y el precio de los libros que cuesten más de $1000
select Titulo,Año,Precio from Libros where precio > 1000

-- 22 - Listar título y precio de los 5 libros más caros
select TOP 5 titulo,precio from Libros order by Precio desc

-- 23 - Listar título, precio y cantidad de páginas de los 5 libros más cortos
select TOP 5 Titulo,Precio,Paginas from Libros order by Paginas asc

-- 24 - Listar título, páginas e IDIdioma de los libros que no tengan idioma o tengan entre 280 y 300 páginas ordenados alfabéticamente
select titulo,paginas,IDIdioma from Libros where IDIdioma is NULL or paginas between 280 and 300 

-- 25 - Listar el nombre de aquellos géneros que comiencen con la palabra ‘Ciencia’ o ‘Fantasía’, o que contenga la palabra ‘para’
select nombre from Generos where nombre like 'Ciencia%' or nombre like 'Fantasía%' or nombre like '%para%'

-- 26 - Listar ordenadamente los distintos nombres que comienzan con J de los autores
select distinct nombres from Autores where nombres like 'J%'

-- 27 - Listar ordenadamente los diferentes años en los que nacieron los autores (sin repetir)
select distinct YEAR(FechaNac) As dintosAñosDeAutores from Autores
 
-- 28 - Listar el apellido, nombre y la descripción del sexo de los autores. Siendo 'Masculino' para 'M', 'Femenino' para 'F' y 'No especificado' para 'X'
select apellidos,nombres,
case
when sexo = 'M' then
'Masculino'
when sexo = 'F' then
'Femenino'
else
'No especificado'
end  As DescripcionSexo
 from Autores 


-- 29 - Listar el título de todos los libros y una columna llamada Longitud con la siguiente condición: "Corto" si la cantidad de páginas es < 200, "Normal" si la cantidad de páginas < 800, "Largo" si la cantidad de páginas < 1200, de lo contrario "Extenso".
Select Titulo, Paginas, 
    Case 
    When Paginas < 200 then 'Corto'
    When Paginas < 800 then 'Normal'
    When Paginas < 1200 then 'Largo'
    Else 'Extenso'
    End as 'Longitud'
From Libros
/* 
    Where Case 
    When Paginas < 200 then 'Corto'
    When Paginas < 800 then 'Normal'
    When Paginas < 1200 then 'Largo'
    Else 'Extenso' End = 'Corto'
*/

-- 30 - Listar todos los campos de todos los libros incluyendo el precio recalculado a partir de la siguiente condición. Descontar un 10% el precio a aquellos libros cuyo año de publicación sea menor a 1990.
Select *,
    Case
    When Año < 1990 Then Precio * 0.9
    Else Precio
    End As 'NuevoPrecio'
 From Libros

-- Claúsula UNION - Próxima clase

-- 31 - Listar todos los campos de todos los libros incluyendo el precio recalculado a partir de la siguiente condición. Aumentar un 30% el precio a aquellos libros cuya IDEditorial sea 5, 6 o 7.
select *,
case 
when IDEditorial in (5,6,7)then
precio+precio*0.3
else
precio
end AS NuevoPrecio
from Libros
-- 32 - Listar todos los campos de todos los autores y una columna adicional con la edad del mismo.
select *,
case
when MONTH(getdate()) >= MONTH(FechaNac) and DAY(getdate()) >= DAY(FechaNac) then
year(GETDATE())-year(FechaNac)
else
year(GETDATE())-year(FechaNac)-1
end As edad
from Autores

-- 33 - Listar los libros cuya publicación haya sido hace menos de 5 años.
Select * From Libros
Where Year(getdate()) - Año < 5

-- 34 - Listar los autores cuyo nacimiento haya ocurrido hace menos de 50 años.
Select * from Autores where year(GETDATE())-year(FechaNac) < 50

-- 35 - Listar todos los campos de todos los libros cuyo título comience con vocal
select * from Libros where Titulo like '[AEIOU]%'

-- 36 - Listar todos los campos de todos los libros cuyo título no finalice con vocal
select * from Libros where Titulo NOT like '%[AEIOU]%'

-- 37 - Listar todos los campos de todos los libros cuyo título contenga todas las vocales
--select * from Libros where Titulo  like  '%[A]%[E]%[I]%[O]%'
select * from Libros where Titulo  like '%A%' and Titulo  like '%E%' and Titulo  like '%I%' and Titulo  like '%O%' and Titulo  like '%U%'

-- 38 - Listar el apellido y nombres de todos los autores cuya edad sea entre 50 y 80 años
select Autores.Apellidos,Autores.Nombres,tabla_inventada.edad from Autores,(select ID, case when MONTH(getdate()) >= MONTH(FechaNac) and DAY(getdate()) >= DAY(FechaNac) then year(GETDATE())-year(FechaNac) else year(GETDATE())-year(FechaNac)-1 end As edad from Autores) as tabla_inventada
where Autores.ID = tabla_inventada.ID and tabla_inventada.edad between 50 and 80

-- 39 - Listar el apellido y nombres y la fecha de cumpleaños de cada autor. La misma debe ser mostrada en una sola columna de tipo varchar(5) con el siguiente formato "DIA/MES".
select apellidos,nombres,CONVERT(varchar(5),FechaNac,103) as FechaCumpleaños  from Autores
 
-- 40 - Listar todos los libros que se escribieron después del 1980, en IDIdioma 1 o 2 que la cantidad de páginas sea entre 500 y 1200, su precio menor a $2000 y que posea Editorial. Ordenarlos del más costoso al más barato.
select * from  Libros where Año > 1980 and (IDIdioma = 1 or IDIdioma = 2) and paginas between 500 and 1200 and precio < 2000 and IDEditorial is not null


