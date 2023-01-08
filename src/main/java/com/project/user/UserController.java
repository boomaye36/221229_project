package com.project.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {
	
	
	//로그인 페이지
	@GetMapping("/user/sign-in")
	public String signIn() {
		
		return "/user/user";
	}
	
	
	//회원가입 약관동의 페이지
	@GetMapping("/user/tos")
	public String tos() {
		
		return "/user/tos";
	}
	
	
	//회원가입 페이지
	@GetMapping("/user/sign-up")
	public String singUp() {
		
		return "/user/signup";
	}
	
	//회원가입 추가정보 페이지
	@GetMapping("/user/sign-up-addition")
	public String signUp_addition(){
		
		return "/user/signup_addition";
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
	
	
}
