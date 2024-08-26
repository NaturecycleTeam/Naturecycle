package com.mbc.controller;

import java.text.SimpleDateFormat;
import java.time.YearMonth;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.mbc.domain.AdminDTO;
import com.mbc.domain.OrderDTO;
import com.mbc.domain.PageDTO;
import com.mbc.service.AdminService;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService adService;

	
	////////////////// 로그인/로그아웃 //////////////////
	// 로그인 페이지 이동
	@GetMapping("adminLogin.do")
	public String loginForm() {

		return "admin/ad_login";
	}
	
	// 관리자 로그인
	@PostMapping("adminLogin.do")
	public String adminLogin(String moveUrl, AdminDTO dto, HttpServletRequest req) {
				
		boolean result = adService.adminLogin(dto, req);
				
		if(!result) {
			return "redirect:adminLogin.do";
		}
		
//		if(!moveUrl.equals("")) {
//			return "redirect:"+moveUrl;
//		}
		return "admin/ad_main";
		//return "redirect:/";
	}
	
	// 관리자 로그아웃
	@GetMapping("adminLogout.do")
	public String adminLogout(HttpSession session) {
		session.invalidate();
		
		return "redirect:adminLogin.do";
	}
	
	// 관리자 홈페이지 이동
	@GetMapping("adminMain.do")
	public String adminMainForm() {
		return "admin/ad_main";
	}
	
	
	// 관리자 홈화면 그래프
//	@RequestMapping("getData.do")
//	@ResponseBody
//	public String getData(Model model) {
//		
//		List<DataDTO> list =adService.getData();
//		
//		Gson gson = new GsonBuilder().create();	
//		JsonArray jArray = new JsonArray();
//		
//		Iterator<DataDTO> it = list.iterator();
//		while(it.hasNext()) {
//			DataDTO dto = it.next();
//			JsonObject object = new JsonObject();
//			int tqty = dto.getTqty();
//			String tname = dto.getTname();
//			
//			object.addProperty("tqty", tqty);
//			object.addProperty("tname", tname);
//			jArray.add(object);			
//		}
//		
//		String json = gson.toJson(jArray);
//		System.out.println("json 데이터값" + json);		
//		
//		return json;
//	}
	
	//////////////// 관리자 홈화면 ////////////////////////
	// 관리자 홈화면 오늘매출
	@RequestMapping("todayPurchase.do")
	@ResponseBody
	public String todayPurchase(Model model) {
		
		String todayPurchaseAmount = adService.todayPurchase();
		System.out.println("####오늘 매출"+ todayPurchaseAmount);
		
		return todayPurchaseAmount;
	}	
	
	// 관리자 홈화면 총매출
	@RequestMapping("totalPurchase.do")
	@ResponseBody
	public String totalPurchase(Model model) {
		
		String totalPurchase = adService.totalPurchase();
						
		return totalPurchase;
	}	
	
	// 그래프 1 : 관리자 홈화면 일매출(최근7일)
	@RequestMapping("dailyPurchase.do")
	@ResponseBody
	public String dailyPurchase(Model model, HttpServletRequest request) {
	
		List<OrderDTO> list =adService.dailyPurchase();
			
		SimpleDateFormat sd = new SimpleDateFormat("yy-MM-dd");	
		
//		// 오늘 매출 맵으로 가져오기
//		Map<String, String> today_purchase = new HashMap<>();
//		for (int i=0; i<list.size(); i++) {
//			String today = sd.format(list.get(i).getOrder_date());
//			String today_income = list.get(i).getPurchase_amount().toString();
//			
//			today_purchase.put(today, today_income);			 
//		}
//		
////		LocalDate now = LocalDate.now();
//		String now = LocalDate.now().toString();
//		System.out.println(now);
//		System.out.println("today_purchase : " + today_purchase);
		
		
		
//		String todayIncome = list.get(4).getPurchase_amount().toString();
//		System.out.println("일매출 리스트 : " + todayIncome);
		
//		ArrayList<HashMap<String, Object>> getIncome = adService.getIncome();
//		 String sum = getIncome.get(0).get("sum").toString();
//		 System.out.println("오늘매출 : "+ sum);
		
		Gson gson = new GsonBuilder().create();	
		JsonArray jArray = new JsonArray();				
		
		Iterator<OrderDTO> it = list.iterator();
		while(it.hasNext()) {
			OrderDTO dto = it.next();
			JsonObject object = new JsonObject();
			
			String date = sd.format(dto.getOrder_date());						
			String sum = dto.getPurchase_amount();
//			System.out.println(sum);
			
			object.addProperty("date", date);
			object.addProperty("sum", sum);
			jArray.add(object);			
		}
				
		String json = gson.toJson(jArray);
//		System.out.println("json 일데이터값" + json);	
		
		return json;
	}
	
	// 그래프 3 : 관리자 홈화면 월매출
	@RequestMapping("monthlyPurchase.do")
	@ResponseBody
	public String monthlyPurchase(Model model) {
		
		List<OrderDTO> list =adService.monthlyPurchase();
		
		Gson gson = new GsonBuilder().create();	
		JsonArray jArray = new JsonArray();		
	
		Iterator<OrderDTO> it = list.iterator();
		while(it.hasNext()) {
			OrderDTO dto = it.next();
			JsonObject object = new JsonObject();
			
			String date = dto.getOrder_month();
						
			String sum = dto.getPurchase_amount();
//			System.out.println(sum);
			
			object.addProperty("date", date);
			object.addProperty("sum", sum);
			jArray.add(object);			
		}
		
		
		String json = gson.toJson(jArray);
//		System.out.println("json 월데이터값" + json);	
		
		return json;
	}
	
	// 그래프 2 : 관리자 홈화면 상품 판매량
		@RequestMapping("prod_purchase.do")
		@ResponseBody
		public String prod_purchase(Model model) {
			
			List<OrderDTO> list =adService.prod_purchase();
			
			Gson gson = new GsonBuilder().create();	
			JsonArray jArray = new JsonArray();		
			
			Iterator<OrderDTO> it = list.iterator();
			while(it.hasNext()) {
				OrderDTO dto = it.next();
				JsonObject object = new JsonObject();

				String totPQTY = dto.getTotPQTY();							
				String cat_name = dto.getCat_name();				
				
				object.addProperty("totPQTY", totPQTY);
				object.addProperty("cat_name", cat_name);
				jArray.add(object);			
			}			
			
			String json = gson.toJson(jArray);
//			System.out.println("json 월데이터값" + json);	
			
			return json;
		}
}
		
