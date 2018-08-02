package com.shopping.model;

import java.util.List;
import java.util.Vector;

public class CartBean {
	private List<CartItem> allCartItems = new Vector<CartItem>();
	private Integer orderTotal;
	  
	 public int getLineItemCount() {
	  return allCartItems.size();
	 }
	  
	 //刪除購物車的商品
	 public void deleteCartItem(String itemIndex) {
	  int iItemIndex = 0;
	  try {
	   iItemIndex = Integer.parseInt(itemIndex);
	   allCartItems.remove(iItemIndex - 1);
	   calculateOrderTotal();
	  } catch(NumberFormatException nfe) {
		  throw new RuntimeException("Error while deleting cart item:  "
				+ nfe.getMessage());
	  }
	 }
	  
	 //更新修改購物車的商品
	 public void updateCartItem(String itemIndex, String quantity) {
	  int total_price = 0;
	  int product_price = 0;
	  int iQuantity = 0;
	  int iItemIndex = 0;
	  CartItem cartItem = null;
	  try {
	   iItemIndex = Integer.parseInt(itemIndex);
	   iQuantity = Integer.parseInt(quantity);
	   if(iQuantity>0) {
	    cartItem = (CartItem)allCartItems.get(iItemIndex-1);
	    product_price = cartItem.getProduct_price();
	    total_price = product_price*iQuantity;
	    cartItem.setQuantity(iQuantity);
	    cartItem.setTotal_price(total_price);
	    calculateOrderTotal();
	   }
	  } catch (NumberFormatException nfe) {
		  throw new RuntimeException("Error while deleting cart item:  "
					+ nfe.getMessage());
	  }
	   
	 }
	  
	 //新增購物車的商品
	 public void addCartItem(Integer product_id, String product_name,
      String product_price, String quantity) {
	  int total_price = 0;
	  int iProduct_price = 0;
	  int iQuantity = 0;
	  CartItem cartItem = new CartItem();
	  try {
	   iProduct_price = Integer.parseInt(product_price);
	   iQuantity = Integer.parseInt(quantity);
	   if(iQuantity>0) {
		total_price = iProduct_price*iQuantity;
	    cartItem.setProduct_id(product_id);
	    cartItem.setProduct_name(product_name);
	    cartItem.setProduct_price(iProduct_price);
	    cartItem.setQuantity(iQuantity);
	    cartItem.setTotal_price(total_price);
	    allCartItems.add(cartItem);
	    calculateOrderTotal();
	   }
	    
	  } catch (NumberFormatException nfe) {
		  throw new RuntimeException("Error while deleting cart item:  "
					+ nfe.getMessage());
	  }
	 }
	  
	 public void addCartItem(CartItem cartItem) {
	   allCartItems.add(cartItem);
	 }
	  
	 public CartItem getCartItem(int itemIndex) {
	  CartItem cartItem = null;
	  if(allCartItems.size()>itemIndex) {
	   cartItem = (CartItem) allCartItems.get(itemIndex-1);
	  }
	  return cartItem;
	 }
	  
	 public List<CartItem> getCartItems() {
	  return allCartItems;
	 }
	 public void setCartItems(Vector<CartItem> allCartItems) {
	  this.allCartItems = allCartItems;
	 }
	 public Integer getOrderTotal() {
	  return orderTotal;
	 }
	 public void setOrderTotal(Integer orderTotal) {
	  this.orderTotal = orderTotal;
	 }
	  
	 protected void calculateOrderTotal() {
	  int orderTotal = 0;
	  for(int counter=0; counter < allCartItems.size(); counter++) {
	   CartItem cartItem = (CartItem) allCartItems.get(counter);
	   orderTotal += cartItem.getTotal_price();
	    
	  }
	  setOrderTotal(orderTotal);
	 }
}
