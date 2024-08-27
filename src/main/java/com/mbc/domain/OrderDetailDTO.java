package com.mbc.domain;

public class OrderDetailDTO {

	private int order_num;
	private String pcode;
	private String pname;
	private int qty_ordered;
	private int price_each;
	
	
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}
	public String getPcode() {
		return pcode;
	}
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getQty_ordered() {
		return qty_ordered;
	}
	public void setQty_ordered(int qty_ordered) {
		this.qty_ordered = qty_ordered;
	}
	public int getPrice_each() {
		return price_each;
	}
	public void setPrice_each(int price_each) {
		this.price_each = price_each;
	}
	
	
}
