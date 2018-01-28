package com.landai.form.model;

import lombok.Data;
import lombok.ToString;

import javax.persistence.*;
import java.util.List;

@Data
@Entity
@Table(name = "t_form")
@ToString(exclude = {"controlList"})
public class Form {

    @Id
    private String id;
    private String title;
    private String description;

    @ManyToMany
    @JoinTable(name = "t_form_control",
            joinColumns = @JoinColumn(name = "form_id", referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(name = "control_id", referencedColumnName = "id"))
    private List<SimpleFormControl> controlList;
}
