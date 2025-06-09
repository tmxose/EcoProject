package com.eco.service;

import java.time.LocalDate;
import java.util.List; 

import org.springframework.stereotype.Service;

import com.eco.domain.ElecUsageVO;
import com.eco.domain.ElecVO;
import com.eco.domain.GasUsageVO;
import com.eco.domain.GasVO;
import com.eco.domain.UserTypeChargeDTO;
import com.eco.exception.ServiceException;
import com.eco.mapper.UsageMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class UsageServiceImpl implements UsageService{
	private UsageMapper mapper;

	// 이번 달 나의 사용량 가져오기
	@Override
	public UserTypeChargeDTO readGasusage(String userId) {
		try {
			return mapper.getGasUsage(userId);
		} catch(Exception e) {
			throw new ServiceException("당월 가스 사용량 조회 실패", e);
		}
	}
	@Override
	public UserTypeChargeDTO readElecusage(String userId) {
		try {
			return mapper.getElecUsage(userId);
		} catch(Exception e) {
			throw new ServiceException("당월 전기 사용량 조회 실패", e);
		}
	}
	
	// 당월 에너지 사용 상세 내역
	@Override
	public List<UserTypeChargeDTO> gasUsageDetail(String userId) {
		try {
			return mapper.getGasUsageDetail(userId);
		} catch(Exception e) {
			throw new ServiceException("당월 가스 사용 상세 내역 조회 실패", e);
		}
	}
	@Override
	public List<UserTypeChargeDTO> elecUsageDetail(String userId) {
		try {
			return mapper.getElecUsageDetail(userId);
		} catch(Exception e) {
			throw new ServiceException("당월 전기 사용 상세 내역 조회 실패", e);
		}
	}
	
	// 지정 기간 에너지 사용 상세 내역
	@Override
	public List<UserTypeChargeDTO> gasUsagePeriod(String userId, LocalDate startDate, LocalDate endDate) {
		try {
			return mapper.getGasUsagePeriod(userId, startDate, endDate);
		} catch(Exception e) {
			throw new ServiceException("지정 기간 가스 사용 내역 조회 실패", e);
		}
	}
	@Override
	public List<UserTypeChargeDTO> elecUsagePeriod(String userId, LocalDate startDate, LocalDate endDate) {
		try {
			return mapper.getElecUsagePeriod(userId, startDate, endDate);
		} catch(Exception e) {
			throw new ServiceException("지정 기간 전기 사용 내역 조회 실패", e);
		}
	}
	
	// 
	@Override
	public List<UserTypeChargeDTO> usageAmount(){
		try {
			return mapper.getUsageLocalAmount();
		}  catch(Exception e) {
			throw new ServiceException("지역별 가장 최근 달의 에너지 사용량 합계 조회 실패", e);
		}
	}
	
	// 사용자의 월별 사용량 합계
	@Override
	public List<UserTypeChargeDTO> usageMonth(String userId) {
		try {
			return mapper.getUsageMonthAmount(userId);
		} catch(Exception e) {
			throw new ServiceException("사용자의 월별 사용량 합계 조회 실패", e);
		}
	}
	
	// 사용자의 가스 사용량 등록
//	@Override
//	public void insertGasUsage(GasUsageVO gasUsage) {
//		try {
//			mapper.insertGasUsage(gasUsage);
//		} catch(Exception e) {
//			throw new ServiceException("사용자의 월별 가스 사용량 등록 실패", e);
//		}
//	}
//	
//	// 사용자의 전기 사용량 등록
//	@Override
//	public void insertElecUsage(ElecUsageVO elecUsage) {
//		mapper.insertElecUsage(elecUsage);
//	}
	
	@Override
	public List<GasVO> getAllGasTypes() {
		return mapper.getAllGasTypes();
	}
	@Override
	public List<ElecVO> getAllElecTypes() {
		return mapper.getAllElecTypes();
	}
	
}
