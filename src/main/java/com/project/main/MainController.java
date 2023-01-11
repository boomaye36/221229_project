package com.project.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

	// 메인페이지
	@GetMapping("/main")
	public String test() {
		return "/main/main";
	}
}
