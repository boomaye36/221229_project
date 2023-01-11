package com.project.main;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

	// 메인페이지
	@GetMapping("/main")
	public String test() {
		return "/main/main";
	}
	
	
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		
		session.removeAttribute("loginUser");
		return "redirect:/user/sign-in";
	}
}
