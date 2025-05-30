package com.eco.mapper;

import com.eco.domain.UsageVO;

public interface ChargeMapper {
	// 이번 달 나의 요금 select
	public UsageVO chargeSelect(int usage_cd);
}
