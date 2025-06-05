package com.eco.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.eco.domain.ElecUsageVO;
import com.eco.domain.GasUsageVO;
import com.eco.domain.UserVO;
import com.eco.mapper.AdminMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
public class AdminServiceImpl implements AdminService{

	private AdminMapper mapper;

	// 사용자 검색
	@Override
	public List<UserVO> searchUsers(String user_nm) {
		return  mapper.selectUers(user_nm);
	}

	//전기 사용내역 조회
	@Override
	public List<ElecUsageVO> getElecUsageByUser(int userCd) {
		return null;
	}
	// 가스 사용내역 조회
	@Override
	public List<GasUsageVO> getGasUsageByUser(int userCd) {
		return null;
	}
	// 가스 사용량 등록
	@Override
	public boolean insertGas(GasUsageVO vo) {
		return false;
	}
	// 전기 사용량 등록
	@Override
	public boolean insertElec(ElecUsageVO vo) {
		return false;
	}
	// 전기 수정
	@Override
	public boolean updateElec(ElecUsageVO vo) {
		return false;
	}
	// 전기 삭제
	@Override
	public boolean deleteElec(int usage_cd) {
		return false;
	}
	// 가스 수정
	@Override
	public boolean updateGas(GasUsageVO vo) {
		return false;
	}
	// 가스 삭제
	@Override
	public boolean deleteGas(int usage_cd) {
		return false;
	}

	
}
