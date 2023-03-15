package com.terzobang.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.terzobang.product.bo.ProductBO;
import com.terzobang.product.model.Product;

@Controller
public class MainController {
	
	private final ProductBO productBO;
	
	@Autowired
	public MainController(ProductBO productBO) {
		this.productBO = productBO;
	}
	
	
	@RequestMapping("/main")
	public String Main(Model model) {
		model.addAttribute("allProdcuts", productBO.getAllProduct());	
		return "/main/main";
	}
	
	@GetMapping("/productDetail/{itemId}")
	public String prodcutDetail(@PathVariable int itemId, Model model) {
		
		model.addAttribute("product", productBO.getProductByItemId(itemId));
		return "/main/productDetail";
		
	}

}
