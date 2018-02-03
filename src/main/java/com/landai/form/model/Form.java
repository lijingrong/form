package com.landai.form.model;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@Table(name = "t_form")
public class Form {

    @Id
    private String id;
    private String title;
    private String description;

}
