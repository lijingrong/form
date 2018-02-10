USE form;
DROP TABLE IF EXISTS t_form;
DROP TABLE IF EXISTS t_form_value;
DROP TABLE IF EXISTS t_component_prototype;
DROP TABLE IF EXISTS t_component;
DROP TABLE IF EXISTS t_form_control;
DROP TABLE IF EXISTS t_component_control;
DROP TABLE IF EXISTS authorities;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  username VARCHAR(50) NOT NULL PRIMARY KEY,
  password VARCHAR(50) NOT NULL,
  enabled  BOOLEAN     NOT NULL,
  telephone VARCHAR(20) NOT NULL UNIQUE ,
  nickname VARCHAR(50) UNIQUE ,
  organization VARCHAR(100)
);

CREATE TABLE authorities (
  username  VARCHAR(50) NOT NULL,
  authority VARCHAR(50) NOT NULL
);
CREATE TABLE t_form(
  id VARCHAR(10) PRIMARY KEY ,
  title VARCHAR(100) NOT NULL ,
  creator VARCHAR(20) NOT NULL ,
  create_time DATETIME DEFAULT now(),
  status VARCHAR(10) NOT NULL ,
  description TEXT
);

CREATE TABLE t_form_value(
  id BIGINT AUTO_INCREMENT PRIMARY KEY ,
  form_id VARCHAR(10),
  form_value TEXT
);

CREATE TABLE t_component_prototype(
  id BIGINT AUTO_INCREMENT PRIMARY KEY ,
  name VARCHAR(20),
  label VARCHAR(255),
  view_page VARCHAR(50),
  edit_page VARCHAR(50),
  data TEXT,
  validate_rules TEXT,
  type VARCHAR(10),
  is_common BOOLEAN DEFAULT TRUE
);

CREATE TABLE t_component(
  id BIGINT AUTO_INCREMENT PRIMARY KEY ,
  name VARCHAR(20),
  label VARCHAR(255),
  view_page VARCHAR(50),
  edit_page VARCHAR(50),
  data TEXT,
  validate_rules TEXT,
  description VARCHAR(255),
  form_id VARCHAR(10),
  type VARCHAR(10)
);

CREATE TABLE t_form_control(
  id BIGINT AUTO_INCREMENT PRIMARY KEY ,
  form_id VARCHAR(10),
  component_id BIGINT,
  label VARCHAR(255),
  name VARCHAR(10)
);

CREATE TABLE t_component_control(
  id BIGINT AUTO_INCREMENT PRIMARY KEY ,
  component_name VARCHAR(50),
  control_label VARCHAR(255),
  control_name VARCHAR(50)
);
