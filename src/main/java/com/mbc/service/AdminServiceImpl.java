package com.mbc.service;

import java.time.YearMonth;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

import com.mbc.domain.AdminDTO;
import com.mbc.domain.DataDTO;
import com.mbc.domain.OrderDTO;
import com.mbc.domain.PageDTO;
import com.mbc.mapper.AdminMapper;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminMapper adMapper;
	
	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	
	// 관리자 로그인
	@Override
	public boolean adminLogin(AdminDTO dto, HttpServletRequest req) {
		HttpSession session = req.getSession();
		
		AdminDTO adLoginDTO = adMapper.adminLogin(dto);
		
		System.out.println(adLoginDTO);
		System.out.println(dto);
				
		if(adLoginDTO != null) {
			String inputPw = dto.getAd_password();
			String dbPw = adLoginDTO.getAd_password();
						
			if(inputPw.equals(dbPw)) { // 비번 일치
				session.setAttribute("adLoginDTO", adLoginDTO);
				session.setAttribute("mode", "admin");
				return true;
			}else{ // 비번 불일치
				return false;
			}			
		}
		return false;
	}
	
	// 로그아웃
	@GetMapping("adminLogout.do")
	public String adminLogout(HttpSession session) {
		session.invalidate(); // 세션 초기화

		return "redirect:/";
	}
	
	///////////// 관리자 홈화면 ///////////////////	
	// 관리자홈 총매출
	@Override
	public String totalPurchase() {
		
		return adMapper.totalPurchase();
	}
	// 관리자홈 오늘매출
	@Override
	public String todayPurchase() {
		
		return adMapper.todayPurchase();
	}	
	
	// 관리자홈 일매출(최근7일)
	@Override
	public List<OrderDTO> dailyPurchase() {
		
		return adMapper.dailyPurchase();
	}
	// 관리자홈 월매출
	@Override
	public List<OrderDTO> monthlyPurchase() {
		
		return adMapper.monthlyPurchase();
	}
	// 관리자홈 상품 판매량
	@Override
	public List<OrderDTO> prod_purchase() {
		
		return adMapper.prod_purchase();
	}		
	
	
	
	////////////매출관리 페이지 ////////////////////
	// 매출관리페이지 매출정보 가져오기
	@Override
	public List<OrderDTO> salesInfo(PageDTO pDto) {
		int totalCnt = adMapper.totalCnt(pDto);
		// setValue호출시 startIndex 셋팅됨 		
		pDto.setValue(totalCnt, pDto.getCntPerPage());
				
		return adMapper.salesInfo(pDto);
	}
	// 매출관리페이지 오늘매출상세보기
	@Override
	public List<OrderDTO> todayAjaxList() {
		
		return adMapper.todayAjaxList();
	}		
	// 매출관리페이지 일일매출(30일 한달단위)
	@Override
	public List<OrderDTO> dailyPurchaseChart() {
		
		return adMapper.dailyPurchaseChart();
	}
	@Override
	public List<OrderDTO> getSalesDataForMonth(YearMonth yearMonth) {
		String startDate = yearMonth.atDay(1).toString(); // e.g., "2024-08-01"
        String endDate = yearMonth.atEndOfMonth().toString(); // e.g., "2024-08-31"

        return adMapper.getSalesDataForPeriod(startDate, endDate);
	}
	
	
	// 매출관리 페이지 날짜 범위 지정 검색
	@Override
	public List<OrderDTO> salesInfoPeriod(OrderDTO dto) {
		
		return adMapper.salesInfoPeriod(dto);
	}

//	@Override
//	public List<OrderDTO> salesInfoPeriod(OrderDTO dto, PageDTO pDto) {
//		int totalCnt = adMapper.totalCnt(pDto);
//		// setValue호출시 startIndex 셋팅됨 		
//		pDto.setValue(totalCnt, pDto.getCntPerPage());
//		
//		return adMapper.salesInfoPeriod(dto, pDto);
//	}



}
