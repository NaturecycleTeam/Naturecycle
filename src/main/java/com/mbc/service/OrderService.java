package com.mbc.service;

import org.springframework.stereotype.Service;

import com.mbc.domain.OrderDTO;

@Service
public interface OrderService {

	void orderInsert(OrderDTO dto);



	

}
