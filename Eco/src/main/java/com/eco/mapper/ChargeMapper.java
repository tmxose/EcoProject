package com.eco.mapper;

import com.eco.domain.UsageVO;

public interface ChargeMapper {
	// �̹� �� ���� ��� select
	public UsageVO chargeSelect(int usage_cd);
}
