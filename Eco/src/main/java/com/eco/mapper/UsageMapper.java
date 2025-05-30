package com.eco.mapper;

import com.eco.domain.UsageVO;

public interface UsageMapper {
	// 이번 달 나의 사용량 select
	public UsageVO usageSelect(int usage_cd);
}
