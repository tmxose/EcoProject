package com.eco.mapper;

import java.util.List;

import com.eco.domain.UsageVO;
import com.eco.domain.UserTypeChargeDTO;

public interface ChargeMapper {
	// 이번 달 나의 요금 가져오기
	public UsageVO chargeSelect(int usage_cd);
	
	// 이번 달 가스요금
	public UserTypeChargeDTO getUserGasChargeSummary(String userId);
	// 이번 달 전기요금
	public UserTypeChargeDTO getUserElecChargeSummary(String userId);
	
	// 가스 상세 내역
	public List<UserTypeChargeDTO> getUserGasChargeDetail(String userId);
	// 전기 상세 내역
	public List<UserTypeChargeDTO> getUserElecChargeDetail(String userId);

}
