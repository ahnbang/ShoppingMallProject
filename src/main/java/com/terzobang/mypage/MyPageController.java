package com.terzobang.mypage;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.terzobang.cart.bo.CartBO;
import com.terzobang.cart.model.CartItem;
import com.terzobang.member.model.Member;
import com.terzobang.mypage.model.CartTableDTO;
import com.terzobang.mypage.model.OrderTableDTO;
import com.terzobang.orders.bo.DeliveryBO;
import com.terzobang.orders.bo.OrderItemBO;
import com.terzobang.orders.bo.OrdersBO;
import com.terzobang.orders.model.OrderItem;
import com.terzobang.orders.model.Orders;
import com.terzobang.product.bo.ProductBO;
import com.terzobang.product.model.Product;

@Controller
@RequestMapping("/mypage")
public class MyPageController {
	
	@Autowired
	private CartBO cartBO;
	
	@Autowired
	private OrdersBO ordersBO;
	
	@Autowired
	private ProductBO productBO;
	
	@Autowired
	private DeliveryBO deliveryBO;
	
	@Autowired
	private OrderItemBO orderItemBO;
	
	@RequestMapping("/main")
	public String mypage(Model model, HttpSession session){
		
		Member member = (Member)session.getAttribute("loginMember");
		if (member == null) {
			return "member/signUpIn";
		}
		
		// OrderTable Part
		List<OrderTableDTO> orderTableDTOList = new ArrayList<>();
		List<Orders> ordersList = ordersBO.getAllOrdersByMemberId(member.getId());
		for(Orders orders : ordersList) {
			OrderTableDTO orderTableDTO = new OrderTableDTO();
			orderTableDTO.setOrders(orders);
			orderTableDTO.setDelivery(deliveryBO.getDeliveryById(orders.getDeliveryId()));
			orderTableDTO.setOrderItem(orderItemBO.getOrderItemListByOrderId(orders.getId()));
			List<Product> productList = new ArrayList<>();
			for(OrderItem orderItem : orderTableDTO.getOrderItem()) {
				productList.add(productBO.getProductByItemId(orderItem.getItemId()));
			}
			orderTableDTO.setProduct(productList);
			orderTableDTOList.add(orderTableDTO);	
		}
		model.addAttribute("orderTableDTOList", orderTableDTOList);
		
		// CartTable Part
		List<CartItem> cartItemList = cartBO.getAllCartItemByMemberId(member.getId());
		List<Product> productListFromCartItem = new ArrayList<>();
		for (CartItem cartItem : cartItemList ) {
			int itemId = cartItem.getItemId();
			Product product = productBO.getProductByItemId(itemId);
			productListFromCartItem.add(product);
		}
		
		CartTableDTO cartTableDTO = new CartTableDTO();
		cartTableDTO.setCartItemList(cartItemList);
		cartTableDTO.setProductListFromCartItem(productListFromCartItem);
		model.addAttribute("cartTableDTO",cartTableDTO);
		return "/mypage/main";

	}
	
	@RequestMapping("/orderhistory")
	public String mypageOrderHistory(Model model, HttpSession session){
		
		Member member = (Member)session.getAttribute("loginMember");
		if (member == null) {
			return "member/signUpIn";
		}
		List<OrderTableDTO> orderTableDTOList = new ArrayList<>();
		List<Orders> ordersList = ordersBO.getAllOrdersByMemberId(member.getId());
		for(Orders orders : ordersList) {
			OrderTableDTO orderTableDTO = new OrderTableDTO();
			orderTableDTO.setOrders(orders);
			orderTableDTO.setDelivery(deliveryBO.getDeliveryById(orders.getDeliveryId()));
			orderTableDTO.setOrderItem(orderItemBO.getOrderItemListByOrderId(orders.getId()));
			List<Product> productList = new ArrayList<>();
			for(OrderItem orderItem : orderTableDTO.getOrderItem()) {
				productList.add(productBO.getProductByItemId(orderItem.getItemId()));
			}
			orderTableDTO.setProduct(productList);
			orderTableDTOList.add(orderTableDTO);	
		}
		model.addAttribute("orderTableDTOList", orderTableDTOList);
		
		return "/mypage/orderHistory";
		
	}
	
	@RequestMapping("/cart")
	public String mypageCart(Model model, HttpSession session){
		
		Member member = (Member)session.getAttribute("loginMember");
		if (member == null) {
			return "member/signUpIn";
		}
		
		List<CartItem> cartItemList = cartBO.getAllCartItemByMemberId(member.getId());
		List<Product> productListFromCartItem = new ArrayList<>();
		for (CartItem cartItem : cartItemList ) {
			int itemId = cartItem.getItemId();
			Product product = productBO.getProductByItemId(itemId);
			productListFromCartItem.add(product);
		}
		
		CartTableDTO cartTableDTO = new CartTableDTO();
		cartTableDTO.setCartItemList(cartItemList);
		cartTableDTO.setProductListFromCartItem(productListFromCartItem);
		model.addAttribute("cartTableDTO",cartTableDTO);
		return "/mypage/cart";
	}

}
