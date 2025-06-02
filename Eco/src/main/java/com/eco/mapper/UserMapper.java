package com.eco.mapper;

import com.eco.domain.UserVO;

public interface UserMapper {
	public void userInsert(UserVO user);
	public UserVO getUserSelect(UserVO user);
	public int getUserCount(UserVO user);
	
	// 가입자 정보
	public UserVO findByUserId(String user_id);  // 아이디로 사용자 조회
}
