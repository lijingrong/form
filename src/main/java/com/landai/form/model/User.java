package com.landai.form.model;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Data
@Entity
@Table(name = "users")
public class User {

    @Id
    private String username;
    private String password;
    private String telephone;
    private String nickname;
    private String organization;
    private Boolean enabled = Boolean.TRUE;

    @Transient
    private String verifyCode;
    @Transient
    private String phoneCode;
    @Transient
    private String confirmPassword;
}
