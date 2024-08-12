package com.mbc.util;

public enum ProdSpec {

	NONE("일반"), STUDY("수능특강"), HIT("베스트셀러"), NEW("기대신간"), RECOMMEND("오늘의 책");
	
	private final String value;
	
	private ProdSpec(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return value;
	}
}
