package com.mbc.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.domain.MemberDTO;

public interface MemberService {
	
	List<MemberDTO> memberList(String id);
	
	void memberRegister(MemberDTO dto);
	
	// 회원가입시 ID 중복체크
	MemberDTO memberIdCheck(String uid);
	// 회원가입시 전화번호 중복체크
	MemberDTO memberTelCheck(String utel);
	// 회원가입시 인증메일 발송 --> controller에서 다 해줌
	MemberDTO memberEmailCheck(String uEmail);
	
	MemberDTO memberInfo(String id);
	
	MemberDTO myProfile(String id);
	
	void memberRemove(String id);
	
	void memberModify(MemberDTO dto);
	
	MemberDTO idCheck(String uid);
	
	// 멤버 로그인
	boolean memberLogin(MemberDTO dto, HttpServletRequest req, RedirectAttributes redirectAttributes);

	String findId(MemberDTO dto);

	int findPw(String uid, String uEmail);

	int modifyPw(MemberDTO dto);

	String getAccessToken(String code);

	String getuserinfo(String access_Token, HttpSession session, RedirectAttributes rttr);

}
