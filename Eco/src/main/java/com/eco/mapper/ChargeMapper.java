package com.eco.mapper;

import java.util.List; 

import com.eco.domain.UserTypeChargeDTO;

public interface ChargeMapper {
	// 이번 달 가스요금
	public UserTypeChargeDTO getGasCharge(String userId);
	// 이번 달 전기요금
	public UserTypeChargeDTO getElecCharge(String userId);
	
	// 가스 상세 내역
	public List<UserTypeChargeDTO> getGasChargeDetail(String userId);
	// 전기 상세 내역
	public List<UserTypeChargeDTO> getElecChargeDetail(String userId);

}
