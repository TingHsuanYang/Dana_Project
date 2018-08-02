package com.shopping.model;

public class CartItem implements java.io.Serializable {
    private Integer product_id;
    private String product_name;
    private String product_mem_id;
    private Integer product_price;
    private Integer quantity;
    private Integer total_price;
     
    public Integer getProduct_id() {
        return product_id;
    }
    public void setProduct_id(Integer product_id) {
        this.product_id = product_id;
    }
    public String getProduct_name() {
        return product_name;
    }
    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }
    public Integer getProduct_price() {
        return product_price;
    }
    public void setProduct_price(Integer product_price) {
        this.product_price = product_price;
    }
    public Integer getQuantity() {
        return quantity;
    }
    public void setQuantity(Integer quantity) {
    	this.quantity = quantity;
    }
 
	public String getProduct_mem_id() {
		return product_mem_id;
	}
	public void setProduct_mem_id(String product_mem_id) {
		this.product_mem_id = product_mem_id;
	}
	public Integer getTotal_price() {
		return total_price;
	}
	public void setTotal_price(Integer total_price) {
		this.total_price = total_price;
	}
}
