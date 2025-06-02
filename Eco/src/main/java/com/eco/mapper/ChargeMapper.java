package com.eco.mapper;

import java.time.LocalDate;
import java.util.List; 

import com.eco.domain.UserTypeChargeDTO;

public interface ChargeMapper {
	// 이번 달 에너지 요금 합계
	public UserTypeChargeDTO getGasCharge(String userId);
	public UserTypeChargeDTO getElecCharge(String userId);
	
	// 당월 에너지 사용 상세 내역
	public List<UserTypeChargeDTO> getGasChargeDetail(String userId);
	public List<UserTypeChargeDTO> getElecChargeDetail(String userId);
	
	// 지정 기간 에너지 사용 상세 내역
	public List<UserTypeChargeDTO> getGasChargePeriod(String userId, LocalDate startDate, LocalDate endDate);
	public List<UserTypeChargeDTO> getElecChargePeriod(String userId, LocalDate startDate, LocalDate endDate);

}
