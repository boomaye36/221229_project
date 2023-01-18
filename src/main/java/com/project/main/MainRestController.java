package com.project.main;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.main.bo.MainBO;
import com.project.user.model.User;

@RestController

public class MainRestController {
@Autowired
private MainBO mainBO;
	@PostMapping("/wait_insert")
	public Map<String, Object> insertWait(@RequestParam String localid, @RequestParam String preference,
			HttpSession session, Model model){
		User loginUser = (User) session.getAttribute("loginUser");
		Map<String, Object> result = new HashMap<>();
		Integer user_id = (Integer)loginUser.getId();
		String user_gender = loginUser.getGender();
		int row = mainBO.addWait(user_id, localid, user_gender, preference);
		if ( row > 0) {
			result.put("code", 100);
			session.setAttribute("loginid", loginUser.getLoginid());
			
		} else {
			result.put("code", 400);
		}
		return result;
	}
}
