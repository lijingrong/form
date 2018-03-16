package com.landai.form.model;

import lombok.Data;

/**
 * Excel Table Header
 *
 * @author <a href="mailto:huangjiang1026@gmail.com">H.J</a> on 2018/3/6 16:49
 */
@Data
public class ExcelTH {

    private String name;
    private String label;
    private String type;

    public ExcelTH() {
    }

    public ExcelTH(String name, String label, String type) {
        this.name = name;
        this.label = label;
        this.type = type;
    }
}
