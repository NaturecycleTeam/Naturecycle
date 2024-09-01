package com.mbc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mbc.domain.BoardDTO;
import com.mbc.domain.PageDTO;

public interface BoardMapper {
	
	////////////////////// 전체게시판  //////////////////////////////

	void insert(BoardDTO dto);

//	List<BoardDTO> getList(PageDTO pDto, @Param("type") String type);
	
	List<BoardDTO> getList(PageDTO pDto);

	BoardDTO view(int bid);

	void update(BoardDTO dto);

	void delete(int bid);
	
	void hitAdd(int bid);
	
	int totalCnt(PageDTO pDto);
	
	// 댓글 추가/삭제시 replyCnt값 수정
	void updateReplyCnt(@Param("bid") int bid, @Param("n") int n);
	
	
	////////////////////// 일대일 문의하기 //////////////////////////////
	void myQuestion(BoardDTO dto);

//	List<BoardDTO> myQuestionList(String mid_fk);

	List<BoardDTO> getPostsByType(PageDTO pDto, @Param("mid_fk") String mid_fk, @Param("type") String type);

	List<BoardDTO> getListQT(PageDTO pDto);

	BoardDTO questionView(int bid);
	
	
	
}
