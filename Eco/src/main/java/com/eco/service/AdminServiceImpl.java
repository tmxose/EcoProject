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
@Log4j
public class AdminServiceImpl implements AdminService {

	private AdminMapper mapper;

	// 사용자 검색
	@Override
	public List<UserVO> searchUsers(String user_nm) {
		return mapper.selectUers(user_nm);
	}

	// 전기 사용내역 조회
	@Override
	public List<ElecUsageVO> getElecUsageByUser(int userCd) {
		return mapper.selectElecUsageByUser(userCd);
	}

	// 가스 사용내역 조회
	@Override
	public List<GasUsageVO> getGasUsageByUser(int userCd) {
		return mapper.selectGasUsageByUser(userCd);
	}

	// 가스 사용량 등록
	@Override
	public boolean insertGas(GasUsageVO vo) {
		int rows = mapper.insertGasUsage(vo);
		log.info("insertGasUsage 영향 받은 행 수: " + rows);
		return rows > 0;
	}

	// 전기 사용량 등록
	@Override
	public boolean insertElec(ElecUsageVO vo) {
		int rows = mapper.insertElecUsage(vo);
		return rows > 0;
	}

	// 전기 수정
	@Override
	public boolean updateElec(ElecUsageVO vo) {
		int affectedRows = mapper.updateElec(vo);
		return affectedRows > 0;
	}

	// 전기 삭제
	@Override
	public boolean deleteElec(int usage_cd) {
		int affectedRows = mapper.deleteElec(usage_cd);
		return affectedRows > 0;
	}

	// 가스 수정
	@Override
	public boolean updateGas(GasUsageVO vo) {
		int affectedRows = mapper.updateGas(vo);
		return affectedRows > 0;
	}

	// 가스 삭제
	@Override
	public boolean deleteGas(int usage_cd) {
		int affectedRows = mapper.deleteGas(usage_cd);
		return affectedRows > 0;
	}

}
