package com.mbc.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.mbc.domain.CartDTO;

public interface CartMapper {
	
	// 카트 리스트
	ArrayList<CartDTO> cartList(String id);

	CartDTO checkCart(CartDTO dto);

	void addCart(CartDTO dto);

	void modifyCart(CartDTO dto);

	void deleteCart(int cart_num);

	void deleteCheckout(@Param("pnum") int pnum, @Param("id") String id);

}
