package com.eco.service;

import com.eco.domain.UsageVO;

public interface ChargeService {
	// 이번 달 나의 요금 select
		public UsageVO chargeRead(int usage_Cd);
}
