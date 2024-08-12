package com.mbc.mapper;

import java.util.List;

import com.mbc.domain.AdminDTO;
import com.mbc.domain.DataDTO;

public interface AdminMapper {

	AdminDTO adminLogin(AdminDTO dto);

	List<DataDTO> getData();

	

}
