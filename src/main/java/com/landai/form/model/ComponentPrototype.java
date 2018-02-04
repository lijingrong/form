package com.landai.form.model;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Data
@Entity
@Table(name = "t_component_prototype")
public class ComponentPrototype implements Serializable{

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
    @OneToMany
    @JoinColumn(name = "component_name", referencedColumnName = "name")
    private List<ComponentControl> controls;
}
