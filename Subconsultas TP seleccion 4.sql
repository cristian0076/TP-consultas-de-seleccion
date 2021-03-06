/*1 Listar todos los datos de todos los libros cuya cantidad de páginas sea superior al
promedio.*/

Select * from Libros where Paginas >
(select AVG(L.Paginas*1.0) from Libros As L)
order by Paginas asc

/*2 Listar el nombre de todos los libros que tengan la valoración más baja.*/

select L.Titulo,LXB.Valoracion from Libros As L
inner join Libros_x_Biblioteca As LXB ON LXB.IDLibro = L.ID
where LXB.Valoracion = (select MIN(valoracion) from Libros_x_Biblioteca)


/*3 Listar el apellido y nombre de los autores y el título del libro de los registros cuyo
precio supere el doble del precio promedio.*/

select A.Apellidos+','+A.Nombres As Autor,L.Titulo,L.Precio from Autores As A
inner join Autores_x_Libro As AXL ON AXL.IDAutor = A.ID
inner join Libros As L ON L.ID = AXL.IDLibro 
where L.Precio > (select AVG(L.Precio)*2 FROM Libros As L)

/*4 Listar el apellido y nombre del usuario y el título del libro de quienes hayan pagado el
precio de libro a un valor mayor al cuádruple del precio promedio del sistema.*/

select AVG(L.Precio)*4 from Libros As L

select U.Apellidos+','+U.Nombres As Usuario,L.Titulo,LXB.Precio from Usuarios As U
inner join Bibliotecas As B ON U.ID = B.IDUsuario
inner join Libros_x_Biblioteca As LXB ON B.ID = LXB.IDBiblioteca
inner join Libros As L ON L.ID = LXB.IDLibro
where LXB.Precio > (select AVG(L.Precio)*4 from Libros As L)


/*5 Listar el apellido y nombre de los autores que no hayan escrito ningún libro.*/

select A.Apellidos,A.Nombres from Autores As A 
where A.ID not in (select distinct IDAutor from Autores_x_Libro)

/*6 Listar el nombre de todos los géneros de los cuales no haya libros escritos.*/


select G.Nombre from Generos As G 
where G.ID not in (
select distinct GXL.IDGenero from Generos_x_Libro As GXL)

/*7 Listar el nombre de todos los idiomas de los cuales no se poseen libros.*/

select * from Idiomas As I 
where I.ID not in (select DISTINCT L.IDIdioma from Libros As  L where L.IDIdioma is not null)


/*8 Listar el nombre de todas las editoriales de las cuales no se poseen libros.*/

select * from Editoriales As E
where E.ID	not in
(Select distinct L.IDEditorial from Libros As  L where L.IDEditorial is not null)

/*9 Listar los títulos y precios de todos los libros que sean más baratos que todos los
libros en idioma Inglés.*/ 

Select L.Titulo,L.Precio From Libros As L
where L.Precio < ALL (Select L.precio from Libros As L
inner join Idiomas As I ON I.ID = L.IDIdioma
where I.Nombre = 'Inglés')

/*10 Listar los títulos, precio, apellidos y nombres de los autores de libros que sean más
caros que todos los libros en idioma inglés.*/

Select L.titulo,L.Precio,A.Apellidos,A.Nombres from Autores As A
inner join Autores_x_Libro As AXL ON AXL.IDAutor = A.ID
inner join Libros As  L ON L.ID = AXL.IDLibro
where Precio > ALL 
(select Precio from Libros As L
inner join Idiomas As I ON I.ID = L.IDIdioma
where I.Nombre = 'Inglés'
)

/*11 Listar los títulos de los libros y cantidad de páginas de los libros que sean más
extensos que algún libro de la editorial Plaza y Janés.*/

select L.titulo,L.Paginas from Libros As L
where L.Paginas > ANY (select Paginas from Libros As L
inner join Editoriales As E ON E.ID = L.IDEditorial
where E.Nombre = 'Plaza y Janés'
)
ORDER BY L.Paginas ASC

