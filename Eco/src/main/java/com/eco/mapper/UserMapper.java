package com.eco.mapper;

import com.eco.domain.UserVO;

public interface UserMapper {
	public void userInsert(UserVO user);
	public UserVO getUserSelect(UserVO user);
	
	// 소셜로그인
	public UserVO findByUserId(String user_id);  // 이메일 기반으로 조회
}
