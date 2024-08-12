package com.mbc.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

public class ProductDTO {
	
	private int pnum;
	private String pname;
	private String pcategory_fk;
	private String pcompany;
	private String pwriter;
	private String pimage;
	private int pqty;
	private int price;
	private String pspec;
	private String pcontent;
	private int point;
	private Date pinput_date;
	
	private String keyword;
	private String searchType;
	
	
	public String getSearchType() {
		return searchType;
	}



	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}



	public String getKeyword() {
		return keyword;
	}



	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}



	public String getPwriter() {
		return pwriter;
	}



	public void setPwriter(String pwriter) {
		this.pwriter = pwriter;
	}



	public int getPnum() {
		return pnum;
	}



	public void setPnum(int pnum) {
		this.pnum = pnum;
	}



	public String getPname() {
		return pname;
	}



	public void setPname(String pname) {
		this.pname = pname;
	}



	public String getPcategory_fk() {
		return pcategory_fk;
	}



	public void setPcategory_fk(String pcategory_fk) {
		this.pcategory_fk = pcategory_fk;
	}



	public String getPcompany() {
		return pcompany;
	}



	public void setPcompany(String pcompany) {
		this.pcompany = pcompany;
	}



	public String getPimage() {
		return pimage;
	}



	public void setPimage(String pimage) {
		this.pimage = pimage;
	}



	public int getPqty() {
		return pqty;
	}



	public void setPqty(int pqty) {
		this.pqty = pqty;
	}



	public int getPrice() {
		return price;
	}



	public void setPrice(int price) {
		this.price = price;
	}



	public String getPspec() {
		return pspec;
	}



	public void setPspec(String pspec) {
		this.pspec = pspec;
	}



	public String getPcontent() {
		return pcontent;
	}



	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}



	public int getPoint() {
		return point;
	}



	public void setPoint(int point) {
		this.point = point;
	}



	public Date getPinput_date() {
		return pinput_date;
	}

	

	public void setPinput_date(Date pinput_date) {
		this.pinput_date = pinput_date;
	}
	
	public ProductDTO() {}

	public ProductDTO(int pnum, String pname, String pcategory_fk, String pcompany, String pimage, String pwriter, int pqty, int price,
			String pspec, String pcontent, int point, Date pinput_date, String keyword, String searchType) {
		super();
		this.pnum = pnum;
		this.pname = pname;
		this.pcategory_fk = pcategory_fk;
		this.pcompany = pcompany;
		this.pwriter = pwriter;
		this.pimage = pimage;
		this.pqty = pqty;
		this.price = price;
		this.pspec = pspec;
		this.pcontent = pcontent;
		this.point = point;
		this.pinput_date = pinput_date;
		this.keyword = keyword;
		this.searchType = searchType;
	}
	
}
