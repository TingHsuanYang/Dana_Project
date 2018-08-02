package com.orderDetails.model;

import java.util.List;


public interface OrderDetailsDAO_interface {
	public void insert(OrderDetailsVO orderDetailsVO);
    public void update(OrderDetailsVO orderDetailsVO);
	public List<OrderDetailsVO> getAll();
	public OrderDetailsVO findByPK(String details_order_id,Integer details_product_id);
}
