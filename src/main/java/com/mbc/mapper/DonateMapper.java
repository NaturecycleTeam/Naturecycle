package com.mbc.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.mbc.domain.MemberDTO;

@Mapper
public interface DonateMapper {
	MemberDTO donateInfo(String id);

	/* void donation(MemberDTO dto); */
	
	void updatePoints(MemberDTO dto);
}
