package com.mbc.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class OrderDTO {

	private int order_num;
	private Date order_date;
	
	private int qty_ordered;
	private int price_each;
	private String pname;
	private String TODAY_PURCHASE_AMOUNT;	
	
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
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getTODAY_PURCHASE_AMOUNT() {
		return TODAY_PURCHASE_AMOUNT;
	}
	public void setTODAY_PURCHASE_AMOUNT(String tODAY_PURCHASE_AMOUNT) {
		TODAY_PURCHASE_AMOUNT = tODAY_PURCHASE_AMOUNT;
	}
	private String purchase_amount; // 일일매출(최근7일)
	private String order_month; // 월매출
	private String totPQTY; // 상품 총 판매량
	private String cat_name; // 카테고리명
	private String tot_purchase_amount; // 누적 총매출
	
	public String getTot_purchase_amount() {
		return tot_purchase_amount;
	}
	public void setTot_purchase_amount(String tot_purchase_amount) {
		this.tot_purchase_amount = tot_purchase_amount;
	}
	public String getTotPQTY() {
		return totPQTY;
	}
	public void setTotPQTY(String totPQTY) {
		this.totPQTY = totPQTY;
	}
	public String getCat_name() {
		return cat_name;
	}
	public void setCat_name(String cat_name) {
		this.cat_name = cat_name;
	}
	public String getOrder_month() {
		return order_month;
	}
	public void setOrder_month(String order_month) {
		this.order_month = order_month;
	}
	public String getPurchase_amount() {
		return purchase_amount;
	}
	public void setPurchase_amount(String purchase_amount) {
		this.purchase_amount = purchase_amount;
	}
	
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}
	public Date getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	
	private Date startDate;
	private Date endDate;
	private int startIndex;
    private int cntPerPage;

	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public int getStartIndex() {
		return startIndex;
	}
	public void setStartIndex(int startIndex) {
		this.startIndex = startIndex;
	}
	public int getCntPerPage() {
		return cntPerPage;
	}
	public void setCntPerPage(int cntPerPage) {
		this.cntPerPage = cntPerPage;
	}
	
}
