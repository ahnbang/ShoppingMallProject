package com.terzobang.admin;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.terzobang.member.bo.MemberBO;
import com.terzobang.product.bo.ProductBO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	private final ProductBO productBO;
	private final MemberBO memberBO;
	
	@Autowired
	public AdminController(ProductBO productBO, MemberBO memberBO) {
		this.productBO = productBO;
		this.memberBO = memberBO;
	}
	
	

	
	@RequestMapping("/main")
	public String adminMain(Model model, HttpSession session) {
		
		if(session.getAttribute("loginMember") == null) {
			return "redirect:/member/signInView";
		}
		
		model.addAttribute("memberList", memberBO.getAllMember());
		return "/admin/main";
	}
	
	@RequestMapping("/createProductView")
	public String createProductView() {
		return "/admin/createProduct";
	}
	
	@RequestMapping("/readProductView")
	public String readProductView() {
	
		return "/admin/readProductView";
	}
	
	@RequestMapping("/selectCategoryAjaxReuslt")
	public String selectCategoryAjaxReuslt(Model model) {
		return "admin/selectCategoryAjaxReuslt";
		
	}
	
	@RequestMapping("/readProductView/selectCategoryAjax")
	public String selectCategory(@RequestParam("category") String category, Model model){
			
			if (category.equals("ALL")){
				model.addAttribute("productList",productBO.getAllProduct()); 
				
			}
			else {
				model.addAttribute("productList",productBO.getProductByCategory(category));
			}
	
			return "admin/selectCategoryAjaxReuslt";
	}
	
	
	
	
	
	
}
