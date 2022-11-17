package com.terzobang.orders.dao;

import org.springframework.stereotype.Repository;

import com.terzobang.orders.model.Delivery;

@Repository
public interface DeliveryDAO {
	
	public void insertDelivery(Delivery delivery);

}
