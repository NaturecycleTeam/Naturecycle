package com.mbc.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.mbc.domain.MemberDTO;
import com.mbc.domain.OrderDTO;
import com.mbc.domain.OrderDetailDTO;

@Service
public interface OrderService {

	// void orderInsert(OrderDTO dto);
	
	boolean placeOrder(OrderDTO order, List<OrderDetailDTO> orderDetails, HttpSession session);

//	void pointInsert(MemberDTO mdto);

	List<OrderDTO> myOrderList(String id);

	List<OrderDetailDTO> myOrderDetail(int order_num);


}
