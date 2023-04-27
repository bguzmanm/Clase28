use grand_slam;
/***
  Procedure que retorna el nombre del país de una persona.
 */
create procedure GetCountryByPerson(in personId int, out country_name varchar(50))
begin

    select  pais.nombre into country_name
    from    persona inner join pais on persona.pais_id = pais.id
    where   persona.id = personId;

end;

call GetCountryByPerson(2, @pais);
select @pais;

/***
  cuenta la cantidad de personas que pertenecen a un país, y retorna esa cuenta + el nombre de del país
 */

create procedure getCountPersonByCountry(in countryId int, out country_name varchar(50), out count_people int)
begin

    select  count(p.id), pais.nombre into count_people, country_name
    from    pais inner join persona p on pais.id = p.pais_id
    where   pais.id = countryId
    group by pais.nombre;

end;

call getCountPersonByCountry(1, @nombre, @cantidad);
select @nombre, @cantidad;

/***
  Inserta una persona, gestiona transacción y excepciones.
 */

drop procedure createPerson;

create procedure createPerson(in i_nombre varchar(100), in i_paisId int unsigned)
begin

    declare exit handler for sqlexception
        begin
            rollback;
            select 'error al ejecutar la transacción en la base de datos' as mensaje;
        end;

    start transaction;

    insert into persona (nombre, pais_id)
        values (i_nombre, i_paisId);

    select 'Ok!' as mensaje;
    commit;
end;

call createPerson('Clarita', 2);

insert into persona (nombre, pais_id)
values ('i_nombre', 988);

/***
  dado un id de una persona, mostrar cada partido en el que participó, ya sea como jugador, entrenador o ártibro.
 */

create procedure listaHistoriaPersona(in id_persona int)
begin

    select  partido.id, p.id, p.nombre
    from    partido inner join persona p on partido.jugador_1 = p.id
    where   jugador_1 = id_persona
    union
    select  partido.id, p.id, p.nombre
    from    partido inner join persona p on partido.jugador_2 = p.id
    where   jugador_2 = id_persona
    union
    select  partido.id, p.id, p.nombre
    from    partido inner join persona p on partido.jugador_3 = p.id
    where   jugador_3 = id_persona
    union
    select  partido.id, p.id, p.nombre
    from    partido inner join persona p on partido.jugador_4 = p.id
    where   jugador_4 = id_persona;

    select  partido.id, p.id, p.nombre
    from    partido inner join persona p on partido.entrenador_1 = p.id
    where   entrenador_1 = id_persona
    union
    select  partido.id, p.id, p.nombre
    from    partido inner join persona p on partido.entrenador_2 = p.id
    where   entrenador_2 = id_persona;


    select  partido.id, p.id, p.nombre
    from    partido inner join persona p on partido.arbitro = p.id
    where   arbitro = id_persona;

end;


call listaHistoriaPersona(1);