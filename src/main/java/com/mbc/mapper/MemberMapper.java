package com.mbc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mbc.domain.MemberDTO;
import com.mbc.domain.ProdPageDTO;
import com.mbc.domain.ProductDTO;

// DAO 대신 mapper 인터페이스 사용
//@Mapper // (mybatis에 있는 기능, 생략가능)
public interface MemberMapper {
	// public 생략 가능
	List<MemberDTO> memberList();
	
	void memberInsert(MemberDTO dto);
	
	MemberDTO memberInfo(String id);
	
	void deleteMember(int no);
	
	void memberUpdate(MemberDTO dto);
	
	MemberDTO idCheck(String uid);
	
	// 멤버 로그인
	MemberDTO memberLogin(MemberDTO dto);

	String findId(MemberDTO dto);

	int findPw(String uid, String uEmail, String tempPw);

	int updatePw(MemberDTO dto);

}
