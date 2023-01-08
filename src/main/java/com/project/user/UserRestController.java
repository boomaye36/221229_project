package com.project.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.user.bo.UserBO;

@RestController
@RequestMapping("/user")
public class UserRestController {

	@Autowired
	private UserBO userBO;
	
	@RequestMapping("/is_duplicated_id")
	public Map<String, Object> isDuplicatedId(
			@RequestParam("user_loginid") String user_loginid){
		Map<String, Object> result = new HashMap<>();
		int existRowCount  = userBO.existingLoginId(user_loginid );
		if (existRowCount > 0) {
			result.put("result", true);
			result.put("code", 100);
		}else {
			result.put("errorMessege", false);
			result.put("code", 100);
		}
		return result;
	}
	@PostMapping("/user_insert")
	public Map<String, Object> addUser(
			@RequestParam("user_loginid") String user_loginid,
			@RequestParam("user_password") String user_password,
			@RequestParam("user_nickname") String user_nickname,
			@RequestParam("user_phonenumber") String user_phonenumber,
			@RequestParam("user_gender") String user_gender,
			@RequestParam("user_email") String user_email
			
			
			){
		Map<String, Object> result = new HashMap<>();
		userBO.addUser(user_loginid, user_password, user_nickname, user_gender, user_email, user_phonenumber);
		result.put("code", 100);
		return result;
	}
	
}
