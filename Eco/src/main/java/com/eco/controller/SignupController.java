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
	
	// �쉶�썝媛��엯 �럹�씠吏�濡� �씠�룞
	@GetMapping("/signup")
	public void signupPage() {
		log.info("signup page");
		
	}
	
	// �쉶�썝媛��엯 DB INSERT
	@PostMapping("/signup")
	public String signupPost(UserVO user) {
		log.info("signup Post");
		service.signup(user);
		return "home";
	}
}
