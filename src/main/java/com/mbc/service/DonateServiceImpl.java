package com.mbc.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mbc.domain.DonationDTO;
import com.mbc.domain.MemberDTO;
import com.mbc.mapper.DonateMapper;

@Service
public class DonateServiceImpl implements DonateService {

	@Autowired // 의존성 추가
	private DonateMapper mapper;

	@Override
	public MemberDTO donateInfo(String id) {
		return mapper.donateInfo(id);
	}

	@Override
	/*public void donation(MemberDTO dto) {
		mapper.donation(dto);
	}*/
	public void donation(MemberDTO dto) {
		
        mapper.updatePoints(dto);
    }

	@Override
	public void donationAmount(DonationDTO dDto) {
		
		mapper.donationAmount(dDto);
	}
}
