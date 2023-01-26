use jardineria

-- Consultas sobre una tabla
-- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
select codigo_oficina, ciudad from oficina;

-- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
SELECT 
    ciudad, telefono
FROM
    oficina
WHERE
    pais = 'España';

-- 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
select nombre, apellido1, apellido2, email from empleado where codigo_jefe = 7;

-- 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
select puesto, nombre, apellido1, apellido2, email from empleado where codigo_jefe is null;

-- 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
select nombre, apellido1, apellido2, puesto from empleado where puesto != 'Representante Ventas';

-- 6. Devuelve un listado con el nombre de los todos los clientes españoles.
select nombre_cliente from cliente where pais = 'Spain';

-- 7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
select distinct (estado) from pedido;

-- 8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. 
-- Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
-- o Utilizando la función YEAR de MySQL.
select distinct (codigo_cliente) from pago where year(fecha_pago) = 2008;

-- o Utilizando la función DATE_FORMAT de MySQL.
select distinct (codigo_cliente) from pago where date_format(fecha_pago, '%Y') = 2008;

-- o Sin utilizar ninguna de las funciones anteriores.
select distinct (codigo_cliente) from pago where left(fecha_pago, 4) = 2008;

-- 9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
	from pedido where fecha_entrega > fecha_esperada;

-- 10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya 
-- fecha de entrega ha sido al menos dos días antes de la fecha esperada.
-- o Utilizando la función ADDDATE de MySQL.
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
	from pedido where adddate(fecha_entrega, interval 2 day) <= fecha_esperada;

-- o Utilizando la función DATEDIFF de MySQL.
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
	from pedido where datediff(fecha_esperada, fecha_entrega) >= 2;

-- 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
select * from pedido where estado = 'Rechazado' and year(fecha_entrega) = 2009;

-- 12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
select * from pedido where estado = 'Entregado' and month(fecha_entrega) = 1;

-- 13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
select * from pago where forma_pago = 'Paypal' and year(fecha_pago) = 2008 order by total desc;

-- 14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.
select distinct forma_pago from pago;

-- 15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. 
-- El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
select * from producto where gama = 'Ornamentales' and cantidad_en_stock > 100 order by precio_venta desc;

-- 16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.
select * from cliente where ciudad = 'Madrid' and codigo_empleado_rep_ventas in (11,30);

-- Consultas multitabla (Composición interna)
-- Las consultas se deben resolver con INNER JOIN.

-- 1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante
-- de ventas.
select c.nombre_cliente, e.nombre, e.apellido1, e.apellido2 from cliente c
	inner join empleado e
		on c.codigo_empleado_rep_ventas = e.codigo_empleado;

-- 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus
-- representantes de ventas.
SELECT DISTINCT(c.nombre_cliente), e.nombre
FROM cliente as c
INNER JOIN pago as p
ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado as e
ON c.codigo_empleado_rep_ventas = e.codigo_empleado;

-- 3. Muestra el nombre de los clientes que no hayan realizado pagos  junto con el nombre de sus representantes de ventas. 
SELECT DISTINCT(c.nombre_cliente), e.nombre
FROM cliente as c
LEFT JOIN pago as p
ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado as e
ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE p.fecha_pago IS NULL;

-- 4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT DISTINCT(c.nombre_cliente), e.nombre, o.ciudad
FROM cliente as c
RIGHT JOIN pago as p
ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado as e
ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina as o
ON e.codigo_oficina = o.codigo_oficina;

-- 5. Devuelve  el  nombre  de  los  clientes  que  no  hayan  hecho  pagos  y  el  nombre  de  sus representantes junto con la ciudad de la oficina a la que pertenece el representante. 
SELECT DISTINCT(c.nombre_cliente), e.nombre, o.ciudad
FROM cliente as c
LEFT JOIN pago as p
ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado as e
ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina as o
ON e.codigo_oficina = o.codigo_oficina
WHERE p.codigo_cliente IS NULL;

-- 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
SELECT * FROM cliente WHERE ciudad = "Fuenlabrada";

SELECT * FROM oficina;

SELECT DISTINCT(o.linea_direccion1), o.linea_direccion2
FROM oficina as o
INNER JOIN empleado as e
ON o.codigo_oficina = e.codigo_oficina
INNER JOIN cliente as c
ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.ciudad = "Fuenlabrada";

-- 7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT DISTINCT(c.nombre_cliente), e.nombre, o.ciudad
FROM oficina as o
INNER JOIN empleado as e
ON o.codigo_oficina = e.codigo_oficina
INNER JOIN cliente as c
ON e.codigo_empleado = c.codigo_empleado_rep_ventas;

-- 8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
SELECT nombre, (SELECT nombre FROM empleado WHERE e.codigo_jefe = codigo_empleado)
FROM empleado as e;

-- 9. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
SELECT c.nombre_cliente
FROM cliente as c
INNER JOIN pedido as p
ON c.codigo_cliente = p.codigo_cliente
WHERE p.fecha_entrega > p.fecha_esperada;

-- 10. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
SELECT c.nombre_cliente, prod.gama
FROM cliente as c
INNER JOIN pedido as p
ON c.codigo_cliente = p.codigo_cliente
INNER JOIN detalle_pedido as d
ON d.codigo_pedido = p.codigo_pedido
INNER JOIN producto as prod
ON prod.codigo_producto = d.codigo_producto
GROUP BY c.nombre_cliente, prod.gama;

