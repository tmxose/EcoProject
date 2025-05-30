package com.eco.mapper;

import java.util.List;

import com.eco.domain.UsageVO;
import com.eco.domain.UserTypeChargeDTO;

public interface UsageMapper {
	// �̹� �� ���� ��뷮 select
	public UsageVO usageSelect(String userId);
	
	// ���� ��� �� ����
	public List<UserTypeChargeDTO> getUserGasUsageDetail(String userId);
	// ���� �� ����
	public List<UserTypeChargeDTO> getUserElecUsageDetail(String userId);

}
