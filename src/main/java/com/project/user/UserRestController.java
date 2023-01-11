package com.project.user;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.*;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import com.project.common.EncryptUtils;
import com.project.user.bo.UserBO;
import com.project.user.model.User;

@RestController
@RequestMapping("/user")
public class UserRestController {

	@Autowired
	private UserBO userBO;

	//회원가입 (필수정보) insert
	@PostMapping("/user_insert")
	public Map<String, Object> addUser(User user, HttpSession session) {
		
		//암호화
		String encryptPassword = EncryptUtils.md5(user.getPassword());
		//암호화 된 정보 셋팅
		user.setPassword(encryptPassword);
		
		Map<String, Object> result = new HashMap<>();
		int row = userBO.addUser(user);
		if ( row > 0 ) {
			result.put("code", 100);
		} else {
			result.put("code", 400);
		}
		return result;
	}
	
	//회원가입 id 중복확인 event
	@RequestMapping("/is_duplicated_id")
	public Map<String, Object> isDuplicatedId(@RequestParam("loginid") String loginid) {
		Map<String, Object> result = new HashMap<>();
		int existRowCount = userBO.existingLoginId(loginid);
		if (existRowCount > 0) {
			result.put("result", true);
			result.put("code", 100);
		} else {
			result.put("errorMessege", false);
			result.put("code", 400);
		}
		return result;
	}
	
	
	//로그인 아이디 및 비밀번호 일치 event
	@PostMapping("/sign_in")
	public Map<String, Object> signIn(User user, HttpSession session) {
		
		//암호화
		String encryptPassword = EncryptUtils.md5(user.getPassword());
		//암호화 
		user.setPassword(encryptPassword);
		
		Map<String, Object> result = new HashMap<>();
		User loginUser = userBO.getUserByLoginIdAndPassword(user);
		if (loginUser != null) {
			session.setAttribute("loginUser", loginUser);
			result.put("code", 100);
		} else {
			result.put("code", 400);
		}
		
		return result;
	}
	@PostMapping("/user_update")
	public Map<String, Object> userUpdate(@RequestParam("user_birth") Date user_birth,HttpSession session,
			@RequestParam("user_area") String user_area,
			@RequestParam("user_intro") String user_intro,
			@RequestParam("user_profilephoto") MultipartFile user_profilephoto){
		Map<String, Object> result = new HashMap<>();
		Integer user_id = (Integer) session.getAttribute("user_id");
		System.out.println("user_birth ################" + user_birth);
		userBO.UpdateUser(user_birth, user_area, user_intro, user_profilephoto, user_id);
		result.put("code", 100);
		return result;

	}
	
	@PostMapping("/sendMessage")
	public Map<String, Object> sendSMS(@RequestParam("user_phonenumber")String phoneNumber, HttpSession session) {
		String confirmNo = userBO.sendRandomMessage(phoneNumber);
		session.setAttribute("confirmNo", confirmNo);
		
		Map<String, Object> result = new HashMap<>();
		result.put("code", 100);
		return result;
	}
	
	@PostMapping("/confirmMessage")
	public Map<String, Object> confirmSMS(@RequestParam("pnconfirm")String pnconfirm, @RequestParam("user_phonenumber")String phoneNumber, HttpSession session) {
	    String confirmNo = (String) session.getAttribute("confirmNo");

		
		Map<String, Object> result = new HashMap<>();
		if (pnconfirm.equals(confirmNo)) {
			result.put("code", 100);
			session.removeAttribute("confirmNo");

		}else {
			result.put("code", 400);
		}
		return result;
	}
	
}