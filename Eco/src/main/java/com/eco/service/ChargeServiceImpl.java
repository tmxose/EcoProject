package com.eco.service;

import java.time.LocalDate;
import java.util.List; 

import org.springframework.stereotype.Service;

import com.eco.domain.UserTypeChargeDTO;
import com.eco.mapper.ChargeMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class ChargeServiceImpl implements ChargeService{
	private ChargeMapper mapper;
	
	// 이번 달 에너지 요금 합계
	@Override
	public UserTypeChargeDTO readGasCharge(String userId) {
		return mapper.getGasCharge(userId);
	}
	@Override
	public UserTypeChargeDTO readElecCharge(String userId) {
		return mapper.getElecCharge(userId);
	}
	
	// 당월 에너지 사용 상세 내역
	@Override
	public List<UserTypeChargeDTO> gasChargeDetail(String userId) {
		return mapper.getGasChargeDetail(userId);
	}
	@Override
	public List<UserTypeChargeDTO> elecChargeDetail(String userId) {
		return mapper.getElecChargeDetail(userId);
	}
	
	// 지정 기간 에너지 사용 상세 내역
	@Override
	public List<UserTypeChargeDTO> gasChargePeriod(String userId, LocalDate startDate, LocalDate endDate) {
		return mapper.getGasChargePeriod(userId, startDate, endDate);
	}
	@Override
	public List<UserTypeChargeDTO> elecChargePeriod(String userId, LocalDate startDate, LocalDate endDate) {
		return mapper.getElecChargePeriod(userId, startDate, endDate);
	}

}
