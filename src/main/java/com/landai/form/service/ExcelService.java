package com.landai.form.service;

import com.landai.form.model.Excel;
import com.landai.form.model.ExcelTH;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.*;

/**
 * @author <a href="mailto:huangjiang1026@gmail.com">H.J</a> on 2018/3/6 14:58
 */
@Service
public class ExcelService {

    private static final String XLS_FILE = "xls";
    private static final String XLSX_FILE = "xlsx";

    //****---------------------文件导入相关-------------------*******//

    /**
     * 检查文件是否存在，是否是excel文件
     *
     * @param file 文件
     * @return Status
     */
    public String checkFile(MultipartFile file) {
        // 判断文件是否存在
        if (null != file) {
            // 获得文件扩展名
            int pointIndex = file.getOriginalFilename().lastIndexOf(".");
            String postfix = file.getOriginalFilename().substring(pointIndex + 1).toLowerCase();

            if (!postfix.equals(XLS_FILE) && !postfix.equals(XLSX_FILE)) {
                return null;
            }
        }
        return null;
    }

    /**
     * 获得Workbook工作薄对象
     *
     * @param file 文件
     * @return Workbook
     */
    private Workbook getWorkBook(MultipartFile file) throws Exception {
        // 获得文件扩展名
        int pointIndex = file.getOriginalFilename().lastIndexOf(".");
        String postfix = file.getOriginalFilename().substring(pointIndex + 1).toLowerCase();

        // 创建Workbook工作薄对象，表示整个excel
        Workbook workbook = null;

        // 获取excel文件的io流
        InputStream is = file.getInputStream();

        // 根据文件后缀名不同(xls和xlsx)获得不同的Workbook实现类对象
        if (postfix.equals(XLS_FILE)) { // 2003
            workbook = new HSSFWorkbook(is);
        } else if (postfix.equals(XLSX_FILE)) { // 2007
            workbook = new XSSFWorkbook(is);
        }

        is.close();
        return workbook;
    }

    /**
     * 读取Excel第一个sheet工作表的内容，并返回读取结果
     * Excel需求：只读取第一个sheet工作表；工作表内单元格不能合并，第一行是标题
     *
     * @param file 文件
     * @return List, Map key: rowNum-行号，rowData-行数据 以数组形式组装
     * @throws Exception 异常
     */
    public List<Map<String, Object>> readFirstSheetContent(MultipartFile file) throws Exception {
        List<Map<String, Object>> list = new ArrayList<>();
        Workbook workbook = getWorkBook(file);

        if (null == workbook) {
            return null;
        }

        // 获得第一个sheet工作表
        Sheet sheet = workbook.getSheetAt(0);
        if (null == sheet) {
            return null;
        }

        // 获得当前sheet的开始行
        int firstRowNum = sheet.getFirstRowNum();
        // 获得当前sheet的结束行
        int lastRowNum = sheet.getLastRowNum();
        // 循环除第一行的所有行
        for (int rowNum = firstRowNum + 1; rowNum <= lastRowNum; rowNum++) {
            // 获得当前行
            Row row = sheet.getRow(rowNum);
            // 略过空行
            if (null == row) {
                continue;
            }

            // 获得当前行的开始列
            int firstCellNum = row.getFirstCellNum();
            // 获得当前行的列数
            int lastCellNum = row.getPhysicalNumberOfCells();
            String[] cells = new String[row.getPhysicalNumberOfCells()];
            // 循环当前行
            for (int cellNum = firstCellNum; cellNum < lastCellNum; cellNum++) {
                Cell cell = row.getCell(cellNum);
                cells[cellNum] = getCellValue(cell);
            }

            // 组装map数据
            Map<String, Object> map = new HashMap<>();
            map.put("rowNum", rowNum);
            map.put("rowData", cells);

            list.add(map);
        }
        workbook.close();

        return list;
    }

