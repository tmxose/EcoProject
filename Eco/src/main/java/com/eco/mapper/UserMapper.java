package com.eco.mapper;

import com.eco.domain.UserVO;

public interface UserMapper {
	public void userInsert(UserVO user);
	public UserVO getUserSelect(UserVO user);
}
