package com.mbc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mbc.domain.DonationDTO;
import com.mbc.domain.MemberDTO;

@Mapper
public interface DonateMapper {
	MemberDTO donateInfo(String id);

	/* void donation(MemberDTO dto); */
	
	void updatePoints(MemberDTO dto);

	void donationAmount(DonationDTO dDto);

	List<DonationDTO> donationList();
}
