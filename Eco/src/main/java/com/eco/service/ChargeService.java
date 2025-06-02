package com.eco.service;

import java.util.List; 

import com.eco.domain.UserTypeChargeDTO;

public interface ChargeService {
	// 이번 달 가스요금
	public UserTypeChargeDTO readGasCharge(String userId);
	// 이번 달 전기요금
	public UserTypeChargeDTO readElecCharge(String userId);
	
	// 가스 상세 내역
	public List<UserTypeChargeDTO> gasChargeDetail(String userId);
	// 전기 상세 내역
	public List<UserTypeChargeDTO> elecChargeDetail(String userId);
}
