package com.mbc.domain;

import java.util.Date;

//import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class OrderDTO {
	
	// orderDTO
	private int order_num;
	private int pnum_fk;
	private String oid_fk;
	private Date order_date;
	private int qty_ordered;
	private int price_each;
	private int point;
//	private Dlv_status dlv_status;  // 만들어야함
	
	
//	private int order_num;
//	private Date order_date;
//	
//	
//	// orderDetailDTO
//	private int qty_ordered;
//	private int price_each;
//	private String pname;
	
	
	
	////////// 관리자홈 ////////
	private String TODAY_PURCHASE_AMOUNT;	// 당일 매출 
	private String tot_purchase_amount; // 누적 총매출 
	private String purchase_amount; // 일일매출(최근7일), 월매출
	private String order_month; // 월매출 	
	private String totPQTY; // 상품 총 판매량 
	
	// categoryDTO (left join)
	private String cat_name; // 카테고리명
	
	//////// 매출관리 페이지 //////
	// 매출 기간 검색
	private Date startDate;  // 검색 시작일
	private Date endDate;  // 검색 완료일
	
	// 검색 페이지네이션
	private int startIndex;
    private int cntPerPage;


	
}
