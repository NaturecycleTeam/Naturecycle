package com.mbc.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mbc.domain.MemberDTO;
import com.mbc.domain.OrderDTO;
import com.mbc.mapper.OrderMapper;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderMapper mapper;
	
	// 주문 정보 저장(관리자용)
	@Override
	public void orderInsert(OrderDTO dto) {
		
		mapper.orderInsert(dto);
	}
	
	// 포인트 적립(회원용) 
	@Override
	public void pointInsert(MemberDTO mdto) {
		
		mapper.pointInsert(mdto);
	}
	

	

	


}
