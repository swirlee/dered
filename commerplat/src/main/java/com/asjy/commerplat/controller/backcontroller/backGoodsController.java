package com.asjy.commerplat.controller.backcontroller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.asjy.commerplat.model.Brand;
import com.asjy.commerplat.model.Classes;
import com.asjy.commerplat.model.Goods;
import com.asjy.commerplat.model.GoodsImages;
import com.asjy.commerplat.model.GoodsSpec;
import com.asjy.commerplat.model.Spec;
import com.asjy.commerplat.model.Specv;
import com.asjy.commerplat.service.Impl.IBrandService;
import com.asjy.commerplat.service.Impl.IClassesService;
import com.asjy.commerplat.service.Impl.IGoodsImagesService;
import com.asjy.commerplat.service.Impl.IGoodsService;
import com.asjy.commerplat.service.Impl.IGoodsSpecService;
import com.asjy.commerplat.service.Impl.ISpecService;
import com.asjy.commerplat.service.Impl.ISpecvService;
import com.asjy.commerplat.util.ReadExcel;

@Controller
@RequestMapping("/goods")
public class backGoodsController {
	
	@Autowired
	IGoodsService goodsService;
	
	@Autowired
	IGoodsImagesService goodsImagesService;
	
	@Autowired
	IClassesService classesService;
	
	@Autowired
	IBrandService brandService;
	
	@Autowired
	ReadExcel readExcel;
	
	@Autowired
	ISpecService specService;
	
	@Autowired
	ISpecvService specvService;
	
	@Autowired
	IGoodsSpecService goodsSpecService;
	
	
	@RequestMapping("/showGoods")
	public String showGoods(Model model ) {
		List<Goods> list_goods = goodsService.findAll();
		model.addAttribute("list_goods", list_goods);
		System.out.println(list_goods);
		return "back/goods_list";
	}
	
	
	@ResponseBody
	@RequestMapping("/ajax_update")
	public Map<String, Object> ajax_update(Integer id, String fieldName, String value) {
		
		Map<String, Object> result = new HashMap<>();
		
		Goods gg = goodsService.findById(id);
		if(fieldName.equals("originalprice")) {
			Long originalprice = Long.parseLong(value);
			gg.setOriginalprice(originalprice);;
		}
		if(fieldName.equals("sellprice")) {
			Long sellprice = Long.parseLong(value);
			gg.setSellprice(sellprice);
		}
		if(fieldName.equals("recommend")) {
			
				if(gg.getRecommend()!=null && gg.getRecommend()==true) {
					gg.setRecommend(false);
				}else
				if(gg.getRecommend()==null || gg.getRecommend()==false){
					gg.setRecommend(true);
				}	
		}
		if(fieldName.equals("delete")) {
			int dd = goodsService.deleteById(id);
			System.out.println("dd的值为："+dd);
			result.put("dd", dd);
		}
		
		int hh = goodsService.updateByPrimaryKeySelective(gg);
		System.out.println(hh);
		result.put("gg", gg);
		return result;
	}
	
	
	@RequestMapping("/addGoods")
	public String addGoods(Model model,Integer pid ) {
		List<Classes> list_classes = classesService.findbypid(pid);
		List<Brand> list_brand = brandService.findAll();
		List<Spec> list_spec = specService.findAll();
		model.addAttribute("list_classes", list_classes);
		model.addAttribute("list_brand", list_brand);
		model.addAttribute("list_spec", list_spec);
		return "back/goods_add";
	}
	
	@RequestMapping("/ajax_classes_select")
	@ResponseBody
	public Map<String, Object> ajax_classes_select(String pid) {
		System.out.println("进入ajax_classes_select");
		Map<String, Object> result = new HashMap<>();
		List<Classes> list_classes = classesService.findbypid(Integer.parseInt(pid));
		result.put("list_classes", list_classes);
		return result;
	}
	
