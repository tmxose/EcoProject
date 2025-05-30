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

	// �̹� �� ���� ��� select
	@Override
	public UsageVO chargeRead(int usage_Cd) {
		return mapper.chargeSelect(usage_Cd);
	}

	//�̹� �� ���� ���
	@Override
	public UserTypeChargeDTO getGasCharge(String userId) {
		return mapper.getUserGasChargeSummary(userId);
	}
	// �̹� �� ���� ���
	@Override
	public UserTypeChargeDTO getElecCharge(String userId) {
		return mapper.getUserElecChargeSummary(userId);
	}
	
	// ���� ��� �� ����
	@Override
	public List<UserTypeChargeDTO> gasChargeDetail(String userId) {
		return mapper.getUserGasChargeDetail(userId);
	}
	// ���� ��� �� ����
	@Override
	public List<UserTypeChargeDTO> elecChargeDetail(String userId) {
		return mapper.getUserElecChargeDetail(userId);
	}

}
