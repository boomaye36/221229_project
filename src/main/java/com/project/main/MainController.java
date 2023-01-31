package com.project.main;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.main.bo.MainBO;
import com.project.main.model.Recent;
import com.project.user.bo.UserBO;
import com.project.user.model.User;

@Controller
public class MainController {
	@Autowired
	private UserBO userBO;
	
	private MainBO mainBO;
	
	// 메인페이지
	@GetMapping("/main")
	public String main() {
		return "/main/main";
	}
	
	// 랜덤통화
	@GetMapping("/call")
	public String call(Recent recent,Model model, HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");
		recent.setUser_sendid(loginUser.getId());
		Recent list = mainBO.getRecentUserBySendId(recent);
		model.addAttribute("list", list);
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
	
	//영상통화 테스트
	@RequestMapping("/test")
	public String test() {
		return "/main/test";
	}
	//remoteid model에 담아서 뷰로 넘김
//	@GetMapping("/match")
//	public String matched( @RequestParam("remoteid") String remoteid, Model model) {
//		//model.addAttribute("localid", localid);
//		model.addAttribute("remoteid", remoteid);
//		return "/main/match";
//		
//	}
}
