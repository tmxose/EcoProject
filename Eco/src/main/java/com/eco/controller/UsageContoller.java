package com.eco.controller;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.eco.domain.ElecUsageVO;
import com.eco.domain.GasUsageVO;
import com.eco.domain.UserTypeChargeDTO;
import com.eco.domain.UserVO;
import com.eco.service.UsageService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/usage")
public class UsageContoller {

	private UsageService service;

	// 이번 달 나의 에너지 사용량 가져오기
	@GetMapping("")
	public String usageSelect(Model model, HttpSession session) {
		log.info("이번 달 나의 사용량 가져오기");
		// session의 유저 정보 가져오기
		UserVO user = (UserVO) session.getAttribute("currentUserInfo");
		model.addAttribute("userId", user.getUser_id());
		model.addAttribute("userName", user.getUser_nm());

		// 이번 달 에너지 사용량 합계
		UserTypeChargeDTO gasTotal = service.readGasusage(user.getUser_id());
		UserTypeChargeDTO elecTotal = service.readElecusage(user.getUser_id());
		model.addAttribute("gasUsage", gasTotal);
		model.addAttribute("elecUsage", elecTotal);
		// 이번 달 사용량이 0일 때 처리
		if (gasTotal == null) {
			model.addAttribute("gasUsageMsg", "이번 달 가스 사용량이 없습니다.");
		}
		if (elecTotal == null) {
			model.addAttribute("elecUsageMsg", "이번 달 전기 사용량이 없습니다.");
		}

		// 가스 상세 내역
		List<UserTypeChargeDTO> gasUse = service.gasUsageDetail(user.getUser_id());
		model.addAttribute("gasUse", gasUse);
		// 전기 상세 내역
		List<UserTypeChargeDTO> elecUse = service.elecUsageDetail(user.getUser_id());
		model.addAttribute("elecUse", elecUse);
		// 이번 달 사용량이 0일 때 처리
		if (gasUse.isEmpty()) {
			model.addAttribute("gasUsageDetailMsg", "이번 달 가스 사용량이 없습니다.");
		}
		if (elecUse.isEmpty()) {
			model.addAttribute("elecUsageDetailMsg", "이번 달 전기 사용량이 없습니다.");
		}

		return "usage";
	}

	// 지정한 기간 나의 에너지 사용량 가져오기
	@GetMapping("/period")
	public String usageSelectPeriod(Model model, HttpSession session,
			@RequestParam("startDate") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
			@RequestParam("endDate") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate) {
		log.info("이번 달 나의 사용량 가져오기");
		// session의 유저 정보 가져오기
		UserVO user = (UserVO) session.getAttribute("currentUserInfo");
		String userID = user.getUser_id();
		model.addAttribute("userId", user.getUser_id());
		model.addAttribute("userName", user.getUser_nm());

		// 이번 달 에너지 사용량 합계
		UserTypeChargeDTO gasTotal = service.readGasusage(userID);
		UserTypeChargeDTO elecTotal = service.readElecusage(userID);
		model.addAttribute("gasUsage", gasTotal);
		model.addAttribute("elecUsage", elecTotal);
		// 이번 달 사용량이 0일 때 처리
		if (gasTotal == null) {
			model.addAttribute("gasUsageMsg", "이번 달 가스 사용량이 없습니다.");
		}
		if (elecTotal == null) {
			model.addAttribute("elecUsageMsg", "이번 달 전기 사용량이 없습니다.");
		}

		log.info("지정 기간 나의 사용량 가져오기");
		// 지정 기간 가스 상세 내역
		List<UserTypeChargeDTO> gasUse = service.gasUsagePeriod(userID, startDate, endDate);
		model.addAttribute("gasUse", gasUse);
		// 지정 기간 전기 상세 내역
		List<UserTypeChargeDTO> elecUse = service.elecUsagePeriod(userID, startDate, endDate);
		model.addAttribute("elecUse", elecUse);
		// 지정 기간 사용량이 0일 때 처리
		if (gasUse.isEmpty()) {
			model.addAttribute("gasUsageDetailMsg", "해당 기간 가스 사용량이 없습니다.");
		}
		if (elecUse.isEmpty()) {
			model.addAttribute("elecUsageDetailMsg", "해당 기간 전기 사용량이 없습니다.");
		}

		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);

		return "usage";
	}

	// 사용자의 가스 사용량 등록
	@PostMapping("/gas/insert")
	public String insertGasUsage(GasUsageVO gasUsage, HttpSession session) {
		UserVO user = (UserVO) session.getAttribute("currentUserInfo");
		gasUsage.setUser_cd(user.getUser_cd());
		service.insertGasUsage(gasUsage);
		log.info("가스 사용량 INSERT");
		return "redirect:/usage";
	}
	// 사용자의 전기 사용량 등록
	@PostMapping("/elec/insert")
	public String insertElecUsage(ElecUsageVO elecUsage, HttpSession session) {
		UserVO user = (UserVO) session.getAttribute("currentUserInfo");
		elecUsage.setUser_cd(user.getUser_cd());
		service.insertElecUsage(elecUsage);
		log.info("전기 사용량 INSERT");
		return "redirect:/usage";
	}

	// 가스/전기 타입 한글명 조회후 model 로 usageForm페이지로 넘겨주기
	@GetMapping("/insert-form")
	public String insertForm(Model model) {
		model.addAttribute("gasList", service.getAllGasTypes());
		model.addAttribute("elecList", service.getAllElecTypes());
		return "usageForm"; 
	}

	// 사용량 수정/삭제

}
