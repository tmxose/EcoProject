package com.eco.mapper;

import com.eco.domain.UsageVO;
import com.eco.domain.UserTypeChargeDTO;

public interface ChargeMapper {
	// 이번 달 나의 요금 select
	public UsageVO chargeSelect(int usage_cd);
	
	// 이번 달 가스 요금
	public UserTypeChargeDTO getUserGasChargeSummary(String userId);
}
