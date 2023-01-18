package com.project.main;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.main.bo.MainBO;
import com.project.main.model.Wait;
import com.project.user.model.User;

@RestController
public class MainRestController {
	
	
	@Autowired
	private MainBO mainBO;
	
	@PostMapping("/wait_insert")
	public Map<String, Object> insertWait(Wait wait, HttpSession session, Model model){
		User loginUser = (User) session.getAttribute("loginUser");
		Map<String, Object> result = new HashMap<>();
		
		//세션 아이디 값 및 성별 세팅
		wait.setUser_id(loginUser.getId());
		wait.setUser_gender(loginUser.getGender());
		
		//대기방 추가메소드 호출
		Wait response = mainBO.addWait(wait);
		result.put("result", response);
		Wait remote = mainBO.addWait(wait);

		String remoteid = remote.getLocalid();
		//String remoteid = wait.getLocalid();
		//model.addAttribute("localid", localid);
		result.put("remoteid", remoteid);
		return result;
	}
	
	
	@DeleteMapping("/wait_delete")
	public Map<String, Object> deleteWait(Wait wait, HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		Map<String, Object> result = new HashMap<>();
		
		//세션 아이디 값 및 성별 세팅
		wait.setId(loginUser.getId());
		
		int response = mainBO.deleteWait(wait);
		result.put("result", response);
		
		return result;
	}
}
