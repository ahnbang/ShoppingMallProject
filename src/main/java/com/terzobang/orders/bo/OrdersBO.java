package com.terzobang.orders.bo;

import java.util.ArrayList;
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
import com.terzobang.orders.model.OrderStatus;
import com.terzobang.orders.model.Orders;
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
	
	
	public void createOrder(Member member, List<List<Integer>> itemIdAndCounts){
		
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
		
		
		// 3.orderItem 생성 + 재고 감소 로직 -> 여러개의 itemId and orderCount를 밖으로부터 받음
		for (List<Integer> itemIdAndCount : itemIdAndCounts) {
			
			OrderItem orderItem = new OrderItem();
			Item item = new Item();
			
			item = productDAO.selectItemByItemId(itemIdAndCount.get(0));
			
			orderItem.setOrdersId(orders.getId());
			orderItem.setItemId(item.getId());
			orderItem.setOrderPrice(item.getPrice());
			orderItem.setOrderCount(itemIdAndCount.get(1));
			
			orderItemDAO.insertOrderItem(orderItem);
			
			// 재고 감소 로직
			int restStock = item.getStock() - itemIdAndCount.get(1);
			if (restStock < 0 ) {
				throw new NotEnoughStockException("상품 재고 수량은 0보다 작을 수 없습니다.");
			}
			
			productDAO.removeStock(item.getId(), restStock);
			

		}
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

