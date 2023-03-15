package com.terzobang.admin;

import java.net.URI;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.terzobang.common.response.Response;
import com.terzobang.common.response.ResponseStatus;
import com.terzobang.product.bo.ProductBO;
import com.terzobang.product.model.ItemCategory;
import com.terzobang.product.model.ItemSex;
import com.terzobang.product.model.Product;

@RestController
@RequestMapping("/admin")
public class AdminRestController {
	
	private final ProductBO productBO;
	@Autowired
	public AdminRestController(ProductBO productBO) {
		this.productBO = productBO;
	}
	
	@RequestMapping("/addProduct")
	public ResponseEntity<?> addProduct(
			@RequestParam("name") String name,
			@RequestParam("content") String content,
			@RequestParam("category") ItemCategory category,
			@RequestParam("sex") ItemSex sex,
			@RequestParam("size") String size,
			@RequestParam("price") int price,
			@RequestParam("stock") int stock,
			@RequestParam("images") List<MultipartFile> images
			,HttpServletResponse responses){
		
		Response result = productBO.createProduct(name, content, category, sex, size, price, stock, images);
		HttpHeaders headers = new HttpHeaders();
		if (result.getStatus() == ResponseStatus.SUCCESS) {
			headers.setLocation(URI.create("/admin/createProductView"));
		}else {
			headers.setLocation(URI.create("/admin/main"));
		}
		return new ResponseEntity<>(headers, HttpStatus.MOVED_PERMANENTLY);
	}
	
	@RequestMapping("/deleteProduct")
	public Response deleteProduct(@RequestParam("itemId") int itemId) {
		return productBO.deleteProductByitemId(itemId);
		
	}
	
	@RequestMapping("/updateProduct")
	public Response updateProduct(
			@RequestParam("itemId") int itemId,
			@RequestParam("name") String name,
			@RequestParam("content") String content,
			@RequestParam("category") ItemCategory category,
			@RequestParam("size") String size,
			@RequestParam("price") int price,
			@RequestParam("stock") int stock,
			@RequestParam("sex") ItemSex sex
			) {
			
		return productBO.updateItemByItemId(itemId, name, content, category, size, price, stock, sex);
		
	
	}
}
