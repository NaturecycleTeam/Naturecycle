package com.mbc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mbc.domain.PointDTO;
import com.mbc.domain.MemberDTO;

@Mapper
public interface DonateMapper {
	MemberDTO donateInfo(String id);
	
	void updatePoints(MemberDTO dto);

	void donationAmount(PointDTO pDto);

	List<PointDTO> donationList();

	List<PointDTO> myDonationList(String id);

	Integer getMyPoint(String id);

}
