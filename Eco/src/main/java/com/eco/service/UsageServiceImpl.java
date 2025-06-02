package com.eco.service;

import java.util.List; 

import org.springframework.stereotype.Service;

import com.eco.domain.UserTypeChargeDTO;
import com.eco.mapper.UsageMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class UsageServiceImpl implements UsageService{
	private UsageMapper mapper;

	// 이번 달 나의 사용량 가져오기
	@Override
	public UserTypeChargeDTO readGasusage(String userId) {
		return mapper.getGasUsage(userId);
	}
	@Override
	public UserTypeChargeDTO readElecusage(String userId) {
		return mapper.getGasUsage(userId);
	}
	
	// 가스 상세 내역
	@Override
	public List<UserTypeChargeDTO> gasUsageDetail(String userId) {
		return mapper.getGasUsageDetail(userId);
	}
	// 전기 상세 내역
	@Override
	public List<UserTypeChargeDTO> elecUsageDetail(String userId) {
		return mapper.getElecUsageDetail(userId);
	}
}
