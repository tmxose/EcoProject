package com.eco.service;

import java.time.LocalDate;
import java.util.List; 

import com.eco.domain.UserTypeChargeDTO;

public interface UsageService {
	// 이번 달 에너지 사용량 합계
	public UserTypeChargeDTO readGasusage(String userId);
	public UserTypeChargeDTO readElecusage(String userId);
	
	// 당월 에너지 사용 상세 내역
	public List<UserTypeChargeDTO> gasUsageDetail(String userId);
	public List<UserTypeChargeDTO> elecUsageDetail(String userId);
	
	// 지정 기간 에너지 사용 상세 내역
	public List<UserTypeChargeDTO> gasUsagePeriod(String userId, LocalDate startDate, LocalDate endDate);
	public List<UserTypeChargeDTO> elecUsagePeriod(String userId, LocalDate startDate, LocalDate endDate);

}
