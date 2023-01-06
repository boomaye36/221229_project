package com.project.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {

	@GetMapping("/user/sign-in")
	public String test() {
		
		return "test";
	}
}
