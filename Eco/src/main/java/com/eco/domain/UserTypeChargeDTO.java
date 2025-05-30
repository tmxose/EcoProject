package com.eco.domain;

import java.util.Date;

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
    
    //����, ���� �� ���� ǥ�� �뵵
    private float gas_usage;
    private Date gas_time;
    private float elec_usage;
    private Date elec_time;
}
