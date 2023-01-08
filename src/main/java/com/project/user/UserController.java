package com.project.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {
	
	@RequestMapping("/user/tos")
	public String tos() {
		return "/user/tos";
	}
	//로그인 페이지
	@GetMapping("/user/sign-in")
	public String signIn() {
		
		return "/user/user";
	}
	
	
	
	//회원가입 페이지
	@GetMapping("/user/sign-up")
	public String singUp() {
		
		return "/user/signup";
	}
	
	
	
	//아이디 찾기 페이지
	@GetMapping("/user/id")
	public String id() {
		return "/user/id";
	}
	
	//비밀번호 찾기 페이지
	@GetMapping("/user/pwd")
	public String pwd() {
		
		return "/user/pwd";
	}
	
	@RequestMapping("/user/signup_addition")
	public String signUpAdd() {
		return "/user/signup_addition";
	}
	
	
}
