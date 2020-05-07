
/* 1 Listar la cantidad de usuarios.*/

select COUNT(*)As cantUsuarios from Usuarios

/* 2 Listar la cantidad de usuarios cuyo tipo de usuario sea 'Librarian'.*/

select COUNT(*) As cantUserLibrarian from Usuarios As U
inner join TiposUsuarios As T ON T.ID = U.IDTipo
where T.Nombre = 'Librarian'

/* 3 Listar la cantidad de libros en inglés.*/

select COUNT(*) As CantLibrosEnIngles from Libros As L
inner join Idiomas As I ON I.ID = L.IDIdioma
WHERE I.Nombre = 'Ingles'

/* 4 Listar la cantidad de libros con editorial.*/

select  COUNT(*) As CantLibrosConEditorial from Libros As L 
inner join Editoriales As E ON E.ID = L.IDEditorial


/* 5 Listar la cantidad de libros sin editorial.*/

select  COUNT(*) As CantLibrosSinEditorial from Libros As L 
left join  Editoriales As E ON E.ID = L.IDEditorial
where L.IDEditorial is null

/* 6 Listar la cantidad de autores de género masculino y nacidos en Argentina.*/

select COUNT(*)As cantAutoresArgYmasc from Autores As A
inner join Paises As P ON P.ID = A.IDPais
where A.Sexo = 'M' and P.Nombre = 'Argentina'

/* 7 Listar el promedio de edad de las autoras de género femenino.*/

select 
AVG(
case
when MONTH(A.FechaNac) > = MONTH(GETDATE()) and DAY(A.FechaNac) > = DAY(GETDATE())THEN
YEAR(GETDATE())-YEAR(FechaNac)-1
else 
YEAR(GETDATE())-YEAR(FechaNac)
end *1.0)As Edad
 from Autores As A

where A.Sexo = 'F'


/* 8 Listar el promedio de edad de los usuarios cuyo tipo de usuario sea 'Free'*/

select 
AVG(
case
when MONTH(U.FechaNac) > = MONTH(GETDATE()) and DAY(U.FechaNac) > = DAY(GETDATE())THEN
YEAR(GETDATE())-YEAR(U.FechaNac)-1
else 
YEAR(GETDATE())-YEAR(U.FechaNac)
end *1.0)As Edad
 from Usuarios As U
inner join TiposUsuarios As T ON T.ID = U.IDTipo
where T.Nombre = 'Free' 


/* 9 Listar el promedio de páginas de los libros publicados en la década del 90*/

select AVG(L.Paginas*1.0) from Libros As L
WHERE L.Año between 1990 and 1999

/* 10 Listar el precio total de todos los libros de la editorial DeBolsillo*/

select SUM(Precio) As precioTotalDeBolsillo from Libros As L 
inner join Editoriales As E ON E.ID = L.IDEditorial
where E.Nombre = 'DeBolsillo'

/* 11 Listar la cantidad total de páginas de los libros de Stephen King*/

select  SUM(L.Paginas) from  Autores As A
inner join Autores_x_Libro As AXL ON AXL.IDAutor = A.ID
inner join Libros As L ON AXL.IDLibro = L.ID
where A.Apellidos ='King' and A.Nombres = 'Stephen'

/* 12 Listar la cantidad máxima de páginas entre todos los libros*/

Select Max(paginas) from Libros

/* 13 Listar la cantidad mínima de páginas entre todos los libros*/

Select MIN(Paginas) from Libros

/* 14 Listar la cantidad máxima de páginas de los libros de Stephen King*/

select  MAX(L.Paginas) from  Autores As A
inner join Autores_x_Libro As AXL ON AXL.IDAutor = A.ID
inner join Libros As L ON AXL.IDLibro = L.ID
where A.Apellidos ='King' and A.Nombres = 'Stephen'

/* 15 Listar el precio mínimo de los libros en Español.*/

select MIN(L.Precio) As PrecioMinLibrosESP from Libros As L 
inner join Idiomas As I ON I.ID = L.IDIdioma
where I.Nombre = 'Español'

/* 16 Listar la cantidad de libros distintos que se terminaron de leer en el año 1991.*/

select   COUNT(distinct(L.titulo)) from Libros As L
inner join Libros_x_Biblioteca As LXB ON LXB.IDLibro = L.ID
inner join Bibliotecas As B ON B.ID = LXB.IDBiblioteca
where YEAR(LXB.Fin) = 1991 

