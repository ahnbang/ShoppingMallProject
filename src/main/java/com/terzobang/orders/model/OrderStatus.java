package com.terzobang.orders.model;

public enum OrderStatus {
	
	ORDER("주문완료"), CANCEL("주문취소");
	
	private String statusValue;

	
	OrderStatus(String statusValue){
		this.statusValue = statusValue;
	}
	
	public String getStatusValue() {
		return statusValue;
	}
	
	
	

}
