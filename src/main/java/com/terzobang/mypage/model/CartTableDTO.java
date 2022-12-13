package com.terzobang.mypage.model;

import java.util.List;

import com.terzobang.cart.model.CartItem;
import com.terzobang.product.model.Product;

public class CartTableDTO {
	
	private List<CartItem> cartItemList;
	private List<Product> productListFromCartItem;
	
	
	public List<CartItem> getCartItemList() {
		return cartItemList;
	}
	public void setCartItemList(List<CartItem> cartItemList) {
		this.cartItemList = cartItemList;
	}
	public List<Product> getProductListFromCartItem() {
		return productListFromCartItem;
	}
	public void setProductListFromCartItem(List<Product> productListFromCartItem) {
		this.productListFromCartItem = productListFromCartItem;
	}
	
	
	
}
