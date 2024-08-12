package com.mbc.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.mbc.domain.CartDTO;
import com.mbc.mapper.CartMapper;

@Service
public class CartServiceImpl implements CartService{
	
	@Autowired
	private CartMapper cartMapper;
	
	@Autowired // root-context에서 생성된 Bean class 를 주입받기 // servlet에서 생성된건 받지 못함
	JavaMailSender mailSender;
	
	@Autowired	// 암호화를위해서 root 추가한 pwEncoder에서 주입받음
	private BCryptPasswordEncoder pwEncoder;
	
	// 카트 전체 리스트 가져오기
	@Override
	public ArrayList<CartDTO> cartList(String id) {
		
		return cartMapper.cartList(id);
	}
	
	//// 카트 리스트 체크(상품이 있는지 없는지)
	@Override
	public CartDTO checkCart(CartDTO dto) {
		
		return cartMapper.checkCart(dto);
	}
	// 카트 등록 (상품이 없으면)
	@Override
	public void addCart(CartDTO dto) {
		cartMapper.addCart(dto);
		
	}
	// 카트 수정 (상품이 있으면)
	@Override
	public void modifyCart(CartDTO dto) {
		cartMapper.modifyCart(dto);		
	}

	// 카트 삭제
	@Override
	public void deleteCart(int cart_num) {
		cartMapper.deleteCart(cart_num);		
	}

	@Override
	public void deleteCheckout(int pnum, String id) {
		cartMapper.deleteCheckout(pnum, id);
		
	}
	
	
	
}
