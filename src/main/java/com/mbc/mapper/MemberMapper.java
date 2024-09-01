package com.mbc.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mbc.domain.MemberDTO;
import com.mbc.domain.ProdPageDTO;
import com.mbc.domain.ProductDTO;

// DAO 대신 mapper 인터페이스 사용
//@Mapper // (mybatis에 있는 기능, 생략가능)
public interface MemberMapper {
	// public 생략 가능
	List<MemberDTO> memberList(String id);
	
	void memberInsert(MemberDTO dto);
	
	// 회원가입시 ID 중복체크
	MemberDTO memberIdCheck(String uid);
	// 회원가입시 전화번호 중복체크
	MemberDTO memberTelCheck(String utel);
	// 회원가입시 인증메일 발송 --> controller에서 다 해줌
	MemberDTO memberEmailCheck(String uEmail);
	
	MemberDTO memberInfo(String id);
	
	MemberDTO myProfile(String id);

	void deleteMember(String id);
	
	void memberUpdate(MemberDTO dto);
	
	MemberDTO idCheck(String uid);
	
	// 멤버 로그인
	MemberDTO memberLogin(MemberDTO dto);

	String findId(MemberDTO dto);

	int findPw(String uid, String uEmail, String tempPw);

	int updatePw(MemberDTO dto);

	//이미 가입된 회원인지 확인하는 메소드
    MemberDTO findkakao(HashMap<String, Object> userInfo);

    //카카오 로그인 회원정보 저장
    void kakaoinsert(HashMap<String, Object> userInfo);

	MemberDTO selectMember(String string);

	void addPoint(String id, int point);

	void updatePoint(String id, int point);

}
