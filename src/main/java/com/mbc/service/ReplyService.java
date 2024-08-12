package com.mbc.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.mbc.domain.MemberDTO;
import com.mbc.domain.ReplyDTO;
import com.mbc.domain.ReplyPageDTO;

public interface ReplyService {
	int register(ReplyDTO rDto);
	
	int remove(int rno);
	
	int modify(ReplyDTO rDto);
	
	ReplyDTO read(int rno);
	
//	List<ReplyDTO> getList(int bid, int vp);
	ReplyPageDTO getList(int bid, int vp);
	
}
