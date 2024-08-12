package com.mbc.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;

import com.mbc.domain.AdminDTO;
import com.mbc.domain.DataDTO;
import com.mbc.mapper.AdminMapper;

public interface AdminService {
	
	// 관리자 로그인
	boolean adminLogin(AdminDTO dto, HttpServletRequest req);

	List<DataDTO> getData();

}
