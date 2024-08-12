package com.mbc.controller;

import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.mbc.domain.AdminDTO;
import com.mbc.domain.DataDTO;
import com.mbc.service.AdminService;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService adService;
	
	// 로그인 페이지 이동
//	@GetMapping("adminLogin.do")
//	public String loginForm() {
//		return "admin/ad_login";
//	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	// 로그인 페이지 이동 (interceptor를 위한 moveUrl 설정)
	@GetMapping("adminLogin.do")
	public String loginForm(String moveUrl, Model model) {
		model.addAttribute("moveUrl", moveUrl);
		return "admin/ad_login";
	}
	
	// 관리자 로그인
	@PostMapping("adminLogin.do")
	public String adminLogin(String moveUrl, AdminDTO dto, HttpServletRequest req) {
				
		boolean result = adService.adminLogin(dto, req);
				
		if(!result) {
			return "redirect:adminLogin.do";
		}
		
//		if(!moveUrl.equals("")) {
//			return "redirect:"+moveUrl;
//		}
		return "admin/ad_main";
		//return "redirect:/";
	}
	
	// 관리자 로그아웃
	@GetMapping("adminLogout.do")
	public String adminLogout(HttpSession session) {
		session.invalidate();
		
		return "admin/ad_main";
	}
	
	// 관리자 홈페이지 이동
	@GetMapping("adminMain.do")
	public String adminMainForm() {
		return "admin/ad_main";
	}
	
	
	// 관리자 홈화면 그래프
	@RequestMapping("getData.do")
	@ResponseBody
	public String getData(Model model) {
		
		List<DataDTO> list =adService.getData();
		
		Gson gson = new GsonBuilder().create();	
		JsonArray jArray = new JsonArray();
		
		Iterator<DataDTO> it = list.iterator();
		while(it.hasNext()) {
			DataDTO dto = it.next();
			JsonObject object = new JsonObject();
			int tqty = dto.getTqty();
			String tname = dto.getTname();
			
			object.addProperty("tqty", tqty);
			object.addProperty("tname", tname);
			jArray.add(object);			
		}
		
		String json = gson.toJson(jArray);
		System.out.println("json 데이터값" + json);		
		
		return json;
	}
	
	
}
