package com.terzobang.orders.dao;

import org.springframework.stereotype.Repository;

import com.terzobang.orders.model.Orders;

@Repository
public interface OrdersDAO {
	
	public void insertOrders(Orders orders);

}
