package com.eco.service;

import com.eco.domain.UsageVO;
import com.eco.domain.UserTypeChargeDTO;

public interface ChargeService {
	// �̹� �� ���� ��� select
	public UsageVO chargeRead(int usage_Cd);
	
	// �̹� �� ���� ���
	public UserTypeChargeDTO getGasCharge(String userId);
}