/* 17 Por cada usuario, listar apellido y nombres y la cantidad de bibliotecas que crearon.
Listar información sólo de los usuarios que crearon bibliotecas.*/

select U.Nombres+','+U.Apellidos As Usuarios,COUNT(*) As CantidadDeBibliotecas from Usuarios As U
inner join Bibliotecas As B ON B.IDUsuario = U.ID
GROUP BY U.Nombres+','+U.Apellidos

/* 18 Por cada usuario, listar apellido y nombres y la cantidad de bibliotecas que crearon.
Listar información de todos los usuarios. Si no crearon bibliotecas listarlos
contabilizando 0 bibliotecas. Ordenar el listado por apellido de manera creciente.*/

select U.Apellidos+','+U.Nombres As Usuario,COUNT(B.Nombre) As CantidadDeBibliotecas from Usuarios As U
left join Bibliotecas As B ON B.IDUsuario = U.ID
group by  U.Apellidos+','+U.Nombres

/* 19 Por cada biblioteca, listar el apellido y nombre del usuario, el nombre de la biblioteca
y la cantidad de libros registrados.*/

Select  U.Apellidos+','+U.Nombres As Usuario,B.Nombre As Biblioteca, COUNT(L.ID) As CantLibros  from  Libros As L 
inner join Libros_x_Biblioteca As LXB ON LXB.IDLibro = L.ID
inner join Bibliotecas As B ON B.ID = LXB.IDBiblioteca
inner join Usuarios As U ON U.ID = B.IDUsuario
group by U.Apellidos+','+U.Nombres,B.Nombre

/* 20 Por cada formato, listar el nombre del formato y la cantidad de libros distintos
asociados.*/

select F.Nombre As Formato,COUNT(DISTINCT(LXB.IDLibro)) from Libros_x_Biblioteca As LXB
inner join Formatos As F ON LXB.IDFormato = F.ID
group by F.Nombre

/* 21 Por cada usuario, listar el apellido y nombre del usuario, el nombre de los libros que
registró en sus bibliotecas y cuántas veces registró dichos libros. Ordenarlo de
manera decreciente por cantidad.*/

select U.Apellidos+','+U.Nombres As Usuario,L.Titulo,COUNT(L.Titulo)  from Usuarios As U
inner join Bibliotecas As B ON B.IDUsuario = U.ID
inner join Libros_x_Biblioteca As LXB ON LXB.IDBiblioteca = B.ID
inner join Libros As L ON L.ID = LXB.IDLibro
GROUP BY U.Apellidos+','+U.Nombres,L.Titulo
order by COUNT(l.Titulo) DESC


/* 22 Por cada autor, listar el precio de libro más caro que haya publicado. Listar apellido y
nombres y precio de los libros. Ordenarlo en forma decreciente por cantidad.*/

select A.Apellidos+','+A.Nombres As Autor, MAX(L.Precio)As PrecioMaximo from Autores As A
inner join Autores_x_Libro As AXL ON AXL.IDAutor = A.ID
inner join Libros As L ON L.ID = AXL.IDLibro
Group by A.Apellidos+','+A.Nombres
ORDER BY PrecioMaximo DESC

/* 23 Igual al anterior pero incluir a los autores que no editaron libros.*/

--no lo entendi

/* 24 Por cada autor listar el apellido y nombres y la cantidad de veces que sus libros
fueron agregado a bibliotecas.*/

select A.Apellidos+','+A.Nombres As Autor,COUNT(L.Titulo) As cant from Autores As A
inner join Autores_x_Libro As AXL ON AXL.IDAutor = A.ID
inner join Libros As L ON L.ID = AXL.IDLibro
inner join Libros_x_Biblioteca As LXB ON LXB.IDLibro = L.ID
inner join Bibliotecas As B ON B.ID = LXB.IDBiblioteca
GROUP BY A.Apellidos+','+A.Nombres 
ORDER BY 2 desc

/* 25 Por cada autor listar el apellido y nombres y el promedio de valoración otorgado por
los usuarios de sus libros. Ordenar por mejor promedio de valoración a peor.*/

select A.Apellidos+','+A.Nombres As Autor,AVG(LXB.Valoracion *1.0) As promedioValoracion from Autores As A
inner join Autores_x_Libro As AXL ON AXL.IDAutor = A.ID
inner join Libros As L ON L.ID = AXL.IDLibro
inner join Libros_x_Biblioteca As LXB ON LXB.IDLibro = L.ID
GROUP BY A.Apellidos+','+A.Nombres
order by 2 desc


