package com.eco.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.eco.domain.UserVO;
import com.eco.service.UserService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class SignupController {
	
	private UserService service;
	
	// 회원가입 페이지로 이동
	@GetMapping("/signup")
	public void signupPage() {
		log.info("signup page");
		
	}
	
	// 회원가입 DB INSERT
	@PostMapping("/signup")
	public String signupPost(UserVO user) {
		log.info("signup Post");
		service.signup(user);
		return "home";
	}
}
