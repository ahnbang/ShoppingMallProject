package com.terzobang.member.model;

public enum MemberRole {
	
	ADMIN(0.9), USER(0.1), VIP(0.5);
	
	private Double discountRatio;

	
	MemberRole(Double discountRatio){
		this.discountRatio = discountRatio;
	}
	
	public Double getDiscountRatio() {
		return discountRatio;
	}

}
