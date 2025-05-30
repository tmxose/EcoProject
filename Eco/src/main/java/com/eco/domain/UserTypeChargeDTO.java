package com.eco.domain;

import lombok.Data;

@Data
public class UserTypeChargeDTO {    
    private int userCd;
    private String userNm;

    private String energyType; // "전기" or "가스"
    private String usageType;  // "주택용", "산업용"
    private float usageAmount;
    private int unitCharge;
    private float totalCharge;
}
