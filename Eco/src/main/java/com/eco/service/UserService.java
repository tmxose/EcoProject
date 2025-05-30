package com.eco.service;

import com.eco.domain.UserVO;

public interface UserService {
	public void signup(UserVO user);
	// 조회함수를 만들어요		

	public UserVO login(UserVO user);
	
	// 소셜 로그인 
	public UserVO findByUserId(String user_id);
	 
}
	