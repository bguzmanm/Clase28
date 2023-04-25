-- drop database grand_slam;
-- create database grand_slam;
-- use grand_slam;

/***
  DDL -> Data Definition Language
 */

create table pais (
    id int unsigned primary key auto_increment,
    nombre varchar(50)
);

create table estadio (
    id int unsigned primary key auto_increment,
    nombre varchar(50),
    pais_id int unsigned,
    foreign key (pais_id) references pais(id)
);

create table torneo (
    ano year,
    estadio_id int unsigned,
    premio_single_masculino double unsigned,
    premio_single_femenino double unsigned,
    premio_double_masculino double unsigned,
    premio_double_femenino double unsigned,
    premio_double_mixto double unsigned,
    primary key (ano, estadio_id),
    foreign key (estadio_id) references estadio(id)
);

create table fase (
    torneo_ano year,
    estadio_id int unsigned,
    numero int unsigned,
    modalidad enum('single_masculino', 'single_femenino', 'double_masculino', 'double_femenino', 'double_mixto'),
    premio_consuelo double,
    primary key (torneo_ano, estadio_id, numero, modalidad),
    foreign key (torneo_ano, estadio_id) references torneo(ano, estadio_id)
);

create table persona (
    id int unsigned primary key auto_increment,
    nombre varchar(100),
    pais_id int unsigned,
    foreign key (pais_id) references pais(id)
);

create table partido (
    id int unsigned primary key auto_increment,
    torneo_ano year,
    estadio_id int unsigned,
    fase_numero int unsigned,
    modalidad enum('single_masculino', 'single_femenino', 'double_masculino', 'double_femenino', 'double_mixto'),
    fecha date,

    jugador_1 int unsigned not null,
    jugador_2 int unsigned null,
    jugador_3 int unsigned not null,
    jugador_4 int unsigned null,
    arbitro int unsigned not null,
    entrenador_1 int unsigned,
    entrenador_2 int unsigned,

    foreign key (torneo_ano, estadio_id, fase_numero, modalidad) references fase(torneo_ano, estadio_id, numero, modalidad),
    foreign key (jugador_1) references persona(id),
    foreign key (jugador_2) references persona(id),
    foreign key (jugador_3) references persona(id),
    foreign key (jugador_4) references persona(id),
    foreign key (arbitro) references persona(id),
    foreign key (entrenador_1) references persona(id),
    foreign key (entrenador_2) references persona(id)
);

create table partido_set (
    numero int unsigned,
    partido_id int unsigned,
    set_jugador_1 int unsigned,
    tie_breake_1 int unsigned,
    set_jugador_2 int unsigned,
    tie_breake_2 int unsigned,
    foreign key (partido_id) references partido(id)
);

/***
  DML -> Data Manipulation Language
  INSERTS
 */

insert into pais (id, nombre)
values  (1, 'Francia'),
        (2, 'Australia'),
        (3, 'Gran Bretaña'),
        (4, 'Estados Unidos');

insert into estadio (id, nombre, pais_id)
values  (1, 'Roland Garros', 1),
        (2, 'Forest Hill', 4),
        (3, 'Flashing Meadows', 4),
        (4, 'Melbourne Arena', 2),
        (5, 'Centre Court', 3);

insert  into torneo (ano, estadio_id, premio_single_masculino, premio_single_femenino,
                    premio_double_masculino, premio_double_femenino, premio_double_mixto)
values  (1979, 1, 1000, 1000, 1000, 1000, 1000),
        (1979, 5, 900, 900, 900, 900, 900),
        (1979, 4, 1100, 1100, 1100, 1100, 1100);

insert  into fase (torneo_ano, estadio_id, numero, modalidad, premio_consuelo)
values
    (1979, 1, 1, 'single_masculino', 10),
    (1979, 1, 2, 'single_masculino', 20),
    (1979, 1, 3, 'single_masculino', 30),
    (1979, 1, 4, 'single_masculino', 40),
    (1979, 1, 5, 'single_masculino', 50),
    (1979, 1, 6, 'single_masculino', 100),
    (1979, 1, 1, 'single_femenino', 10),
    (1979, 1, 2, 'single_femenino', 20),
    (1979, 1, 3, 'single_femenino', 30),
    (1979, 1, 4, 'single_femenino', 40),
    (1979, 1, 5, 'single_femenino', 50),
    (1979, 1, 6, 'single_femenino', 100);

