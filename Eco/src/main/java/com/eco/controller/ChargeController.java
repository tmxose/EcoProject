package com.eco.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.eco.domain.UserTypeChargeDTO;
import com.eco.domain.UserVO;
import com.eco.service.ChargeService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class ChargeController {
	
	private ChargeService service;
	
	// 이번 달 나의 요금 가져오기
	@GetMapping("/charge")
	public String chargePage(Model model, HttpSession session) {
		log.info("이번 달 나의 요금 가져오기");
		// session의 유저 아이디 가져오기
		UserVO user = (UserVO) session.getAttribute("currentUserInfo");
		// 이번 달 에너지 사용 요금 합계
		model.addAttribute("gasCharge", service.readGasCharge(user.getUser_id()));
		model.addAttribute("elecCharge", service.readElecCharge(user.getUser_id()));
		
		//가스 상세 내역
		List<UserTypeChargeDTO> gasUse = service.gasChargeDetail(user.getUser_id());
		model.addAttribute("gasUse", gasUse);
		//전기 상세 내역
		List<UserTypeChargeDTO> elecUse = service.elecChargeDetail(user.getUser_id());
		model.addAttribute("elecUse", elecUse);
		
		return "charge";
	}
	
}
