package com.eco.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.eco.service.UsageService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class UsageContoller {
	
	UsageService service;
	
	// 이번 달 나의 사용량 select
	@GetMapping("/usage")
	public void usageSelect(Model model) {
		log.info("사용량 조회 화면 이동");
		model.addAttribute("usage", service.usageRead(2));
	}
}
