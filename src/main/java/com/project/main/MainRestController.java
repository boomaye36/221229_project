package com.project.main;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
		//String localid = wait.getLocalid();
		result.put("remoteid", remoteid);
		result.put("user_id", remote.getUser_id());
		return result;
	}
	
	
	@PostMapping("/wait_delete")
	public Map<String, Object> deleteWait(@RequestParam int user_id, HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		Map<String, Object> result = new HashMap<>();
		// jsp에서 가져온 user_id를 넣는다.
		int user_receiveid = user_id;
		// 현재 로그인한 사람의 id를 가져온다.
		int user_sendid = loginUser.getId();
		int response = mainBO.deleteWait(user_receiveid, user_sendid);
		result.put("result", response);
		
		return result;
	}
}
