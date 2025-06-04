package com.eco.service;

import com.eco.domain.UserVO;

public interface UserService {
	public void signup(UserVO user);
	
	// 로그인 기능 구현
	public UserVO login(UserVO user);
	
	// 사용자 아이디 존재여부 확인
	public UserVO findByUserId(String user_id, String user_type);
	 
}
	