	@RequestMapping("/ajax_spec_select")
	@ResponseBody
	public Map<String, Object> ajax_spec_select(String id) {
		Map<String, Object> result = new HashMap<>();
		List<Specv> list_specv = specvService.findByPid(Integer.parseInt(id));
		result.put("list_specv", list_specv);
		return result;
	}
	
	@RequestMapping("/findByGoodsNumber")
	@ResponseBody
	public Boolean findByGoodsNumber(String goodsnumber,HttpServletResponse resp) {
		Boolean ggnn;
		Goods gg = goodsService.findByGoodsNumber(goodsnumber);
		if(gg != null) {
			ggnn=false;
		}else {
			ggnn=true;
		}
		return ggnn;
	}
	

	
	
	
	@RequestMapping("/editGoods")
	public String editGoods(Model model, Integer id) {
		
		Goods goods = goodsService.findById(id);
		Integer c3id = goods.getClassid();
		if(c3id!=null) {
		Classes c3 = classesService.findbyid(c3id);
		Integer c2id = c3.getPid();
		Classes c2 = classesService.findbyid(c2id);
		Integer c1id = c2.getPid();
		List<Classes> list_classes = classesService.findbypid(0);
		List<Classes> list_classes2 = classesService.findbypid(c1id);
		List<Classes> list_classes3 = classesService.findbypid(c2id);
		model.addAttribute("list_classes", list_classes);
		model.addAttribute("list_classes2", list_classes2);
		model.addAttribute("list_classes3", list_classes3);
		model.addAttribute("c1id", c1id);
		model.addAttribute("c2id", c2id);
		model.addAttribute("c3id", c3id);
		}
		List<Brand> list_brand = brandService.findAll();
		List<GoodsImages> list_imagesPath = goodsImagesService.findByGoodsId(id);
		model.addAttribute("list_imagesPath", list_imagesPath);
		model.addAttribute("list_brand", list_brand);
		model.addAttribute("goods", goods);
		//查询规格
		List<Spec> list_spec = specService.findAll();
		model.addAttribute("list_spec", list_spec);
		List<Spec> list_specs = specService.findByGoodsId(id);
		Spec spp1 = specService.selectedById(list_specs.get(0).getId());
		Spec spp2 = specService.selectedById(list_specs.get(1).getId());
		model.addAttribute("spec1", list_specs.get(0));
		model.addAttribute("spec2", list_specs.get(1));
		model.addAttribute("spp1", spp1);
		model.addAttribute("spp2", spp2);
		return "back/goods_edit";
	}
	
