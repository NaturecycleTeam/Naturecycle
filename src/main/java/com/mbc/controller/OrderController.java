package com.mbc.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.domain.CartDTO;
import com.mbc.domain.OrderDTO;
import com.mbc.service.CartService;
import com.mbc.service.OrderService;

@Controller
public class OrderController {

	@Autowired
	private OrderService service;
	
	@Autowired
	private CartService cartService;
	
	@GetMapping("orderInsert.do")
	public String orderComplete(HttpSession session, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		
		 // 세션에서 장바구니 목록을 가져옵니다.
	    List<CartDTO> cartList = (List<CartDTO>)session.getAttribute("dtos");
	    
	    if (cartList == null || cartList.isEmpty()) {
	        // 장바구니에 상품이 없을 경우 처리
	        return "redirect:/cartList.do"; // 장바구니가 비어있으면 장바구니 페이지로 리디렉션
	    }

	    // 각 장바구니 항목을 OrderDTO로 변환하여 DB에 저장
	    for (CartDTO cartItem : cartList) {
	        OrderDTO dto = new OrderDTO();
	        
	        // OrderDTO에 필요한 값 설정
	        dto.setPnum_fk(cartItem.getPnum_fk()); // 상품 번호 설정
	        dto.setOid_fk(cartItem.getCid_fk()); // 주문자 아이디 설정
	        dto.setQty_ordered(cartItem.getPqty()); // 주문 수량 설정
	        dto.setPrice_each(cartItem.getPrice()); // 개별 가격 설정
	        dto.setPoint(cartItem.getPoint()); // 포인트 설정
	        
	        // 주문 정보를 DB에 저장
	        service.orderInsert(dto);
	    }
	    
	    // 주문이 완료된 후 세션에서 dtos 제거
	    for (CartDTO cart : cartList) {	    	
	    	cartService.deleteCart(cart.getCart_num());
	    }
	    
	    // 주문 완료 후 세션에서 'dtos' 속성을 제거
	    // session.removeAttribute("dtos");	    
	    
	    redirectAttributes.addFlashAttribute("msg", "주문이 완료되었습니다!!");
	    // 모든 주문 정보가 저장된 후 메인 페이지로 리디렉션
	    
	    return "redirect:myProfile.do";
	}
	
}
