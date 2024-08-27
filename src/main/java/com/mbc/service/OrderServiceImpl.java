package com.mbc.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mbc.domain.OrderDTO;
import com.mbc.mapper.OrderMapper;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderMapper mapper;
	
	@Override
	public void orderInsert(OrderDTO dto) {
		
		mapper.orderInsert(dto);
	}

	


}
