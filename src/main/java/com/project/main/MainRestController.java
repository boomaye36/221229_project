package com.project.main;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.main.bo.MainBO;
import com.project.main.model.Recent;
import com.project.main.model.Wait;
import com.project.user.model.User;

@RestController
public class MainRestController {
	
	@Autowired
	private MainBO mainBO;
	
	//영상통화 시작 event
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
		
		return result;
	}
	
	//성공 후 대기방 삭제 및 recent 테이블 insert 
	@PostMapping("/recent_insert")
	public Map<String, Object> insertRecent(Recent recent, HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		Map<String, Object> result = new HashMap<>();
		
		// 세션 아이디 값 세팅
		recent.setUser_sendid(loginUser.getId());
		
		// 대기방 삭제 및 recent 테이블 insert
		int response = mainBO.insertRecent(recent);
		
		result.put("result", response);
		
		return result;
	}
	
	//매칭중 취소 event => 대기방 삭제
	@DeleteMapping("/wait_delete")
	public Map<String, Object> deleteWait(Wait wait, HttpSession session, Model model){
		User loginUser = (User) session.getAttribute("loginUser");
		Map<String, Object> result = new HashMap<>();
		
		//세션 아이디 값 및 성별 세팅
		wait.setUser_id(loginUser.getId());
		
		int response = mainBO.deleteWait(wait);
		
		result.put("result", response);
		
		return result;
	}
	
	
	//아웃
	@DeleteMapping("/wait_out")
	public Map<String, Object> deleteWait(HttpSession session, Model model){
		User loginUser = (User) session.getAttribute("loginUser");
		Map<String, Object> result = new HashMap<>();
		
		int checkout = mainBO.checkWait(loginUser.getId());
		result.put("result", checkout);
		return result;
		
	}
}
