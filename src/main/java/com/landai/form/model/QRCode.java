package com.landai.form.model;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "t_qrcode")
public class QRCode {

    private @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    private String ossName;
    private String formId;

}
