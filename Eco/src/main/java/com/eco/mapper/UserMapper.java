package com.eco.mapper;

import org.springframework.stereotype.Service;

import com.eco.domain.UserVO;

public interface UserMapper {
	public void userInsert(UserVO user);
}
