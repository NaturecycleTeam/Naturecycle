package com.mbc.service;

import org.springframework.stereotype.Service;
import com.mbc.domain.MemberDTO;

@Service
public interface DonateService {
	MemberDTO donateInfo(String id);

	/* void donation(MemberDTO dto); */

	void donation(MemberDTO dto);
}
