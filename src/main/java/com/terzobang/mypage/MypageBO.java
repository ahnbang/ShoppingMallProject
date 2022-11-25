package com.terzobang.mypage;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.terzobang.orders.bo.OrdersBO;
import com.terzobang.orders.model.Delivery;
import com.terzobang.orders.model.OrderItem;
import com.terzobang.orders.model.Orders;
import com.terzobang.product.bo.ProductBO;
import com.terzobang.product.model.Product;

@Service
public class MypageBO {
	
	@Autowired
	private OrdersBO ordersBO;
	
	@Autowired
	private ProductBO productBO;
	
	public HashMap<String,Object> createModelDataForView(int memberId){
		

		HashMap<String, Object> models = new HashMap<>();
		List<Orders> orderList = ordersBO.getAllOrdersByMemberId(memberId); // 회원id기반 orders 전부 가져오기
		models.put("orderList", orderList);
		
		HashMap<Integer,List<OrderItem>> orderItemList = new HashMap<Integer,List<OrderItem>>();// key = ordersId, value = orderItem
		HashMap<Integer, Delivery> deliveryList = new HashMap<Integer,Delivery>();// key = ordersId, value = delivery
		HashMap<Integer, Product> itemList = new HashMap<Integer,Product>();// key = orderItemId, value = Product
		
		// 
		for (Orders order : orderList) {
			int ordersId = order.getId();
			List<OrderItem> orderItems = new ArrayList<>();
			orderItems = ordersBO.getAllOrderItemByOrderId(ordersId);
			orderItemList.put(ordersId, orderItems);
			
			for (OrderItem orderItem : orderItems) {
				int itemId = orderItem.getItemId();
				itemList.put(orderItem.getId(), productBO.getProductByItemId(orderItem.getId()));
			};
			
			deliveryList.put(ordersId, ordersBO.getDeliveryById(order.getDeliveryId()));
		}
		models.put("orderItemList", orderItemList);
		models.put("deliveryList", deliveryList);
		models.put("itemList",itemList);
		
		return models;
	}

}
