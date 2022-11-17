package com.terzobang.orders.model;

import java.util.Date;

public class Orders {
	
	private int id;
	private int memberId;
	private int deliverId;
	private OrdersStauts status;
	private Date createdAt;
	private Date updatedAt;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getMemberId() {
		return memberId;
	}
	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}
	public int getDeliverId() {
		return deliverId;
	}
	public void setDeliverId(int deliverId) {
		this.deliverId = deliverId;
	}
	public OrdersStauts getStatus() {
		return status;
	}
	public void setStatus(OrdersStauts status) {
		this.status = status;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public Date getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	
	
	
}
