CREATE TABLE member(
   idx int primary key auto_increment, 
   email varchar(50) unique not null,
   pass varchar(16) not null,
   nick varchar(16) unique not null,
   phone varchar(20) unique not null,
   date Date
   
);

CREATE table grade(
	idx int primary key auto_increment,
	nick VARCHAR(50) not null,
	grade int NOT NULL,
	gener VARCHAR(40) NOT NULL,
	movieSeq int NOT NULL,
	title VARCHAR(100) NOT NULL,
	runtime int NOT NULL,
	wish VARCHAR(1),
	FOREIGN KEY (nick) REFERENCES member(nick)
);

CREATE table collection(
	idx int primary key auto_increment,
	nick VARCHAR(50) not null,
	collection_name varchar(100) NOT NULL,
	movieSeq int NOT NULL,
	title VARCHAR(100) NOT NULL,
	poster VARCHAR(200)
);

CREATE table review(
	idx int primary key auto_increment,
	nick VARCHAR(50) not null,
	grade int NOT NULL,
	gener VARCHAR(40) NOT NULL,
	movieSeq int NOT NULL,
	title VARCHAR(100) NOT NULL,
	type_name VARCHAR(100) NOT NULL,
	content VARCHAR(10000) NOT NULL,
	likecount int NOT NULL
);

CREATE table recommend_user(
	idx int primary key auto_increment,
	nick VARCHAR(50) not null,
	1st VARCHAR(20) UNIQUE ,
	2nd VARCHAR(20) UNIQUE ,
	3rd VARCHAR(20) UNIQUE ,
	4th VARCHAR(20) UNIQUE ,
	5th VARCHAR(20) UNIQUE ,
	FOREIGN KEY (nick) REFERENCES member(nick)
);


