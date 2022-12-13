package com.terzobang.orders.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.terzobang.orders.model.OrderStatus;
import com.terzobang.orders.model.Orders;

@Repository
public interface OrdersDAO {
	
	public void insertOrders(Orders orders);
	public List<Orders> selectAllOrdersByMemberId(int memberId);
	public void updateOrderStatusById(@Param("ordersId") int ordersId, @Param("orderStatus") OrderStatus orderStatus);
	
	

}
