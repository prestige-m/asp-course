
USE callboard;


CREATE TABLE options(
id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
name VARCHAR(150),
value VARCHAR(150)
);


CREATE TABLE roles(
id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
name VARCHAR(150) NOT NULL
);

CREATE TABLE regions(
id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
name VARCHAR(150)
);

CREATE TABLE cities(
id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
name VARCHAR(150),
region_id FOREIGN KEY REFERENCES regions(id) NOT NULL,
);


CREATE TABLE categories(
id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
name VARCHAR(150)
);

CREATE TABLE subcategories(
id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
name VARCHAR(150),
category_id INT FOREIGN KEY REFERENCES categories(id) NOT NULL,
);

CREATE TABLE users(
id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
email VARCHAR(100) NOT NULL,
password VARCHAR(100) NOT NULL,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
patronymic VARCHAR(100) NOT NULL,
image_name VARCHAR(100) DEFAULT('default.png'),
contact VARCHAR(200),
role_id INT FOREIGN KEY REFERENCES roles(id) NOT NULL,
is_active INT DEFAULT(0) NOT NULL,
creation_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE announcements (
id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
title VARCHAR(150) NOT NULL,
user_id INT FOREIGN KEY REFERENCES users(id) NOT NULL,
subcategory_id INT FOREIGN KEY REFERENCES subcategories(id) NOT NULL,
city_id INT FOREIGN KEY REFERENCES cities(id) NOT NULL,
image_name VARCHAR(100) DEFAULT('no-image.png'),
creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
message_text TEXT,
price NUMERIC(18, 2)
);

CREATE TABLE mail(
id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
user_id INT FOREIGN KEY REFERENCES users(id) NOT NULL,
email VARCHAR(80) NOT NULL,
is_active TINYINT NOT NULL
);


CREATE TABLE mail_subscribe(
id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
mail_id INT FOREIGN KEY REFERENCES mail(id) NOT NULL,
subject_id INT FOREIGN KEY REFERENCES subjects(id) NOT NULL,
);


