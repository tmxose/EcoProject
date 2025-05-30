package com.eco.service;

import java.util.List;

import com.eco.domain.UsageVO;
import com.eco.domain.UserTypeChargeDTO;

public interface UsageService {
	// 이번 달 나의 사용량 select
	public UsageVO usageRead(String userId);
	
	// 가스 사용 상세 내역
	public List<UserTypeChargeDTO> gasUsageDetail(String userId);
	// 전기 사용 상세 내역
	public List<UserTypeChargeDTO> elecUsageDetail(String userId);
}
