package com.mbc.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mbc.domain.CartDTO;
import com.mbc.domain.MemberDTO;
import com.mbc.domain.OrderDTO;
import com.mbc.domain.OrderDetailDTO;
import com.mbc.domain.PointDTO;
import com.mbc.mapper.CartMapper;
import com.mbc.mapper.OrderMapper;
import com.mbc.util.PointType;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderMapper mapper;
	
	@Autowired
	private CartMapper cartMapper;
	
	// 주문 정보 저장(관리자용)
//	@Override
//	public void orderInsert(OrderDTO dto) {
//		
//		mapper.orderInsert(dto);
//	}
	
	@Override
	@Transactional
	public boolean placeOrder(OrderDTO order, List<OrderDetailDTO> orderDetails, HttpSession session) {
	    // 세션에서 장바구니 목록을 가져오기
	    List<CartDTO> cartList = (List<CartDTO>) session.getAttribute("dtos");

	    if (cartList == null || cartList.isEmpty()) {
	        // 장바구니에 상품이 없을 경우 처리
	        return false; // 장바구니가 비어있으면 장바구니 페이지로 리디렉션
	    }

	    // OrderDTO에 필요한 값 설정
	    MemberDTO mDto = (MemberDTO) session.getAttribute("loginDTO");
	    String id = mDto.getId();

	    int total_amount = 0;
	    int total_point = 0;

	    for (CartDTO cartItem : cartList) {
	        total_amount += (cartItem.getPqty() * cartItem.getPrice());
	        total_point += (cartItem.getPqty() * cartItem.getPoint());
	    }

	    // 1. tbl_order 저장
	    order.setId(id);   // 주문자 아이디 설정
	    order.setTotal_amount(total_amount);   // 주문 합계
	    order.setTotal_point(total_point);   // 포인트 합계
	    mapper.insertOrder(order);

	    // Get the generated order_num (assumes your mapper returns it)
	    int orderNum = order.getOrder_num();

	    // 2. tbl_orderDetail 저장
	    for (CartDTO cartItem : cartList) {
	        OrderDetailDTO detail = new OrderDetailDTO();
	        detail.setOrder_num(orderNum); // Use the generated order_num
	        detail.setPnum(cartItem.getPnum_fk());
	        detail.setQuantity(cartItem.getPqty());
	        detail.setUnitPrice(cartItem.getPrice());
	        detail.setUnitPoint(cartItem.getPoint());

	        mapper.insertOrderDetail(detail);
	    }
	    
	    // 주문이 완료된 후 장바구니에서 dtos 제거
	    for (CartDTO cart : cartList) {	    	
	    	cartMapper.deleteCart(cart.getCart_num());
	    }
	    
	    // 3. tbl_member 포인트 적립
		MemberDTO mdto = new MemberDTO();
        
        mdto.setId(id); // 아이디 저장
        mdto.setPoint(total_point); // 포인트 설정
        
        mapper.pointInsert(mdto);
	    
        // 4. tbl_point 포인트 적립
        PointDTO pDto = new PointDTO();
        
        pDto.setId(id);
        pDto.setPoint(total_point);
        pDto.setPointType(PointType.OBTAINED);
        
        mapper.pointObtained(pDto);
        
	    return true;
	}
	
	
	// 포인트 적립(회원용) 
//	@Override
//	public void pointInsert(MemberDTO mdto) {
//		
//		mapper.pointInsert(mdto);
//	}

	// 내 주문정보 불러오기(회원용)
	@Override
	public List<OrderDTO> myOrderList(String id) {
		
		return mapper.myOrderList(id);
	}
	
	// 내 주문 상세정보 불러오기(회원용)
	@Override
	public List<OrderDetailDTO> myOrderDetail(int order_num) {
		
		
		return mapper.orderDetailList(order_num);
	}

}
