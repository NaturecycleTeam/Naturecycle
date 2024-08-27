package com.mbc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mbc.domain.BoardDTO;
import com.mbc.domain.PageDTO;
import com.mbc.domain.QuestionBoardDTO;
import com.mbc.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardMapper mapper;
	

	////////////////////// 전체게시판  //////////////////////////////
	
	// 게시글 등록
	@Override
	public void register(BoardDTO dto) {
		mapper.insert(dto);		
	}
		
	// 일반 게시글 불러오기(GENERAL)
	@Override
	public List<BoardDTO> getList(PageDTO pDto) {
		
		int totalCnt = mapper.totalCnt(pDto);
		
		// setValue호출시 startIndex 셋팅됨 		
		pDto.setValue(totalCnt, pDto.getCntPerPage());
		
		return mapper.getList(pDto);
	}
	
	// 게시글 상세보기
	@Override
	public BoardDTO view(int bid, String mode, String loginId) {
		
		BoardDTO dto = mapper.view(bid);
		
		if(mode.equals("v") && !loginId.equals(dto.getMid_fk())) {
			// 조회수 추가
			mapper.hitAdd(bid);
		}
		
		return mapper.view(bid);
	}
	
	// 게시글 수정
	@Override
	public void modify(BoardDTO dto) {		
		mapper.update(dto);
	}
	
	// 게시글 삭제
	@Override
	public void remove(int bid) {
		mapper.delete(bid);
		
	}

	
	//////////////////////1:1 문의하기  //////////////////////////////
	@Override
	public void myQuestion(BoardDTO dto) {
		mapper.myQuestion(dto);		
	}

//	@Override
//	public List<BoardDTO> myQuestionList(String mid_fk) {
//		
//		return mapper.myQuestionList(mid_fk);
//	}
	
	// 일대일 게시글 불러오기(QUESTION)
	@Override
	public List<BoardDTO> getQuestionPosts(String mid_fk) {
		
		return mapper.getPostsByType(mid_fk, "QUESTION");
	}

	@Override
	public List<BoardDTO> getListQT(BoardDTO dto) {
		
		return mapper.getListQT(dto);
	}


	
	








	
}
