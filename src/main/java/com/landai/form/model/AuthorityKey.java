package com.landai.form.model;

import lombok.Data;

import java.io.Serializable;

@Data
public class AuthorityKey implements Serializable{

    private String username;
    private String authority;

}
