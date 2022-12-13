package com.terzobang.orders.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.terzobang.orders.dao.OrderItemDAO;
import com.terzobang.orders.model.OrderItem;

@Service
@Transactional
public class OrderItemBO {
	
	@Autowired
	private OrderItemDAO orderItemDAO;
	
	@Transactional
	public void createOrderItem(OrderItem orderItem) {
		
		orderItemDAO.insertOrderItem(orderItem);
	}
	
	@Transactional
	public List<OrderItem> getOrderItemListByOrderId(int ordersId){
		return orderItemDAO.selectAllOrderItemByOrderId(ordersId);
	}
	
	@Transactional
	public List<OrderItem> getOrderItemById(int orderItemId){
		return orderItemDAO.selectOrderItemById(orderItemId);
	}
	
	

}
