package com.eco.controller;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.eco.domain.UserTypeChargeDTO;
import com.eco.service.ChargeService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class SimpleLookUpController {
	
	private ChargeService service;
	
	@GetMapping("/simplelookup")
	public String simpleLookUpPage(Model model) {
		log.info("SimpleLookup Page");
		model.addAttribute("gasChargeMsg", "해당 기간 가스 사용량이 없습니다.");
		model.addAttribute("elecChargeMsg", "해당 기간 전기 사용량이 없습니다.");
		
		return "simplelookup";
	}
	
	@PostMapping("/simplelookup")
	public String simpleLookup(Model model, @RequestParam("user_num") int userCd, 
			@RequestParam("startDate") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate, 
			@RequestParam("endDate") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate) {
		// 이번 달 에너지 사용 요금 합계
		UserTypeChargeDTO gasCharge = service.simpleGasCharge(userCd, startDate, endDate);
		UserTypeChargeDTO elecCharge = service.simpleElecCharge(userCd, startDate, endDate);
		model.addAttribute("gasCharge", gasCharge);
		model.addAttribute("elecCharge", elecCharge);
		
		// 이번 달 사용량이 0일 때 처리
		if(gasCharge == null) {
			model.addAttribute("gasChargeMsg", "해당 기간 가스 사용량이 없습니다.");
		}
		if(elecCharge == null) {
			model.addAttribute("elecChargeMsg", "해당 기간 전기 사용량이 없습니다.");
		}
		
		return "simplelookup";
	}
}
