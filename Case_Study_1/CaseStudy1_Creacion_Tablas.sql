-- CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE IF NOT EXISTS `Danny's Diner`; 
USE `Danny's Diner`;

-- CREACIÓN DE LAS TABLAS
CREATE TABLE IF NOT EXISTS sales(
customer_id VARCHAR(1),
order_date DATE,
product_id INTEGER);

CREATE TABLE IF NOT EXISTS members(
customer_id VARCHAR(1),
join_date TIMESTAMP);

CREATE TABLE IF NOT EXISTS menu(
product_id INTEGER,
product_name VARCHAR(5),
price INTEGER);

-- INSERTAR DATOS EN LAS TABLAS

-- Tabla sales
INSERT INTO sales
VALUES
  ('A', '2021-01-01', 1),
  ('A', '2021-01-01', 2),
  ('A', '2021-01-07', 2),
  ('A', '2021-01-10', 3),
  ('A', '2021-01-11', 3),
  ('A', '2021-01-11', 3),
  ('B', '2021-01-01', 2),
  ('B', '2021-01-02', 2),
  ('B', '2021-01-04', 1),
  ('B', '2021-01-11', 1),
  ('B', '2021-01-16', 3),
  ('B', '2021-02-01', 3),
  ('C', '2021-01-01', 3),
  ('C', '2021-01-01', 3),
  ('C', '2021-01-07', 3);
  
-- Tabla menu
INSERT INTO menu
VALUES
  ('1', 'sushi', 10),
  ('2', 'curry', 15),
  ('3', 'ramen', 12);

-- Tabla members
INSERT INTO members
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');