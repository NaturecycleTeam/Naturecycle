package com.mbc.domain;

import lombok.Data;

@Data
public class ReservationDTO {
	private int rno;
	private String rid;
	private String date;
	private String time;
	private String contents;
}
