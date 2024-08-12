package com.mbc.service;

import java.util.List;
import java.util.UUID;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.domain.MemberDTO;
import com.mbc.domain.ProdPageDTO;
import com.mbc.domain.ProductDTO;
import com.mbc.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired  // 의존성 추가
	private MemberMapper mapper;
	
	@Autowired
	private JavaMailSender mailSender;
	
	// 멤버 리스트
	@Override
	public List<MemberDTO> memberList() {		
		return mapper.memberList();
	}
	
	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	
	// 멤버 등록
	@Override
	public void memberRegister(MemberDTO dto) {
		String plainPw = dto.getPw(); // 회원가입시 입력된 평문 비번
		String chiperPw = pwEncoder.encode(plainPw);
		dto.setPw(chiperPw);  // 암호화된 비번을 dto에 셋팅
		mapper.memberInsert(dto);		
	}
	
	// 멤버 상세정보
	@Override
	public MemberDTO memberInfo(String id) {		
		return mapper.memberInfo(id);
	}
	
	// 멤버 삭제
	@Override
	public void memberRemove(int no) {
		mapper.deleteMember(no);		
	}
	
	// 멤버 수정
	@Override
	public void memberModify(MemberDTO dto) {
		mapper.memberUpdate(dto);		
	}
	
	// 멤버 아이디체크
	@Override
	public MemberDTO idCheck(String uid) {		
		return mapper.idCheck(uid);
	}
	
	// 멤버 로그인
	@Override
	public boolean memberLogin(MemberDTO dto, HttpServletRequest req, RedirectAttributes redirectAttributes) {
		HttpSession session = req.getSession();
		
		// 입력아이디와 일치하는 회원정보를 DTO에 담아서 가져옴
		MemberDTO loginDTO = mapper.memberLogin(dto);
		
		System.out.println("loginDTO : " + loginDTO);
		System.out.println("dto : " + dto);
				
		// 암호화 전 -----------------------
//		if(loginDTO != null) {// 일치하는 아이디가 존재
//			String inputPw = dto.getPw(); // 입력 비번
//			String dbPw = loginDTO.getPw();
//			
//			if(inputPw.equals(dbPw)) { // 비번 일치
//				session.setAttribute("loginDTO", loginDTO);
//				return true;
//			}else{ // 비번 불일치
//				return false;
//			}
//		}
		
		// 암호화 후 -------------------
		if(loginDTO != null) {// 일치하는 아이디가 존재
			String inputPw = dto.getPw(); // 입력 비번
			String dbPw = loginDTO.getPw(); // 암호화된 비번
			
			if(pwEncoder.matches(inputPw,  dbPw) || inputPw.equals(dbPw)) { // 비번 일치
				session.setAttribute("loginDTO", loginDTO);
				session.setAttribute("mode", "user");
				return true;
			}else{ // 비번 불일치
				redirectAttributes.addFlashAttribute("loginErr", "pwdErr"); // 비번 불일치
				return false;
			}
		}
		redirectAttributes.addFlashAttribute("loginErr", "idErr");
		return false; // 아이디 불일치
	}

	@Override
	public String findId(MemberDTO dto) {
		String findId = mapper.findId(dto);
		return findId;
	}

	@Override
	
	public int findPw(String uid, String uEmail) {
		 // 임시 비밀번호 생성
	     String tempPw = UUID.randomUUID().toString().substring(0,8);
	      
	      // MimeMessage 객체 생성 : 데이터 전송
	      MimeMessage mail = mailSender.createMimeMessage();
	      
	      // 메일 내용
	      String mailContents = "<h3>임시 비밀번호 발급</h3><br/>"
	            + "<h2>"+tempPw+"</h2>"
	      		+ "<p>로그인 후 마이페이지에서 비밀번호를 변경하시면 됩니다.</p>"; 
	    
	          
	      try {         
	         // 메일 제목 
	         mail.setSubject("jh아카데미 [임시 비밀번호]", "utf-8");
	         // 메일 내용 셋팅
	         mail.setText(mailContents, "utf-8", "html");
	         
	         // 수신자 셋팅, 인터넷 주소체계로 변환
	         mail.addRecipient(RecipientType.TO, new InternetAddress(uEmail));
	         mailSender.send(mail);
	          
	         
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
		int n = mapper.findPw(uid, uEmail, tempPw);
		return n;
	}

	@Override
	public int modifyPw(MemberDTO dto) {
		int n = mapper.updatePw(dto);
		return n;
	}	
}
