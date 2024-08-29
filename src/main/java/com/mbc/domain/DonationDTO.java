package com.mbc.domain;

import java.time.LocalDate;
import java.util.Date;

import lombok.Data;

@Data
public class DonationDTO {

	private int donation_num;
	private String did_fk;
	private int donation_amount;
	private Date donation_Date;
	
	// 관리자홈 기부금 차트
	private String donation_month;
	private String monthlyAmount;
	
}
