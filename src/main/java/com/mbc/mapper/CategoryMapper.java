package com.mbc.mapper;

import java.util.List;

import com.mbc.domain.AdminDTO;
import com.mbc.domain.CategoryDTO;

public interface CategoryMapper {

	AdminDTO adminLogin(AdminDTO dto);

	void categoryInsert(CategoryDTO dto);

	List<CategoryDTO> categoryList();

	void categoryDelete(Integer cat_num);

	

}
