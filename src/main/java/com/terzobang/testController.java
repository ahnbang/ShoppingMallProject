package com.terzobang;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.terzobang.product.model.ItemCategory;
import com.terzobang.product.model.ItemSex;

@Controller
public class testController {
	
	@RequestMapping("test")
	public String Test() {
		return "admin/index";
	}
	
	@RequestMapping("test2")
	public String Test2() {
		return "admin/layout-static";
	}
	
	@RequestMapping("test3")
	public String test3(Model model) {
		model.addAttribute("testcase", ItemSex.MALE);
		return "test3";
	}
	

}
