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
	
	
	@GetMapping("/signup")
	public void signupPage() {
		log.info("signup page");
		
	}
	
	@PostMapping("/signup")
	public String signupPost(UserVO user) {
		
		log.info("signup Post");
		log.info(user.getUser_id());
		log.info(user.getUser_nm());		
		log.info(user.getUser_pw());		
		
		service.signup(user);
		
		return "home";
	}
}
