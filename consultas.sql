/**
  Preguntas:
  Dado un año y un torneo, composición y resultado de los partidos.

 */
select  jugador1.nombre, jugador2.nombre, entrenador1.nombre,
        jugador3.nombre, jugador4.nombre, entrenador2.nombre,
        arbitro.nombre, set_jugador_1, tie_breake_1, set_jugador_2, tie_breake_2
from    partido pa
        inner join persona jugador1 on pa.jugador_1 = jugador1.id
        left join persona jugador2 on pa.jugador_2 = jugador2.id
        inner join persona jugador3 on pa.jugador_3 = jugador3.id
        left join persona jugador4 on pa.jugador_4 = jugador4.id
        inner join persona arbitro on pa.arbitro = arbitro.id
        left join persona entrenador1 on pa.entrenador_1 = entrenador1.id
        left join persona entrenador2 on pa.entrenador_2 = entrenador2.id
        inner join partido_set ps on pa.id = ps.partido_id

where   pa.torneo_ano = 1979 and pa.estadio_id = 1;

select  partido_id, jugador1.nombre, jugador2.nombre,
        IF(sum(set_jugador_1 + IFNULL(tie_breake_1, 0)) > sum(set_jugador_2 + IFNULL(tie_breake_2, 0)), jugador1.nombre, jugador2.nombre) ganador
from    partido pa
        inner join persona jugador1 on pa.jugador_1 = jugador1.id
        inner join persona jugador2 on pa.jugador_3 = jugador2.id
        inner join partido_set ps on pa.id = ps.partido_id
where   pa.torneo_ano = 1979 and pa.estadio_id = 1
group by jugador1.nombre, jugador2.nombre, partido_id;

/***
  Lista de árbitros que participaron en el torneo.
 */

select  distinct p.nombre
from    partido pa
        inner join persona p on pa.arbitro = p.id
where   pa.torneo_ano = 1979 and pa.estadio_id = 1;

/***
  Ganancias percibidas en premios por un jugador a lo largo del torneo.
 */

select  persona.nombre, p.fase_numero, premio_consuelo
from    persona
        inner join partido p on (persona.id = p.jugador_1 or persona.id = p.jugador_2 or persona.id = p.jugador_3 or persona.id = p.jugador_4)
        inner join fase f on (p.fase_numero = f.numero and p.torneo_ano = f.torneo_ano and p.estadio_id = f.estadio_id and p.modalidad = f.modalidad)
        inner join torneo t on f.torneo_ano = t.ano and f.estadio_id = t.estadio_id
        inner join ganadores g on f.torneo_ano = g.torneo_ano and f.estadio_id = g.estadio_id and g.fase_numero = 6
where   persona.id = 3
order by premio_consuelo desc
limit 1;

select * from partido where fase_numero = 6;
select * from persona where id = 10;


select  *
from    ganadores
where   estadio_id = 1 and torneo_ano = 1979 and fase_numero = 6;

