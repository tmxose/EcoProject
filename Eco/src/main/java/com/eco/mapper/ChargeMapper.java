package com.eco.mapper;

import com.eco.domain.UsageVO;
import com.eco.domain.UserTypeChargeDTO;

public interface ChargeMapper {
	// �̹� �� ���� ��� select
	public UsageVO chargeSelect(int usage_cd);
	
	// �̹� �� ���� ���
	public UserTypeChargeDTO getUserGasChargeSummary(String userId);
}
