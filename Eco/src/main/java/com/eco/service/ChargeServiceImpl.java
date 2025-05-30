package com.eco.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.eco.domain.UsageVO;
import com.eco.domain.UserTypeChargeDTO;
import com.eco.mapper.ChargeMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class ChargeServiceImpl implements ChargeService{
	private ChargeMapper mapper;

	// 이번 달 나의 요금 가져오기
	@Override
	public UsageVO chargeRead(int usage_Cd) {
		return mapper.chargeSelect(usage_Cd);
	}

	// 이번 달 가스요금
	@Override
	public UserTypeChargeDTO getGasCharge(String userId) {
		return mapper.getUserGasChargeSummary(userId);
	}
	// 이번 달 전기요금
	@Override
	public UserTypeChargeDTO getElecCharge(String userId) {
		return mapper.getUserElecChargeSummary(userId);
	}
	
	// 가스 상세 내역
	@Override
	public List<UserTypeChargeDTO> gasChargeDetail(String userId) {
		return mapper.getUserGasChargeDetail(userId);
	}
	// 전기 상세 내역
	@Override
	public List<UserTypeChargeDTO> elecChargeDetail(String userId) {
		return mapper.getUserElecChargeDetail(userId);
	}

}
