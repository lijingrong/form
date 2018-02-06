package com.landai.form.model;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "t_form")
public class Form {

    @Id
    private String id;
    private String title;
    private String description;
    @ManyToOne
    @JoinColumn(name = "creator")
    private User user;

}
