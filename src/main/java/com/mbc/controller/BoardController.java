package com.mbc.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mbc.domain.BoardDTO;
import com.mbc.domain.MemberDTO;
import com.mbc.domain.PageDTO;
import com.mbc.service.BoardService;

@Controller
public class BoardController {

	@Autowired
	private BoardService service;
		
	
	@GetMapping("/register.do")
	public String register() {
		
		return "board/register";
	}
	
	@PostMapping("/register.do")
	public String register(BoardDTO dto, HttpSession session) {

		// 임의 게시글 123개 생성
//		for(int i=1; i<=123; i++) {
//			BoardDTO bDto = new BoardDTO();
//			bDto.setSubject(i + "번째 제목입니다~~~");
//			bDto.setContents(i + "번째 내용입니다~~~");
//			bDto.setWriter("아무개 " + (i%10));
//			service.register(bDto);
//		}
		
		// 게시글 타입 설정 (예: 일반 게시글)
	    dto.setType("GENERAL");
				
		service.register(dto);
		return "redirect:list.do";
	}
	
	
//	@GetMapping("/list.do")
//	public String list(Model model) {
//		List<BoardDTO> list = service.getList();
//		model.addAttribute("list", list);
//		
//		return "board/boardList";
//	}
	
	// 게시글 리스트 페이징 처리 
//	@GetMapping("/list.do")
////	public String list(@RequestParam(name="viewPage", defaultValue="1") int viewPage, Model model) {
//	public String list(PageDTO pDto, Model model) {		
//		List<BoardDTO> list = service.getList(pDto);
//		model.addAttribute("list", list);
//		
//		// serviceImpl에서 셋팅된 pDto
//		model.addAttribute("pDto", pDto);
//		
//		return "board/boardList";
//	}
	
//	@RequestMapping("/list.do")
//	public String list(PageDTO pDto, Model model) {		
//		List<BoardDTO> list = service.getList(pDto);
//		model.addAttribute("list", list);
//						
//		// serviceImpl에서 셋팅된 pDto
//		model.addAttribute("pDto", pDto);
//		
//		return "board/boardList";
//	}
	
	// 게시글 가져오기 (일반 게시글과 일대일문의 게시글 구분)
	@RequestMapping("/list.do")
	public String myBoardList(PageDTO pDto, Model model) {
		
        // 일반 게시글 불러오기
        List<BoardDTO> generalPosts = service.getList(pDto);

        // 모델에 데이터 추가
        model.addAttribute("generalPosts", generalPosts);
        
        // serviceImpl에서 셋팅된 pDto
		model.addAttribute("pDto", pDto);

        return "board/boardList";
    }
		
	// 글상세보기
	@GetMapping("/view.do")
	public String view(int bid, PageDTO pDto, Model model, HttpSession session) {
		 // 세션에서 로그인 ID를 가져옴
	    MemberDTO loginDTO = (MemberDTO) session.getAttribute("loginDTO");
	    if (loginDTO == null) {
	        return "redirect:login.do"; // 로그인되지 않은 경우 리디렉션
	    }
	    String loginId = loginDTO.getId();
		
		
		BoardDTO dto = service.view(bid, "v", loginId);
		
		model.addAttribute("dto", dto);
		model.addAttribute("pDto", pDto);
		
		return "board/view";
	}
	
	// 수정페이지 이동
	@GetMapping("/modify.do")
	public String modifyForm(PageDTO pDto, int bid, Model model) {
		System.out.println("vp : " + pDto.getViewPage());
		BoardDTO dto = service.view(bid, "m", "x");
		model.addAttribute("dto", dto);
		model.addAttribute("pDto", pDto);
		System.out.println("vp2 : " + pDto.getViewPage());
		
		return "board/modify";
	}
	
	// 게시글 수정하기
	@PostMapping("/modify.do")
	public String modify(PageDTO pDto, BoardDTO dto, Model model) {
		service.modify(dto);
		
		int viewPage = pDto.getViewPage();
		System.out.println("vp ======> " +viewPage);
		model.addAttribute("viewPage", viewPage);
		model.addAttribute("searchType", pDto.getSearchType());
		model.addAttribute("keyword", pDto.getKeyword());
		model.addAttribute("cntPerPage", pDto.getCntPerPage());
		
		return "redirect:list.do";
	}
	
	// 게시글 삭제
	@GetMapping("/remove.do")
	public String remove(PageDTO pDto, int bid, Model model) {
		service.remove(bid);		
		model.addAttribute("viewPage", pDto.getViewPage());
		 
		// redirect 시 model에 바인딩된 값은 queryString으로 전달된다.
		// PageDTO 객체는 queryString으로 전달될 수 없음(int, String은 가능)
		return "redirect:list.do";
	}
	
	
	
	//////////////////////  1:1 문의하기  //////////////////////////////
	// 일대일문의하기 페이지 이동
	@GetMapping("/myQuestion.do")	
	public String question() {		
		
		return "board/myQuestion";		
	}	
	
	// 일대일 문의하기
	@PostMapping("/myQuestion.do")
	public String myQuestion(BoardDTO dto, HttpSession session) {
		
		 // 세션에서 사용자 정보를 가져올 때, loginDTO 객체에서 id를 가져옵니다.
		MemberDTO loginDTO = (MemberDTO) session.getAttribute("loginDTO");

	    // loginDTO가 null인지 확인
	    if (loginDTO != null) {
	        String mid_fk = loginDTO.getId();
	        dto.setMid_fk(mid_fk);

	        System.out.println("bbs_mid_fk : " + mid_fk);
	    } else {
	        // 로그인이 되어있지 않으면 로그인 페이지로 리디렉션
	        return "redirect:login.do";
	    }
	    
		// 게시글 타입 설정 (예: 일반 게시글)
	    dto.setType("QUESTION");
		
		service.myQuestion(dto);		
		
		return "redirect:myQuestionList.do";
	}	
	
	// 일대일 문의내용 확인 
	@RequestMapping("/myQuestionList.do")	
	public String myQuestionList(String mid_fk, Model model, HttpSession session) {	

        // 세션에서 로그인 ID를 가져옴
        if (mid_fk == null || mid_fk.isEmpty()) {
            MemberDTO loginDTO = (MemberDTO) session.getAttribute("loginDTO");
            if (loginDTO != null) {
                mid_fk = loginDTO.getId();
            } else {
                return "redirect:login.do"; // 로그인이 되어 있지 않으면 로그인 페이지로 리디렉션
            }
        }
        
		List<BoardDTO> questionPosts = service.getQuestionPosts(mid_fk);
		
		model.addAttribute("questionPosts", questionPosts);
	
		return "board/myQuestionList";
	}
	
	// 관리자 문의내용 관리
	@RequestMapping("/adQuestionList.do")
	public String listQT(BoardDTO dto, Model model) {		
		List<BoardDTO> qList = service.getListQT(dto);
		model.addAttribute("qList", qList);
						
		// serviceImpl에서 셋팅된 qDto
		model.addAttribute("dto", dto);
		
		return "admin/ad_question_list";
	}
	
}
