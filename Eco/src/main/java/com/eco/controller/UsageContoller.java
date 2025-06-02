package com.eco.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

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
	public String usageSelect(Model model, HttpSession session) {
		log.info("이번 달 나의 사용량 가져오기");
		// session의 유저 아이디 가져오기
		String userId = (String)session.getAttribute("currentUserID");
		// 이번 달 에너지 사용량 합계
		model.addAttribute("usage", service.readGasusage("abcd"));
		model.addAttribute("usage", service.readElecusage("abcd"));
		
		//가스 상세 내역
		List<UserTypeChargeDTO> gasUse = service.gasUsageDetail("abcd");
		model.addAttribute("gasUse", gasUse);
		//전기 상세 내역
		List<UserTypeChargeDTO> elecUse = service.elecUsageDetail("abcd");
		model.addAttribute("elecUse", elecUse);
		
		return "usage";
	}
}
