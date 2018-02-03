USE form;
DROP TABLE IF EXISTS t_form;
DROP TABLE IF EXISTS t_form_value;
DROP TABLE IF EXISTS t_component_prototype;
DROP TABLE IF EXISTS t_component;

CREATE TABLE t_form(
  id VARCHAR(10) PRIMARY KEY ,
  title VARCHAR(100),
  description VARCHAR(255)
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
