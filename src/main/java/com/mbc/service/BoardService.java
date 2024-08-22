package com.mbc.service;

import java.util.List;

import com.mbc.domain.BoardDTO;
import com.mbc.domain.PageDTO;
import com.mbc.domain.QuestionBoardDTO;

public interface BoardService {
	// 게시글 등록
	void register(BoardDTO dto);
	
	// 게시글 리스트
//	List<BoardDTO> getList();
	List<BoardDTO> getList(PageDTO pDto);
	
	// 글 상세보기
	BoardDTO view(int bid, String mode);
	
	// 글 수정하기
	void modify(BoardDTO dto);

	void remove(int bid);

	//////////////////////1:1 문의하기  //////////////////////////////
	void question(QuestionBoardDTO qDto);

//	List<QuestionBoardDTO> getListQ(QuestionBoardDTO qDto);

	List<QuestionBoardDTO> getListQT(QuestionBoardDTO qDto);

	QuestionBoardDTO getListQ(String mid);


	

	
}
