package com.mbc.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.mbc.domain.AdminDTO;
import com.mbc.domain.DataDTO;
import com.mbc.mapper.AdminMapper;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminMapper adMapper;
	
	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	
	@Override
	public boolean adminLogin(AdminDTO dto, HttpServletRequest req) {
		HttpSession session = req.getSession();
		
		AdminDTO adLoginDTO = adMapper.adminLogin(dto);
		
		System.out.println(adLoginDTO);
		System.out.println(dto);
				
		if(adLoginDTO != null) {
			String inputPw = dto.getPassword();
			String dbPw = adLoginDTO.getPassword();
						
			if(inputPw.equals(dbPw)) { // 비번 일치
				session.setAttribute("adLoginDTO", adLoginDTO);
				session.setAttribute("mode", "admin");
				return true;
			}else{ // 비번 불일치
				return false;
			}			
		}
		return false;
	}

	@Override
	public List<DataDTO> getData() {
		
		return adMapper.getData();
	}

}
