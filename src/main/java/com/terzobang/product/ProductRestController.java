package com.terzobang.product;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.terzobang.common.response.Response;
import com.terzobang.common.response.ResponseUtil;

@RestController
@RequestMapping("/product")
public class ProductRestController {
	
	@RequestMapping("/create")
	public Response createProduct(
			@RequestParam("name") String name,
			@RequestParam("price") int price,
			@RequestParam("content") String content,
			@RequestParam("size") String size,
			@RequestParam("stock") int stock
			) {
		
		return ResponseUtil.ERROR(size, null);
		
		
		
		
	}
	

}
