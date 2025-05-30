package com.eco.domain;

import lombok.Data;

@Data
public class UserVO {
	private int user_cd;	
	private String user_id;
	private String user_pw;
	private String user_nm;
	private char use_yn;
	
	   // + email 이 필요할 수도 있음 (user_id 로 대체 가능하면 생략)
}
