use personal;

-- METODOS USADOS --

-- LIKE = Contine debe ir con WHERE
-- ORDER BY = Orden
-- WHERE = Donde
-- AS = Cambio de nombre en la tabla (muestra)
-- NOT = Negación / No contiene 
-- FROM = De donde sacamos los datos
-- NOT IN = Para decir que no muestre lo que hay dentro del campo
-- DISTINCT = Muestra solamente los distintos
-- MAX(campo de la tabla) = Muestra valor Maximo
-- MIN(campo de la tabla) = Muestra valor Minimo
-- AVG(columna) promedio de los valores de una columna
-- SUN(columna) suma todos los valores de una columna
-- ROUND(valor, cantindaa de decimales) redondeo de decimales
-- HAVING clausula que se usa con GROUP BY para funcionar con un WHERE con grupos


-- ACLARACIONES! 
-- Si o si el % va detras de la letra o cadena para que no aparezca


-- Ejercicio 1

-- 1. Obtener los datos completos de los empleados.
select * from personal.empleado;

-- 2. Obtener los datos completos de los departamentos.
select * from personal.departamento;

-- 3. Listar el nombre de los departamentos.
select nombre_depto from personal.departamento;
select distinct nombre_depto from personal.departamento;

-- 4. Obtener el nombre y salario de todos los empleados.
select nombre, salario from personal.empleado;

-- 5. Listar todas las comisiones.
select comision from personal.empleado;
select nombre, comision from personal.empleado;

-- 6. Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’.
select * from personal.empleado where cargo = "Secretaria";
select * from personal.empleado where cargo = 'Secretaria';

-- 7. Obtener los datos de los empleados vendedores, ordenados por nombre alfabéticamente.
select * from personal.empleado where cargo = 'Vendedor' order by nombre;

-- 8. Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a mayor.
select nombre, cargo, salario from personal.empleado order by salario;

-- 9. Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para las respectivas tablas de empleados.
select nombre as 'Nombre', cargo as 'Cargo' from personal.empleado;
select nombre, cargo from personal.empleado;

-- 10. Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisión de menor a mayor.
select nombre as 'Nombre' , salario as 'Salario', comision as 'Comision' from personal.empleado where id_depto = 2000;
select nombre, salario, comision from personal.empleado where id_depto = 2000;

-- 11. Obtener el valor total a pagar que resulta de sumar el salario y la comisión de los empleados del departamento 3000 una bonificación de 500, 
-- en orden alfabético del empleado.
select nombre as 'Nombre', salario as 'Salario', comision as 'Comision', (salario + comision + 500) as 'Salario + Comision + Bonificación' 
from personal.empleado where id_depto = 3000 order by nombre;
select nombre, salario, comision, (salario + comision + 500) as 'Salario + Comision + Bonificación' from personal.empleado where id_depto = 3000 order by nombre;

-- 12. Muestra los empleados cuyo nombre empiece con la letra J.
select nombre as 'Nombre' from personal.empleado where nombre like 'J%'; -- Empiezo con J
select nombre as 'Nombre' from personal.empleado where nombre like '%a'; -- Termina con A 
select nombre as 'Nombre' from personal.empleado where nombre like '%j%'; -- Contiene J ó Empieza con J 
select nombre as 'Nombre' from personal.empleado where nombre like '_%j%'; -- Contiene J
select nombre as 'Nombre' from personal.empleado where nombre like '_o%'; -- Su segunda letra es O

-- 13. Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de aquellos empleados que tienen comisión superior a 1000.
select salario as 'Salario', comision as 'Comision', (salario + comision) as 'Salario + Comision', nombre as 'Nombre' from personal.empleado where comision > 1000;
select salario, comision, (salario + comision) as 'Salario + Comision', nombre from personal.empleado where comision > 1000;

-- 14. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisión.
select salario as 'Salario', comision as 'Comision', (salario + comision) as 'Salario + Comision', nombre as 'Nombre' from personal.empleado where comision = 0;
select salario, comision, (salario + comision) as 'Salario + Comision', nombre from personal.empleado where comision = 0;

