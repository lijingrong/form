package com.landai.form.model;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;
import java.io.Serializable;

@Data
@Entity
@Table(name = "authorities")
@IdClass(AuthorityKey.class)
public class Authority implements Serializable {
    @Id
    private String username;
    @Id
    private String authority;

    public Authority() {
    }

    public Authority(String username, String authority) {
        this.username = username;
        this.authority = authority;
    }
}
