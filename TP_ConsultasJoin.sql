/*1 Listar para cada autor el Apellido y el Nombre, el sexo, el IDPais y el nombre del pa�s.*/

select A.Apellidos,A.Nombres,A.Sexo,A.IDPais,P.Nombre As Pais from Autores As A
inner join Paises As P ON P.ID = A.IDPais

/*2 Listar para cada usuario el Apellido y nombre, el sexo, la edad, la cantidad de d�as
desde que se registr�, el nombre del pa�s de nacimiento y el nombre del tipo de
usuario.*/

Select u.ID,U.Apellidos +','+U.Nombres,U.Sexo,
case
when MONTH(U.FechaNac) >= MONTH(GETDATE()) and DAY(U.FechaNac) >= DAY(GETDATE())then
YEAR(GETDATE())-YEAR(U.FechaNac)
else
(YEAR(GETDATE())-YEAR(U.FechaNac))-1
end As Edad,
DATEDIFF(DAY,U.FechaReg,GETDATE()) As DiasTranscurridos,
P.Nombre As Pais,T.Nombre As TipoUser
from Usuarios As U
inner join Paises As P ON P.ID = U.IDPais
inner join TiposUsuarios As T ON T.ID = U.IDTipo

/*3 Listar para cada libro el t�tulo, la cantidad de p�ginas, el precio y el nombre de la
editorial. S�lo listar los libros que posean editorial registrada.*/

select L.Titulo,L.Paginas,L.Precio,E.nombre As Editorial from Libros As L
inner join Editoriales As E ON E.ID = L.IDEditorial

/*4 Listar para cada libro el t�tulo, la cantidad de p�ginas, el precio y el nombre de la
editorial. Listar todos los libros independientemente de si disponen editorial.*/

select L.Titulo,L.Paginas,L.Precio,E.nombre As Editorial from Libros As L
left join Editoriales As E ON E.ID = L.IDEditorial

/*5 Listar para cada libro el t�tulo, la cantidad de p�ginas, el precio y el nombre de la
editorial. Listar todas las editoriales independientemente de si disponen libros.*/

select L.Titulo,L.Paginas,L.Precio,E.nombre As Editorial from Libros As L
right join Editoriales As E ON E.ID = L.IDEditorial

/*6 Listar para cada libro el t�tulo, el a�o, el precio, la cantidad de p�ginas y el nombre de
los g�neros asociados al libro.*/

select L.Titulo,L.A�o,L.Precio,L.Paginas,G.Nombre As Genero from Libros As L 
inner join Generos_x_Libro AS GXL ON  L.ID = GXL.IDLibro
inner join Generos As G ON G.ID = GXL.IDGenero

/*7 Listar para cada libro el t�tulo, el a�o, el apellido y nombre del autor y el nombre del
pa�s del autor.*/

select L.Titulo, L.A�o,A.Apellidos+','+A.Nombres,P.Nombre As PaisAutor from Libros As L
inner join Autores_x_Libro AS AXL ON AXL.IDLibro = L.ID
inner join Autores As A ON A.ID = AXL.IDAutor
inner join Paises As P ON P.ID = A.IDPais

/*8 Listar para cada usuario el apellido y nombres, el email, el tipo de usuario y el
nombre del pa�s, el sexo ('M' - Masculino, 'F' - Femenino, 'X' - Otro g�nero), la edad y
la cantidad de d�as transcurridos desde la registraci�n.*/

Select U.Apellidos+',' +U.Nombres As Usuario, U.Email,T.Nombre As TipoUser,P.Nombre,
case
when U.Sexo = 'M' then
'Masculino'
when U.Sexo = 'F' then
'Femenino'
when U.Sexo = 'X' then
'Otro genero'
else
'-'
end As Sexo,
case
when MONTH(U.FechaNac) >= MONTH(GETDATE()) and DAY(U.FechaNac) >= DAY(GETDATE())then
YEAR(GETDATE())-YEAR(U.FechaNac)
else
(YEAR(GETDATE())-YEAR(U.FechaNac))-1
end As Edad,DATEDIFF(DAY,U.FechaReg,GETDATE()) As DiasTranscurridos
 from Usuarios As U 
inner join TiposUsuarios As T ON T.ID = U.IDTipo
inner join Paises As P ON P.ID = U.IDPais

/*9 Listar para cada usuario el apellido y nombres y el nombre de sus bibliotecas.
Solamente los usuarios que se hayan registrado hace menos de 1000 d�as.*/

Select U.Apellidos,U.Nombres, B.Nombre As Biblioteca from Usuarios As U
inner join Bibliotecas As B ON U.ID = B.IDUsuario
where DATEDIFF(DAY,U.FechaReg,GETDATE()) < 1000

/*10 Listar el t�tulo del libro, el nombre del formato, la valoraci�n, la conservaci�n, la
fecha de adquisici�n, el precio, el nombre de la biblioteca de los usuarios cuyo tipo
de usuario sea 'Bibliotecarian'.*/

