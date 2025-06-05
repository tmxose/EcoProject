package com.eco.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eco.domain.ElecUsageVO;
import com.eco.domain.GasUsageVO;
import com.eco.domain.UserVO;
import com.eco.service.AdminService;
import com.eco.service.UsageService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/admin")
public class AdminController {
	private AdminService adminService;
	private UsageService service; // 또는 final + 생성자 주입
	
	// admin 페이지로 이동
	@GetMapping("")
	public String adminPage(Model model) {
		log.info("AdminController - adminPage");
		// 가스/전기 타입 목록 조회 후 admin 페이지로 전달
		model.addAttribute("gasList", service.getAllGasTypes());
	    model.addAttribute("elecList", service.getAllElecTypes());
	    return "admin"; 
	}

	// 사용자 검색
	@GetMapping("/search-users")
	@ResponseBody
	public List<UserVO> searchUser(@RequestParam String keyword) {
		log.info("AdminController - searchUser");
		List<UserVO> result = adminService.searchUsers(keyword);
		log.info("result:" + result);
		return result;
	}

	// 전기 사용내역 조회
	@GetMapping("/user/{userCd}/elec-usage")
	@ResponseBody
	public List<ElecUsageVO> getElecUsage(@PathVariable int userCd) {
		log.info("AdminController - getElecUsage");
		return adminService.getElecUsageByUser(userCd);
	}

	// 가스 사용내역 조회
	@GetMapping("/user/{userCd}/gas-usage")
	@ResponseBody
	public List<GasUsageVO> getGasUsage(@PathVariable int userCd) {
		log.info("AdminController - getGasUsage");
		return adminService.getGasUsageByUser(userCd);
	}

	// 가스 사용량 등록
	@PostMapping("/gas/insert")
	@ResponseBody
	public boolean insertGasUsage(@RequestBody GasUsageVO vo) {
		log.info("AdminController - insertGasUsage");
		if (vo.getGas_time() != null) {
		        // Date → Timestamp 변환 (직접 변환해도 됨)
		        Timestamp timestamp = new Timestamp(vo.getGas_time().getTime());
		        vo.setGas_time(timestamp);
		        log.info("Timestamp : " + timestamp);
		}
	    return adminService.insertGas(vo);  // boolean true/false 반환
	}

	// 전기 사용량 등록
	@PostMapping("/elec/insert")
	@ResponseBody
	public boolean insertElecUsage(@RequestBody ElecUsageVO vo) {
		log.info("AdminController - insertElecUsage");
		if (vo.getElec_time() != null) {
	        // Date → Timestamp 변환 (직접 변환해도 됨)
	        Timestamp timestamp = new Timestamp(vo.getElec_time().getTime());
	        vo.setElec_time(timestamp);
	        log.info("Timestamp : " + timestamp);
		}
		return adminService.insertElec(vo); // user_cd, gas_usage, gas_time 등이 포함됨
	}

	// 전기 수정
	@PostMapping("/elec/update")
	@ResponseBody
	public Map<String, Object> updateElec(@RequestBody ElecUsageVO vo) {
		log.info("AdminController - updateElec");
		log.info(vo);
		boolean result = adminService.updateElec(vo);
		return Map.of("success", result);
	}

	// 전기 삭제
	@PostMapping("/elec/delete")
	@ResponseBody
	public Map<String, Object> deleteElec(@RequestBody ElecUsageVO vo) {
		log.info("AdminController - deleteElec");
		boolean result = adminService.deleteElec(vo.getUsage_cd());
		return Map.of("success", result);
	}

	// 가스 수정
	@PostMapping("/gas/update")
	@ResponseBody
	public Map<String, Object> updateGas(@RequestBody GasUsageVO vo) {
		log.info("AdminController - updateGas");
		boolean result = adminService.updateGas(vo);
		return Map.of("success", result);
	}

	// 가스 삭제
	@PostMapping("/gas/delete")
	@ResponseBody
	public Map<String, Object> deleteGas(@RequestBody GasUsageVO vo) {
		log.info("AdminController - deleteGas");
		boolean result = adminService.deleteGas(vo.getUsage_cd());
		return Map.of("success", result);
	}
	
}
