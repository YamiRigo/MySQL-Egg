#CANDADO A

-- La posición de código será igual a la cantidad de jugadores que proceden de Michigan y forman parte de equipos de la 
-- conferencia oeste.
select count(*) as 'Cantidad' from jugador j inner join equipo e 
	on j.nombre_equipo = e.nombre where e.conferencia = 'West'
		and j.procedencia = 'Michigan'; #2
        
-- Al resultado obtenido lo dividiremos por la cantidad de jugadores cuyo peso es mayor o igual a 195, y a eso le vamos
-- a sumar 0.9945.
select count(j.codigo) as 'Total' from jugador j 
	where j.peso >= (195);
#La posición del candado A es (2/362) + 0.9945 = 1.000024 

-- Muestre la suma total del peso de los jugadores, donde la conferencia sea Este y la posición se centro o este
-- comprendida en otras posiciones
select sum(j.peso) as 'Suma total de peso' from jugador j 
	inner join equipo e on e.nombre = j.nombre_equipo
		where e.conferencia = 'East' and j.posicion like '%c%'; #14043
        

#CANDADO B
-- Muestre la cantidad de jugadores que poseen más asistencias por partidos, que el número de jugadores que tiene
-- el equipo Heat (16)
select count(j.codigo) from jugador j 
	inner join estadistica e 	
		on j.codigo = e.jugador
			where e.Asistencias_por_partido > (select count(e.jugador) as 'Total'
												from jugador j inner join equipo e
												on e.nombre = j.nombre_equipo
                                                where e.nombre = 'heat');
#La posición del candado B es 3.

-- La clave será igual al conteo de partidos jugados durante las temporadas del año 1999
select count(p.codigo) as 'Total' from partido p 
	where p.temporada like '%99%'; #3480
    

#CANDADO C 
-- Muestre cuántas veces los jugadores lograron tener más o la misma cantidad de asistencias por partido, 
-- que el máximo de asistencias por partido
select count(j.codigo) from jugador j 
	inner join estadistica e on j.codigo = e.jugador
		where e.Asistencias_por_partido >= (select max(e.Asistencias_por_partido)
											from estadistica e); #2
                                            
-- Para obtener el siguiente código deberás redondear hacia abajo el resultado que se devuelve de sumar: 
-- el promedio de puntos por partido, el conteo de asistencias por partido, y la suma de tapones por partido,
-- Además, este resultado debe ser, donde la división sea central. 
select floor(avg(e.Puntos_por_partido) + count(e.Asistencias_por_partido) + sum(e.Tapones_por_partido)) as 'Total'
	from estadistica e inner join jugador j on e.jugador = j.codigo
		inner join equipo q on q.nombre = j.nombre_equipo
			where q.division = 'central'; #631
            

#CANDADO D
-- Muestre los tapones por partido del jugador Corey Maggette durante la temporada 00/01. Este resultado debe ser
-- redondeado
select round(e.tapones_por_partido) from estadistica e 
	inner join jugador j on e.jugador = j.codigo
		where j.nombre = 'Corey Maggette' and e.temporada = '00/01'; #4
        
-- Para obtener el siguiente código deberás redondear hacia abajo, la suma de puntos por partido de todos los jugadores
-- de procedencia argentina
select floor(sum(e.puntos_por_partido)) as 'Puntos totales' from estadistica e
	inner join jugador j on e.jugador = j.codigo
		where j.procedencia = 'argentina'; #191

