-- Consultas multitabla (Composición externa) 
-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, JOIN. 
-- 1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago. 
SELECT c.*
FROM pago as p
RIGHT JOIN cliente as c
ON p.codigo_cliente = c.codigo_cliente
WHERE p.codigo_cliente IS NULL;

-- 2. Devuelve  un  listado  que  muestre  solamente  los  clientes  que  no  han  realizado  ningún pedido. 
SELECT c.*
FROM pedido as p
RIGHT JOIN cliente as c
ON p.codigo_cliente = c.codigo_cliente
WHERE p.codigo_cliente IS NULL;

-- 3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.
SELECT DISTINCT(c.codigo_cliente), c.nombre_cliente
FROM cliente as c
LEFT JOIN pedido as p1
ON p1.codigo_cliente = c.codigo_cliente
LEFT JOIN pago as p2
ON p2.codigo_cliente = c.codigo_cliente
WHERE (p1.codigo_cliente IS NULL) OR (p2.codigo_cliente IS NULL);

-- 4. Devuelve  un  listado  que  muestre  solamente  los  empleados  que  no  tienen  una  oficina asociada.
SELECT *
FROM empleado as e
LEFT JOIN oficina as o
ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_oficina IS NULL;

-- 5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente
-- asociado.
select * from empleado e left join cliente c 
	on e.codigo_empleado = c.codigo_cliente
		where e.codigo_empleado is null;

-- 6. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.
select * from empleado e 
	left join oficina o on o.codigo_oficina = e.codigo_oficina
        left join cliente c on c.codigo_cliente = e.codigo_empleado
			where (o.codigo_oficina is null) or (c.codigo_cliente is null);

-- 7. Devuelve un listado de los productos que nunca han aparecido en un pedido.
select * from producto pr
	left join pedido p on p.codigo_pedido = pr.codigo_producto
		where p.estado is null;

-- 8. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los
-- representantes de ventas de algún cliente que haya realizado la compra de algún producto
-- de la gama Frutales.
-- 9. Devuelve un listado con los clientes que han realizado algún pedido, pero no han realizado
-- ningún pago.
-- 10. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el
-- nombre de su jefe asociado.
-- Consultas resumen
-- 1. ¿Cuántos empleados hay en la compañía?
-- 2. ¿Cuántos clientes tiene cada país?
-- 3. ¿Cuál fue el pago medio en 2009?
-- 4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el
-- número de pedidos.
-- 5. Calcula el precio de venta del producto más caro y más barato en una misma consulta.
-- 6. Calcula el número de clientes que tiene la empresa.
-- 7. ¿Cuántos clientes tiene la ciudad de Madrid?
-- 8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
-- 9. Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende
-- cada uno.
-- 10. Calcula el número de clientes que no tiene asignado representante de ventas.
-- 11. Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado
-- deberá mostrar el nombre y los apellidos de cada cliente.
-- 12. Calcula el número de productos diferentes que hay en cada uno de los pedidos.
-- 13. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de
-- los pedidos.
-- 14. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que
-- se han vendido de cada uno. El listado deberá estar ordenado por el número total de
-- unidades vendidas.
-- 15. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el
-- IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el
-- número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base
-- imponible, y el total la suma de los dos campos anteriores.
-- 16. La misma información que en la pregunta anterior, pero agrupada por código de producto.
-- 17. La misma información que en la pregunta anterior, pero agrupada por código de producto
-- filtrada por los códigos que empiecen por OR.
-- 18. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se
-- mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21%
-- IVA)
-- Subconsultas con operadores básicos de comparación
-- 1. Devuelve el nombre del cliente con mayor límite de crédito.
-- 2. Devuelve el nombre del producto que tenga el precio de venta más caro.
-- 3. Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en cuenta
-- que tendrá que calcular cuál es el número total de unidades que se han vendido de cada
-- producto a partir de los datos de la tabla detalle_pedido. Una vez que sepa cuál es el código
-- del producto, puede obtener su nombre fácilmente.)
-- 4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar
-- INNER JOIN).
-- 5. Devuelve el producto que más unidades tiene en stock.
-- 6. Devuelve el producto que menos unidades tiene en stock.
-- 7. Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto
-- Soria.
-- Subconsultas con ALL y ANY
-- 1. Devuelve el nombre del cliente con mayor límite de crédito.
-- 2. Devuelve el nombre del producto que tenga el precio de venta más caro.
-- 3. Devuelve el producto que menos unidades tiene en stock.
-- Subconsultas con IN y NOT IN
-- 1. Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún
-- cliente.
-- 2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
-- 3. Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.
-- 4. Devuelve un listado de los productos que nunca han aparecido en un pedido.
-- 5. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que
-- no sean representante de ventas de ningún cliente.
-- Subconsultas con EXISTS y NOT EXISTS
-- 1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún
-- pago.
-- 2. Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.
-- 3. Devuelve un listado de los productos que nunca han aparecido en un pedido.
-- 4. Devuelve un listado de los productos que han aparecido en un pedido alguna vez.