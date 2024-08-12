package com.mbc.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;

import com.mbc.domain.AdminDTO;
import com.mbc.domain.CategoryDTO;
import com.mbc.domain.ProductDTO;
import com.mbc.mapper.AdminMapper;

public interface CategoryService {
	
	// 카테고리 등록 OK
	void categoryRegister(CategoryDTO dto);
	
	// 카테고리 리스트
	List<CategoryDTO> categoryList();
	
	// 카테고리 삭제
	void categoryDelete(Integer cat_num);
	
	
	
}
