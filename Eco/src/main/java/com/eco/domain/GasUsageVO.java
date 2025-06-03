package com.eco.domain;

import java.util.Date;

import lombok.Data;

@Data
public class GasUsageVO {
	private int usage_cd;
	private int user_cd;
	private int gas_cd;
	private float gas_usage;
	private Date gas_time;
	private char use_yn;
}
