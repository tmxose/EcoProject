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
public class IndexController {
	
	private UsageService usageService;
	
	@GetMapping("/")
	public String Index(Model model) {
		log.info("index 페이지 진입");
		
		// 지역별 가장 최근 달의 에너지 사용량 합계
		List<UserTypeChargeDTO> usageAmount = usageService.usageAmount();
		model.addAttribute("usageAmount", usageAmount);
		
		return "index";
	}
}
