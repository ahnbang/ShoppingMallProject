package com.terzobang.product.model;

import java.util.Date;

public class Item {
	
	private int id;
	private String name;
	private int price;
	private String content;
	private String size;
	private int stock;
	private ItemCategory cagegory;
	private ItemGender gender;
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
	public ItemCategory getCagegory() {
		return cagegory;
	}
	public void setCagegory(ItemCategory cagegory) {
		this.cagegory = cagegory;
	}
	public ItemGender getGender() {
		return gender;
	}
	public void setGender(ItemGender gender) {
		this.gender = gender;
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
