use nba;

-- 1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.
select nombre, peso from jugador order by nombre;

-- 2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras, ordenados por nombre alfabéticamente.
select nombre, posicion, peso from jugador where posicion = 'C' and peso > 200 order by peso;

-- 3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.
select nombre from equipo order by nombre;

-- 4. Mostrar el nombre de los equipos del este (East).
select nombre, conferencia from equipo where conferencia like 'east%';

select nombre, conferencia from equipo where conferencia = 'East';

-- 5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.
select nombre from equipo where nombre like 'c%';

-- 6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.
select nombre, nombre_equipo from jugador order by nombre_equipo;

-- 7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.
select nombre, nombre_equipo from jugador where nombre_equipo like 'Raptors%' order by nombre;

-- 8. Mostrar los puntos por partido del jugador ‘Pau Gasol’.
select puntos_por_partido, jugador, temporada from estadistica 
	where jugador = (select codigo from jugador where nombre like 'Pau Gasol%');
    
select e.puntos_por_partido, e.jugador, e.temporada, j.nombre from estadistica e 
	join jugador j on j.codigo = e.jugador where j.nombre like 'Pau Gasol%';

-- 9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.
select e.puntos_por_partido, e.jugador, e.temporada, j.nombre from estadistica e
	join jugador j on j.codigo = e.jugador where j.nombre like 'Pau Gasol%' and e.temporada like '04/05%';

-- 10. Mostrar el número de puntos de cada jugador en toda su carrera.
select j.nombre, round(sum(puntos_por_partido),2) as 'Total Puntos' from estadistica e 
	join jugador j on j.codigo = e.jugador group by e.jugador order by sum(Puntos_por_partido);

-- 11. Mostrar el número de jugadores de cada equipo.
select nombre_equipo, count(nombre_equipo) as 'Nro de Jugadores' from jugador group by nombre_equipo;

-- 12. Mostrar el jugador que más puntos ha realizado en toda su carrera.
select j.nombre, round(sum(puntos_por_partido),2) as 'Total Puntos' from estadistica e
	join jugador j on j.codigo = e.jugador group by e.jugador
		order by sum(Puntos_por_partido) desc limit 1;
        
-- 13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.
select e.nombre, e.conferencia, e.division, j.nombre, j.altura from equipo e join jugador j
	on j.nombre_equipo = e.nombre order by j.altura desc limit 1;

-- 14. Mostrar la media de puntos en partidos de los equipos de la división Pacific.
select e.nombre, e.conferencia, e.division, avg(puntos_local) as 'Promedio Local' from equipo e
	join partido p on p.equipo_local = e.nombre where e.division = 'Pacific' group by e.nombre;
    
-- 15. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor diferencia de puntos.
select * from partido where abs(puntos_local - puntos_visitante) = 
	(select max(abs(puntos_local - puntos_visitante)) from partido);

-- 16. Mostrar la media de puntos en partidos de los equipos de la división Pacific.
select e.nombre, avg(puntos_local) from partido p inner join equipo e 
	on p.equipo_local = e.nombre where e.division = 'Pacific' group by e.nombre;

-- 17. Mostrar los puntos de cada equipo en los partidos, tanto de local como de visitante.
select equipo_local, puntos_local, equipo_visitante, puntos_visitante from partido;

select distinct (e.nombre), (select sum(puntos_local) from partido where equipo_local = e.nombre) as puntos_local,
	(select sum(puntos_visitante) from partido where equipo_visitante = e.nombre) as puntos_visitante from equipo e;

-- 18. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante, equipo_ganador), en caso de empate sera null.
select codigo, equipo_local, equipo_visitante, if(puntos_local > puntos_visitante, equipo_local, if(puntos_local < puntos_visitante, equipo_visitante, null))
	as 'equipo_ganador' from partido;












