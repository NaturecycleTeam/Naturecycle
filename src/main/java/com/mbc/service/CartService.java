package com.mbc.service;

import java.util.ArrayList;

import com.mbc.domain.CartDTO;

public interface CartService {
	
	// 카트 전체 리스트 가져오기
	ArrayList<CartDTO> cartList(String cid_fk);
	
	//////  카트 추가  ///////
	// 카트 리스트 체크(상품이 있는지 없는지)
	CartDTO checkCart(CartDTO dto);
	// 카트 등록 (상품이 없으면)
	void addCart(CartDTO dto);
	// 카트 수정 (상품이 있으면)
	void modifyCart(CartDTO dto);
	// 카트 삭제
	void deleteCart(int cart_num);

	void deleteCheckout(int pnum, String id);

	
}
