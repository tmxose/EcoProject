package com.eco.mapper;

import java.util.List; 

import com.eco.domain.UserTypeChargeDTO;

public interface UsageMapper {
	// 이번 달 에너지 사용량 합계
	public UserTypeChargeDTO getGasUsage(String userId);
	public UserTypeChargeDTO getElecUsage(String userId);
	
	// 가스 상세 내역
	public List<UserTypeChargeDTO> getGasUsageDetail(String userId);
	// 전기 상세 내역
	public List<UserTypeChargeDTO> getElecUsageDetail(String userId);

}
