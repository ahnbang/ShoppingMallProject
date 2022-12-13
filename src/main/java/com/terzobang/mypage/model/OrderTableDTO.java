package com.terzobang.mypage.model;


import java.util.List;
import com.terzobang.orders.model.Delivery;
import com.terzobang.orders.model.OrderItem;
import com.terzobang.orders.model.Orders;
import com.terzobang.product.model.Product;

public class OrderTableDTO {
	
	// 1
	private Orders orders;
	private Delivery delivery;
	
	// N
	private List<OrderItem> orderItem;
	private List<Product> product;
	
	public Orders getOrders() {
		return orders;
	}
	public void setOrders(Orders orders) {
		this.orders = orders;
	}
	public Delivery getDelivery() {
		return delivery;
	}
	public void setDelivery(Delivery delivery) {
		this.delivery = delivery;
	}
	public List<OrderItem> getOrderItem() {
		return orderItem;
	}
	public void setOrderItem(List<OrderItem> orderItem) {
		this.orderItem = orderItem;
	}
	public List<Product> getProduct() {
		return product;
	}
	public void setProduct(List<Product> product) {
		this.product = product;
	}

	
	
}
