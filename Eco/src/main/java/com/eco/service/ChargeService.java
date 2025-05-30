package com.eco.service;

import java.util.List;

import com.eco.domain.UsageVO;
import com.eco.domain.UserTypeChargeDTO;

public interface ChargeService {
	// 이번 달 나의 요금 select
	public UsageVO chargeRead(int usage_Cd);
	
	// 이번 달 가스 요금
	public UserTypeChargeDTO getGasCharge(String userId);
	// 이번 달 전기 요금
	public UserTypeChargeDTO getElecCharge(String userId);
	
	// 가스 요금 상세 내역
	public List<UserTypeChargeDTO> gasChargeDetail(String userId);
	// 전기 요금 상세 내역
	public List<UserTypeChargeDTO> elecChargeDetail(String userId);
}
