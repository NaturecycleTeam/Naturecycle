package com.mbc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mbc.domain.MemberDTO;
import com.mbc.service.DonateService;

@Controller
public class DonateController {

	@Autowired
	private DonateService service;

	// 기부페이지 이동
	@GetMapping("donation.do")
	public String donateInfo(String id, Model model) {
		MemberDTO dto = service.donateInfo(id);
		model.addAttribute("dto", dto);
//		System.out.println("dto = " + dto);
		return "donate/donation";
	}


	// 기부하기 @RequestParam("point") 
	@PostMapping("donation.do")
	public String donation(int point, MemberDTO dto, Model model) {
		// Get the current points from the database
		MemberDTO currentDto = service.donateInfo(dto.getId());
//		System.out.println("###dto.getId()" + dto.getId());
		int currentPoints = currentDto.getPoint();

		// Get the donation points from the form
		int donatedPoints = point;
		
		// 이 point와 날짜를 DB에 저장시켜야 함 (donation_point, donation_date) --> dto 추가를 oderDTO에 해줌

		// Calculate the remaining points after donation
		int remainingPoints = currentPoints - donatedPoints;

		// Set the new point value in the dto
		dto.setPoint(remainingPoints);

		// Update the points in the database
		service.donation(dto);

		// Redirect to the donation page with updated points
		return "redirect:donation.do?id=" + dto.getId();
	}
}