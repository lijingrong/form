package com.landai.form.model;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "t_control_data")
public class NameValuePair extends AbstractNameValuePair {

    @ManyToOne
    @JoinColumn(name = "control_id")
    private SimpleFormControl control;

}
