package com.asjy.commerplat.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.asjy.commerplat.model.Brand;
import com.asjy.commerplat.model.Goods;




@Component
public class ReadExcel{
	
	/**
     * read the Excel file
     * @param path the path of the Excel file
     * @return
     * @throws IOException
     */
    public List<Goods> readExcel(String path, List<Brand> list_brand, HttpServletResponse resp) throws IOException {
        if(StringUtils.isEmpty(path)){
            return null;
        }else{
            String postfix = Util.getPostfix(path);
            if (!Common.EMPTY.equals(postfix)) {
                if (Common.OFFICE_EXCEL_2003_POSTFIX.equals(postfix)) {
                    return readXls(path, list_brand,resp);
                } else if (Common.OFFICE_EXCEL_2010_POSTFIX.equals(postfix)) {
                    return readXlsx(path, list_brand,resp);
                }
            } else {
                System.out.println(path + Common.NOT_EXCEL_FILE);
            }
        }
        return null;
    }

    /**
     * Read the Excel 2010
     * @param path the path of the excel file
     * @return
     * @throws IOException
     */
    public List<Goods> readXlsx(String path, List<Brand> list_brand, HttpServletResponse resp) throws IOException {
        System.out.println(Common.PROCESSING+"readXlsx"+ path);
        InputStream is = new FileInputStream(path);
        XSSFWorkbook xssfWorkbook = new XSSFWorkbook(is);
        List<Goods> list = new ArrayList<Goods>();
      //读取内容
        System.out.println(xssfWorkbook.getNumberOfSheets());
        for (int numSheet = 0; numSheet < xssfWorkbook.getNumberOfSheets(); numSheet++) {
            XSSFSheet xssfSheet = xssfWorkbook.getSheetAt(numSheet);
            if (xssfSheet == null) {
                continue;
            }
            //从rowNum行开始循环读取表格中的数据，有数据的最后一行结束（xssfSheet.getLastRowNum()）
            for (int rowNum = 2; rowNum <= xssfSheet.getLastRowNum(); rowNum++) {
                XSSFRow xssfRow = xssfSheet.getRow(rowNum);
                if (xssfRow != null) {
                	Goods goods = new Goods();
                    XSSFCell goodsname = xssfRow.getCell(1);
                    XSSFCell inventory = xssfRow.getCell(2);
                    XSSFCell brandName = xssfRow.getCell(3);
                    XSSFCell originalprice =xssfRow.getCell(4);
                    XSSFCell sellprice =xssfRow.getCell(5);
                    
                    Map<String, Integer> map = new HashMap<String,Integer>();
                    if(list_brand != null && list_brand.size() > 0) {
                    	for(Brand brand : list_brand) {
                    		map.put(brand.getBrandname(), brand.getId());
                    	}
                    }
                    int brandId = 0;
                    if(map.containsKey(getValue(brandName))) {
                    	brandId = map.get(getValue(brandName));
                    }
                   
                    goods.setGoodsname(getValue(goodsname));
                    goods.setInventory(Integer.parseInt(getValue(inventory)));
                    goods.setBrandid(brandId);
                    goods.setOriginalprice(Long.parseLong(getValue(originalprice)));
                    goods.setSellprice(Long.parseLong(getValue(sellprice)));
                    list.add(goods);
                }
            }
        }
    	
        
        return list;
        
    }
    
    /**
     * Read the Excel 2003-2007
     * @param path the path of the Excel
     * @return
     * @throws IOException
     */
    public List<Goods> readXls(String path, List<Brand> list_brand, HttpServletResponse resp) throws IOException {
        System.out.println(Common.PROCESSING+"readXls"+ path); 
        InputStream is = new FileInputStream(path);
        HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
        Goods goods = null;
        List<Goods> list = new ArrayList<Goods>();
        
        
        int rowNum = 3;
        int exist_error = 0;
        
        // Read the Sheet
        for (int numSheet = 0; numSheet < hssfWorkbook.getNumberOfSheets(); numSheet++) {
            HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(numSheet);
            if (hssfSheet == null) {
                continue;
            }
            // Read the Row
            for (rowNum = 3; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
                HSSFRow hssfRow = hssfSheet.getRow(rowNum);
                if (hssfRow != null) {
                    goods = new Goods();
                    HSSFCell goodsname = hssfRow.getCell(1);
                    HSSFCell pprice = hssfRow.getCell(2);
                    HSSFCell sprice = hssfRow.getCell(3);
                    HSSFCell oprice = hssfRow.getCell(4);
                    HSSFCell storage = hssfRow.getCell(5);
                    HSSFCell weight = hssfRow.getCell(6);
                    HSSFCell size = hssfRow.getCell(7);
                    HSSFCell productnum = hssfRow.getCell(8);
                    HSSFCell status = hssfRow.getCell(9);
                    HSSFCell recommend = hssfRow.getCell(10);
                    HSSFCell classname = hssfRow.getCell(11);
                    HSSFCell brandname = hssfRow.getCell(12);
                    
                   
                    list.add(goods);
                }
            }
        }
        return list;
    }

    @SuppressWarnings("static-access")
    private String getValue(XSSFCell xssfRow) {
        if (xssfRow.getCellType() == xssfRow.CELL_TYPE_BOOLEAN) {
            return String.valueOf(xssfRow.getBooleanCellValue());
        } else if (xssfRow.getCellType() == xssfRow.CELL_TYPE_NUMERIC) {
        	
        	String temp = String.valueOf(xssfRow.getNumericCellValue());
        	if(temp.contains(".")){
        		temp = temp.substring(0, temp.indexOf("."));
        	}
        	
            return temp;
        } else {
            return String.valueOf(xssfRow.getStringCellValue());
        }
    }

    @SuppressWarnings("static-access")
    private String getValue(HSSFCell hssfCell) {
        if (hssfCell.getCellType() == hssfCell.CELL_TYPE_BOOLEAN) {
            return String.valueOf(hssfCell.getBooleanCellValue());
        } else if (hssfCell.getCellType() == hssfCell.CELL_TYPE_NUMERIC) {
            return String.valueOf(hssfCell.getNumericCellValue());
        } else {
            return String.valueOf(hssfCell.getStringCellValue());
        }
    }

	
    
}
