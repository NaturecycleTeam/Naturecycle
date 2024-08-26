package com.mbc.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
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

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.mbc.domain.MemberDTO;
import com.mbc.domain.ProdPageDTO;
import com.mbc.domain.ProductDTO;
import com.mbc.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired // 의존성 추가
	private MemberMapper mapper;

	@Autowired
	private JavaMailSender mailSender;

	// 멤버 리스트
	@Override
	public List<MemberDTO> memberList(String id) {
		return mapper.memberList(id);
	}

	@Autowired
	private BCryptPasswordEncoder pwEncoder;

	// 멤버 등록
	@Override
	public void memberRegister(MemberDTO dto) {
		String plainPw = dto.getPw(); // 회원가입시 입력된 평문 비번
		String chiperPw = pwEncoder.encode(plainPw);
		dto.setPw(chiperPw); // 암호화된 비번을 dto에 셋팅
		mapper.memberInsert(dto);
	}

	// 멤버 상세정보
	@Override
	public MemberDTO memberInfo(String id) {
		return mapper.memberInfo(id);
	}
	
	@Override
	public MemberDTO myProfile(String id) {
		return mapper.myProfile(id);
	}

	// 멤버 삭제
	@Override
	public void memberRemove(String id) {
		mapper.deleteMember(id);
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
	
	@Override
	public MemberDTO memberIdCheck(String uid) {
		return mapper.memberIdCheck(uid);
	}

	@Override
	public MemberDTO memberTelCheck(String utel) {
		return mapper.memberTelCheck(utel);
	}

	@Override
	public MemberDTO memberEmailCheck(String uEmail) {
		return mapper.memberEmailCheck(uEmail);
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
		if (loginDTO != null) {// 일치하는 아이디가 존재
			String inputPw = dto.getPw(); // 입력 비번
			String dbPw = loginDTO.getPw(); // 암호화된 비번

			if (pwEncoder.matches(inputPw, dbPw) || inputPw.equals(dbPw)) { // 비번 일치
				session.setAttribute("loginDTO", loginDTO);
				session.setAttribute("mode", "user");
				return true;
			} else { // 비번 불일치
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
		String tempPw = UUID.randomUUID().toString().substring(0, 8);

		// MimeMessage 객체 생성 : 데이터 전송
		MimeMessage mail = mailSender.createMimeMessage();

		// 메일 내용
		String mailContents = "<h3>임시 비밀번호 발급</h3><br/>" + "<h2>" + tempPw + "</h2>"
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

	// 카카오 로그인 api
	@Override
	public String getAccessToken(String authorize_code) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";

		try {
			URL url = new URL(reqURL);

			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			// POST 요청을 위해 기본값이 false인 setDoOutput을 true로 변경을 해주세요

			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			// POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
			// BufferedWriter 간단하게 파일을 끊어서 보내기로 토큰값을 받아오기위해 전송

			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=97ec31a3e4c1ac77764914d0f6bbf209"); // 발급받은 key
			sb.append("&redirect_uri=http://localhost:8090/oauth"); // 본인이 설정해 놓은 redirect_uri 주소
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();

			// 결과 코드가 200이라면 성공
			// 여기서 안되는경우가 많이 있어서 필수 확인 !! **
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode + "확인");

			// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result + "결과");

			// Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

			System.out.println("access_token : " + access_Token);
			System.out.println("refresh_token : " + refresh_Token);

			br.close();
			bw.close();
		} catch (IOException e) {

			e.printStackTrace();
		}
		return access_Token;
	}

	@Override
	public String getuserinfo(String access_Token, HttpSession session, RedirectAttributes rttr) {

		HashMap<String, Object> userInfo = new HashMap<>();
		System.out.println("getuserinfo()");

		String requestURL = "https://kapi.kakao.com/v2/user/me";
		String view = null;
		String msg = null;

		try {
			URL url = new URL(requestURL); // 1.url 객체만들기
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			// 2.url 에서 url connection 만들기
			conn.setRequestMethod("GET"); // 3.URL 연결구성
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);

			// 키 값, 속성 적용
			int responseCode = conn.getResponseCode(); // 서버에서 보낸 http 상태코드 반환
			System.out.println("responseCode :" + responseCode + "여긴가");
			BufferedReader buffer = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			// 버퍼를 사용하여 읽은 것
			String line = "";
			String result = "";
			while ((line = buffer.readLine()) != null) {
				result += line;
			}
			// readLine()) ==> 입력 String 값으로 리턴값 고정

			System.out.println("response body :" + result);

			// 읽었으니깐 데이터꺼내오기
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result); // Json element 문자열변경
			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

			String mnickname = properties.getAsJsonObject().get("nickname").getAsString();
			String mmail = kakao_account.getAsJsonObject().get("email").getAsString();

			//userInfo에 사용자 정보 저장
	        userInfo.put("mid", mmail);
	        userInfo.put("mnickname", mnickname);
	        userInfo.put("mmail", mmail);

			System.out.println(String.valueOf(userInfo));

		} catch (Exception e) {
			e.printStackTrace();
		}

		MemberDTO member = mapper.findkakao(userInfo);
		// 저장되어있는지 확인
		System.out.println("S :" + member);

		if (member == null) {
			// member null 이면 정보가 저장 안되어있는거라서 정보를 저장.
			mapper.kakaoinsert(userInfo);
			// 저장한 member 정보 다시 가져오기 HashMap이라 형변환 시켜줌
			member = mapper.selectMember((String)userInfo.get("mid"));
			session.setAttribute("member", member);

			// 로그인 처리 후 메인 페이지로 이동
			view = "redirect:/";
			msg = "로그인 성공";
		} else {
			session.setAttribute("member", member);
			view = "redirect:/";
			msg = "로그인 성공";

		}
		rttr.addFlashAttribute("msg", msg);
		return view;

	}

}
