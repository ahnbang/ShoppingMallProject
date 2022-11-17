package com.terzobang.orders.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.terzobang.common.exception.NotEnoughStockException;
import com.terzobang.member.model.Member;
import com.terzobang.orders.dao.DeliveryDAO;
import com.terzobang.orders.dao.OrderItemDAO;
import com.terzobang.orders.dao.OrdersDAO;
import com.terzobang.orders.model.Delivery;
import com.terzobang.orders.model.DeliveryStatus;
import com.terzobang.orders.model.OrderItem;
import com.terzobang.orders.model.Orders;
import com.terzobang.orders.model.OrdersStauts;
import com.terzobang.product.dao.ProductDAO;
import com.terzobang.product.model.Item;

@Service
public class OrdersBO {
	
	@Autowired
	private OrdersDAO ordersDAO;
	
	@Autowired
	private  DeliveryDAO deliveryDAO;
	
	@Autowired
	private  OrderItemDAO orderItemDAO;
	
	@Autowired
	private ProductDAO productDAO;
	
	
	// 단일 주문 생성?
	// 주문 생성 - delivery, orderItem, orders 동시생성, 엄밀히 따지면 순차생성 (delivery -> orders -> orderItem) 주문상품이 연관관게 주인
	// ㅅㅂ 이질감 느껴지는데
	
	public void createOrder(Member member, List<List<Integer>> itemIdAndCounts){
		
		// 1. delivery 생성
		Delivery delivery = new Delivery();
		delivery.setAddress(member.getAddress()); // 차후에 독립 adrress로 별경
		delivery.setStatus(DeliveryStatus.READY);
		deliveryDAO.insertDelivery(delivery);
		
		// 2. orders 생성
		Orders orders = new Orders();
		orders.setMemberId(member.getId());
		orders.setDeliverId(delivery.getId());
		orders.setStatus(OrdersStauts.ORDER);
		ordersDAO.insertOrders(orders);
		
		
		// 3.orderItem 생성 -> 여러개의 itemId and orderCount를 밖으로부터 받음
		
		for (List<Integer> itemIdAndCount : itemIdAndCounts) {
			
			OrderItem orderItem = new OrderItem();
			Item item = new Item();
			
			item = productDAO.selectItemByItemId(itemIdAndCount.get(0));
			
			orderItem.setOrersId(orders.getId());
			orderItem.setItemId(item.getId());
			orderItem.setOrderPrice(item.getPrice());
			orderItem.setOrderCount(itemIdAndCount.get(1));
			
			int restStock = item.getStock() - itemIdAndCount.get(1);
			if (restStock < 0 ) {
				throw new NotEnoughStockException("상품 재고 수량은 0보다 작을 수 없습니다.");
			}
			
			productDAO.removeStock(item.getId(), restStock);
			

		}
	
	}
	
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
}

