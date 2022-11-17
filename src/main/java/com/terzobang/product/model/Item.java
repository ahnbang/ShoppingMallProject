package com.terzobang.product.model;

import java.util.Date;

import com.terzobang.common.exception.NotEnoughStockException;

public class Item {
	
	private int id;
	private String name;
	private int price;
	private String content;
	private String size;
	private int stock;
	private ItemCategory category;
	private ItemSex sex;
	private Date createdAt;
	private Date updatedAt;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public ItemCategory getCategory() {
		return category;
	}
	public void setCategory(ItemCategory category) {
		this.category = category;
	}
	public ItemSex getSex() {
		return sex;
	}
	public void setSex(ItemSex sex) {
		this.sex = sex;
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
	
	//비니지스 로직 entity내부에 설계하는 방식 시도
	
	// 재고 증가
	public void addStock(int quantity) {
		this.stock += quantity;
	}
	
	// 재고 감소
	public void removeStock(int quantity) {
		int restStock = this.stock - quantity;
		
		//상품재고 0미만 검증 
		if (restStock < 0 ) {
			throw new NotEnoughStockException("상품 재고 수량은 0보다 작을 수 없습니다.");
		}
		this.stock = restStock;
	}
	
	
	
	
	
	
	
	

	
}
