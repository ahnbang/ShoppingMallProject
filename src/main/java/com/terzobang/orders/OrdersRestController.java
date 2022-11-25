package com.terzobang.orders;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.terzobang.common.response.Response;
import com.terzobang.common.response.ResponseUtil;
import com.terzobang.member.model.Member;
import com.terzobang.orders.bo.OrdersBO;

@RestController
public class OrdersRestController {
	
	@Autowired
	private OrdersBO ordersBO;
	
	
	@RequestMapping("/stockCheck")
	public Response stockCheck(@RequestParam("itemIdList")  List<Integer> itemIdList ,@RequestParam("orderCountList") List<Integer> orderCountList) {

		return ordersBO.stockCheckFilter(itemIdList, orderCountList);
		
	}
	
	
	@RequestMapping("/orderCheckView")
	public String orderCheckView(@RequestParam("orderCountList") List<Integer> orderCountList, @RequestParam("itemIdList")  List<Integer> itemIdList) {
		
		return "test";
		
	}
	
	
	
	@RequestMapping("/createOrder")
	public Response createlOrder (@RequestParam("itemIdList") List<Integer> itemIdList, @RequestParam("orderCountList") List<Integer> orderCountList, HttpSession session){
		ordersBO.createOrder((Member)session.getAttribute("loginMember"),itemIdList, orderCountList);
		return ResponseUtil.SUCCESS("", null);	
	}
	

	
	
	
}
