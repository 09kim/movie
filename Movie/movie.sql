CREATE TABLE member(
   idx int primary key, 
   email varchar(50) unique not null,
   pass varchar(16) not null,
   nick varchar(16) unique not null,
   phone varchar(20) unique not null,
   date Date
);

SELECT * from member;

drop table member;


show tables;