package com.terzobang.orders.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.terzobang.orders.model.OrderItem;

@Repository
public interface OrderItemDAO {
	
	public void insertOrderItem(OrderItem orderItem);
	public List<OrderItem> selectAllOrderItemByOrderId(int ordersId);

}
