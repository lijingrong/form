package com.landai.form.model;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "t_component")
public class Component {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String label;
    private String viewPage;
    private String editPage;
    private String data;
    private String validateRules;
    @ManyToOne
    @JoinColumn(name = "form_id")
    private Form form;
    @Transient
    private String html;
    private String description;
    private String type;
    private Short orders;
}