//		// 그래프 4 : 기부금 현황
//		@RequestMapping("monthlyDonation.do")
//		@ResponseBody
//		public String monthlyDonation(Model model) {
//			
//			List<OrderDTO> list =adService.monthlyDonation();
//			
//			Gson gson = new GsonBuilder().create();	
//			JsonArray jArray = new JsonArray();		
//		
//			Iterator<OrderDTO> it = list.iterator();
//			while(it.hasNext()) {
//				OrderDTO dto = it.next();
//				JsonObject object = new JsonObject();
//				
//				String date = dto.getOrder_month();
//							
//				String sum = dto.getPurchase_amount();
////				System.out.println(sum);
//				
//				object.addProperty("date", date);
//				object.addProperty("sum", sum);
//				jArray.add(object);			
//			}
//			
//			
//			String json = gson.toJson(jArray);
////			System.out.println("json 월데이터값" + json);	
//			
//			return json;
//		}
		
		
		
		
		
		
		
		
		
//		//////////// salesController로 이동 ///////////
//		
//		// 매출관리 페이지 이동
//		@GetMapping("salesInfo.do")
//		public String salesInfo(PageDTO pDto, Model model) {
//			List<OrderDTO> orderDto = adService.salesInfo(pDto);
//			
//			model.addAttribute("orderDto", orderDto);
////			System.out.println("###orderDto#### : " + orderDto);
//			
//			// serviceImpl에서 셋팅된 pDto
//			model.addAttribute("pDto", pDto);
////			System.out.println("###pDto#### : " + pDto);
//			return "admin/ad_salesInfo";
//		}		
//		
//		// 매출관리 페이지 - 오늘매출 상세보기
//		@GetMapping("todayAjaxList.do")
//		@ResponseBody
//		public List<OrderDTO> todayAjaxList(){
//			List<OrderDTO> todayList = adService.todayAjaxList();
//			
//			return todayList;
//		}
//		
//		
//		// 매출관리 페이지 - 오늘매출 
////		@RequestMapping("todayPurchaseInfo.do")
////		@ResponseBody
////		public List<OrderDTO> todayPurchaseInfo(Model model) {
////			
////			List<OrderDTO> todayPurchaseAmountInfo = adService.todayPurchaseInfo();
////			System.out.println("####오늘 매출 상세보기"+ todayPurchaseAmountInfo);
////			model.addAttribute("todayPurchaseAmountInfo", todayPurchaseAmountInfo);
////			
////			return todayPurchaseAmountInfo;
////		}
//		
//		// 매출관리 페이지 - 일일매출 그래프(월단위 30일)
//		@RequestMapping("dailyPurchaseChart.do")
//		@ResponseBody
//		public String dailyPurchaseChart(Model model, HttpServletRequest request) {
//			List<OrderDTO> list =adService.dailyPurchaseChart();
//			
//			SimpleDateFormat sd = new SimpleDateFormat("yy-MM-dd");
//			Gson gson = new GsonBuilder().create();	
//			JsonArray jArray = new JsonArray();				
//			
//			Iterator<OrderDTO> it = list.iterator();
//			while(it.hasNext()) {
//				OrderDTO dto = it.next();
//				JsonObject object = new JsonObject();
//				
//				String date = sd.format(dto.getOrder_date());						
//				String sum = dto.getPurchase_amount();
////				System.out.println(sum);
//				
//				object.addProperty("date", date);
//				object.addProperty("sum", sum);
//				jArray.add(object);			
//			}
//					
//			String json = gson.toJson(jArray);
//			System.out.println("json 일데이터값@@@@@" + json);	
//			
//			return json;
//		}
//		
//		@GetMapping("/getMonthlySalesData.do")
//	    @ResponseBody
//	    public List<OrderDTO> getMonthlySalesData(
//	            @RequestParam("year") int year,
//	            @RequestParam("month") int month) {
//
//	        // Create a YearMonth object for the given year and month
//	        YearMonth yearMonth = YearMonth.of(year, month);
//
//	        // Fetch the sales data for the month from the service
//	        return adService.getSalesDataForMonth(yearMonth);
//	    }
//		
//		// 매출관리 페이지 날짜 범위 지정 검색
//		@GetMapping("salesInfoPeriod.do")
//		public String salesInfoPeriod(@RequestParam("startDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
//                @RequestParam("endDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate, Model model) {
//			
//			OrderDTO dto = new OrderDTO();
//			dto.setStartDate(startDate);
//			dto.setEndDate(endDate);
//	       
//
//	        List<OrderDTO> orderDto = adService.salesInfoPeriod(dto);
////	        List<OrderDTO> orderDto = adService.salesInfoPeriod(dto, pDto);
//	        model.addAttribute("orderDto", orderDto);
//			
////			System.out.println("@@@@orderDTO@@@" + orderDto);
//	        
//			// serviceImpl에서 셋팅된 pDto
////			model.addAttribute("pDto", pDto);
//			
//			return "admin/income_state";
//		}			
//			
//}
//		
////	// 매출관리 페이지 이동
////		@GetMapping("incomeState.do")
////		public String incomeStateForm(Model model) {
////			
////			 ArrayList<HashMap<String, Object>> getIncome = adService.getIncome();
////			 String sum = getIncome.get(0).get("sum").toString();
////			 System.out.println("오늘매출 : "+ sum);
////			 
////			    JsonArray jArray = new JsonArray();
////
////			    for (HashMap<String, Object> map : getIncome) {
////			    	
////			        JsonObject json = new JsonObject();
////			        
////			        
////			        for (HashMap.Entry<String, Object> entry : map.entrySet()) {
////			            String key = entry.getKey();
////			            Object value = entry.getValue();
////
////			            // Check the type of value and add it appropriately
////			            if (value instanceof String) {
////			                json.addProperty(key, (String) value);
////			            } else if (value instanceof Number) {
////			                json.addProperty(key, (Number) value);
////			            } else if (value instanceof Boolean) {
////			                json.addProperty(key, (Boolean) value);
////			            } else {
////			                json.addProperty(key, value.toString());
////			            }
////			        }  
////			        jArray.add(json);
////			    }
////			   
////			
////			model.addAttribute("jArray", jArray);
////			System.out.println("############jArray : " + jArray);
////			
////			return "admin/income_state";
////		}
//		
////		@GetMapping("incomeState.do")
////		public String incomeStateForm(Model model) {
////			List<OrderDTO> list = adService.getIncome();
////			
//////			model.addAttribute("list", list);
////			System.out.println(list);
////			
////			Gson gson = new GsonBuilder().create();	
////			JsonArray jArray = new JsonArray();
////			
////			Iterator<OrderDTO> it = list.iterator();
////			while(it.hasNext()) {
////				OrderDTO dto = it.next();
////				JsonObject object = new JsonObject();
////				
////				int order_num = dto.getOrder_num();
////				String order_date = dto.getOrder_date().toString();
////				
////				
////				object.addProperty("order_num", order_num);
////				object.addProperty("order_date", order_date);
////				
////				
////				jArray.add(object);			
////			}
////					
////			String json = gson.toJson(jArray);
////			model.addAttribute("json", json);
////			System.out.println(json);
////			
////			return "admin/income_state";
////		}
////	

