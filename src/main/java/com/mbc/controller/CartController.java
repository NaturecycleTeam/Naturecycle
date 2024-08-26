package com.mbc.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.domain.CartDTO;
import com.mbc.domain.MemberDTO;
import com.mbc.service.CartService;
import com.mbc.service.MemberService;

@Controller
public class CartController {

	@Autowired
	private CartService cartService;

	@Autowired
	private MemberService memberService;

	// 장바구니 이동
	@GetMapping("cartList.do")
	public String cartList(HttpSession session) {

		MemberDTO dto = (MemberDTO) session.getAttribute("loginDTO");
		String cid_kf = dto.getId();
//		System.out.println("@@@@@@@@@dto : " + dto);
//		System.out.println("@@@@@@@@@id : " + id);

		ArrayList<CartDTO> cartList = cartService.cartList(cid_kf);

		for (CartDTO cdto : cartList) {
			cdto.setTotal();
		}

		session.setAttribute("dtos", cartList);		

		return "product/cart_list";
	}

	// 장바구니 담기
	@RequestMapping("addCart.do")
	public String addCart(CartDTO dto, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
		MemberDTO mdto = (MemberDTO) session.getAttribute("loginDTO");
		dto.setCid_fk(mdto.getId());
		CartDTO ckDTO = cartService.checkCart(dto);	
		
		
		if (ckDTO == null) {
			cartService.addCart(dto);
			redirectAttributes.addFlashAttribute("msg", "장바구니 등록 완료");
		} else {
			dto.setPqty(ckDTO.getPqty() + 1);
			dto.setCart_num(ckDTO.getCart_num());
			cartService.modifyCart(dto);
			redirectAttributes.addFlashAttribute("msg", "장바구니 수량추가");
		}

		return "redirect:cartList.do";
	}

	// 카트 정보(인포)폼에서 수정OK 이동
	@RequestMapping("/modifyCart.do")
	public String modifyCart(CartDTO dto, RedirectAttributes redirectAttributes) {
		cartService.modifyCart(dto);
		redirectAttributes.addFlashAttribute("msg", "장바구니 수정완료");
		return "redirect:cartList.do";
	}

	// 장바구니 삭제
	@PostMapping("deleteCart.do")
	public String deleteCart(int cart_num, RedirectAttributes redirectAttributes) {
		cartService.deleteCart(cart_num);
		redirectAttributes.addFlashAttribute("msg", "장바구니 수정완료");
		return "redirect:cartList.do";
	}

	// 구매페이지 이동
	@GetMapping("checkout.do")
	public String checkOutFoam(Model model, HttpSession session, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		MemberDTO mdto = (MemberDTO) session.getAttribute("loginDTO");
		String cid_kf = mdto.getId();

		MemberDTO mDto = memberService.memberInfo(cid_kf);
		model.addAttribute("mDto", mDto);
		request.setAttribute("msg", "구매 페이지로 이동합니다.");

		return "product/checkout";
	}

	// 구매리스트에서 삭제
	@RequestMapping("deleteCheckout.do")
	public String deleteCheckout(String pnum, String cid_kf, HttpSession session, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {

		MemberDTO mdto = (MemberDTO) session.getAttribute("loginDTO");
		cid_kf = mdto.getId();

//		pnum = null;

		String pnums = request.getParameter("delPnums");
		System.out.println("pnums : " + pnums);

		// 1. 삭제 버튼
		if (pnums == null) {
			if (request.getMethod().equals("POST")) { // 보안
				pnum = request.getParameter("pnum");
			}
			if (pnum == null || pnum.trim().equals("")) { // 보안
				request.setAttribute("msg", "잘못된 경로 입니다.");
				return "redirect:userMainForm.do";
			}
			// DB에서 리스트 삭제
			cartService.deleteCheckout(Integer.valueOf(pnum), cid_kf); // cartDAO로 리턴
			// id를 세션으로 묵으면 결제하기페이지에서 소환가능
			ArrayList<CartDTO> cartList = cartService.cartList(cid_kf);
			// 토탈 setTotal() 함수 호출하기 (합계구하는 함수)
			for (CartDTO cDto : cartList) {
				cDto.setTotal(); // 수량만큼 totPrice, totPoint 계산
			}
			// 바인딩
			session.setAttribute("dtos", cartList);
			redirectAttributes.addFlashAttribute("msg", "장바구니1 삭제 완료");
			return "redirect:checkout.do"; // '장바구니리스트'로 리턴
		}

		// 2. 선택삭제

		String[] numArr = pnums.split("/"); // 구분자로 값을 꺼내서 배열에 넣기 [5,7,6...]

		for (int i = 0; i < numArr.length; i++) {
			cartService.deleteCheckout(Integer.valueOf(numArr[i]), cid_kf); // cartDAO로 리턴
		}

		// id를 세션으로 묵으면 결제하기페이지에서 소환가능
		ArrayList<CartDTO> cartList = cartService.cartList(cid_kf);

		// 토탈 setTotal() 함수 호출하기 (합계구하는 함수)
		for (CartDTO cDto : cartList) {
			cDto.setTotal(); // 수량만큼 totPrice, totPoint 계산
		}

		// 바인딩
		session.setAttribute("dtos", cartList);
		redirectAttributes.addFlashAttribute("msg", "장바구니2 삭제 완료");
		return "redirect:checkout.do";
	}

}
