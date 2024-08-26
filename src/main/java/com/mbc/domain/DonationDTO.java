package com.mbc.domain;

import java.util.Date;

import lombok.Data;

@Data
public class DonationDTO {

	private int donation_num;
	private String did_fk;
	private int donation_amount;
	private Date donation_Date;
	
}
