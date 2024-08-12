package com.mbc.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class MemberDTO {
//	private int no;
	private String id;
	private String pw;
	private String name;
	private int age;
	private String email;
	private String zipcode;
	private String road_addr;
	private String detail_addr;
	private String tel;

	private String npw;
	
	private String cartPqty;

	// 기본 생성자
	public MemberDTO() {
	}

	// 인자 생성자
	public MemberDTO(String id, String pw, String name, int age, String email, String tel) {
		super();		
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.age = age;
		this.email = email;
		this.tel = tel;
	}
	
	@Override
	public String toString() {
		return "MemberDTO [id=" + id + ", pw=" + pw + ", name=" + name + ", age=" + age + ", email="
				+ email + ", tel=" + tel + ", npw=" + npw + ", cartPqty=" + cartPqty + "]";
	}

//	public int getNo() {
//		return no;
//	}
//
//	public void setNo(int no) {
//		this.no = no;
//	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getRoad_addr() {
		return road_addr;
	}

	public void setRoad_addr(String road_addr) {
		this.road_addr = road_addr;
	}

	public String getDetail_addr() {
		return detail_addr;
	}

	public void setDetail_addr(String detail_addr) {
		this.detail_addr = detail_addr;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getNpw() {
		return npw;
	}

	public void setNpw(String npw) {
		this.npw = npw;
	}

	public String getCartPqty() {
		return cartPqty;
	}

	public void setCartPqty(String cartPqty) {
		this.cartPqty = cartPqty;
	}	

}
