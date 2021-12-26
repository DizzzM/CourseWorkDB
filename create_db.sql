create table if not exists theory_questions (
	id integer primary key,
    question varchar(200) not null,
    answer varchar(200) not null
);

create table if not exists lecturers(
	id integer primary key,
    name varchar(100) not null
);

create table if not exists instructors(
	id integer primary key,
    name varchar(100) not null
);

create table if not exists car(
	id integer primary key,
    name varchar(100) not null,
    transmission varchar(50) check (transmission = "manual" or transmission = "automatic") not null,
    power integer check(power>0) not null,
    production_year date not null
);

delimiter $$
create trigger check_year_before_car_insert
before insert on car
for each row
begin
if new.production_year>=curdate() then 
signal sqlstate '45000';
end if;
end$$