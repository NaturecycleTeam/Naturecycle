package com.mbc.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mbc.domain.PageDTO;
import com.mbc.domain.ReservationDTO;

@Service
public interface ReservationService {

	/////////////////// 관리자 //////////////////////	
//	List<ReservationDTO> reservationList(PageDTO pDto);
	List<ReservationDTO> reservationList();
	
	void reservationConfirmed(int rno);
	
	void reservationCancel(int rno);
	
	List<ReservationDTO> calendarList();
	
	
	
	/////////////////// 유저 //////////////////////	
	
	void reservation(ReservationDTO dto);
	
	List<ReservationDTO> reservationInfo(String rid_fk);

	List<String> getReservedTimes(String date);

	
	
	


	

	

	













	

}
