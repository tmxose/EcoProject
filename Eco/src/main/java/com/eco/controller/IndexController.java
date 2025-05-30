package com.eco.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class IndexController {
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String Index() {
		log.info("index 페이지 진입");
		return "index";
	}
}
