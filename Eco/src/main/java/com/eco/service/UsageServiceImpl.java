package com.eco.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.eco.domain.UsageVO;
import com.eco.domain.UserTypeChargeDTO;
import com.eco.mapper.UsageMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class UsageServiceImpl implements UsageService{
	private UsageMapper mapper;

	// 이번 달 나의 사용량 select
	@Override
	public UsageVO usageRead(String userId) {
		return mapper.usageSelect(userId);
	}
	
	// 가스 사용 상세 내역
	@Override
	public List<UserTypeChargeDTO> gasUsageDetail(String userId) {
		return mapper.getUserGasUsageDetail(userId);
	}
	// 전기 사용 상세 내역
	@Override
	public List<UserTypeChargeDTO> elecUsageDetail(String userId) {
		return mapper.getUserElecUsageDetail(userId);
	}
}
