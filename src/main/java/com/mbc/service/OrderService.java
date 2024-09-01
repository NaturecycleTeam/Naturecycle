package com.mbc.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mbc.domain.MemberDTO;
import com.mbc.domain.OrderDTO;

@Service
public interface OrderService {

	void orderInsert(OrderDTO dto);

	void pointInsert(MemberDTO mdto);

	List<OrderDTO> myOrderList(String id);

	List<OrderDTO> myOrderDetail(int order_num);



}
