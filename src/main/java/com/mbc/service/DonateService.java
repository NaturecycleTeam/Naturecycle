package com.mbc.service;

import org.springframework.stereotype.Service;

import com.mbc.domain.DonationDTO;
import com.mbc.domain.MemberDTO;

@Service
public interface DonateService {
	
	void donation(MemberDTO dto);

	void donationAmount(DonationDTO dDto);
	
	
	MemberDTO donateInfo(String id);

	/* void donation(MemberDTO dto); */


}
