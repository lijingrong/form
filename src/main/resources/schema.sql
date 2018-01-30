USE form;
DROP TABLE IF EXISTS t_control  ;
DROP TABLE IF EXISTS t_control_data ;
DROP TABLE IF EXISTS t_form;
DROP TABLE IF EXISTS t_form_control;
DROP TABLE IF EXISTS t_control_validate;
DROP TABLE IF EXISTS t_validate_rule;
DROP TABLE IF EXISTS t_validate_rule_group;
DROP TABLE IF EXISTS t_validate_rule_group_rule;
DROP TABLE IF EXISTS t_rule_value;
DROP TABLE IF EXISTS t_validate_rule_group_control_type;

CREATE TABLE t_control(
  id BIGINT AUTO_INCREMENT PRIMARY KEY ,
  name VARCHAR(50),
  type VARCHAR(50),
  label VARCHAR(50),
  view_name VARCHAR(50),
  is_common BOOLEAN,
  rule_group_id BIGINT
);

CREATE TABLE t_control_data(
  id BIGINT AUTO_INCREMENT PRIMARY KEY ,
  control_id BIGINT,
  name VARCHAR(50),
  value VARCHAR(50)
);

CREATE TABLE t_form(
  id VARCHAR(10) PRIMARY KEY ,
  title VARCHAR(100),
  description VARCHAR(255)
);

CREATE TABLE t_form_control(
  form_id VARCHAR(10),
  control_id BIGINT
);

CREATE TABLE t_control_validate(
  id BIGINT AUTO_INCREMENT PRIMARY KEY ,
  required BOOLEAN,
  min_length INT,
  max_length INT,
  range_length VARCHAR(10),
  min DOUBLE,
  max DOUBLE,
  number BOOLEAN,
  digits BOOLEAN,
  control_id BIGINT NOT NULL,
  form_id VARCHAR(10) NOT NULL
);

CREATE TABLE t_validate_rule(
  id BIGINT AUTO_INCREMENT PRIMARY KEY ,
  name VARCHAR(100) NOT NULL ,
  label VARCHAR(100) NOT NULL,
  type VARCHAR(10) NOT NULL
);

CREATE TABLE t_validate_rule_group(
  id BIGINT AUTO_INCREMENT PRIMARY KEY ,
  group_name VARCHAR(100) NOT NULL,
  group_label VARCHAR(100)
);

CREATE TABLE t_validate_rule_group_control_type(
  validate_rule_group_id BIGINT NOT NULL ,
  control_type VARCHAR(50) NOT NULL ,
  PRIMARY KEY (validate_rule_group_id,control_type)
);

CREATE TABLE t_validate_rule_group_rule(
  rule_id BIGINT NOT NULL ,
  rule_group_id BIGINT NOT NULL ,
  PRIMARY KEY (rule_group_id,rule_id)
);

CREATE TABLE t_rule_value(
  id BIGINT AUTO_INCREMENT PRIMARY KEY ,
  rule_value VARCHAR(100),
  rule_id BIGINT NOT NULL ,
  control_id BIGINT NOT NULL ,
  form_id VARCHAR(50) NOT NULL
);

