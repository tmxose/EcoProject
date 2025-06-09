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
	public UserVO findByUserId(String user_id, String user_type) {
		return mapper.findByUserId(user_id, user_type);
	}

	// 회원 정보 수정
	@Override
	public void userModify(UserVO user) {
		mapper.userUpdate(user);
	}
	@Override
	public UserVO findByUserCD(int user_cd) {
		return mapper.findByUserCD(user_cd);
	}

	// 회원 탈퇴
	@Override
	public void userDelete(int user_cd) {
		mapper.userDelete(user_cd);
	}

	// 간편 요금 조회에서 사용자 검색
	@Override
	public UserVO findByUserCdUserNm(int user_cd, String user_nm) {
		return mapper.findByUserCdUserNm(user_cd, user_nm);
	}
}
