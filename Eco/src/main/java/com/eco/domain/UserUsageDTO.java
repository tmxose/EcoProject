package com.eco.domain;

import lombok.Data;

@Data
public class UserUsageDTO {
	private int userCd;
    private String userNm;
    
    private float elecUsage;
    private int elecChargePerUnit;
    private float elecTotalCharge;

    private float gasUsage;
    private int gasChargePerUnit;
    private float gasTotalCharge;
}
