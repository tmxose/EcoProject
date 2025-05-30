package com.eco.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.eco.domain.UsageVO;
import com.eco.domain.UserTypeChargeDTO;
import com.eco.service.ChargeService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class ChargeController {
	
	private ChargeService service;
	
	// 이번 달 나의 요금 select
	@GetMapping("/charge")
	public void chargePage(Model model) {
		log.info("요금 조회 화면 이동");
		//UserTypeChargeDTO gasChargeDTO = service.getGasCharge("abcd");
//		//사용량
//	    float gas_usage = gasChargeDTO.getGas_usage();
//	    float elec_usage = gasChargeDTO.getElec_usage();
//	    //표준요금
//	    
//	    //사용량 * 표준요금
//	    float gas_charge = gas_usage * 표준요금;
//	    float elec_charge = elec_usage * 표준요금;
	    
//	    model.addAttribute("usage", gasChargeDTO);
//	    model.addAttribute("gasCharge", gas_charge);
//	    model.addAttribute("elecCharge", elec_charge);
		
//		log.info("userCd " +gasChargeDTO.getUserCd());
//		log.info("userNm " +gasChargeDTO.getUserNm());
//		log.info("energyType " +gasChargeDTO.getEnergyType());
//		log.info("usageType " +gasChargeDTO.getUsageType());
//		log.info("usageAmount " +gasChargeDTO.getUsageAmount());
//		log.info("unitCharge " +gasChargeDTO.getUnitCharge());
//		log.info("totalCharge " +gasChargeDTO.getTotalCharge());
	}
	@GetMapping("/chargeSelect")
	public void chargeSelect(Model model) {
		//log.info("요금 조회 화면 이동");
		UserTypeChargeDTO gasChargeDTO = service.getGasCharge("abcd");
//		//사용량
//	    float gas_usage = gasChargeDTO.getGas_usage();
//	    float elec_usage = gasChargeDTO.getElec_usage();
//	    //표준요금
//	    
//	    //사용량 * 표준요금
//	    float gas_charge = gas_usage * 표준요금;
//	    float elec_charge = elec_usage * 표준요금;
	    
//	    model.addAttribute("usage", gasChargeDTO);
//	    model.addAttribute("gasCharge", gas_charge);
//	    model.addAttribute("elecCharge", elec_charge);
		
		log.info("userCd " +gasChargeDTO.getUserCd());
		log.info("userNm " +gasChargeDTO.getUserNm());
		log.info("energyType " +gasChargeDTO.getEnergyType());
		log.info("usageType " +gasChargeDTO.getUsageType());
		log.info("usageAmount " +gasChargeDTO.getUsageAmount());
		log.info("unitCharge " +gasChargeDTO.getUnitCharge());
		log.info("totalCharge " +gasChargeDTO.getTotalCharge());
	}
}
