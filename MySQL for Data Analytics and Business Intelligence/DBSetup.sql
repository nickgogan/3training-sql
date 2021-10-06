-- Create database
create database if not exists training_sales;

-- Set the default db to be used by subsequent queries.
-- Otherwise, you have to do db_name.table_name
use training_sales;

-- Create tables
create table sales
(
	purchase_number int not null primary key auto_increment,
	date_of_purchase date not null,
    customer_id int,
    item_code varchar(10) not null
); 

-- Another way to designate a primary key for a table 
create table sales
(
	purchase_number int not null auto_increment,
	date_of_purchase date not null,
    customer_id int,
    item_code varchar(10) not null,
primary key(purchase_number)
); 
drop table sales;

-- Create the “customers” table in the “sales” database. Let it contain the following 5 columns: customer_id, first_name, last_name, email_address, and number_of_complaints. Let the data types of customer_id and number_of_complaints be integer, while the data types of all other columns be VARCHAR of 255.
create table customers
(
	customer_id int not null primary key,
    first_name varchar(255),
    last_name varchar(255),
    number_of_complaints int
);
-- Forgot to add the email_address field
alter table customers
add column email_address varchar(255);

select * from sales;
select * from training_sales.sales;

-- Practice adding primary key the low-level way
drop table training_sales.customers;
create table customers
(
	customer_id int not null,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
    number_of_complaints int,
primary key(customer_id)
);

create table items
(
	item_code varchar(255),
    item varchar(255),
    unit_price numeric(10,2),
    company_id varchar(255),
primary key(item_code)
);

create table companies
(
	company_id varchar(255) not null primary key,
    company_name varchar(255),
    headquarters_phone_number int(12)
);

-- Looking to the next few lectures of the course, drop all tables from the “Sales” database in the following order: first drop “sales”, then “customers”, “items”, and finally “companies”.
drop table training_sales.sales;
drop table customers;
drop table items;
drop table training_sales.companies;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT,
PRIMARY KEY (customer_id)
);

ALTER TABLE customers
ADD COLUMN gender ENUM('M', 'F') AFTER last_name;

INSERT INTO customers (first_name, last_name, gender, email_address, number_of_complaints)
VALUES ('John', 'Mackinley', 'M', 'john.mckinley@365careers.com', 0);

alter table customers
change column number_of_complaints number_of_complaints int default 0;

insert into customers 
(first_name, last_name, gender) values ('n', 'g', 'M');
select * from customers;

alter table customers
alter column number_of_complaints drop default;

/* Recreate the “companies” table
(company_id – VARCHAR of 255,  
company_name – VARCHAR of 255,  
headquarters_phone_number – VARCHAR of 255)
This time setting the “headquarters phone number” to be the unique key, and default value of the company name to be X. After you execute the code properly, drop the “companies” table. */
create table companies
(
	company_id varchar(255) not null primary key,
    company_name varchar(255) not null,
    headquarters_phone_number varchar(255) unique default 'X'
);
alter table companies
alter column headquarters_phone_number drop default;

alter table companies
add unique(company_name);

drop table companies;

-- Using ALTER TABLE, first add the NULL constraint to the headquarters_phone_number field in the “companies” table, and then drop that same constraint.
alter table companies
modify headquarters_phone_number varchar(255) not null;
-- OR
alter table companies
change column headquarters_phone_number headquarters_phone_number varchar(255) not null;
