package com.eco.service;

import com.eco.domain.UsageVO;
import com.eco.domain.UserTypeChargeDTO;

public interface ChargeService {
	// 이번 달 나의 요금 select
	public UsageVO chargeRead(int usage_Cd);
	
	// 이번 달 가스 요금
	public UserTypeChargeDTO getGasCharge(String userId);
}
