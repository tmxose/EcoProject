package com.eco.mapper;

import org.apache.ibatis.annotations.Param;

import com.eco.domain.UserVO;

public interface UserMapper {
	public void userInsert(UserVO user);
	public UserVO getUserSelect(UserVO user);
	//	public int getUserCount(UserVO user);
	
	// 가입자 정보
	public UserVO findByUserId(@Param("user_id") String user_id, @Param("user_type") String user_type);  // 아이디로 사용자 조회
	
	// 회원 정보 수정
	public void userUpdate(UserVO user);
	public UserVO findByUserCD(@Param("user_cd") int user_cd);
	
	// 회원 탈퇴
	public void userDelete(@Param("user_cd") int user_cd);
}
