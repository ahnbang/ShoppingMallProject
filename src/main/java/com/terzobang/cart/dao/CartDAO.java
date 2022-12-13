package com.terzobang.cart.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.terzobang.cart.model.Cart;
import com.terzobang.cart.model.CartItem;

@Repository
public interface CartDAO {
	
	public void insertCart(int memberId);
	public Cart selectCartByMemberId(int memberId);
	public int insertCartItem(@Param("cartId")int cartId, @Param("itemId")int itemId, @Param("count")int count, @Param("size")String size);
	public List<CartItem> selctAllCartItemByCartId(int cartId);	
	public int deleteCartItemById(int cartItemId);
}
