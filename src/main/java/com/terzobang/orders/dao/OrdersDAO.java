package com.terzobang.orders.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.terzobang.orders.model.OrderItem;
import com.terzobang.orders.model.Orders;

@Repository
public interface OrdersDAO {
	
	public void insertOrders(Orders orders);
	public List<Orders> selectAllOrdersByMemberId(int memberId);
	

}
