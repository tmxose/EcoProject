package com.eco.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class UsageContoller {
	@GetMapping("/usage")
	public void loginPage() {
		log.info("사용량 조회 화면 이동");
	}
}
