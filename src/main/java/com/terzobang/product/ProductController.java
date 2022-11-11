package com.terzobang.product;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.terzobang.member.model.Member;
import com.terzobang.member.model.MemberRole;

@Controller
@RequestMapping("/product")
public class ProductController {
	
	@RequestMapping("/createView")
	public String createProductView(HttpSession session) {
		
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		if(loginMember.getRole() != MemberRole.ADMIN) {
			return "/member/signUpIn";	 
		}
		else {
			return "/product/createView";
		}

	}
	
	

}