-- 15. Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
select nombre as 'Nombre', comision as 'Comision', salario as 'Salario' from personal.empleado where comision > salario order by nombre;
select nombre, comision, salario from personal.empleado where comision > salario order by nombre;

-- 16. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
select nombre as 'Nombre', comision as 'Comision', salario as 'Salario' from personal.empleado where comision <= salario * 0.30 order by nombre;
select nombre, comision, salario from personal.empleado where comision <= salario * 0.30 order by nombre;

-- 17. Hallar los empleados cuyo nombre no contiene la cadena “MA”
select nombre as 'Nombre' from personal.empleado where nombre not like 'MA%';
select nombre from personal.empleado where nombre not like 'MA%';

-- 18. Obtener los nombres de los departamentos que sean “Ventas” ni “Investigación” ni ‘Mantenimiento.
select distinct nombre_depto as 'Nombre Departamento' from personal.departamento where nombre_depto in ('Ventas','Investigación','Mantenimiento');
select distinct nombre_depto from personal.departamento where nombre_depto in ('Ventas','Investigación','Mantenimiento');

-- 19. Ahora obtener los nombres de los departamentos que no sean “Ventas” ni “Investigación” ni ‘Mantenimiento.
select nombre_depto as 'Nombre Departamento' from personal.departamento where nombre_depto not in ('Ventas','Investigación','Mantenimiento');
select nombre_depto from personal.departamento where nombre_depto not in ('Ventas','Investigación','Mantenimiento');

-- 20. Mostrar el salario más alto de la empresa.
select max(salario) as 'Salario Más Alto', nombre as 'Nombre' from personal.empleado;
select max(salario) as 'Salario Más Alto', nombre from personal.empleado;

-- 21. Mostrar el nombre del último empleado de la lista por orden alfabético.
select nombre from personal.empleado order by nombre desc;
select max(nombre) from personal.empleado;
-- Con consulta
select * from personal.empleado where nombre = (select max(nombre) from personal.empleado);

-- 22. Hallar el salario más alto, el más bajo y la diferencia entre ellos.
select max(salario) as 'Salario Más Alto', min(salario) as 'Salario Más Bajo', max(salario) - min(salario) as 'Diferencia' from personal.empleado;

-- 23. Hallar el salario promedio por departamento.
select sum(salario) as 'Total Salarios', count(salario) as 'Cant. de Salarios', round(sum(salario) / count(salario),2) as 'Promedio' from personal.empleado;
select sum(salario) as 'Total Salarios', count(salario) as 'Cant. de Salarios', round(avg(salario),2) as 'Promedio' from personal.empleado;

SELECT AVG(salario) AS salario_prom, nombre_depto FROM empleado e INNER JOIN departamento d WHERE e.id_depto = d.id_depto GROUP BY d.nombre_depto;


-- Consultas con Having
-- 24. Hallar los departamentos que tienen más de tres empleados. Mostrar el número de empleados de esos departamentos.
select id_depto as 'Codigo de Departemento', count(id_empleado) as 'Cantidad de Empleados' from empleado
group by id_depto having count(id_empleado) > 3;

-- 25. Mostrar el código y nombre de cada jefe, junto al número de empleados que dirige. Solo los que tengan más de dos empleados (2 incluido).
select *, count(*) as 'Cantidad' from empleado group by id_depto having Cantidad >= 2 and cargo like 'Jefe%';

-- 26. Hallar los departamentos que no tienen empleados
select * from departamento as d left join empleado as e on d.id_depto = e.id_depto group by d.id_depto having count(e.nombre) = 0;
select nombre_depto as 'Departamento sin Empleados' from departamento d left join empleado e on d.id_depto = e.id_depto where e.id_empleado is null;

-- 27. Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la empresa. Ordenarlo por departamento.
select nombre 'Nombre Empleado', salario 'Salario mayor o igual al promedio' from empleado where salario >= (select avg(salario) from empleado);
select d.nombre_depto, e.nombre, e.salario from empleado e inner join departamento d on d.id_depto = e.id_depto where e.salario >= (select avg(e.salario)
from empleado e) order by d.nombre_depto;



