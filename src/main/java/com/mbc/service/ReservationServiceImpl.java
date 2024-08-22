package com.mbc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mbc.domain.ReservationDTO;
import com.mbc.mapper.ReservationMapper;

@Service
public class ReservationServiceImpl implements ReservationService {

	@Autowired // 의존성 추가
	private ReservationMapper mapper;

//	@Override
//	public ReservationDTO reservationInfo(String rid) {
//		
//		return mapper.reservationInfo(rid);
//	}

	@Override
	public void reservation(ReservationDTO dto) {
		mapper.reservation(dto);

	}

	@Override
	public List<ReservationDTO> reservationInfo(String rid) {

		return mapper.reservationInfo(rid);
	}

	@Override
	public List<ReservationDTO> timeCheck(String date) {
		
		return mapper.timeCheck(date);
	}

//	@Override
//	public List<ReservationDTO> timeCheck(String date, String time) {
//		
//		return mapper.timeCheck(date, time);
//	}

	

//	@Override
//	public List<ReservationDTO> reservationcheck(String date) {
//		
//		return mapper.reservationcheck(date);
//	}
}
