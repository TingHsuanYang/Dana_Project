package com.ord.model;

import java.util.List;

public interface OrdDAO_interface {
	 public void insert(OrdVO ordVO);
     public void update(OrdVO ordVO);
     public OrdVO findByPK(String order_id);
     public List<OrdVO> getAll();
	 public List<OrdVO> getOneForAllBuy(String buyer_mem_id);
	 public List<OrdVO> getOneForAllSell(String seller_mem_id);
}
