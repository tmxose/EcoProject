package com.eco.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.eco.domain.UserTypeChargeDTO;
import com.eco.domain.UserVO;
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
		UserVO user = (UserVO) session.getAttribute("currentUserInfo");
		// 이번 달 에너지 사용량 합계
		model.addAttribute("usage", service.readGasusage(user.getUser_id()));
		model.addAttribute("usage", service.readElecusage(user.getUser_id()));
		log.info(user.getUser_id());
		//가스 상세 내역
		List<UserTypeChargeDTO> gasUse = service.gasUsageDetail(user.getUser_id());
		model.addAttribute("gasUse", gasUse);
		log.info(gasUse);
		//전기 상세 내역
		List<UserTypeChargeDTO> elecUse = service.elecUsageDetail(user.getUser_id());
		model.addAttribute("elecUse", elecUse);
		
		return "usage";
	}
}
