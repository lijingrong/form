package com.landai.form.model;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Data
@Entity
@Table(name = "t_form")
public class Form {

    @Id
    private String id;
    private String title;
    private String description;
    private String afterPostDesc;
    private Boolean template;
    @ManyToOne
    @JoinColumn(name = "creator")
    private User user;
    private Date createTime = new Date();
    @Enumerated(EnumType.STRING)
    private FormStatus status = FormStatus.DRAFT;
}
