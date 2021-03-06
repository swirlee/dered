package com.asjy.commerplat.util;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.regex.Pattern;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Component;
import com.asjy.commerplat.model.Order;


@Component
public class ExcelUtil {
	
	//创建excel文件对象
	public static XSSFWorkbook exportExcelForOrder(List<Order> list_order) {  
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-HH:mm:ss");
		//创建excel表格  
		//excel为03版本及以下（.xls）的用“HSSFWorkbook”
		//excel为07版本及以上（.xlsx）的用“HSSFWorkbook”
		XSSFWorkbook wb = new XSSFWorkbook();
		String status = "";
		String recommend = "";
		
		//创建名字为" "的sheet页
		Sheet sheet = wb.createSheet("订单列表页");
		
		//创建第一行  
		Row row1 = sheet.createRow(0);  
		//创建第二行  
		Row row2 = sheet.createRow(1);  
		//文件头字体                                                          加粗              字体           斜体              字号
		Font font0 = createFonts(wb, Font.BOLDWEIGHT_BOLD, "宋体", false, (short) 250);  
		Font font1 = createFonts(wb, Font.BOLDWEIGHT_NORMAL, "hakuyoxingshu7000", false,  (short) 250);  
		//合并第一行的单元格                                                                              行     行    列      列
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 5));  
		
		//设置第一行的文字  
		createCell(wb, row1, 0, "用户订单信息列表", font1); 
		
		//给第二行添加文本  
		createCell(wb, row2, 0, "序号", font0); 
		createCell(wb, row2, 1, "买家", font0);
		createCell(wb, row2, 2, "订单号", font0);
		createCell(wb, row2, 3, "下单时间", font0);
		createCell(wb, row2, 4, "订单总额", font0);
		createCell(wb, row2, 5, "订单状态", font0);
		
		//第四行表示  
		int line = 2;  
		//这里将商品的信息存入到表格中          
		for (int i = 0; i < list_order.size(); i++) {  
		    //创建一行  
			
		    Row rowData = sheet.createRow(line++);  
		    Order order = list_order.get(i);
		    createCell(wb, rowData, 0, String.valueOf(i+1), font0); 
		    createCell(wb, rowData, 1, order.getUser().getUsername(), font0);
		    createCell(wb, rowData, 2, order.getOrdernumber(), font0);
			createCell(wb, rowData, 3, String.valueOf(sdf.format(order.getAddtime())), font0);
			createCell(wb, rowData, 4, String.valueOf(order.getTotalprice()), font0);
			createCell(wb, rowData, 5, String.valueOf(order.getOrderstate()), font0);
		}
		//自动调节列宽
		for(int x = 0; x < 15; x++){
			sheet.autoSizeColumn(x);
		}
		return wb;  
	}
	/**
	 * 创建单元格并设置样式,值
	 * 
	 * @param wb
	 * @param row
	 * @param column
	 * @param
	 * @param
	 * @param value
	 */
	public static void createCell(Workbook wb, Row row, int column,	String value, Font font) {
		Cell cell = row.createCell(column);
		cell.setCellValue(value);
		CellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		cellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_BOTTOM);
		cellStyle.setFont(font);
		cell.setCellStyle(cellStyle);
	}

	/**
	 * 设置字体
	 * 
	 * @param wb
	 * @return
	 */
	public static Font createFonts(Workbook wb, short bold, String fontName,boolean isItalic, short hight) {
		Font font = wb.createFont();
		font.setFontName(fontName);
		font.setBoldweight(bold);
		font.setItalic(isItalic);
		font.setFontHeight(hight);
		return font;
	}

	/**
	 * 判断是否为数字
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isNumeric(String str) {
		if (str == null || "".equals(str.trim()) || str.length() > 10)
			return false;
		Pattern pattern = Pattern.compile("^0|[1-9]\\d*(\\.\\d+)?$");
		return pattern.matcher(str).matches();
	}

}