    /**
     * 获取单元格内容
     *
     * @param cell 单元格对象
     * @return String
     */
    private String getCellValue(Cell cell) {
        String cellValue = "";
        if (null == cell) {
            return cellValue;
        }

        // 把数字当成String来读，避免出现1读成1.0的情况
        if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
            cell.setCellType(Cell.CELL_TYPE_STRING);
        }

        // 判断数据的类型
        switch (cell.getCellType()) {
            case Cell.CELL_TYPE_NUMERIC: // 数字
                cellValue = String.valueOf(cell.getNumericCellValue());
                break;
            case Cell.CELL_TYPE_STRING: // 字符串
                cellValue = String.valueOf(cell.getStringCellValue());
                break;
            case Cell.CELL_TYPE_BOOLEAN: // Boolean
                cellValue = String.valueOf(cell.getBooleanCellValue());
                break;
            case Cell.CELL_TYPE_FORMULA: // 公式
                cellValue = String.valueOf(cell.getCellFormula());
                break;
            case Cell.CELL_TYPE_BLANK: // 空值
                cellValue = "";
                break;
            case Cell.CELL_TYPE_ERROR: // 故障
                cellValue = "非法字符";
                break;
            default:
                cellValue = "未知类型";
                break;
        }
        return cellValue;
    }


    //****---------------------文件导出相关-------------------*******//

    /**
     * 根据文件后缀名不同(xls和xlsx)创建不同的Workbook实现类对象
     *
     * @param postfix 文件后缀名
     * @return Workbook
     */
    private Workbook createWorkbook(String postfix) {
        Workbook wb = null;
        if (postfix.equals(XLS_FILE)) { // 2003
            wb = new HSSFWorkbook();
        } else if (postfix.equals(XLSX_FILE)) { // 2007
            wb = new XSSFWorkbook();
        }
        return wb;
    }

    /**
     * 设置单元格样式和值
     *
     * @param row         row对象
     * @param cellStyle   单元格样式对象
     * @param columnIndex 列索引
     * @param cellValue   单元格值
     */
    private void setCellStyleAndValue(Row row, CellStyle cellStyle, Integer columnIndex, String cellValue) {
        Cell cell = row.createCell(columnIndex);
        cell.setCellStyle(cellStyle);
        cell.setCellValue(cellValue);
    }

    /**
     * 设置导出表格的标题行
     *
     * @param wb          workbook对象
     * @param sheet       sheet对象
     * @param columnIndex 列索引
     * @param rowIndex    行索引
     * @param excel       excel对象
     */
    private void setTitleRow(Workbook wb, Sheet sheet, Integer columnIndex, Integer rowIndex, Excel excel) {
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, excel.getHeaders().size() - 1));
        Row row = sheet.createRow(rowIndex);
        row.setHeight(excel.getHeaderRowHeight());
        setCellStyleAndValue(row, setTitleCellStyle(wb), columnIndex, excel.getSheetName());
    }

    /**
     * 设置导出表格的表头行
     *
     * @param wb       workbook对象
     * @param sheet    sheet对象
     * @param excel    excel对象
     * @param rowIndex 行索引
     */
    private void setHeaderRow(Workbook wb, Sheet sheet, Excel excel, Integer rowIndex) {
        Row row = sheet.createRow(rowIndex);
        row.setHeight(excel.getHeaderRowHeight());
        for (int i = 0; i < excel.getHeaders().size(); i++) {
            sheet.setColumnWidth(i, excel.getDefaultColumnWidth());
            setCellStyleAndValue(row, setHeaderCellStyle(wb), i, excel.getHeaders().get(i).getLabel());
        }
    }

    /**
     * 设置标题单元格样式
     *
     * @param wb workbook对象
     * @return CellStyle
     */
    private CellStyle setTitleCellStyle(Workbook wb) {
        CellStyle cs = wb.createCellStyle();
        cs.setFillForegroundColor(IndexedColors.SKY_BLUE.getIndex()); // 天空蓝
        cs.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        setHorizontalAndVertical(cs);
        cs.setWrapText(true);
        cs.setFont(setCellFont(wb, (short) 16, true));
        return cs;
    }

    /**
     * 设置表格表头单元格样式
     *
     * @param wb workbook对象
     * @return CellStyle
     */
    private CellStyle setHeaderCellStyle(Workbook wb) {
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
     * 设置表格表体单元格样式
     *
     * @param wb workbook对象
     * @return CellStyle
     */
    private CellStyle setBodyCellStyle(Workbook wb) {
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
    private void setBorderCellStyle(CellStyle cs) {
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
    private void setHorizontalAndVertical(CellStyle cs) {
        setHorizontalAndVertical(cs, HorizontalAlignment.CENTER, VerticalAlignment.CENTER);
    }

    /**
     * 设置水平垂直对齐方式
     *
     * @param cs         CellStyle 对象
     * @param horizontal 水平对象
     * @param vertical   垂直对象
     */
    private void setHorizontalAndVertical(CellStyle cs, HorizontalAlignment horizontal, VerticalAlignment vertical) {
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
    private Font setCellFont(Workbook wb, Short fontSize, Boolean bold) {
        Font font = wb.createFont();
        font.setFontHeightInPoints(fontSize);
        font.setBold(bold);
        return font;
    }

    /**
     * 设置导出数据
     *
     * @param wb       workbook对象
     * @param sheet    sheet对象
     * @param excel    excel对象
     * @param rowIndex 行索引
     * @return Integer
     */
    private Integer setExportData(Workbook wb, Sheet sheet, Excel excel, Integer rowIndex) {
        if (excel.getValues().size() > 0) {
            Row row;
            for (Map map : excel.getValues()) {
                row = sheet.createRow(rowIndex);
                if (null != excel.getBodyRowHeight()) {
                    row.setHeight(excel.getBodyRowHeight());
                }
                int columnIndex = 0;
                for (ExcelTH header : excel.getHeaders()) {
                    columnIndex = handleSingleData(wb, row, map.get(header.getName()), columnIndex);
                }
                rowIndex++;
            }
        }
        return rowIndex;
    }

    /**
     * 处理导出单条数据
     *
     * @param wb          workbook对象
     * @param row         row对象
     * @param ob          数据值
     * @param columnIndex 列索引
     * @return Integer
     */
    private Integer handleSingleData(Workbook wb, Row row, Object ob, Integer columnIndex) {
        String cellValue = "";
        if (null != ob) {
            if (ob instanceof ArrayList) {
                cellValue = StringUtils.join(((ArrayList) ob).toArray(), ",");
            } else {
                cellValue = ob.toString();
            }
        }
        setCellStyleAndValue(row, setBodyCellStyle(wb), columnIndex, cellValue);
        columnIndex++;
        return columnIndex;
    }

    /**
     * 导出数据，默认导出xlsx后缀的excel文件，只写入第一个sheet页
     *
     * @param response HttpServletResponse 对象
     * @param excel    Excel 对象
     * @throws Exception IO异常
     */
    public void exportData(HttpServletResponse response, Excel excel) throws Exception {
        Workbook wb = createWorkbook(XLSX_FILE);
        Sheet sheet = wb.createSheet();
        int rowIndex = 0;
        wb.setSheetName(0, excel.getSheetName());
//        setTitleRow(wb, sheet, 0, rowIndex++, excel);
//        sheet.createRow(rowIndex++).setHeight(excel.getHeaderRowHeight());
        setHeaderRow(wb, sheet, excel, rowIndex++);
        setExportData(wb, sheet, excel, rowIndex);

        response.setHeader("Content-Disposition", "attachment;filename=" + excel.getFileName() + "." + XLSX_FILE);
        response.setContentType("application/vnd.ms-excel");
        OutputStream os = response.getOutputStream();
        wb.write(os);
        os.close();
    }
}
