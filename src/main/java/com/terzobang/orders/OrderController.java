package com.terzobang.orders;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.terzobang.member.bo.MemberBO;
import com.terzobang.orders.bo.OrdersBO;
import com.terzobang.product.bo.ProductBO;
import com.terzobang.product.model.Product;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	private OrdersBO ordersBO;
	
	@Autowired
	private ProductBO productBO;
	
	private Logger log = LoggerFactory.getLogger(OrdersBO.class);
	
	@PostMapping("/orderCheck")
	public String orderCheckView(@RequestParam("itemId") List<Integer> itemId ,@RequestParam("orderCount") List<Integer> orderCount,
			@RequestParam(required=false, value="cartItemId") List<Integer> cartItemId, Model model) {
		
		// this mean order is from cart
		if(cartItemId != null) {
			model.addAttribute("cartItemId",cartItemId);
		}

		
		int totalPrice = 0;
		List<Product> productList = new ArrayList<>();
		for (int i =0; i < itemId.size(); i++) {
			Product product = new Product();
			product = productBO.getProductByItemId(itemId.get(i));
			productList.add(product);
			totalPrice += (product.getItem().getPrice())*(orderCount.get(i));
		}
		
		model.addAttribute("productList",productList);
		model.addAttribute("orderCountList",orderCount);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("itemIdList",itemId);
		model.addAttribute("orderCountList",orderCount);
		
		
		return "/main/orderCheck";
	}

}
