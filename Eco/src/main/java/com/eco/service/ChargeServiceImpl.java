package com.eco.service;

import org.springframework.stereotype.Service;

import com.eco.domain.UsageVO;
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

}
