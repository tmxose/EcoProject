package com.eco.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class SimpleLookUpController {
	
	@GetMapping("/simplelookup")
	public void simpleLookUpPage() {
		log.info("SimpleLookup Page");
	}
}
