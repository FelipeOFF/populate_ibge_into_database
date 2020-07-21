create database states_and_cities;

use states_and_cities;

create table state(
	id int primary key not null,
    sigla varchar(2)
);

create table citie(
	id int primary key not null,
    nome varchar(50)
);

create table citie_and_state(
	id_state int not null,
	id_citie int not null,
    foreign key (id_state) references state(id),
    foreign key (id_citie) references citie(id)
);