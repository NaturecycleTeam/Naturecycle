package com.mbc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.mbc.domain.DonationDTO;
import com.mbc.domain.MemberDTO;
import com.mbc.service.DonateService;

@Controller
public class DonateController {

	@Autowired
	private DonateService service;
	
	
	// 캠페인 페이지 이동
	@GetMapping("campaign.do")
	public String campaignForm() {

		return "donate/donate_campaign";
	}
	
	// 캠페인 리스트 페이지 이동
	   @GetMapping("campaignInfo.do")
	   public String campaignInfo() {
	      
	      return "donate/donate_campaignInfo";
	   }
	
	// 기부페이지 이동
	@GetMapping("donation.do")
	public String donateInfo(String id, Model model) {
		
		List<DonationDTO> dDto = service.donationList();
		model.addAttribute("dDto", dDto);
		
		MemberDTO dto = service.donateInfo(id);
		model.addAttribute("dto", dto);
//		System.out.println("dto = " + dto);
		return "donate/donate_donation";
	}


	// 기부하기 
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
		
		// 기부금 내역 (관리자페이지)
		DonationDTO dDto = new DonationDTO();
		
		dDto.setDid_fk(currentDto.getId());
		dDto.setDonation_amount(donatedPoints);
		
		System.out.println("dDto : " + dDto);
		service.donationAmount(dDto);
		
		
		// Redirect to the donation page with updated points
		return "redirect:donation.do?id=" + dto.getId();
	}
	
	// 기부내역 확인 페이지 이동
	@GetMapping("mydonationInfo.do")
	public String mydonationInfo() {
		
		return "donate/donate/donationInfo";
	}
	
	// 기부등급
	@PostMapping("upgradeLevel.do")
	public String upgradeLevel() {
		
		
		return "donate/donate_donationInfo";
	}
}