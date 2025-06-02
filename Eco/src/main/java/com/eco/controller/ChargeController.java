package com.eco.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
		
		return "charge";
	}
	
	// 지정한 기간 나의 에너지 요금 가져오기
	@GetMapping("/period")
	public void chargeSelectPeriod() {
		
	}
	
}