/* 26 Por cada usuario listar el apellido y nombres y el costo total abonado en concepto
de libros. Utilizar el precio del libro que indicó en Libros_x_Biblioteca. Mostrar
información de los usuarios que no hayan registrado libros con un total de $0.
Ordenar de menor a mayor por total abonado.*/

select U.Apellidos,U.Nombres,ISNULL(SUM(LXB.Precio),0) As GastosEnLibros from Usuarios As  U 
left  join  Bibliotecas As  B ON B.IDUsuario = U.ID
left join Libros_x_Biblioteca As LXB ON LXB.IDBiblioteca = B.ID
left  join Libros As L ON L.ID = LXB.IDLibro
group by U.Apellidos,U.Nombres
order by GastosEnLibros asc

/* 27 Por cada usuario listar el apellido y nombres y el costo total en concepto de libros si
hubiesen comprado dichos libros al precio que figura en el sistema. Utilizar el precio
del libro que se indica en Libros. Mostrar información de los usuarios que no hayan
registrado libros con un total de $0.*/

select U.Apellidos,U.Nombres,ISNULL(SUM(L.Precio),0) As GastosEnLibros from Usuarios As  U 
left join  Bibliotecas As  B ON B.IDUsuario = U.ID
left join Libros_x_Biblioteca As LXB ON LXB.IDBiblioteca = B.ID
left  join Libros As L ON L.ID = LXB.IDLibro
group by U.Apellidos,U.Nombres
order by GastosEnLibros asc

/* 28 Por cada autor listar el apellido y nombre y la cantidad de veces que sus libros
fueron agregado a bibliotecas. Sólo listar aquellos autores que hayan contabilizado
5 o más libros agregados a bibliotecas.*/

select A.Apellidos+','+A.Nombres As Autor,COUNT(L.Titulo)As cantLibros from Autores As A
inner join  Autores_x_Libro As AXL ON AXL.IDAutor = A.ID
inner join Libros As  L ON L.ID = AXL.IDLibro
inner join Libros_x_Biblioteca As LXB ON LXB.IDLibro = L.ID
group by A.Apellidos+','+A.Nombres
having COUNT(L.Titulo) > = 5
order by cantLibros desc


/* 29 Por cada autor listar el apellido y nombres y el promedio de valoración otorgado por
los usuarios de sus libros. Sólo listar aquellos autores que hayan registrado más de
10 votaciones.*/

select A.Apellidos+','+A.Nombres As Autor,AVG(LXB.Valoracion *1.0) As promedioValoracion,COUNT(LXB.Valoracion) As CantValoraciones from Autores As A
inner join Autores_x_Libro As AXL ON AXL.IDAutor = A.ID
inner join Libros As L ON L.ID = AXL.IDLibro
inner join Libros_x_Biblioteca As LXB ON LXB.IDLibro = L.ID
GROUP BY A.Apellidos+','+A.Nombres
having COUNT(LXB.Valoracion) > 10
order by 2 desc

/* 30 Listar el apellido y nombres de los usuarios que registren más de tres bibliotecas.*/

Select U.Apellidos,U.Nombres,COUNT(B.ID)As CantBibliotecas from Usuarios As U
inner join Bibliotecas As B ON B.IDUsuario = U.ID
GROUP BY U.Apellidos,U.Nombres
having COUNT(B.ID) > 3

/* 31 Listar los nombres de los países que tengan exactamente tres autores relacionados.*/

select P.Nombre As Pais from Autores As A
inner join Paises As P ON P.ID = A.IDPais
group by P.Nombre
having COUNT(A.Nombres) = 3

/* 32 Listar el apellido y nombre de los usuarios de aquellos que hayan pagado (en total)
menos por el costo de sus libros que si los hubiesen comprado al costo del sistema.*/

select U.Apellidos,U.Nombres,ISNULL(SUM(LXB.Precio),0)As PagoReal,ISNULL(SUM(L.Precio),0) As PagoAlPrecioDeSistema from Usuarios As  U 
left  join  Bibliotecas As  B ON B.IDUsuario = U.ID
left join Libros_x_Biblioteca As LXB ON LXB.IDBiblioteca = B.ID
left  join Libros As L ON L.ID = LXB.IDLibro
group by U.Apellidos,U.Nombres
having ISNULL(SUM(LXB.Precio),0) < ISNULL(SUM(L.Precio),0)
