package com.landai.form.model;

import lombok.Data;

import java.io.Serializable;

@Data
public class ControlKey implements Serializable{

    private String formId;
    private String name;

}
