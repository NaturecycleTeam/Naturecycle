package com.mbc.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mbc.domain.PointDTO;
import com.mbc.domain.MemberDTO;

@Service
public interface DonateService {
	
	void donation(MemberDTO dto);

	void donationAmount(PointDTO pDto);
	
	
	MemberDTO donateInfo(String id);

	List<PointDTO> donationList();

	List<PointDTO> myDonationList(String id);

	Integer getMyPoint(String id);




}
