package com.eco.mapper;

import java.util.List;

import com.eco.domain.UsageVO;
import com.eco.domain.UserTypeChargeDTO;

public interface ChargeMapper {
	// �̹� �� ���� ��� select
	public UsageVO chargeSelect(int usage_cd);
	
	// �̹� �� ���� ���
	public UserTypeChargeDTO getUserGasChargeSummary(String userId);
	// �̹� �� ���� ���
	public UserTypeChargeDTO getUserElecChargeSummary(String userId);
	
	// ���� ��� �� ����
	public List<UserTypeChargeDTO> getUserGasChargeDetail(String userId);
	// ���� ��� �� ����
	public List<UserTypeChargeDTO> getUserElecChargeDetail(String userId);

}
