package com.terzobang.cart;

import java.util.List;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.terzobang.cart.bo.CartBO;
import com.terzobang.cart.model.CartItem;
import com.terzobang.common.response.Response;
import com.terzobang.common.response.ResponseStatus;
import com.terzobang.common.response.ResponseUtil;

@RestController
@RequestMapping("/cart")
public class CartRestController {
	
	@Autowired
	private CartBO cartBO;
	
	private Logger log;
	@RequestMapping("/addCartItem")
	public Response addCartItem(
			@RequestParam("memberId") int memberId,
			@RequestParam("itemId") int itemId,
			@RequestParam("count") int count,
			@RequestParam("size") String size
			){
		
		return cartBO.createCartItem(memberId,itemId,count,size);
	}
	
	@RequestMapping("/deleteCartItemOne")
	public Response deleteCartItemOne(@RequestParam("cartItemId") int cartItemId) {
		
		return cartBO.deleteCartItemById(cartItemId);
	}
	
	@RequestMapping("/deleteCartItemAll")
	public Response deleteCartItemAll(@RequestParam("cartItemIdList") List<Integer> cartItemIdList) {
		
		for(int cartItemId : cartItemIdList) {
			
			Response result = cartBO.deleteCartItemById(cartItemId);
			
			if(result.getStatus() == ResponseStatus.FAIL) {
				return result;
			}
			
		}
		
		return ResponseUtil.SUCCESS("장바구니 상품들을 모두 삭제했습니다.", null);
		
	}

	

}
	