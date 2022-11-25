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
import com.terzobang.orders.dao.DeliveryDAO;
import com.terzobang.orders.dao.OrderItemDAO;
import com.terzobang.orders.dao.OrdersDAO;
import com.terzobang.orders.model.Delivery;
import com.terzobang.orders.model.DeliveryStatus;
import com.terzobang.orders.model.OrderItem;
import com.terzobang.orders.model.OrderStatus;
import com.terzobang.orders.model.Orders;
import com.terzobang.product.dao.ProductDAO;
import com.terzobang.product.model.Item;

@Service
@Transactional
public class OrdersBO {
	
	@Autowired
	private OrdersDAO ordersDAO;
	
	@Autowired
	private  DeliveryDAO deliveryDAO;
	
	@Autowired
	private  OrderItemDAO orderItemDAO;
	
	@Autowired
	private ProductDAO productDAO;
	
	@Transactional
	public Response stockCheckFilter(List<Integer> itemIdList, List<Integer> orderCountList){
		
		List<String> result = new ArrayList<>();
		boolean flag = false;
		for (int i =0; i < itemIdList.size(); i++) {
			Item item = new Item();
			item = productDAO.selectItemByItemId(itemIdList.get(i));
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
	public Response createOrder(Member member, List<Integer> itemIdList, List<Integer> orderCountList){
		
		// 1. delivery 생성
		Delivery delivery = new Delivery();
		delivery.setAddress(member.getAddress()); // 차후에 독립 adrress로 별경
		delivery.setStatus(DeliveryStatus.READY);
		deliveryDAO.insertDelivery(delivery);
		
		// 2. orders 생성
		Orders orders = new Orders();
		orders.setMemberId(member.getId());
		orders.setDeliveryId(delivery.getId());
		orders.setStatus(OrderStatus.ORDER);
		ordersDAO.insertOrders(orders);
		
		
		// 3.orderItem 생성 + 재고 감소
		for (int i =0; i < itemIdList.size(); i++) {
			
			OrderItem orderItem = new OrderItem();
			Item item = new Item();
			item = productDAO.selectItemByItemId(itemIdList.get(i));
			
			orderItem.setOrdersId(orders.getId());
			orderItem.setItemId(item.getId());
			orderItem.setOrderPrice(item.getPrice());
			orderItem.setOrderCount(orderCountList.get(i));
			orderItemDAO.insertOrderItem(orderItem);
			
			// 재고 감소 로직
			int restStock = item.getStock() - orderCountList.get(i);
			if (restStock < 0 ) {
				throw new NotEnoughStockException("상품 재고 수량은 0보다 작을 수 없습니다.");
			}
			
			productDAO.removeStock(item.getId(), restStock);
		}
		return ResponseUtil.SUCCESS("주문이 정상적으로 완료되었습니다.", orders.getId());
	}
	
	
	public List<Orders> getAllOrdersByMemberId(int memberId){
		
		List<Orders> ordersList = new ArrayList<>();
		ordersList = ordersDAO.selectAllOrdersByMemberId(memberId);
		
		return ordersList;
		
	}
	
	public List<OrderItem> getAllOrderItemByOrderId(int ordersId){
		
		List<OrderItem> orderItemList = new ArrayList<>();
		orderItemList = orderItemDAO.selectAllOrderItemByOrderId(ordersId);
		
		return orderItemList;
		
	}
	
	public Delivery getDeliveryById(int deliveryId) {
		return deliveryDAO.selectDeliveryById(deliveryId);
	}
	
	
	
	
	
	
	/*
	public void cancelOrder(int ordersId){
		
		Orders orders = new Orders();
		orders = ordersDAO.selectOrdersByOrdersId();
		Delivery delivery = deliveryDAO.selectDeliveryByOrderId(ordersId);
		
		if(delivery.getStatus() == DeliveryStatus.COMPLETE) {
			throw new IllegalStateException("이미 배송완료된 상품은 취소가 불가능합니다.");
		}
		
		ordersDAO.updateOrdersStatus(OrdersStauts.CANCEL);
		for ()

		
			
		
		
		
		
		
	}
*/
}

