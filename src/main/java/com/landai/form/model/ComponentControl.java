package com.landai.form.model;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@Table(name = "t_component_control")
public class ComponentControl {

    @Id
    private Long id;
    private String controlLabel;
    private String controlName;
    //private String componentName;
}
