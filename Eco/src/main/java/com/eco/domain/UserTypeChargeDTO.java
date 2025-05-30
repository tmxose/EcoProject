package com.eco.domain;

import java.util.Date;

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
    
    //가스, 전기 상세 내역 표시 용도
    private float gas_usage;
    private Date gas_time;
    private float elec_usage;
    private Date elec_time;
}
