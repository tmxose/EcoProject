package com.eco.service;

import com.eco.domain.UserVO;

public interface UserService {
	public void signup(UserVO user);
	// ��ȸ�Լ��� ������		

	public UserVO login(UserVO user);
}
	