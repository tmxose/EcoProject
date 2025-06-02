package com.eco.mapper;

import java.time.LocalDate;
import java.util.List; 

import com.eco.domain.UserTypeChargeDTO;

public interface UsageMapper {
	// 이번 달 에너지 사용량 합계
	public UserTypeChargeDTO getGasUsage(String userId);
	public UserTypeChargeDTO getElecUsage(String userId);
	
	// 당월 에너지 사용 상세 내역
	public List<UserTypeChargeDTO> getGasUsageDetail(String userId);
	public List<UserTypeChargeDTO> getElecUsageDetail(String userId);
	
	// 지정 기간 에너지 사용 상세 내역
	public List<UserTypeChargeDTO> getGasUsagePeriod(String userId, LocalDate startDate, LocalDate endDate);
	public List<UserTypeChargeDTO> getElecUsagePeriod(String userId, LocalDate startDate, LocalDate endDate);

}
