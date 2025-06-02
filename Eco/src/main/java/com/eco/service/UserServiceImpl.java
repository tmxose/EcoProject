package com.eco.service;

import org.springframework.stereotype.Service;

import com.eco.domain.UserVO;
import com.eco.mapper.UserMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class UserServiceImpl implements UserService {

	private UserMapper mapper;

	@Override
	public void signup(UserVO user) {
		log.info("INSERT USER");
		mapper.userInsert(user);
	}

	@Override
	public UserVO login(UserVO user) {
		return mapper.getUserSelect(user);
	}

	// �α��� �Լ��� ������

	// mapper �Լ��� ����ؿ�

	// �Ҽ� �α��� �Լ�
	@Override
	public UserVO findByUserId(String user_id) {
		return mapper.findByUserId(user_id);
	}
}