/*12 Listar por cada libro el título y la cantidad de veces que fueron agregados a una
biblioteca en medio digital y la cantidad de veces que fueron agregados a una
biblioteca en medio físico.
NOTA:
Medio digital → El valor del campo Medio es 'D'
Medio físico → El valor del campo Medio es 'F'*/


Select lib.Titulo,
(select COUNT(F.Medio)As Digital from Libros As L
inner join Libros_x_Biblioteca As LXB ON LXB.IDLibro = L.ID
inner join Formatos As F on F.ID = LXB.IDFormato
where F.Medio = 'D' and lib.ID = l.ID) As Digital
,
(select COUNT(F.Medio)As Digital from Libros As L
inner join Libros_x_Biblioteca As LXB ON LXB.IDLibro = L.ID
inner join Formatos As F on F.ID = LXB.IDFormato
where F.Medio = 'F' and lib.ID = l.ID) As Fisico
FROM Libros AS Lib

/*Esta es otra posibilidad*/
select L.Titulo,F.Medio,COUNT(F.Medio) from Libros As L
inner join Libros_x_Biblioteca As LXB ON LXB.IDLibro = L.ID
inner join Formatos As F on F.ID = LXB.IDFormato
Group by L.Titulo,F.Medio

/*13 Listar por cada país el nombre y la cantidad de autores de sexo masculino y la
cantidad de autores de sexo femenino.*/

SELECT P.Nombre,
(select COUNT(A.Sexo) from Autores As A
where A.Sexo = 'M' and P.ID = A.IDPais)As Masculinos 
,
(select COUNT(A.Sexo) from Autores As A
where A.Sexo = 'F' and P.ID = A.IDPais)As Femeninos

from Paises As P

/*14 Listar por cada usuario los nombres y apellidos, la cantidad de libros en formato
digital y la cantidad de libros en formato físico.*/

Select U.Nombres,U.Apellidos,
(select COUNT(F.Medio)As Digital from Libros As L
inner join Libros_x_Biblioteca As LXB ON LXB.IDLibro = L.ID
inner join Formatos As F on F.ID = LXB.IDFormato
inner join Bibliotecas As B ON B.ID = LXB.IDbiblioteca
where F.Medio = 'D' and B.IDUsuario = U.ID ) As Digital
,
(select COUNT(F.Medio)As Digital from Libros As L
inner join Libros_x_Biblioteca As LXB ON LXB.IDLibro = L.ID
inner join Formatos As F on F.ID = LXB.IDFormato
inner join Bibliotecas As B ON B.ID = LXB.IDbiblioteca
where F.Medio = 'F' and B.IDUsuario = U.ID ) As Fisico
 FROM Usuarios As U

/*15 Listar por cada autor el apellido y nombre y la cantidad de libros de su autoría en
idioma Inglés y la cantidad de libros de su autoría en idioma Español.*/
Select Aut.apellidos,Aut.nombres,

(select COUNT(L.ID) from Libros As L
inner join Autores_x_Libro As AXL ON AXL.IDLibro = L.ID
inner join Autores As A ON A.ID = AXL.IDAutor
inner join Idiomas As I ON I.ID = L.IDIdioma
where I.Nombre = 'Inglés' and Aut.ID = axl.IDAutor)As Ingles,


(select COUNT(L.ID) from Libros As L
inner join Autores_x_Libro As AXL ON AXL.IDLibro = L.ID
inner join Autores As A ON A.ID = AXL.IDAutor
inner join Idiomas As I ON I.ID = L.IDIdioma
where I.Nombre = 'Español' and Aut.ID = axl.IDAutor) As Español

from Autores As Aut
/*16 Por cada género listar el nombre y el promedio de precio de los libros escritos antes
a 1990 y el promedio de precio de los libros escritos después a 1990.*/

SELECT G.Nombre,

