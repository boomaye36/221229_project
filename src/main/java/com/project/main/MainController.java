package com.project.main;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

	// 메인페이지
	@GetMapping("/main")
	public String main() {
		return "/main/main";
	}
	
	// 랜덤통화
	@GetMapping("/call")
	public String call() {
		return "/main/call";
	}
	
	// 친구추천
	@GetMapping("/recommend")
	public String recommend() {
		return "/main/recommend";
	}
	
	//친구목록
	@GetMapping("/friend")
	public String friend() {
		return "/main/friend";
	}
	
	// 내정보
	@GetMapping("/mypage")
	public String mypage() {
		return "/main/mypage";
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		
		session.removeAttribute("loginUser");
		return "redirect:/user/sign-in";
	}
}
