package com.mbc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mbc.domain.ReservationDTO;
import com.mbc.service.ReservationService;

@Controller
public class ReservationController {

	@Autowired
	private ReservationService service;

	// 예약 상세정보
//	@RequestMapping("reservationInfo.do")
//	public String reservationInfo(String rid, Model model) {
//		ReservationDTO dto = service.reservationInfo(rid);
//		model.addAttribute("dto", dto);
//		
//		return "member/reservationInfo";
//	}
	
	@RequestMapping("reservationInfo.do")
	public String reservationInfo(String rid, Model model) {
		List<ReservationDTO> list = service.reservationInfo(rid);
		model.addAttribute("list", list);
		
		return "member/reservationInfo";
	}
	
	// 예약하기
	@GetMapping("reservation.do")
	public String reservation() {
				
		return "member/reservation";
	}
	
	// 예약하기
	@PostMapping("reservation.do")
	public String reservationOk(ReservationDTO dto) {
		service.reservation(dto);
		
		return "redirect:/";
	}
	
	// 예약시간 중복체크
	@RequestMapping("reservationTimeCheck.do")
	@ResponseBody
	public String reservationTimeCheck(String date, String time, Model model) {
		List<ReservationDTO> rDto = service.timeCheck(date, time);
		if (rDto != null) {
			model.addAttribute("rDto", rDto);
		}
		
		return "member/reservation";
	}
	
	// model로 바인딩 해서 reservation.jsp로 넘겨
	
	
//	
//	@RequestMapping("reservationTimeCheck.do")
//	public String reservationcheck(String date, Model model) {
//		
//		List<ReservationDTO> timeList = service.reservationcheck(date);
//		model.addAttribute("timeList", timeList);
//		
//		return "member/reservation";
//	}
	
	
	
	
}