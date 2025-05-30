package com.eco.service;

import org.springframework.stereotype.Service;

import com.eco.domain.UsageVO;
import com.eco.mapper.UsageMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class UsageServiceImpl implements UsageService{
	private UsageMapper mapper;

	// �̹� �� ���� ��뷮 select
	@Override
	public UsageVO usageRead(int usage_cd) {
		return mapper.usageSelect(usage_cd);
	}
}
