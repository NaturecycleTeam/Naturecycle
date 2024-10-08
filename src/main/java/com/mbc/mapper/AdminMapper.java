package com.mbc.mapper;


import java.util.List;

import com.mbc.domain.AdminDTO;
import com.mbc.domain.ChartDTO;
import com.mbc.domain.PointDTO;
import com.mbc.domain.OrderDTO;
import com.mbc.domain.OrderDetailDTO;

public interface AdminMapper {

	// 관리자 로그인
	AdminDTO adminLogin(AdminDTO dto);
	
	

	///////////// 관리자 홈화면 ///////////////////		
	List<OrderDTO> dailyPurchase();
	
	List<OrderDTO> monthlyPurchase();

	List<OrderDetailDTO> prod_purchase();

	String totalPurchase();

	String todayPurchase();
	
	List<PointDTO> monthlyDonation();

	void saveChartData(ChartDTO dto);

	List<ChartDTO> findById(String id);

	void deleteChart(String canvasId);
	
	
	
	
	
//	
//	////////////매출관리 페이지 ////////////////////
//	List<OrderDTO> salesInfo(PageDTO pDto);
//
//	List<OrderDTO> dailyPurchaseChart();
//
//	List<OrderDTO> todayAjaxList();
//
//	int totalCnt(PageDTO pDto);
//
//	List<OrderDTO> salesInfoPeriod(OrderDTO dto);
//
//	List<OrderDTO> getSalesDataForPeriod(String startDate, String endDate);
//
//
//
////	List<OrderDTO> salesInfoPeriod(OrderDTO dto, PageDTO pDto);

	

}
