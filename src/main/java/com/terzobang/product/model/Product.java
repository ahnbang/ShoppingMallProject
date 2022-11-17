package com.terzobang.product.model;

import java.util.List;

public class Product {
	
	private Item item;
	private List<Image> images;
	
	public Item getItem() {
		return item;
	}
	public void setItem(Item item) {
		this.item = item;
	}
	public List<Image> getImages() {
		return images;
	}
	public void setImages(List<Image> images) {
		this.images = images;
	}
	
	public String getThumnail() {
		return images.get(0).getSaveName();
	}
	
	
	
	

	
}
