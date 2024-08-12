package com.mbc.domain;

import java.util.Date;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class CartDTO {
	
	// 카트 dto
	private int cart_num;
	private String id;
	private int pnum;
	private int pqty;
	private Date indate;
	
	// 상품 dto
	private String pname;
	private String pimage;
	private int price;
	private int point;
	private String pspec;
	
	// total 가격 및 포인트
	private int totPrice;
	private int totPoint;
	
	private int tot_pqty;
	
	public void setTotal() {
		this.totPrice = this.pqty*price;
		this.totPoint = this.pqty*point;
	}
	
	
	
		
	public int getCart_num() {
		return cart_num;
	}




	public void setCart_num(int cart_num) {
		this.cart_num = cart_num;
	}




	public String getId() {
		return id;
	}




	public void setId(String id) {
		this.id = id;
	}




	public int getPnum() {
		return pnum;
	}




	public void setPnum(int pnum) {
		this.pnum = pnum;
	}




	public int getPqty() {
		return pqty;
	}




	public void setPqty(int pqty) {
		this.pqty = pqty;
	}




	public Date getIndate() {
		return indate;
	}




	public void setIndate(Date indate) {
		this.indate = indate;
	}




	public String getPname() {
		return pname;
	}




	public void setPname(String pname) {
		this.pname = pname;
	}




	public String getPimage() {
		return pimage;
	}




	public void setPimage(String pimage) {
		this.pimage = pimage;
	}




	public int getPrice() {
		return price;
	}




	public void setPrice(int price) {
		this.price = price;
	}




	public int getPoint() {
		return point;
	}




	public void setPoint(int point) {
		this.point = point;
	}




	public String getPspec() {
		return pspec;
	}




	public void setPspec(String pspec) {
		this.pspec = pspec;
	}




	public int getTotPrice() {
		return totPrice;
	}




	public void setTotPrice(int totPrice) {
		this.totPrice = totPrice;
	}




	public int getTotPoint() {
		return totPoint;
	}




	public void setTotPoint(int totPoint) {
		this.totPoint = totPoint;
	}




	public int getTot_pqty() {
		return tot_pqty;
	}




	public void setTot_pqty(int tot_pqty) {
		this.tot_pqty = tot_pqty;
	}




	public CartDTO() {}	
	
	@Override
	public String toString() {
		return "CartDTO [cart_num=" + cart_num + ", id=" + id + ", pnum=" + pnum + ", pqty=" + pqty + ", indate="
				+ indate + ", pname=" + pname + ", pimage=" + pimage + ", price=" + price + ", point=" + point
				+ ", pspec=" + pspec + ", totPrice=" + totPrice + ", totPoint=" + totPoint + "]";
	}
	
}
