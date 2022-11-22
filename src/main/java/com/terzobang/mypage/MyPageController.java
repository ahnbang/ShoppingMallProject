package com.terzobang.mypage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.terzobang.member.model.Member;
import com.terzobang.orders.model.Delivery;
import com.terzobang.orders.model.OrderItem;
import com.terzobang.orders.model.Orders;
import com.terzobang.product.model.Product;

@Controller
public class MyPageController {
	
	@Autowired
	private MypageBO mypageBO;
	
	@RequestMapping("/mypage")
	public String Mypage(Model model, HttpSession session){
		
		// 모델이 들고 가야할 애들 : orders, delivery, orderItem, Product(item+image)
		
		Member member = (Member)session.getAttribute("loginMember");
		if (member == null) {
			return "member/signUpIn";
		}
		
		HashMap<String, Object> models = mypageBO.createModelDataForView(member.getId());
		model.addAttribute("orders", models.get("orderList"));
		model.addAttribute("orderItem",models.get("orderItemList"));
		model.addAttribute("delivery", models.get("deliveryList"));
		model.addAttribute("item",models.get("itemList"));
		
		return "mypage/main";
	}

}
