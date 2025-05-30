package com.eco.domain;

import lombok.Data;

@Data
public class UserTypeChargeDTO {    
    private int userCd;
    private String userNm;

    private String energyType; // "����" or "����"
    private String usageType;  // "���ÿ�", "�����"
    private float usageAmount;
    private int unitCharge;
    private float totalCharge;
}
