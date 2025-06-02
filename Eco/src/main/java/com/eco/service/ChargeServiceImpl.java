package com.eco.service;

import java.util.List; 

import org.springframework.stereotype.Service;

import com.eco.domain.UserTypeChargeDTO;
import com.eco.mapper.ChargeMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class ChargeServiceImpl implements ChargeService{
	private ChargeMapper mapper;
	// 이번 달 가스요금
	@Override
	public UserTypeChargeDTO readGasCharge(String userId) {
		return mapper.getGasCharge(userId);
	}
	// 이번 달 전기요금
	@Override
	public UserTypeChargeDTO readElecCharge(String userId) {
		return mapper.getElecCharge(userId);
	}
	
	// 가스 상세 내역
	@Override
	public List<UserTypeChargeDTO> gasChargeDetail(String userId) {
		return mapper.getGasChargeDetail(userId);
	}
	// 전기 상세 내역
	@Override
	public List<UserTypeChargeDTO> elecChargeDetail(String userId) {
		return mapper.getElecChargeDetail(userId);
	}

}
