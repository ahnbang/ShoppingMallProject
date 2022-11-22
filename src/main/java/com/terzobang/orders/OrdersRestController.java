package com.terzobang.orders;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.terzobang.member.model.Member;
import com.terzobang.orders.bo.OrdersBO;

@RestController

public class OrdersRestController {
	
	@Autowired
	private OrdersBO ordersBO;
	@RequestMapping("/order")
	public String createOrder (@RequestParam("orderCount") int orderCount, @RequestParam("itemId") int itemId, HttpSession session) {
		
		List<List<Integer>> orderInfo = new ArrayList<>();
		List<Integer> infoData = new ArrayList<>();
		infoData.add(itemId);
		infoData.add(orderCount);
		orderInfo.add(infoData);
		
		ordersBO.createOrder((Member) session.getAttribute("loginMember"), orderInfo);
		
		
		
		
		
		
	
		return "orderCount:"+ itemId;
		
	}
	
	
	
	
	
}
