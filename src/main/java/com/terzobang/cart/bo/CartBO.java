package com.terzobang.cart.bo;

import java.util.List;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.terzobang.cart.dao.CartDAO;
import com.terzobang.cart.model.Cart;
import com.terzobang.cart.model.CartItem;
import com.terzobang.common.response.Response;
import com.terzobang.common.response.ResponseUtil;

@Service
@Transactional
public class CartBO {
	
	@Autowired
	private CartDAO cartDAO;
	
	@Transactional
	public void createCart(int memberId) {
		cartDAO.insertCart(memberId);
	}
	
	@Transactional
	public Cart getCartByMemberId(int memberId) {
		return cartDAO.selectCartByMemberId(memberId);
	}
	
	@Transactional
	public Response createCartItem(int memberId, int itemId, int count, String size) {
		Cart cart = new Cart();
		cart = cartDAO.selectCartByMemberId(memberId);
		int cartId = cart.getId();
		int row = cartDAO.insertCartItem(cartId, itemId, count, size);
		if (row==1) {
			return ResponseUtil.SUCCESS("해당 상품이 장바구니에 담겼습니다", null);
		}else {
			return ResponseUtil.FAIL("장바구니에 담지 못했습니다", null);
		}
	}
	
	@Transactional
	public List<CartItem> getAllCartItemByMemberId(int memberId){
		
		Cart cart = cartDAO.selectCartByMemberId(memberId);
		return cartDAO.selctAllCartItemByCartId(cart.getId());
		
	}
	
	@Transactional
	public Response deleteCartItemById(int cartItemId) {
		
		int row = cartDAO.deleteCartItemById(cartItemId); 
		if (row == 1) {
			return ResponseUtil.SUCCESS("장바구니에서 해당 상품을 제거했습니다.", null);
		}
		return ResponseUtil.FAIL("장바구니에서 해당 상품을 제거하지 못했습니다.", cartItemId);
	}
	
	
	

}
