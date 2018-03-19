package com.landai.form.model;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "t_form_control")
public class Control {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String formId;
    @OneToOne
    @JoinColumn(name = "component_id")
    private Component component;
    private String name;
    private String label;

}
