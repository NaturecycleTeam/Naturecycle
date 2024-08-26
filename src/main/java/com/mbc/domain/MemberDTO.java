package com.mbc.domain;

import java.sql.Timestamp;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
@ToString
public class MemberDTO {
//	private int no;
	private String id;
	private String pw;
	private String name;
	private String email;
	private String tel;
	private String zipcode;
	private String road_addr;
	private String detail_addr;
	private Timestamp rdate;
	private int point;

	private String npw;

	private String cartPqty;

	// 기본 생성자
	public MemberDTO() {

	}

}
