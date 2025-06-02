package com.eco.controller;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.eco.domain.UserTypeChargeDTO;
import com.eco.domain.UserVO;
import com.eco.service.ChargeService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/charge")
public class ChargeController {
	
	private ChargeService service;
	
	// 이번 달 나의 요금 가져오기
	@GetMapping("")
	public String chargeSelect(Model model, HttpSession session) {
		log.info("이번 달 나의 요금 가져오기");
		// session의 유저 정보 가져오기
		UserVO user = (UserVO) session.getAttribute("currentUserInfo");
		model.addAttribute("userId", user.getUser_id());
		model.addAttribute("userName", user.getUser_nm());
		// 이번 달 에너지 사용 요금 합계
		UserTypeChargeDTO gasCharge = service.readGasCharge(user.getUser_id());
		UserTypeChargeDTO elecCharge = service.readElecCharge(user.getUser_id());
		model.addAttribute("gasCharge", gasCharge);
		model.addAttribute("elecCharge", elecCharge);
		
		// 이번 달 사용량이 0일 때 처리
		if(gasCharge == null) {
			model.addAttribute("gasChargeMsg", "이번 달 가스 사용량이 없습니다.");
		}
		if(elecCharge == null) {
			model.addAttribute("elecChargeMsg", "이번 달 전기 사용량이 없습니다.");
		}
		
		//가스 상세 내역
		List<UserTypeChargeDTO> gasUse = service.gasChargeDetail(user.getUser_id());
		model.addAttribute("gasUse", gasUse);
		//전기 상세 내역
		List<UserTypeChargeDTO> elecUse = service.elecChargeDetail(user.getUser_id());
		model.addAttribute("elecUse", elecUse);
		// 이번 달 사용량이 0일 때 처리
		if(gasUse.isEmpty()) {
			model.addAttribute("gasChargeDetailMsg", "이번 달 가스 사용량이 없습니다.");
		}
		if(elecUse.isEmpty()) {
			model.addAttribute("elecChargeDetailMsg", "이번 달 전기 사용량이 없습니다.");
		}
		
		return "charge";
	}
	
	// 지정한 기간 나의 에너지 요금 가져오기
	@GetMapping("/period")
	public String chargeSelectPeriod(Model model, HttpSession session,
			@RequestParam("startDate") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate, 
			@RequestParam("endDate") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate) {
		log.info("이번 달 나의 사용량 가져오기");
		// session의 유저 정보 가져오기
		UserVO user = (UserVO) session.getAttribute("currentUserInfo");
		String userID = user.getUser_id();
		model.addAttribute("userId", user.getUser_id());
		model.addAttribute("userName", user.getUser_nm());
		
		// 이번 달 에너지 사용량 합계
		UserTypeChargeDTO gasCharge = service.readGasCharge(userID);
		UserTypeChargeDTO elecCharge = service.readElecCharge(userID);
		model.addAttribute("gasCharge", gasCharge);
		model.addAttribute("elecCharge", elecCharge);
		// 이번 달 사용량이 0일 때 처리
		if(gasCharge == null) {
			model.addAttribute("gasChargeMsg", "이번 달 가스 사용량이 없습니다.");
		}
		if(elecCharge == null) {
			model.addAttribute("elecChargeMsg", "이번 달 전기 사용량이 없습니다.");
		}
		
		log.info("지정 기간 나의 사용량 가져오기");
		// 지정 기간 가스 상세 내역
		List<UserTypeChargeDTO> gasUse = service.gasChargePeriod(userID, startDate, endDate);
		model.addAttribute("gasUse", gasUse);
		// 지정 기간 전기 상세 내역
		List<UserTypeChargeDTO> elecUse = service.elecChargePeriod(userID, startDate, endDate);
		model.addAttribute("elecUse", elecUse);
		// 지정 기간 사용량이 0일 때 처리
		if(gasUse.isEmpty()) {
			model.addAttribute("gasUsageDetailMsg", "해당 기간 가스 사용량이 없습니다.");
		}
		if(elecUse.isEmpty()) {
			model.addAttribute("elecUsageDetailMsg", "해당 기간 전기 사용량이 없습니다.");
		}
		
		return "charge";
	}
	
}
