package com.mbc.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mbc.domain.DonationDTO;
import com.mbc.domain.MemberDTO;

@Service
public interface DonateService {
	
	void donation(MemberDTO dto);

	void donationAmount(DonationDTO dDto);
	
	
	MemberDTO donateInfo(String id);

	List<DonationDTO> donationList();

	/* void donation(MemberDTO dto); */


}
