package com.eco.service;

import java.util.List;

import com.eco.domain.UsageVO;
import com.eco.domain.UserTypeChargeDTO;

public interface ChargeService {
	// �̹� �� ���� ��� select
	public UsageVO chargeRead(int usage_Cd);
	
	// �̹� �� ���� ���
	public UserTypeChargeDTO getGasCharge(String userId);
	// �̹� �� ���� ���
	public UserTypeChargeDTO getElecCharge(String userId);
	
	// ���� ��� �� ����
	public List<UserTypeChargeDTO> gasChargeDetail(String userId);
	// ���� ��� �� ����
	public List<UserTypeChargeDTO> elecChargeDetail(String userId);
}
