package com.eco.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.eco.service.ChargeService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class ChargeController {
	
	ChargeService service;
	
	// 이번 달 나의 요금 select
	@GetMapping("/charge")
	public void chargeSelect(Model model) {
		log.info("요금 조회 화면 이동");
		model.addAttribute("usage", service.chargeRead(2));
	}
}