Select U.Apellidos,L.Titulo,F.Nombre As Formato, LXB.Valoracion,LXB.Conservacion,LXB.Adquisicion,L.Precio,B.Nombre As biblioteca  from Libros As L
inner join Libros_x_Biblioteca As LXB ON LXB.IDLibro = L.ID
inner join Bibliotecas As B ON B.ID = LXB.IDBiblioteca 
inner join Formatos As F ON LXB.IDFormato = F.ID
inner join Usuarios As U ON U.ID = B.IDUsuario
inner join TiposUsuarios As T ON U.IDTipo = T.ID
where U.IDTipo = 4

/*11 Listar apellido y nombres, el t�tulo del libro y la cantidad de d�as que demor� el
usuario en leerlo. S�lo aquellos que hayan finalizado la lectura.*/

Select U.Apellidos,U.Nombres,L.Titulo,DATEDIFF(DAY,LXB.Inicio,LXB.Fin)  from Libros As L
inner join Libros_x_Biblioteca As LXB ON LXB.IDLibro = L.ID
inner join Bibliotecas As B ON B.ID = LXB.IDBiblioteca
inner join Usuarios As U ON U.ID = B.IDUsuario
where LXB.Fin is not null

/*12 Listar el apellido y nombres sin repeticiones de los usuarios que registren al menos
un libro en formato 'EPUB'.*/

Select DISTINCT U.Apellidos,U.Nombres from Libros As L
inner join Libros_x_Biblioteca As LXB ON LXB.IDLibro = L.ID
inner join Bibliotecas As B ON B.ID = LXB.IDBiblioteca
inner join Formatos As F ON F.ID = LXB.IDFormato
inner join Usuarios As U ON U.ID = B.IDUsuario
where F.Nombre = 'EPUB' 

/*13 Listar el apellido y nombres de los usuarios y apellido y nombre de los autores cuyos
libros el usuario haya finalizado la lectura. No repetir la combinaci�n de datos de
usuario y autores.*/

select distinct U.Apellidos+','+U.Nombres As Usuario ,A.Apellidos+','+A.Nombres As Autor from Libros As L
inner join Libros_x_Biblioteca AS LXB ON LXB.IDLibro = L.ID
inner join Bibliotecas As B ON B.ID = LXB.IDBiblioteca
inner join Autores_x_Libro As AXL ON AXL.IDLibro = L.ID
inner join Autores As A ON A.ID = AXL.IDAutor
inner join Usuarios As U ON U.ID = B.IDUsuario
where LXB.Fin IS NOT NULL

/*14 Listar apellido y nombres de los usuarios que no posean bibliotecas.*/
select U.Apellidos,U.Nombres from Libros_x_Biblioteca As LXB
inner join Bibliotecas As B ON LXB.IDBiblioteca = B.ID
right join Usuarios As U ON U.ID = B.IDUsuario
where B.Nombre is null 

/*15 Listar apellido y nombres de los usuarios que tengan alg�n libro sin terminar de leer.
No repetir combinaci�n de apellido y nombres.*/

Select distinct U.Apellidos,U.Nombres from Libros As L
inner join Libros_x_Biblioteca As LXB ON LXB.IDLibro = L.ID
inner join Bibliotecas As B ON B.ID = LXB.IDBiblioteca
inner join Usuarios As U ON U.ID = B.IDUsuario
where LXB.Fin is null

/*16 Listar apellido y nombres de los autores que hayan recibido alguna calificaci�n de
8,00 o m�s en alguno de sus libros. No repetir combinaci�n de apellido y nombres.*/

select distinct A.Nombres+','+A.Apellidos As Autores from Autores As A
inner join Autores_x_Libro As AXL ON A.ID = AXL.IDAutor
inner join Libros As L ON L.ID = AXL.IDLibro
inner join Libros_x_Biblioteca As LXB ON LXB.IDLibro = L.ID
where LXB.Valoracion >= 8

/*17 Listar para cada autor el apellido y nombres y los nombres de los g�neros de los
libros que dicho autor escribi�. No repetir el mismo g�nero para el mismo autor.*/

select distinct A.Apellidos+','+A.Nombres As Autores, G.Nombre As Genero from Libros L
inner join Generos_x_Libro As GXL ON GXL.IDLibro = L.ID
inner join Generos As G ON G.ID = GXL.IDGenero
inner join Autores_x_Libro As AXL ON AXL.IDLibro = L.ID
inner join Autores As A ON A.ID = AXL.IDAutor

/*18 Listar el t�tulo del libro, el idioma (si lo tiene), la editorial (si la tiene) de los libros 5
con mejor calificaci�n individual.*/

select TOP 5 L.Titulo,I.Nombre As idioma, E.Nombre As Editorial, LXB.Valoracion from Libros As L
inner join Idiomas AS I ON I.ID = L.IDIdioma
inner join Editoriales As E ON E.ID = L.IDEditorial
inner join Libros_x_Biblioteca As LXB ON LXB.IDLibro = L.ID
inner join Bibliotecas As B ON b.ID = LXB.IDBiblioteca
order by LXB.Valoracion desc

/*19 Listar los t�tulos de los libros sin idioma.*/

