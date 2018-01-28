package com.landai.form.model;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "t_control_validate")
public class ControlValidate {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private boolean required;
    private Integer minLength;
    private Integer maxLength;
    private String rangeLength;
    private Integer min;
    private Integer max;
    private boolean number;
    private boolean digits;

    @OneToOne
    @JoinColumn(name = "control_id")
    private SimpleFormControl control;

    @ManyToOne
    @JoinColumn(name = "form_id")
    private Form form;
}
