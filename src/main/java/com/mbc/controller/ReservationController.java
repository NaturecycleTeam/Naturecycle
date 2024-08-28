package com.mbc.controller;

import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.mbc.domain.OrderDTO;
import com.mbc.domain.PageDTO;
import com.mbc.domain.ReservationDTO;
import com.mbc.service.ReservationService;
import com.mbc.util.ReservationStatus;

@Controller
public class ReservationController {

	@Autowired
	private ReservationService service;

	/////////////////// 관리자 //////////////////////
	
	// 예약 리스트 페이지 이동
	@GetMapping("reservationList.do")
//	public String reservationList(PageDTO pDto, Model model) {
	public String reservationList(Model model) {
		
//		List<ReservationDTO> list = service.reservationList(pDto);
		List<ReservationDTO> list = service.reservationList();
		model.addAttribute("list", list);
//		System.out.println("###list####" + list);
			
//		model.addAttribute("pDto", pDto);
		
		return "admin/ad_reservationList";
	}
	
	// 예약 확정하기
	@RequestMapping("reservationConfirmed.do")
	public String reservationConfirm(@RequestParam("rno") int rno, Model model, RedirectAttributes redirectAttributes) {

		// 예약 번호(rno)에 해당하는 예약의 상태를 DONE으로 변경(xml에서 변경)
	    service.reservationConfirmed(rno);
	    redirectAttributes.addFlashAttribute("msg", "예약을 확정하였습니다!!");

	    // 예약 리스트 페이지로 리디렉션
	    return "redirect:reservationList.do";
	}
	
	
	// 예약 취소하기
	@GetMapping("reservationCancel.do")
	public String reservationCancel(int rno, RedirectAttributes redirectAttributes) {
		service.reservationCancel(rno);
		redirectAttributes.addFlashAttribute("msg", "예약을 취소하였습니다!!");
		
		return "redirect:reservationList.do";		
	}
	
	// 예약 리스트 달력에 표시
	@RequestMapping("calendarList.do")
	@ResponseBody
	public String calendarList(Model model) {
		
		List<ReservationDTO> list =service.calendarList();
//		SimpleDateFormat sd = new SimpleDateFormat("yy-MM-dd");	
		
		JsonArray jArray = new JsonArray();	
		Iterator<ReservationDTO> it = list.iterator();
		while(it.hasNext()) {
			ReservationDTO dto = it.next();
			JsonObject object = new JsonObject();
			
//			String reservation_month = dto.getReservation_month();
			int rno = dto.getRno();
			String date = dto.getDate();
			String time = dto.getTime();
			String rid_fk = dto.getRid_fk();
			String contents = dto.getContents();
			String reservationStatus = dto.getReservationStatus().toString();			
			
//			System.out.println(sum);
			
//			object.addProperty("reservation_month", reservation_month);
			object.addProperty("rno", rno);
			object.addProperty("date", date);
			object.addProperty("time", time);
			object.addProperty("rid_fk", rid_fk);
			object.addProperty("contents", contents);
			object.addProperty("reservationStatus", reservationStatus);
			jArray.add(object);			
		}
		
		Gson gson = new GsonBuilder().create();	
		String json = gson.toJson(jArray);
		System.out.println("jjjjjjjjjjjjjjson" + json);
		
		return json;
	}
	
	// 달력
	/*
	 * @GetMapping("calendar1.do") public String calForm1() {
	 * 
	 * return "member/calendar"; }
	 */
	
	// 달력 페이지 이동
	@GetMapping("calendar2.do")
	public String calForm() {

		return "admin/ad_reservationList_old";
	}
	
	
	/////////////////// 유저 //////////////////////
	
	// 리사이클 페이지 이동
	@GetMapping("recycle.do")
	public String recycle() {
      
      return "member/recycle";
	}

	// 예약페이지 이동
	@GetMapping("reservation.do")
	public String reservation() {

		return "member/reservation";
	}

	// 예약하기
	@PostMapping("reservation.do")
	public String reservationOk(ReservationDTO dto, Model model) {
		
        dto.setReservationStatus(ReservationStatus.PENDING); 
        service.reservation(dto);
	  		    
	    // 모델에 예약 리스트 추가하여 JSP로 전달
	    model.addAttribute("dto", dto);
	    
	    return "redirect:/";
	}
	
	
	// 예약정보 확인하기
	@RequestMapping("reservationInfo.do")
	public String reservationInfo(String rid_fk, Model model) {
	 List<ReservationDTO> list = service.reservationInfo(rid_fk);
//	 System.out.println("@@@@list1@@@@ : " + list);
	 
//	    // 각 예약에 상태 설정
//	    for (ReservationDTO dto : list) {
//	    	dto.setStatus(dto.getStatus()); // DB에서 가져온 상태를 그대로 사용
//	    	System.out.println("@@@@@reservationDTO@@@@@ : " + dto);
//	    }
	    
	    model.addAttribute("list", list);
//	    System.out.println("@@@@list2@@@@ : " + list);

	    return "member/reservationInfo";  // JSP 파일 경로
	}

	// 예약시간 중복체크
	@RequestMapping("reservationTimeCheck.do")
	@ResponseBody
	public List<String> reservationTimeCheck(@RequestParam String date) {
        List<String> reservedTimes = service.getReservedTimes(date);
//        System.out.println("reservedTimes" + reservedTimes);  
        
        return reservedTimes;
    }


}