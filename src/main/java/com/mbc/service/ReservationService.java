package com.mbc.service;

import java.util.List;

import org.springframework.stereotype.Service;
import com.mbc.domain.ReservationDTO;

@Service
public interface ReservationService {

	List<ReservationDTO> reservationInfo(String rid);

	void reservation(ReservationDTO dto);

//	List<ReservationDTO> timeCheck(String date, String time);

	List<ReservationDTO> timeCheck(String date);

//	List<ReservationDTO> reservationcheck(String date);

}