	@RequestMapping(value="/saveGoods",method=RequestMethod.POST)
	public String saveGoods(HttpServletRequest request,HttpServletResponse response,Integer  spec1,Integer  specv1,Integer  spec2,Integer  specv2,
							String goodsname, Integer classes3, String recommend,Integer brand,
							Long sellprice,Long originalprice,Integer inventory,String state,
							Long volume,Long weight,String goodsnumber,String details)throws IllegalStateException, IOException {
		/**
		 *此方法用来执行添加商品的操作，重点是包含了“图片的上传”！！！
		 */
		Date addtime = new Date();
        Goods goods = new Goods();
		String newFileName = null;
		GoodsImages goodsImages = new GoodsImages();
		//创建一个通用的多部分解析器   MultipartHttpServletRequest mreq = (MultipartHttpServletRequest)req;
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());  
        //判断 request 是否有文件上传,即多部分请求  
        if(multipartResolver.isMultipart(request)){  
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;//转换成多部分request
        	//取得request中的所有文件名
            Iterator<String> iter = multiRequest.getFileNames();  
            int i = 0;
	        while(iter.hasNext()){  
	            //取得上传文件  
	            MultipartFile file = multiRequest.getFile(iter.next());
	            if(file != null){
	                //取得当前上传文件的文件名称  
	                String myFileName = file.getOriginalFilename();  
	                SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	                //如果名称不为"",说明该文件存在，否则说明该文件不存在  
	                if(! myFileName.trim().equals("")){
	                    //文件重命名  
	                    newFileName = sdf.format( new Date()) + i + myFileName.substring(myFileName.lastIndexOf('.') );
	                    //将文件存在指定的虚拟路径下
	            	    FileOutputStream fos = new FileOutputStream("D:/uploadFiles/"+newFileName);
	            	    fos.write(file.getBytes());
	            	    fos.flush();//刷新缓冲区
	            	    fos.close();//关闭资源
	                }  
	            } 
	            if(i == 0) {
	            	goods.setPath("/asjy/file/"+newFileName);
	            	goods.setAddtime(addtime);
	                goods.setBrandid(brand);
	                goods.setClassid(classes3);
	                goods.setWeight(weight);
	                goods.setDetails(details);
	                goods.setGoodsname(goodsname);
	                goods.setGoodsnumber(goodsnumber);
	                goods.setInventory(inventory);
	                goods.setOriginalprice(originalprice);
	                goods.setSellprice(sellprice);
	                goods.setState(state);
	                goods.setVolume(volume);
	                if(recommend.equals("true")) {
	                	goods.setRecommend(true);
	        		}else {
	        			goods.setRecommend(false);
	        		}
	                goodsService.addGoods(goods);
	                
	                GoodsSpec goodsSpec1 = new GoodsSpec();
	                goodsSpec1.setGoodsid(goods.getId());
	                goodsSpec1.setGoodsnumber(goodsnumber);
	                goodsSpec1.setSpecid(spec1);
	                goodsSpec1.setSpecvid(specv1);
	                GoodsSpec goodsSpec2 = new GoodsSpec();
	                goodsSpec2.setGoodsid(goods.getId());
	                goodsSpec2.setGoodsnumber(goodsnumber);
	                goodsSpec2.setSpecid(spec2);
	                goodsSpec2.setSpecvid(specv2);
	                goodsSpecService.addGoodsSpec(goodsSpec1);
	                goodsSpecService.addGoodsSpec(goodsSpec2);
	                
	            }else {
	            	goodsImages.setPath("/asjy/file/"+newFileName);
	            	goodsImages.setGoodsid(goods.getId());
	            	goodsImagesService.addGoodsImages(goodsImages);
	            }
	            i++;
	        } 
        }
        return "redirect:/goods/showGoods";
	}
	
	

	@RequestMapping(value="/doeditGoods",method=RequestMethod.POST)
	public String doeditGoods(HttpServletRequest request,HttpServletResponse response,Integer goodsid,String[] imagesPaths,
							String goodsname, Integer classes3, String recommend,Integer brand,String file0,
							Long sellprice,Long originalprice,Integer inventory,String state,String[] oldimgids,String deltePictureArr,
							Long volume,Long weight,String goodsnumber,String details,Integer  spec1,Integer  specv1,Integer  spec2,Integer  specv2)throws IllegalStateException, IOException {
		/**
		 *此方法用来执行添加商品的操作，重点是包含了“图片的上传”！！！
		 */
		//删除商品图片表中的图片
		String[] delteArr = deltePictureArr.split(",");
		if(delteArr.length>0 && oldimgids.length>0 && !delteArr[0].equals("")) {
			for (String str : delteArr) {
				int a = 0;
				for (String oldid : oldimgids) {
					if(oldid.equals(str)) {
						a++;
					}
				}
				if(a==0) {
					goodsSpecService.deleteById(Integer.parseInt(str));
				}
			}
		}
		if(delteArr.length>0 && oldimgids.length==0 && !delteArr[0].equals("")) {
			for (String str : delteArr) {
				goodsSpecService.deleteById(Integer.parseInt(str));
			}
		}
		
		
        Goods goods = goodsService.findById(goodsid);
		String newFileName = null;
		GoodsImages goodsImages = new GoodsImages();
		
		//创建一个通用的多部分解析器
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();

        //判断 request 是否有文件上传,即多部分请求  
        if(multipartResolver.isMultipart(request)){  
        	//转换成多部分request
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;
        	//取得request中的所有文件名
            Iterator<String> iter = multiRequest.getFileNames();
            int i = 0;
            int j = 0;
	        while(iter.hasNext()){  
	            //取得上传文件  
	            MultipartFile file = multiRequest.getFile(iter.next());
	            if(file != null){
	                //取得当前上传文件的文件名称  
	                String myFileName = file.getOriginalFilename();
	                if(!myFileName.equals("/images/add.jpg") && !myFileName.equals("") && myFileName!=null) {
		                SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		                //如果名称不为"",说明该文件存在，否则说明该文件不存在  
		                if(! myFileName.trim().equals("")){
		                    //文件重命名  
		                    newFileName =sdf.format( new Date()) + i + myFileName.substring(myFileName.lastIndexOf('.') );
		                    //将文件存在指定的虚拟路径下
		            	    FileOutputStream fos = new FileOutputStream("D:/uploadFiles/"+newFileName);
		            	    fos.write(file.getBytes());
		            	    fos.flush();//刷新缓冲区
		            	    fos.close();//关闭资源
		                } 
	               
	             
	         
	            if(file0!=null &&!file0.equals("")&& i==0) {
	            	goods.setPath("/asjy/file/"+newFileName);
	                
	            }
	            else if(imagesPaths!=null && imagesPaths.length>=j && i<=imagesPaths.length){
	            	System.out.println(imagesPaths[j]);
	            	GoodsImages goodsImages1=goodsImagesService.findBYId(Integer.parseInt(oldimgids[j]));
            		goodsImages1.setPath("/asjy/file/"+newFileName);
            		goodsImagesService.updateGoodsImages(goodsImages1);
            		j++;
	            }
	            else{
            		goodsImages.setPath("/asjy/file/"+newFileName);
	            	goodsImages.setGoodsid(goods.getId());
	            	goodsImagesService.addGoodsImages(goodsImages);
	            }
	        }
	            }
	        i++;
	        }
	        goods.setBrandid(brand);
            goods.setClassid(classes3);
            goods.setWeight(weight);
            goods.setDetails(details);
            goods.setGoodsname(goodsname);
            goods.setGoodsnumber(goodsnumber);
            goods.setInventory(inventory);
            goods.setOriginalprice(originalprice);
            goods.setSellprice(sellprice);
            goods.setState(state);
            goods.setVolume(volume);
            if(recommend.equals("true")) {
            	goods.setRecommend(true);
    		}else {
    			goods.setRecommend(false);
    		}
            goodsService.updateGoods(goods);
            
            List<GoodsSpec> list_goods_spec = goodsSpecService.findByGoodsId(goodsid);
            list_goods_spec.get(0).setGoodsnumber(goodsnumber);
            list_goods_spec.get(0).setSpecid(spec1);
            list_goods_spec.get(0).setSpecvid(specv1);
            list_goods_spec.get(1).setGoodsnumber(goodsnumber);
            list_goods_spec.get(1).setSpecid(spec2);
            list_goods_spec.get(1).setSpecvid(specv2);
            goodsSpecService.updateGoodsSpec(list_goods_spec.get(0));
            goodsSpecService.updateGoodsSpec(list_goods_spec.get(1));
	    } 
        return "redirect:/goods/showGoods";
	}
	
	

	
	
	
	
	
	@RequestMapping(value="/excelUpload",method=RequestMethod.POST)
	public String excelUpload(HttpServletRequest req) throws IOException {
		
		//上传EXCEL文档
		MultipartHttpServletRequest mreq = (MultipartHttpServletRequest)req;
		MultipartFile file = mreq.getFile("excelFile");
		String fileName = file.getOriginalFilename();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String path = "D:/uploadFiles"+sdf.format(new Date())+fileName.substring(fileName.lastIndexOf('.'));
		FileOutputStream fos = new FileOutputStream(path);
		fos.write(file.getBytes());
		fos.flush();
		fos.close();
		
		
		//解析excel
		List<Brand> list_brand = brandService.findAll();
		
		List<Goods> list = readExcel.readExcel(path, list_brand, null);
		for(Goods goods : list) {
			goodsService.addGoods(goods);
		}
		return "redirect:/goods/showGoods";
	}
	
	
	
	
}
