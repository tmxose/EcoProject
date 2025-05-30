package com.eco.mapper;

import java.util.List;

import com.eco.domain.UsageVO;
import com.eco.domain.UserTypeChargeDTO;

public interface UsageMapper {
	// 이번 달 나의 사용량 select
	public UsageVO usageSelect(String userId);
	
	// 가스 사용 상세 내역
	public List<UserTypeChargeDTO> getUserGasUsageDetail(String userId);
	// 전기 상세 내역
	public List<UserTypeChargeDTO> getUserElecUsageDetail(String userId);

}
