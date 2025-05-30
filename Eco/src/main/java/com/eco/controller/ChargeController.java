package com.eco.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ChargeController {
	@GetMapping("/charge")
	public void loginPage() {
		log.info("요금 조회 페이지로 이동");
	}
}