(select AVG(L.precio) From Libros As L 
inner join Generos_x_Libro As GXL ON GXL.IDLibro = L.ID
where L.Año < 1990 and GXL.IDGenero = G.ID) As ANT1990
,
(select AVG(L.precio) From Libros As L 
inner join Generos_x_Libro As GXL ON GXL.IDLibro = L.ID
where L.Año > 1990 and GXL.IDGenero = G.ID) As DES1990

 FROM Generos As G




select AVG(L.precio) From Libros As L 
where L.Año < 1990

select AVG(L.precio) From Libros As L 
where L.Año > 1990

/*17 Listar los títulos de los libros que hayan registrado más libros en medios digitales
que en medios físicos.*/

select X,Digital,fisico	
From
(select L.titulo As X,

(select COUNT(F.Medio) from Libros_x_Biblioteca As LXB
inner join Formatos As F ON F.ID = LXB.IDFormato
where F.Medio = 'D' and L.ID=LXB.IDLibro) As Digital
,
(select COUNT(F.Medio) from Libros_x_Biblioteca As LXB
inner join Formatos As F ON F.ID = LXB.IDFormato
where F.Medio = 'F' and L.ID=LXB.IDLibro) As Fisico

 from Libros As  L)As VirtualTable
where Digital > Fisico


/*18 Listar los títulos de los libros que hayan registrado la misma cantidad de medios
digitales que físicos pero que al menos hayan registrado por lo menos algún medio.*/

select X,Digital,fisico	
From
(select L.titulo As X,

(select COUNT(F.Medio) from Libros_x_Biblioteca As LXB
inner join Formatos As F ON F.ID = LXB.IDFormato
where F.Medio = 'D' and L.ID=LXB.IDLibro) As Digital
,
(select COUNT(F.Medio) from Libros_x_Biblioteca As LXB
inner join Formatos As F ON F.ID = LXB.IDFormato
where F.Medio = 'F' and L.ID=LXB.IDLibro) As Fisico

 from Libros As  L)As VirtualTable
where Digital = Fisico and (Digital > 0 or Fisico > 0)

/*19 Listar los países que registren más de un autor de sexo masculino y más de una
autora de sexo femenino.*/

select * from
(SELECT P.Nombre,
(select COUNT(A.Sexo) from Autores As A
where A.Sexo = 'M' and P.ID = A.IDPais)As Masculinos 
,
(select COUNT(A.Sexo) from Autores As A
where A.Sexo = 'F' and P.ID = A.IDPais)As Femeninos

from Paises As P)As t
where Femeninos > 0 and Masculinos > 0

/*20 Listar la cantidad de países que no registren autoras de sexo femenino.*/

select count(*) As Cantidad from
(SELECT P.Nombre,
(select COUNT(A.Sexo) from Autores As A
where A.Sexo = 'M' and P.ID = A.IDPais)As Masculinos 
,
(select COUNT(A.Sexo) from Autores As A
where A.Sexo = 'F' and P.ID = A.IDPais)As Femeninos

from Paises As P)As t
where Femeninos = 0


/*21 Listar los apellidos de los autores que hayan escrito más libros en Español que en
Inglés pero que hayan escrito al menos un libro en Inglés.*/


SELECT Ap,N FROM

(Select Aut.apellidos As Ap,Aut.nombres As N,

(select COUNT(L.ID) from Libros As L
inner join Autores_x_Libro As AXL ON AXL.IDLibro = L.ID
inner join Autores As A ON A.ID = AXL.IDAutor
inner join Idiomas As I ON I.ID = L.IDIdioma
where I.Nombre = 'Inglés' and Aut.ID = axl.IDAutor)As Ingles,


(select COUNT(L.ID) from Libros As L
inner join Autores_x_Libro As AXL ON AXL.IDLibro = L.ID
inner join Autores As A ON A.ID = AXL.IDAutor
inner join Idiomas As I ON I.ID = L.IDIdioma
where I.Nombre = 'Español' and Aut.ID = axl.IDAutor) As Español

from Autores As Aut
) As T

where (Español > Ingles) and Ingles > 0