package com.landai.form.service;

import com.landai.form.model.Excel;
import com.landai.form.model.ExcelTH;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Map;

/**
 * @author <a href="mailto:huangjiang1026@gmail.com">H.J</a> on 2018/3/6 14:58
 */
@Service
public class ExcelService {

    /**
     * 设置单元格样式和值
     *
     * @param row         row对象
     * @param cellStyle   单元格样式对象
     * @param columnIndex 列索引
     * @param cellValue   单元格值
     */
    public void setCellStyleAndValue(Row row, CellStyle cellStyle, Integer columnIndex, String cellValue) {
        Cell cell = row.createCell(columnIndex);
        cell.setCellStyle(cellStyle);
        cell.setCellValue(cellValue);
    }

    /**
     * 定制导出表格的标题行
     *
     * @param wb          workbook对象
     * @param sheet       sheet对象
     * @param columnIndex 列索引
     * @param rowIndex    行索引
     * @param excel       excel对象
     */
    public void customTitleRow(Workbook wb, Sheet sheet, Integer columnIndex, Integer rowIndex, Excel excel) {
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, excel.getHeaders().size() - 1));
        Row row = sheet.createRow(rowIndex);
        row.setHeight(excel.getDefaultRowHeight());
        setCellStyleAndValue(row, customTitleCellStyle(wb), columnIndex, excel.getSheetName());
    }

    /**
     * 定制导出表格的表头行
     *
     * @param wb       workbook对象
     * @param sheet    sheet对象
     * @param excel    excel对象
     * @param rowIndex 行索引
     */
    public void customHeaderRow(Workbook wb, Sheet sheet, Excel excel, Integer rowIndex) {
        Row row = sheet.createRow(rowIndex);
        row.setHeight(excel.getDefaultRowHeight());
        for (int i = 0; i < excel.getHeaders().size(); i++) {
            sheet.setColumnWidth(i, excel.getDefaultColumnWidth());
            setCellStyleAndValue(row, customHeaderCellStyle(wb), i, excel.getHeaders().get(i).getLabel());
        }
    }

    /**
     * 定制标题单元格样式
     *
     * @param wb workbook对象
     * @return CellStyle
     */
    public CellStyle customTitleCellStyle(Workbook wb) {
        CellStyle cs = wb.createCellStyle();
        cs.setFillForegroundColor(IndexedColors.SKY_BLUE.getIndex()); // 黄色
        cs.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        setHorizontalAndVertical(cs);
        cs.setWrapText(true);
        cs.setFont(setCellFont(wb, (short) 16, true));
        return cs;
    }

    /**
     * 定制表格表头单元格样式
     *
     * @param wb workbook对象
     * @return CellStyle
     */
    public CellStyle customHeaderCellStyle(Workbook wb) {
        CellStyle cs = wb.createCellStyle();
        cs.setFillForegroundColor(IndexedColors.LIGHT_BLUE.getIndex()); // 青蓝色
        cs.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        setHorizontalAndVertical(cs);
        cs.setWrapText(true);
        setBorderCellStyle(cs);
        cs.setFont(setCellFont(wb, (short) 14, true));
        return cs;
    }

    /**
     * 定制表格表体单元格样式
     *
     * @param wb workbook对象
     * @return CellStyle
     */
    public CellStyle customBodyCellStyle(Workbook wb) {
        CellStyle cs = wb.createCellStyle();
        setHorizontalAndVertical(cs);
        cs.setWrapText(true);
        setBorderCellStyle(cs);
        return cs;
    }

    /**
     * 设置单元格边框样式为 thin
     *
     * @param cs CellStyle 对象
     */
    public void setBorderCellStyle(CellStyle cs) {
        cs.setBorderBottom(BorderStyle.THIN);
        cs.setBorderLeft(BorderStyle.THIN);
        cs.setBorderTop(BorderStyle.THIN);
        cs.setBorderRight(BorderStyle.THIN);
    }

    /**
     * 设置水平垂直对齐方式-居中
     *
     * @param cs CellStyle 对象
     */
    public void setHorizontalAndVertical(CellStyle cs) {
        setHorizontalAndVertical(cs, HorizontalAlignment.CENTER, VerticalAlignment.CENTER);
    }

    /**
     * 设置水平垂直对齐方式
     *
     * @param cs         CellStyle 对象
     * @param horizontal 水平对象
     * @param vertical   垂直对象
     */
    public void setHorizontalAndVertical(CellStyle cs, HorizontalAlignment horizontal, VerticalAlignment vertical) {
        cs.setAlignment(horizontal);
        cs.setVerticalAlignment(vertical);
    }

    /**
     * 设置单元格字体样式
     *
     * @param wb       workbook对象
     * @param fontSize 字体大小
     * @param bold     是否加粗
     * @return Font
     */
    public Font setCellFont(Workbook wb, Short fontSize, Boolean bold) {
        Font font = wb.createFont();
        font.setFontHeightInPoints(fontSize);
        font.setBold(bold);
        return font;
    }

    /**
     * 设置导出表格的表头
     *
     * @param wb       workbook对象
     * @param sheet    sheet对象
     * @param excel    excel对象
     * @param rowIndex 行索引
     * @return Integer
     */
    public Integer setExportTableHeader(Workbook wb, Sheet sheet, Excel excel, Integer rowIndex) {
        wb.setSheetName(excel.getSheetNum(), excel.getSheetName());
//        customTitleRow(wb, sheet, 0, rowIndex++, excel);
//        sheet.createRow(rowIndex++).setHeight(excel.getDefaultRowHeight());
        customHeaderRow(wb, sheet, excel, rowIndex++);
        return rowIndex;
    }

    /**
     * 设置导出表单数据
     *
     * @param wb       workbook对象
     * @param sheet    sheet对象
     * @param excel    excel对象
     * @param rowIndex 行索引
     * @return Integer
     */
    public Integer setExportFormData(Workbook wb, Sheet sheet, Excel excel, Integer rowIndex) {
        if (excel.getValues().size() > 0) {
            Row row;
            for (Map map : excel.getValues()) {
                row = sheet.createRow(rowIndex);
                int columnIndex = 0;
                for (ExcelTH header : excel.getHeaders()) {
                    columnIndex = handleFormSingleData(wb, row, map.get(header.getName()), columnIndex);
                }
                rowIndex++;
            }
        }
        return rowIndex;
    }

    /**
     * 处理导出表单单条数据
     *
     * @param wb          workbook对象
     * @param row         row对象
     * @param ob          数据值
     * @param columnIndex 列索引
     * @return Integer
     */
    public Integer handleFormSingleData(Workbook wb, Row row, Object ob, Integer columnIndex) {
        String cellValue = "";
        if (null != ob) {
            if (ob instanceof ArrayList) {
                cellValue = StringUtils.join(((ArrayList) ob).toArray(), ",");
            } else {
                cellValue = ob.toString();
            }
        }
        setCellStyleAndValue(row, customBodyCellStyle(wb), columnIndex, cellValue);
        columnIndex++;
        return columnIndex;
    }
}