Select L.Titulo,I.Nombre As Idiomas from Libros As L
left join Idiomas As I ON I.ID = L.IDIdioma
where I.Nombre is null

/*20 Listar para cada usuario el apellido y nombres y los idiomas de los libros que posee.
No repetir la combinaci�n de usuario e idioma.*/

Select distinct U.Apellidos+','+U.Nombres As Usuario,I.Nombre As Idioma from Usuarios As U 
inner join Bibliotecas As B ON B.IDUsuario = U.ID
inner join Libros_x_Biblioteca As LXB ON LXB.IDBiblioteca = B.ID
inner join Libros As L ON L.ID = LXB.IDLibro
inner join Idiomas As I ON I.ID = L.IDIdioma

/*21 Listar los apellidos y nombres de los usuarios que posean al menos un libro cuyo
t�tulo contenga 'Historia' o cuyo g�nero contenga 'Edad media'*/

Select  U.Apellidos+','+U.Nombres As Usuario,l.Titulo,g.Nombre As Genero from Usuarios As U 
inner join Bibliotecas As B ON B.IDUsuario = U.ID
inner join Libros_x_Biblioteca As LXB ON LXB.IDBiblioteca = B.ID
inner join Libros As L ON L.ID = LXB.IDLibro
inner join Generos_x_Libro As GXL ON GXL.IDLibro = L.ID
inner join Generos As G ON G.ID = GXL.IDGenero
where L.Titulo like '%Historia%' or G.Nombre like '%Edad media%'

/*22 Listar los apellidos y nombres de los usuarios que posean al menos un libro en
Ingl�s pero que no lo hayan le�do a�n.*/

Select  U.Apellidos+','+U.Nombres As Usuario,I.Nombre As Idioma from Usuarios As U 
inner join Bibliotecas As B ON B.IDUsuario = U.ID
inner join Libros_x_Biblioteca As LXB ON LXB.IDBiblioteca = B.ID
inner join Libros As L ON L.ID = LXB.IDLibro
inner join Idiomas As I ON I.ID = L.IDIdioma
where I.Nombre = 'Ingl�s' and LXB.fin is null

/*23 Listar el nombre de las editoriales que tengan al menos un libro en Franc�s.*/

select E.Nombre As Editoriales from Libros As L
inner join Editoriales As E ON E.ID = L.IDEditorial
inner join Idiomas As I ON I.ID = L.IDIdioma
where I.Nombre = 'Franc�s'

/*24 Listar todos los t�tulos de los libros de autores cuyo pa�s de nacimiento sea Escocia
o Austria.*/

Select L.Titulo from Autores As A
inner join Autores_x_Libro As AXL ON AXL.IDAutor = A.ID
inner join Libros As L ON AXL.IDLibro = L.ID
inner join Paises As P ON P.ID = A.IDPais
where P.Nombre = 'Austria' or P.Nombre = 'Escocia'


/*25 Listar apellido y nombre de los usuarios en una columna llamada Usuario, nombre
de la biblioteca, t�tulo de los libros, apellido y nombre de los autores en una columna
llamada Autor, idioma, nombre de los g�neros, nombre de la editorial, nombre del
formato del libro, grado de valoraci�n y conservaci�n, fecha de adquisici�n y precio
abonado, fecha de inicio, fin de lectura y cantidad de d�as en finalizar la lectura. El
listado deber� figurar ordenado por usuario en primera instancia, nombre de
biblioteca en segunda instancia y t�tulo del libro en tercera instancia. Incluir los
usuarios que no posean bibliotecas y los datos de los libros que figuren en
bibliotecas pero que no posean autor, editorial o g�nero.
NOTA: Si un libro tiene m�s de un autor o m�s de un g�nero, �stos datos deber�n
aparecer en filas distintas. No se pretende que un registro se almacenen autores o
g�neros separados por coma.*/

Select U.Apellidos+','+U.Nombres As Usuario, B.Nombre As Biblioteca,L.Titulo,A.Apellidos+','+A.Nombres As Autores,
 I.Nombre As Idioma,G.Nombre As Genero,E.Nombre As Editorial,F.Nombre As Formato,LXB.Valoracion,LXB.Conservacion,LXB.Adquisicion,
 L.Precio,LXB.Inicio,LXB.Fin,DATEDIFF(DAY,LXB.Inicio,LXB.Fin) As DiasDeLectura
 from Libros As L
left join Autores_x_Libro As AXL ON AXL.IDLibro = L.ID
left join Autores As A ON A.ID = AXL.IDAutor
left join Editoriales As E ON E.ID = L.IDEditorial
left join Generos_x_Libro As GXL ON GXL.IDLibro = L.ID
left join Generos As G ON G.ID = GXL.IDGenero
inner join Libros_x_Biblioteca As LXB ON LXB.IDLibro = L.ID
inner join Bibliotecas As B ON B.ID = LXB.IDBiblioteca
inner join Idiomas As I ON I.ID = L.IDIdioma
inner join Formatos As F ON F.ID = LXB.IDFormato
right join Usuarios As U ON B.IDUsuario = U.ID
Order by Usuario,B.Nombre,L.Titulo


