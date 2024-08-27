package com.mbc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mbc.domain.PageDTO;
import com.mbc.domain.ReservationDTO;

@Mapper
public interface ReservationMapper {

	/////////////////// 관리자 //////////////////////
//	List<ReservationDTO> reservationList(PageDTO pDto);
	List<ReservationDTO> reservationList();
	
	int totalCnt(PageDTO pDto);
	
	void reservationConfirmed(int rno);
	
	void reservationCancel(int rno);
	
	List<ReservationDTO> calendarList();
	
	
	
	
	/////////////////// 유저 //////////////////////

	List<ReservationDTO> reservationInfo(String rid);
	
	void reservation(ReservationDTO dto);

	List<String> getReservedTimes(String date);

	
	


	





	




	
}
