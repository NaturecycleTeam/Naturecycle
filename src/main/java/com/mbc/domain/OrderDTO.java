package com.mbc.domain;

import java.util.Date;

//import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class OrderDTO {

	private int order_num;
	private Date order_date;
	
	
	// orderDetailDTO
	private int qty_ordered;
	private int price_each;
	private String pname;
	
	
	
	// 관리자페이지
	private String TODAY_PURCHASE_AMOUNT;	// 당일 매출 (order_date, qty_orderd, price_each)
	private String tot_purchase_amount; // 누적 총매출 (order_date, qty_orderd, price_each)
	private String purchase_amount; // 일일매출(최근7일) (order_date, qty_orderd, price_each)
	private String order_month; // 월매출 (order_date, qty_orderd, price_each)
	
	private String totPQTY; // 상품 총 판매량 (order_date, qty_orderd, cat_name)
	private String cat_name; // 카테고리명
	
	
	// 매출 기간 검색
	private Date startDate;  // 검색 시작일
	private Date endDate;  // 검색 완료일
	
	// 검색 페이지네이션
	private int startIndex;
    private int cntPerPage;


	
}
