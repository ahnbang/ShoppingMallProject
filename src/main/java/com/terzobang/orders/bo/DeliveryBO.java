package com.terzobang.orders.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.terzobang.orders.dao.DeliveryDAO;
import com.terzobang.orders.model.Delivery;

@Service
@Transactional
public class DeliveryBO {
	
	@Autowired
	private DeliveryDAO deliveryDAO;
	
	
	@Transactional
	public void createDelivery(Delivery delivery) {
		
		deliveryDAO.insertDelivery(delivery);	
	}
	
	public Delivery getDeliveryById(int deliveryId) {
		
		return deliveryDAO.selectDeliveryById(deliveryId);
	}
	
	
	
	
	
	
}
