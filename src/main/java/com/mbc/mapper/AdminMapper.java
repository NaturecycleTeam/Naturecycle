package com.mbc.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.mbc.domain.AdminDTO;
import com.mbc.domain.DataDTO;
import com.mbc.domain.OrderDTO;
import com.mbc.domain.PageDTO;

public interface AdminMapper {

	// 관리자 로그인
	AdminDTO adminLogin(AdminDTO dto);
	
	

	///////////// 관리자 홈화면 ///////////////////		
	List<OrderDTO> dailyPurchase();
	
	List<OrderDTO> monthlyPurchase();

	List<OrderDTO> prod_purchase();

	String totalPurchase();

	String todayPurchase();
	
	
	
	
	////////////매출관리 페이지 ////////////////////
	List<OrderDTO> salesInfo(PageDTO pDto);

	List<OrderDTO> dailyPurchaseChart();

	List<OrderDTO> todayAjaxList();

	int totalCnt(PageDTO pDto);

	List<OrderDTO> salesInfoPeriod(OrderDTO dto);

	List<OrderDTO> getSalesDataForPeriod(String startDate, String endDate);



//	List<OrderDTO> salesInfoPeriod(OrderDTO dto, PageDTO pDto);

	

}
