package com.eco.service;

import java.util.List;

import com.eco.domain.UsageVO;
import com.eco.domain.UserTypeChargeDTO;

public interface UsageService {
	// �̹� �� ���� ��뷮 select
	public UsageVO usageRead(String userId);
	
	// ���� ��� �� ����
	public List<UserTypeChargeDTO> gasUsageDetail(String userId);
	// ���� ��� �� ����
	public List<UserTypeChargeDTO> elecUsageDetail(String userId);
}
