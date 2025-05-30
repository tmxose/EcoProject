package com.eco.service;

import org.springframework.stereotype.Service;

import com.eco.domain.UsageVO;
import com.eco.mapper.UsageMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class UsageServiceImpl implements UsageService{
	private UsageMapper mapper;

	// 이번 달 나의 사용량 select
	@Override
	public UsageVO usageRead(int usage_cd) {
		return mapper.usageSelect(usage_cd);
	}
}
