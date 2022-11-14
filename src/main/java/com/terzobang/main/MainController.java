package com.terzobang.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.terzobang.product.bo.ProductBO;

@Controller
public class MainController {
	
	@Autowired
	private ProductBO productBO;
	
	@RequestMapping("/main")
	public String Main(Model model) {
		
		model.addAttribute("allProdcuts", productBO.getAllProduct());	
		
		return "/main/main";
	}

}
