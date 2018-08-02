package com.ord.model;

import java.sql.Timestamp;
import java.util.List;



public class OrdService {
	private OrdDAO_interface dao;

	public OrdService() {
		dao = new OrdDAO();
	}

	public OrdVO addOrd(String buyer_mem_id,String seller_mem_id,String order_address,Integer payment_status,Integer payment_method,Integer shipment_status,
			Timestamp order_date,Integer order_status,Integer order_total,Integer order_item,Integer shipment_method,String ord_store_711_name) {

		OrdVO ordVO = new OrdVO();
		
		ordVO.setBuyer_mem_id(buyer_mem_id);
		ordVO.setSeller_mem_id(seller_mem_id);
		ordVO.setOrder_address(order_address);
		ordVO.setPayment_status(payment_status);
		ordVO.setPayment_method(payment_method);
		ordVO.setShipment_status(shipment_status);
		ordVO.setOrder_date(order_date);
		ordVO.setOrder_status(order_status);
		ordVO.setOrder_total(order_total);
		ordVO.setOrder_item(order_item);
		ordVO.setShipment_method(shipment_method);
		ordVO.setOrd_store_711_name(ord_store_711_name);
		

		dao.insert(ordVO);

		return ordVO;
	}

	public OrdVO updateOrd(Integer payment_status,Integer shipment_status,Integer order_status,Integer cancel_reason,Integer stob_rating,
			String stob_rating_descr,Integer btos_rating,String btos_rating_descr,String shipment_id,String order_id) {

		OrdVO ordVO = new OrdVO();
		
		ordVO.setPayment_status(payment_status);
		ordVO.setShipment_status(shipment_status);
		ordVO.setOrder_status(order_status);
		ordVO.setCancel_reason(cancel_reason);
		ordVO.setStob_rating(stob_rating);
		ordVO.setStob_rating_descr(stob_rating_descr);
		ordVO.setBtos_rating(btos_rating);
		ordVO.setBtos_rating_descr(btos_rating_descr);
		ordVO.setShipment_id(shipment_id);
		ordVO.setOrder_id(order_id);
		
		dao.update(ordVO);

		return ordVO;
	}

	public OrdVO getOneOrd(String order_id) {
		return dao.findByPK(order_id);
	}

	public List<OrdVO> getAll() {
		return dao.getAll();
	}
}
