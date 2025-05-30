package com.eco.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.eco.domain.UserTypeChargeDTO;
import com.eco.service.ChargeService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class ChargeController {
	
	private ChargeService service;
	
	// 이번 달 나의 요금 가져오기
	@GetMapping("/charge")
	public void chargePage(Model model) {
		log.info("이번 달 나의 요금 가져오기");
		model.addAttribute("gasCharge", service.getGasCharge("abcd"));
		model.addAttribute("elecCharge", service.getElecCharge("abcd"));
		
		//가스 상세 내역
		List<UserTypeChargeDTO> gasUse = service.gasChargeDetail("abcd");
		model.addAttribute("gasUse", gasUse);
		//전기 상세 내역
		List<UserTypeChargeDTO> elecUse = service.elecChargeDetail("abcd");
		model.addAttribute("elecUse", elecUse);
	}
	
	@GetMapping("/chargeSelect")
	public void chargeSelect(Model model) {
		//log.info("��� ��ȸ ȭ�� �̵�");
		UserTypeChargeDTO gasChargeDTO = service.getGasCharge("abcd");
//		//��뷮
//	    float gas_usage = gasChargeDTO.getGas_usage();
//	    float elec_usage = gasChargeDTO.getElec_usage();
//	    //ǥ�ؿ��
//	    
//	    //��뷮 * ǥ�ؿ��
//	    float gas_charge = gas_usage * ǥ�ؿ��;
//	    float elec_charge = elec_usage * ǥ�ؿ��;
	    
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
