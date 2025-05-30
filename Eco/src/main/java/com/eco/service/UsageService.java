package com.eco.service;

import java.util.List;

import com.eco.domain.UsageVO;
import com.eco.domain.UserTypeChargeDTO;

public interface UsageService {
	// 이번 달 나의 사용량 가져오기
	public UsageVO usageRead(String userId);
	
	// 가스 상세 내역
	public List<UserTypeChargeDTO> gasUsageDetail(String userId);
	// 전기 상세 내역
	public List<UserTypeChargeDTO> elecUsageDetail(String userId);
}
