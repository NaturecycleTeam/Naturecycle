package com.mbc.service;

import java.time.YearMonth;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;

import com.mbc.domain.AdminDTO;
import com.mbc.domain.DataDTO;
import com.mbc.domain.OrderDTO;
import com.mbc.domain.PageDTO;
import com.mbc.mapper.AdminMapper;

public interface AdminService {
	
	// 관리자 로그인
	boolean adminLogin(AdminDTO dto, HttpServletRequest req);

	
	///////////// 관리자 홈화면 ///////////////////
	// 일매출(최근7일)
	List<OrderDTO> dailyPurchase();
	// 월매출
	List<OrderDTO> monthlyPurchase();
	// 상품 정보
	List<OrderDTO> prod_purchase();
	// 총매출
	String totalPurchase();
	// 오늘 매출
	String todayPurchase();
	
	
	
	//////////// 매출관리 페이지 ////////////////////
	// 전체 매출 리스트
	List<OrderDTO> salesInfo(PageDTO pDto);
	// 일매출(30일 한달기준)
	List<OrderDTO> dailyPurchaseChart();
	// 오늘 매출 디테일
//	List<OrderDTO> todayPurchaseInfo();
	// 오늘 매출 상세보기
	List<OrderDTO> todayAjaxList();
	// 매출관리 페이지 날짜 범위 지정 검색
	List<OrderDTO> salesInfoPeriod(OrderDTO dto);

	// 일매출(30일 한달기준)
	List<OrderDTO> getSalesDataForMonth(YearMonth yearMonth);


//	List<OrderDTO> salesInfoPeriod(OrderDTO dto, PageDTO pDto);	
	

}
