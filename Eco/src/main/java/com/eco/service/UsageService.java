package com.eco.service;

import com.eco.domain.UsageVO;

public interface UsageService {
	// 이번 달 나의 사용량 select
	public UsageVO usageRead(int usage_Cd);
}
