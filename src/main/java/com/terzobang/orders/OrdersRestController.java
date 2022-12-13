package com.terzobang.orders;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.terzobang.cart.bo.CartBO;
import com.terzobang.common.response.Response;
import com.terzobang.member.model.Member;
import com.terzobang.orders.bo.OrdersBO;
@Transactional
@RestController
@RequestMapping("/order")
public class OrdersRestController {
	
	@Autowired
	private OrdersBO ordersBO;
	
	@Autowired
	private CartBO cartBO;
	
	
	@RequestMapping("/stockCheck")
	public Response stockCheck(@RequestParam("itemIdList")  List<Integer> itemIdList ,@RequestParam("orderCountList") List<Integer> orderCountList) {
		return ordersBO.stockCheckFilter(itemIdList, orderCountList);	
	}
	

	@Transactional
	@RequestMapping("/createOrder")
	public Response createlOrder (
			@RequestParam("itemIdList") List<Integer> itemIdList,
			@RequestParam("orderCountList") List<Integer> orderCountList,
			@RequestParam("address") String address,
			@RequestParam("addressDetail") String addressDetail,
			@RequestParam(required=false, value="cartItemIdList") List<Integer> cartItemIdList,
			HttpSession session
			){
		
		if (cartItemIdList != null) {
			for(int cartItemId : cartItemIdList) {
				cartBO.deleteCartItemById(cartItemId);
			}
			
		}
		String finalAddress = address + addressDetail;
		return 	ordersBO.createOrder((Member)session.getAttribute("loginMember"),itemIdList, orderCountList, finalAddress);
	}
	
	@Transactional
	@RequestMapping("/cancelOrder")
	public Response cancelOrder(
			@RequestParam("ordersId") int ordersId, 
			@RequestParam("orderItemId") int orderItemId, 
			@RequestParam("deliveryId") int deliveryId) {
		
		return ordersBO.cancelOrder(ordersId, deliveryId, orderItemId);
		
	}
	
	
	

	
	
	
}
