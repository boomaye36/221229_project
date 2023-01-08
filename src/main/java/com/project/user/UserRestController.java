package com.project.user;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.common.EncryptUtils;
import com.project.user.bo.UserBO;
import com.project.user.model.User;

@RestController
@RequestMapping("/user")
public class UserRestController {

	@Autowired
	private UserBO userBO;

	@RequestMapping("/is_duplicated_id")
	public Map<String, Object> isDuplicatedId(@RequestParam("user_loginid") String user_loginid) {
		Map<String, Object> result = new HashMap<>();
		int existRowCount = userBO.existingLoginId(user_loginid);
		if (existRowCount > 0) {
			result.put("result", true);
			result.put("code", 100);
		} else {
			result.put("errorMessege", false);
			result.put("code", 100);
		}
		return result;
	}

	@PostMapping("/user_insert")
	public Map<String, Object> addUser(@RequestParam("user_loginid") String user_loginid,
			@RequestParam("user_password") String user_password, @RequestParam("user_nickname") String user_nickname,
			@RequestParam("user_phonenumber") String user_phonenumber, @RequestParam("user_gender") String user_gender,
			@RequestParam("user_email") String user_email, HttpSession session

	) {

		String encryptPassword = EncryptUtils.md5(user_password);

		Map<String, Object> result = new HashMap<>();
		userBO.addUser(user_loginid, encryptPassword, user_nickname, user_gender, user_email, user_phonenumber);
		result.put("code", 100);
		return result;
	}

	@PostMapping("/sign_in")
	public Map<String, Object> signIn(@RequestParam("user_loginid") String user_loginid,
			@RequestParam("user_password") String user_password, HttpSession session) {

		String encryptPassword = EncryptUtils.md5(user_password);

		Map<String, Object> result = new HashMap<>();
		User user = userBO.getUserByLoginIdAndPassword(user_loginid, encryptPassword);
		if (user != null) {
			result.put("code", 100);
			session.setAttribute("user_loginid", user.getUser_loginid());
			session.setAttribute("user_id", user.getId());

		} else {
			result.put("code", 400);
		}
		return result;
	}
	@PostMapping("/user_update")
	public Map<String, Object> userUpdate(@RequestParam("user_birth") Date user_birth,HttpSession session,
			@RequestParam("user_area") String user_area,
			@RequestParam("user_intro") String user_intro,
			@RequestParam("user_profilephoto") String user_profilephoto){
		Map<String, Object> result = new HashMap<>();
		Integer user_id = (Integer) session.getAttribute("user_id");
		userBO.UpdateUser(user_birth, user_area, user_intro, user_profilephoto, user_id);
		result.put("code", 100);
		return result;

	}
}