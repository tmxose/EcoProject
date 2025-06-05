package com.eco.service;

import java.time.LocalDate;
import java.util.List; 

import org.springframework.stereotype.Service;

import com.eco.domain.ElecUsageVO;
import com.eco.domain.ElecVO;
import com.eco.domain.GasUsageVO;
import com.eco.domain.GasVO;
import com.eco.domain.UserTypeChargeDTO;
import com.eco.mapper.UsageMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class UsageServiceImpl implements UsageService{
	private UsageMapper mapper;

	// 이번 달 나의 사용량 가져오기
	@Override
	public UserTypeChargeDTO readGasusage(String userId) {
		return mapper.getGasUsage(userId);
	}
	@Override
	public UserTypeChargeDTO readElecusage(String userId) {
		return mapper.getElecUsage(userId);
	}
	
	// 당월 에너지 사용 상세 내역
	@Override
	public List<UserTypeChargeDTO> gasUsageDetail(String userId) {
		return mapper.getGasUsageDetail(userId);
	}
	@Override
	public List<UserTypeChargeDTO> elecUsageDetail(String userId) {
		return mapper.getElecUsageDetail(userId);
	}
	
	// 지정 기간 에너지 사용 상세 내역
	@Override
	public List<UserTypeChargeDTO> gasUsagePeriod(String userId, LocalDate startDate, LocalDate endDate) {
		return mapper.getGasUsagePeriod(userId, startDate, endDate);
	}
	@Override
	public List<UserTypeChargeDTO> elecUsagePeriod(String userId, LocalDate startDate, LocalDate endDate) {
		return mapper.getElecUsagePeriod(userId, startDate, endDate);
	}
	
	// 지역별 가장 최근 달의 에너지 사용량 합계
	@Override
	public List<UserTypeChargeDTO> usageAmount(){
		return mapper.getUsageLocalAmount();
	}
	
	// 사용자의 월별 사용량 합계
	@Override
	public List<UserTypeChargeDTO> usageMonth(String userId) {
		return mapper.getUsageMonthAmount(userId);
		}
	
	// 사용자의 가스 사용량 등록
	@Override
	public void insertGasUsage(GasUsageVO gasUsage) {
		mapper.insertGasUsage(gasUsage);
	}
	
	// 사용자의 전기 사용량 등록
	@Override
	public void insertElecUsage(ElecUsageVO elecUsage) {
		mapper.insertElecUsage(elecUsage);
	}
	
	@Override
	public List<GasVO> getAllGasTypes() {
		return mapper.getAllGasTypes();
	}
	@Override
	public List<ElecVO> getAllElecTypes() {
		return mapper.getAllElecTypes();
	}
	
}
