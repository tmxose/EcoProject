package com.eco.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.eco.domain.UserTypeChargeDTO;
import com.eco.service.UsageService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class UsageContoller {
	
	private UsageService service;
	
	// 이번 달 나의 사용량 가져오기
	@GetMapping("/usage")
	public void usageSelect(Model model) {
		log.info("이번 달 나의 사용량 가져오기");
		model.addAttribute("usage", service.usageRead("abcd"));
		
		//가스 상세 내역
		List<UserTypeChargeDTO> gasUse = service.gasUsageDetail("abcd");
		model.addAttribute("gasUse", gasUse);
		//전기 상세 내역
		List<UserTypeChargeDTO> elecUse = service.elecUsageDetail("abcd");
		model.addAttribute("elecUse", elecUse);
	}
}
