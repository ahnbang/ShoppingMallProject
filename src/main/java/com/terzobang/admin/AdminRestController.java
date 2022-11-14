package com.terzobang.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.terzobang.admin.bo.AdminBO;
import com.terzobang.common.response.Response;
import com.terzobang.product.model.ItemCategory;
import com.terzobang.product.model.ItemSex;

@RestController
@RequestMapping("/admin")
public class AdminRestController {
	
	@Autowired
	private AdminBO adminBO;
	
	@RequestMapping("/addProduct")
	public Response addProduct(
			@RequestParam("name") String name,
			@RequestParam("content") String content,
			@RequestParam("category") ItemCategory category,
			@RequestParam("sex") ItemSex sex,
			@RequestParam("size") String size,
			@RequestParam("price") int price,
			@RequestParam("stock") int stock,
			@RequestParam("images") List<MultipartFile> images
			){
		 
		Response result = adminBO.addProduct(name, content, category, sex, size, price, stock, images);
		
		return result;
		
		
		
	}
	
	

}
