package com.mbc.service;

import org.springframework.stereotype.Service;

import com.mbc.domain.MemberDTO;
import com.mbc.domain.OrderDTO;

@Service
public interface OrderService {

	void orderInsert(OrderDTO dto);

	void pointInsert(MemberDTO mdto);



	

}
