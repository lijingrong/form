package com.landai.form.model;

import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * @author <a href="mailto:huangjiang1026@gmail.com">H.J</a> on 2018/3/6 16:16
 */
@Data
public class Excel {

    private List<ExcelTH> headers;
    private List<Map> values;
    private Short defaultColumnWidth = 5000;
    private Short defaultRowHeight = 500;
    private Short sheetNum = 0;
    private String sheetName;
}