insert into persona (id, nombre, pais_id)
values
    (1, 'Connors', 1),
    (2, 'Aravena', 2),
    (3, 'Díaz', 3),
    (4, 'Mercado', 4),
    (5, 'Polanco', 1),
    (6, 'Guzmán', 2),
    (7, 'Rios', 4),
    (8, 'Gonzalez', 1),
    (9, 'Massu', 2),
    (10, 'Federer', 3);


insert into partido (id, torneo_ano, estadio_id, fase_numero, modalidad, fecha,
                     jugador_1, jugador_2, jugador_3, jugador_4, arbitro, entrenador_1, entrenador_2)
values  (1, 1979, 1, 1, 'single_masculino', now(), 1, null, 3, null, 6, 9, 5),
        (2, 1979, 1, 2, 'single_masculino', now(), 1, null, 4, null, 6, 9, 5),
        (3, 1979, 1, 3, 'single_masculino', now(), 1, null, 2, null, 6, 9, 5),
        (4, 1979, 1, 4, 'single_masculino', now(), 1, null, 7, null, 6, 9, 5),
        (5, 1979, 1, 5, 'single_masculino', now(), 1, null, 8, null, 6, 9, 5),
        (6, 1979, 1, 6, 'single_masculino', now(), 1, null, 10, null, 6, 9, 5),
        (7, 1979, 1, 1, 'single_masculino', now(), 2, null, 4, null, 6, 9, 5);

select * from partido;

insert into partido_set (numero, partido_id, set_jugador_1, tie_breake_1, set_jugador_2, tie_breake_2)
values
        (1, 1, 6, null, 0, null),
        (2, 1, 6, null, 0, null),
        (3, 1, 6, null, 0, null),
        (1, 2, 6, null, 1, null),
        (2, 2, 6, null, 1, null),
        (3, 2, 6, null, 1, null),
        (1, 3, 5, 7, 6, 5),
        (2, 3, 3, null, 6, null),
        (3, 3, 6, null, 2, null),
        (1, 4, 6, null, 0, null),
        (2, 4, 6, null, 0, null),
        (3, 4, 6, null, 0, null),
        (1, 5, 6, null, 4, null),
        (2, 5, 6, null, 4, null),
        (3, 5, 6, null, 4, null),
        (1, 6, 6, null, 3, null),
        (2, 6, 4, 7, 6, 5),
        (3, 6, 6, null, 0, null),
        (1, 7, 6, null, 0, null),
        (2, 7, 6, null, 4, null),
        (3, 7, 6, null, 3, null);


/*

1. Ronda de clasificación
2. Cuadro principal
3. Segunda ronda
4. Cuartos de final
5. Semifinales
6. Final
 */

 /***
   VIEWS
  */

create view ganadores as
select  pa.torneo_ano, pa.estadio_id, partido_id, fase_numero, jugador1.id j1id, jugador1.nombre j1nombre, jugador2.id j2id, jugador2.nombre j2nombre,
        IF(sum(set_jugador_1 + IFNULL(tie_breake_1, 0)) > sum(set_jugador_2 + IFNULL(tie_breake_2, 0)), jugador1.id, jugador2.id) ganadorid,
        IF(sum(set_jugador_1 + IFNULL(tie_breake_1, 0)) > sum(set_jugador_2 + IFNULL(tie_breake_2, 0)), jugador1.nombre, jugador2.nombre) ganador
from    partido pa
        inner join persona jugador1 on pa.jugador_1 = jugador1.id
        inner join persona jugador2 on pa.jugador_3 = jugador2.id
        inner join partido_set ps on pa.id = ps.partido_id
group by jugador1.nombre, jugador2.nombre, partido_id;