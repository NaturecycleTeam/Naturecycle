package com.mbc.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.mbc.domain.OrderDTO;

@Mapper
public interface OrderMapper {

	void orderInsert(OrderDTO dto);
	




	
}
