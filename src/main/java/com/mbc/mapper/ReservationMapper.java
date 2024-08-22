package com.mbc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mbc.domain.ReservationDTO;

@Mapper
public interface ReservationMapper {

//	ReservationDTO reservationInfo(String rid);
	List<ReservationDTO> reservationInfo(String rid);
	
	void reservation(ReservationDTO dto);

//	List<ReservationDTO> timeCheck(String date, String time);

	List<ReservationDTO> timeCheck(String date);

//	List<ReservationDTO> reservationcheck(String date);
	
}
