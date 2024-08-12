package com.mbc.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.domain.MemberDTO;
import com.mbc.domain.ProdPageDTO;
import com.mbc.domain.ProductDTO;



public interface MemberService {
	
	List<MemberDTO> memberList();
	
	void memberRegister(MemberDTO dto);
	
	MemberDTO memberInfo(String id);
	
	void memberRemove(int no);
	
	void memberModify(MemberDTO dto);
	
	MemberDTO idCheck(String uid);
	
	// 멤버 로그인
	boolean memberLogin(MemberDTO dto, HttpServletRequest req, RedirectAttributes redirectAttributes);

	String findId(MemberDTO dto);

	int findPw(String uid, String uEmail);

	int modifyPw(MemberDTO dto);

}
