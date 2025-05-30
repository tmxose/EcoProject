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
public class LoginController {

	private UserService service;
	
	@GetMapping("/login")
	public void loginPage() {
		log.info("login form");
	}
	
	@PostMapping("/login")
	public void loginPost(UserVO user) {
		log.info("loginPost 진입");
		log.info("user_id: "+ user.getUser_id());
		log.info("user_pw: "+ user.getUser_pw());

		//서비스에 함수를 호출값 만들기
		UserVO loginUser = service.login(user);
		
	}
}
