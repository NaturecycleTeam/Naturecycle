package com.mbc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mbc.domain.MemberDTO;
import com.mbc.domain.OrderDTO;
import com.mbc.domain.OrderDetailDTO;
import com.mbc.domain.PointDTO;

@Mapper
public interface OrderMapper {

	// void orderInsert(OrderDTO dto);

	void insertOrder(OrderDTO order);
	
	boolean insertOrderDetail(OrderDetailDTO orderDetail);

	void pointInsert(MemberDTO mdto);

	List<OrderDTO> myOrderList(String id);

	String myOrderDetail(int order_num);

	List<OrderDetailDTO> orderDetailList(int order_num);

	void pointObtained(PointDTO pDto);


	
}
