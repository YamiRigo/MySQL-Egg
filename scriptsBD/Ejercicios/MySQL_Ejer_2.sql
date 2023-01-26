use tienda;

-- Ejercicio
-- 1. Lista el nombre de todos los productos que hay en la tabla producto.
select nombre from producto;

-- 2. Lista los nombres y los precios de todos los productos de la tabla producto.
select nombre as 'Nombre Producto', precio as 'Precio Lista $' from producto;

-- 3. Lista todas las columnas de la tabla producto.
select * from producto;

-- 4. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
select nombre as 'Nombre Producto', round(precio) as 'Precio Lista $' from producto;

-- 5. Lista el código de los fabricantes que tienen productos en la tabla producto.
select codigo_fabricante from producto;

-- 6. Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar los repetidos.
select distinct codigo_fabricante from producto;

-- 7. Lista los nombres de los fabricantes ordenados de forma ascendente.
select nombre from fabricante; -- Para poder ver la diferencia
select nombre from fabricante order by nombre asc; -- Como se escribiría
select nombre from fabricante order by nombre; -- Por defecto es de forma Ascendente

-- 8. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
select nombre as 'Nombre Producto', round(precio) as 'Precio Lista $' from producto order by nombre asc;

select nombre as 'Nombre Producto', round(precio) as 'Precio Lista $' from producto order by precio desc;

-- Seria así y solo se podría verificar si hubieran dos productos del mismo nombre
select nombre as 'Nombre Producto', round(precio) as 'Precio Lista $' from producto order by nombre, precio desc;

-- 9. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
select * from fabricante limit 5;

-- 10. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
select nombre, precio from producto order by precio limit 1;
select nombre, precio from producto where precio = (select min(precio) from producto);

-- 11. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
select nombre, precio from producto order by precio desc limit 1;

select nombre, precio from producto where precio = (select max(precio) from producto);

-- 12. Lista el nombre de los productos que tienen un precio menor o igual a $120.
select nombre, precio from producto where precio <= 120 order by precio;

-- 13. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador BETWEEN.
select nombre, round(precio) from producto where precio between 60 and 200 order by precio;

-- 14. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
select nombre, round(precio) 'Precio', codigo_fabricante from producto where codigo_fabricante in (1,3,5) order by precio;

-- 15. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
select nombre, round(precio) 'Precio', codigo_fabricante from producto where nombre like 'Portatil%' order by precio;


-- Consultas Multitabla
-- 1. Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
select p.codigo, p.nombre 'Producto Nombre', p.codigo_fabricante 'Cod. Fabricante', f.nombre 'Fabricante' 
from producto p join fabricante f on p.codigo_fabricante = f.codigo;

-- 2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. 
-- Ordene el resultado por el nombre del fabricante, por orden alfabético.
select p.codigo, p.nombre 'Producto Nombre', p.precio 'Precio', f.nombre 'Fabricante' from producto p join fabricante f 
on p.codigo_fabricante = f.codigo order by f.nombre;

-- 3. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
select p.nombre 'Producto Nombre', p.precio 'Precio', f.nombre 'Fabricante' from producto p join fabricante f 
on p.codigo_fabricante = f.codigo order by p.precio limit 1;

-- 4. Devuelve una lista de todos los productos del fabricante Lenovo.
select p.codigo, p.nombre 'Producto Nombre', p.precio 'Precio', f.nombre 'Fabricante' from producto p join fabricante f 
on p.codigo_fabricante = f.codigo where f.nombre like 'Lenovo%';

-- 5. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que $200.
select p.codigo, p.nombre 'Producto Nombre', p.precio 'Precio', f.nombre 'Fabricante' from producto p join fabricante f
on p.codigo_fabricante = f.codigo where f.nombre like 'Crucial%' and p.precio > 200;

-- 6. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard. Utilizando el operador IN.
select p.codigo, p.nombre 'Producto Nombre', p.precio 'Precio', f.nombre 'Fabricante' from producto p join fabricante f 
on p.codigo_fabricante = f.codigo where f.nombre in ('Asus', 'Hewlett-Packard') order by precio;

-- 7. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a $180. 
-- Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
select p.nombre 'Producto Nombre', p.precio 'Precio', f.nombre 'Fabricante' from producto p join fabricante f 
on p.codigo_fabricante = f.codigo where p.precio >= 180 order by p.precio and p.nombre asc;

select p.nombre 'Producto Nombre', f.nombre 'Fabricante', p.precio 'Precio' from producto p join fabricante f 
on p.codigo_fabricante = f.codigo where p.precio >= 180 order by f.nombre, p.precio desc;


-- Consultas Multitabla
-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

-- 1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. 
-- El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.
select p.nombre 'Producto Nombre', p.precio 'Precio', f.nombre 'Fabricante' from fabricante f left join producto p 
on f.codigo = p.codigo_fabricante;

-- 2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
select p.nombre 'Producto Nombre', p.precio 'Precio', f.nombre 'Fabricante' from fabricante f left join producto p 
on f.codigo = p.codigo_fabricante where p.nombre is null;


-- Subconsultas (En la cláusula WHERE)
-- Con operadores básicos de comparación

-- 1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
select * from producto where codigo_fabricante = (select codigo from fabricante where nombre = 'Lenovo');

-- 2. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).
select * from producto where precio = (select max(precio) from producto where codigo_fabricante = 
	(select codigo from fabricante where nombre = 'Lenovo'));

-- 3. Lista el nombre del producto más caro del fabricante Lenovo.
select nombre from producto where precio = (select max(precio) from producto where codigo_fabricante =
	(select codigo from fabricante where nombre = 'Lenovo'))
		and codigo_fabricante = (select codigo from fabricante where nombre = 'Lenovo');

-- 4. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
select * from producto where codigo_fabricante = (select codigo from fabricante where nombre = 'Asus')
	and precio = (select avg(precio) from producto where codigo_fabricante = 
		(select codigo from fabricante where nombre = 'Asus'));


-- Subconsultas con IN y NOT IN
-- 1. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
select distinct nombre 'Nombre Fabricante' from fabricante where codigo in 
	(select codigo_fabricante from producto);

-- 2. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
select nombre 'Nombre Fabricante' from fabricante where codigo not in
	(select codigo_fabricante from producto);


-- Subconsultas (En la cláusula HAVING)
-- 1. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.
select f.nombre 'Nombre Fabricante' from fabricante f inner join producto p 
	on f.codigo = p.codigo_fabricante group by f.codigo
		having count(p.codigo_fabricante) >= 2;

select fabricante.nombre, count(producto.codigo) from fabricante inner join producto 
	on fabricante.codigo = producto.codigo_fabricante group by fabricante.codigo
		having count(producto.codigo) >= (select count(producto.codigo)
			from fabricante inner join producto on fabricante.codigo = producto.codigo_fabricante
				where fabricante.nombre = 'Lenovo');


























