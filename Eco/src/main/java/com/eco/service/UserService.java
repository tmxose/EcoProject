package com.eco.service;

import com.eco.domain.UserVO;

public interface UserService {
	public void signup(UserVO user);
	// ��ȸ�Լ��� ������		

	public UserVO login(UserVO user);
	
	// �Ҽ� �α��� 
	public UserVO findByUserId(String user_id, String user_type);
	 
}
	