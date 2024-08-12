package com.mbc.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter 
@Setter
@ToString
public class CategoryDTO {
	
	private Integer cat_num;
	private String code;
	private String cat_name;
	
	public CategoryDTO(Integer cat_num, String code, String cat_name) {
		super();
		this.cat_num = cat_num;
		this.code = code;
		this.cat_name = cat_name;
	}

	public Integer getCat_num() {
		return cat_num;
	}

	public void setCat_num(Integer cat_num) {
		this.cat_num = cat_num;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getCat_name() {
		return cat_name;
	}

	public void setCat_name(String cat_name) {
		this.cat_name = cat_name;
	}
	
	
	
}
