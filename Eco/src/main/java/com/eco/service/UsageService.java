package com.eco.service;

import java.util.List; 

import com.eco.domain.UserTypeChargeDTO;

public interface UsageService {
	// 이번 달 에너지 사용량 합계
	public UserTypeChargeDTO readGasusage(String userId);
	public UserTypeChargeDTO readElecusage(String userId);
	
	// 가스 상세 내역
	public List<UserTypeChargeDTO> gasUsageDetail(String userId);
	// 전기 상세 내역
	public List<UserTypeChargeDTO> elecUsageDetail(String userId);
}
