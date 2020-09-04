-- Crear Base de Datos
CREATE DATABASE peliculas;

-- Cambiar a la Base de Datos Peliculas
\c peliculas

-- Revisar los archivos peliculas.csv y reparto.csv para crear las tablas correspondientes, determinando la relación entre ambas tablas. 
CREATE TABLE peliculas(id SERIAL PRIMARY KEY,pelicula VARCHAR(100),año_estreno INT,director VARCHAR(70));

CREATE TABLE reparto(pelicula_id INT, nombre VARCHAR(70), FOREIGN KEY(pelicula_id) REFERENCES peliculas(id));

-- Cargar archivos a la tabla correspondiente
\copy peliculas FROM '/home/simon/Documentos/Desafio Latam/Desafios Full Stack/unidad_3/top_100/peliculas.csv' csv HEADER;

\copy reparto FROM '/home/simon/Documentos/Desafio Latam/Desafios Full Stack/unidad_3/top_100/reparto.csv' csv;

-- Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película, año de estreno, director y todo el reparto. 
SELECT pelicula, año_estreno, director, reparto.nombre AS reparto FROM peliculas INNER JOIN reparto ON pelicula_id = peliculas.id WHERE pelicula = 'Titanic';

-- Listar los titulos de las películas donde actúe Harrison Ford.
SELECT pelicula FROM peliculas INNER JOIN reparto ON pelicula_id = peliculas.id WHERE nombre = 'Harrison Ford';

-- Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en el top 100.
SELECT director, COUNT(director) AS numero_de_peliculas
FROM Peliculas
GROUP BY director
ORDER BY (COUNT(director)) DESC LIMIT(10);

-- Indicar cuantos actores distintos hay 
SELECT COUNT(actores) FROM (SELECT nombre FROM reparto GROUP BY nombre) AS actores;

-- Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas por título de manera ascendente.
SELECT pelicula FROM peliculas WHERE año_estreno >= 1990 AND año_estreno <= 1999 ORDER BY pelicula ASC;

-- Listar el reparto de las películas lanzadas el año 2001
SELECT reparto.nombre FROM reparto
INNER JOIN peliculas ON reparto.pelicula_id = peliculas.id
WHERE peliculas.año_estreno = 2001;

-- Listar los actores de la película más nueva 
SELECT nombre FROM reparto INNER JOIN peliculas ON peliculas.id = reparto.pelicula_id WHERE año_estreno = (SELECT MAX(año_estreno) FROM peliculas);