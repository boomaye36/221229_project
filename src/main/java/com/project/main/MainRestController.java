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
import com.project.main.model.Recent;
import com.project.main.model.Wait;
import com.project.user.bo.UserBO;
import com.project.user.model.User;

@RestController
public class MainRestController {
	@Autowired
	private UserBO userBO;
	@Autowired
	private MainBO mainBO;
<<<<<<< HEAD
=======
	
	@Autowired
	private UserBO userBO;
	
>>>>>>> hyungeon
	//영상통화 시작 event
	@PostMapping("/wait_insert")
	public Map<String, Object> insertWait(Wait wait, HttpSession session, Model model){
		User loginUser = (User) session.getAttribute("loginUser");
		Map<String, Object> result = new HashMap<>();
		User user = userBO.getUserByLoginIdAndPassword(loginUser);
		//세션 아이디 값 및 성별 세팅
		wait.setUser_id(loginUser.getId());
		wait.setUser_gender(loginUser.getGender());
		wait.setUser(user);
		System.out.println("%%%%%%%%%%usernickname =  " + wait.getUser().getNickname());
		//대기방 추가메소드 호출
		result.put("user", user);
		Wait response = mainBO.addWait(wait);
		
		if ( response != null) {
			
			User responseUser = userBO.findCallPageByUserid(response.getUser_id());
			result.put("responseUser", responseUser);
		}
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
	public Map<String, Object> deleteWait(HttpSession session){
		User loginUser = (User) session.getAttribute("loginUser");
		Map<String, Object> result = new HashMap<>();
		
		int checkout = mainBO.checkWait(loginUser.getId());
		result.put("result", checkout);
		return result;
		
	}
	
	
	//응답받는사람 기준으로 상대방 정보 가져오기
	@GetMapping("/recent_check")
	public Map<String, Object> recentCheck(HttpSession session, Recent recent) {
		User loginUser = (User) session.getAttribute("loginUser");
		Map<String, Object> result = new HashMap<>();
		int user_sendid = loginUser.getId();
		User user = mainBO.recentCheck(user_sendid);
		result.put("user", user);
		return result;
	}
}
