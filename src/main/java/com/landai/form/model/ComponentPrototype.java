package com.landai.form.model;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "t_component_prototype")
public class ComponentPrototype {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String label;
    private String viewPage;
    private String editPage;
    private String data;
    private String validateRules;
    private Boolean isCommon;
    private String type;
}
