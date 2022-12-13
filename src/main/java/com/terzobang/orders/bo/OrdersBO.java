package com.terzobang.orders.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.terzobang.common.exception.NotEnoughStockException;
import com.terzobang.common.response.Response;
import com.terzobang.common.response.ResponseUtil;
import com.terzobang.member.model.Member;
import com.terzobang.orders.dao.OrdersDAO;
import com.terzobang.orders.model.Delivery;
import com.terzobang.orders.model.DeliveryStatus;
import com.terzobang.orders.model.OrderItem;
import com.terzobang.orders.model.OrderStatus;
import com.terzobang.orders.model.Orders;
import com.terzobang.product.bo.ProductBO;
import com.terzobang.product.model.Item;

@Service
@Transactional
public class OrdersBO {
	
	@Autowired
	private OrdersDAO ordersDAO;
	
	@Autowired
	private  DeliveryBO deliveryBO;
	
	@Autowired
	private  OrderItemBO orderItemBO;
	
	@Autowired
	private ProductBO productBO;
	
	@Transactional 
	public Response stockCheckFilter(List<Integer> itemIdList, List<Integer> orderCountList){
		
		List<String> result = new ArrayList<>();
		boolean flag = false;
		for (int i =0; i < itemIdList.size(); i++) {
			Item item = new Item();
			item = productBO.getItemByItemId(itemIdList.get(i));
			int restStock = item.getStock() - orderCountList.get(i);
			int gap = 0;
			if (restStock < 0) {
				flag = true;
				gap = restStock * (-1);
				result.add(
						item.getName() + "상품의 최대 구매 수량을" + gap + "만큼 초과했습니다." + "" 
						+ item.getName() + "상품의 최대 구매 수량은" + item.getStock() + "입니다.");
			}
		}
		
		if(flag) {
			return ResponseUtil.FAIL("상품 재고를 초과하는 주문이 존재합니다.", result);
		}
		
		return ResponseUtil.SUCCESS("상품 재고를 초과하는 주문이 존재하지 않습니다", "/order/orderCheck");	
	}
	
	@Transactional
	public Response createOrder(Member member, List<Integer> itemIdList, List<Integer> orderCountList, String address){
		
		// 1. delivery 생성 : 연쇄생성을 위해 객체차제를 insert 이후 useGeneratedKeys로 Id값 가져오기
		Delivery delivery = new Delivery();
		delivery.setAddress(address);
		delivery.setStatus(DeliveryStatus.READY);
		deliveryBO.createDelivery(delivery);
		
		
		// 2. orders 생성 : 연쇄생성을 위해 객체차제를 insert 이후 useGeneratedKeys로 Id값 가져오기
		Orders orders = new Orders();
		orders.setMemberId(member.getId());
		orders.setDeliveryId(delivery.getId());
		orders.setStatus(OrderStatus.ORDER);
		ordersDAO.insertOrders(orders);
		
		// 3.orderItem 생성 + 재고 감소
		for (int i =0; i < itemIdList.size(); i++) {
			
			OrderItem orderItem = new OrderItem();
			Item item = new Item();
			item = productBO.getItemByItemId(itemIdList.get(i));
			
			orderItem.setOrdersId(orders.getId());
			orderItem.setItemId(item.getId());
			orderItem.setOrderCount(orderCountList.get(i));
			orderItem.setOrderPrice(item.getPrice()*orderCountList.get(i));
			orderItemBO.createOrderItem(orderItem);
			
			// 재고 감소 로직
			int restStock = item.getStock() - orderCountList.get(i);
			if (restStock < 0 ) {
				throw new NotEnoughStockException("상품 재고 수량은 0보다 작을 수 없습니다." + "문제의 상품ID = " + item.getId());
			}
			
			productBO.updateStock(item.getId(), restStock);
		}
		return ResponseUtil.SUCCESS("주문이 정상적으로 완료되었습니다.", orders.getId());
	}
	
	@Transactional
	public List<Orders> getAllOrdersByMemberId(int memberId){
		
		return ordersDAO.selectAllOrdersByMemberId(memberId);		
	}
	
	@Transactional
	public Integer totalOrderPriceByItemIdList(List<Integer> itemIdList, List<Integer> orderCountList) {
		int totalPrice = 0;
		for (int i =0; i < itemIdList.size(); i++) {
			
			Item item = productBO.getItemByItemId(itemIdList.get(i));
			totalPrice += (item.getPrice()*orderCountList.get(i));
			
		}
		return totalPrice;
	}
	
	@Transactional
	public Response cancelOrder(int ordersId, int deliveryId, int orderItemId) {
		
			// check 
			Delivery delivery = deliveryBO.getDeliveryById(deliveryId);
			if(delivery.getStatus() != DeliveryStatus.READY) {
				return ResponseUtil.FAIL("배송중이거나 배송중인 상품은 취소 불가합니다", null);
			}
			
			//주문 상태 변경
			ordersDAO.updateOrderStatusById(ordersId, OrderStatus.CANCEL);
			
			//재고 증가
			List<OrderItem> orderItemList = orderItemBO.getOrderItemById(orderItemId);
			for(OrderItem orderitem : orderItemList) {
			Item item = productBO.getItemByItemId(orderitem.getItemId());
			int itemId = item.getId();
			int restStock = item.getStock() + orderitem.getOrderCount();
			productBO.updateStock(itemId, restStock);
			}
			
			return ResponseUtil.SUCCESS("선택한 주문이 취소되었습니다.", null);
			
	}
	
}

