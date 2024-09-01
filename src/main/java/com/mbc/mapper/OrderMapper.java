package com.mbc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mbc.domain.MemberDTO;
import com.mbc.domain.OrderDTO;

@Mapper
public interface OrderMapper {

	void orderInsert(OrderDTO dto);

	void pointInsert(MemberDTO mdto);

	List<OrderDTO> myOrderList(String id);

	String myOrderDetail(int order_num);

	List<OrderDTO> orderDetailList(String order_date);

	
}
