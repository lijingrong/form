package com.landai.form.model;

import lombok.Data;
import lombok.ToString;

import javax.persistence.*;

@Data
@Entity
@Table(name = "t_form_value")
@ToString(exclude = {"form"})
public class FormValue {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "form_id")
    private Form form;

    private String formValue;
}
