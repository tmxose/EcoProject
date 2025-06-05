package com.eco.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.eco.domain.UserVO;

public interface AdminMapper {

	public List<UserVO> selectUers(@Param("user_nm") String user_nm);

}
