package com.project.user;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.project.common.SHA256;
import com.project.user.bo.SendEmail;
import com.project.user.bo.UserBO;
import com.project.user.model.Mail;
import com.project.user.model.User;

@RestController
public class UserRestController {

	@Autowired
	private UserBO userBO;
	
	@Autowired
	private SendEmail sendEmail;


	//회원가입 (필수정보) insert
	@PostMapping("/user/user_insert")
	public Map<String, Object> addUser(User user, HttpSession session) throws NoSuchAlgorithmException {
		
		//회원 비밀번호가 null이 아닐 때 암호화시킴
		if (user.getPassword() != null) {

		//암호화
		SHA256 sha256 = new SHA256();
		String encryptPassword = sha256.encrypt(user.getPassword());
		//암호화 된 정보 셋팅
		user.setPassword(encryptPassword);
		}
		Map<String, Object> result = new HashMap<>();
		int row = userBO.addUser(user);
		User loginUser = userBO.getUserByLoginIdAndPassword(user);
		session.setAttribute("loginUser", loginUser);
		if ( row > 0 ) {
			result.put("code", 100);
		} else {
			result.put("code", 400);
		}
		return result;
	}
	
	//회원가입 id 중복확인 event
	@RequestMapping("/user/is_duplicated_id")
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
	@PostMapping("/user/sign_in")
	public Map<String, Object> signIn(User user, HttpSession session) throws NoSuchAlgorithmException {
		
		//암호화
		SHA256 sha256 = new SHA256();
		String encryptPassword = sha256.encrypt(user.getPassword());
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
	
	
	//추가 선택정보 회원가입 event
	@PostMapping("/user/user_update")
	public Map<String, Object> userUpdate(User user,@RequestParam(value="file", required=false)MultipartFile file, HttpSession session){
		Map<String, Object> result = new HashMap<>();
		//세션객체 가져오기
		User loginUsers = (User) session.getAttribute("loginUser");
		
		//user 객체에 아이디 셋팅해주기
		user.setLoginid(loginUsers.getLoginid());
		int row  = userBO.updateUser(user, file);
		session.removeAttribute("loginUser");
		User loginUser = userBO.getUserByLoginId(user.getLoginid());
		session.setAttribute("loginUser", loginUser);
		if ( row > 0) {
			result.put("code", 100);
			session.setAttribute("loginid", loginUser.getLoginid());
			
		} else {
			result.put("code", 400);
		}
		return result;

	}
	
	//인증번호 보내기 event
	@PostMapping("/user/sendMessage")
	public Map<String, Object> sendSMS(@RequestParam("phoneNumber")String phoneNumber, HttpSession session) {
		String confirmNo = userBO.sendRandomMessage(phoneNumber);
		session.setAttribute("confirmNo", confirmNo);
		Map<String, Object> result = new HashMap<>();
		result.put("code", 100);
		return result;
	}
	
	//인증번호 일치여부 event
	@PostMapping("/user/confirmMessage")
	public Map<String, Object> confirmSMS(@RequestParam("pnconfirm")String pnconfirm, @RequestParam("phoneNumber")String phoneNumber, HttpSession session) {
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
	
	
	//비밀번호 찾기 - 아이디 이메일 일치여부 확인 event
	@GetMapping("/is_duplicated_email")
	public User email_check(User user) {
		User check = userBO.getUserCheckByUserIdUserEmail(user);
		return check;
	}
	
	
	//비밀번호 찾기 - 이메일 보내기 event
	@PostMapping("/user/sendEmail")
	public void sendEmail(User user) throws NoSuchAlgorithmException {
		//메일 형식 만들기
		Mail mail = sendEmail.createMailAndChangePassword(user);
		
		//메일 보내기 메소드
		sendEmail.mailSend(mail);
		
		//임의생성된 패스워드 셋팅
		user.setPassword(mail.getPassword());
		
		//비밀번호 업데이트 메소드
		sendEmail.updataedPassword(user);
	}
	
	// 회원정보 수정 - 내정보 변경
	@PutMapping("/mypage/user_update")
	public Map<String, Object> mypageUserUpdate(User user, @RequestParam(value="file", required=false) MultipartFile file, HttpSession session) {
		//세션객체 가져오기
		User loginUsers = (User) session.getAttribute("loginUser");
		
		//user 객체에 아이디 셋팅해주기
		user.setLoginid(loginUsers.getLoginid());
		user.setProfilephoto(loginUsers.getProfilephoto());
		Map<String, Object> result = new HashMap<>();
		int row  = userBO.updateUserbyId(user, file);
		session.removeAttribute("loginUser");
		User loginUser = userBO.getUserByLoginId(user.getLoginid());
		session.setAttribute("loginUser", loginUser);
		if (row > 0) {
			result.put("code", 100);
			session.setAttribute("loginid", loginUser.getLoginid());
		} else {
			result.put("code", 400);
		}
		return result;
	}
	
	// 회원정보 수정 - 비밀번호 변경
	@PostMapping("/mypage/pwd_update")
	public Map<String, Object> pwdUpdate(User user, @RequestParam("changedPassword") String changedPassword, HttpSession session) throws NoSuchAlgorithmException {
//		String loginid = user.getLoginid(); user객체에서 loginid를 받아왔더니 null로 뜨면서 update가 되지 않아서 session에서 받아옴
		User loginUser = (User)session.getAttribute("loginUser");
		// 현재 비밀번호 가져오기
		String currentPassword = user.getPassword();
		
		// 암호화
		SHA256 sha256 = new SHA256();
		String encryptPassword = sha256.encrypt(currentPassword);
		String newEncryptPassword = sha256.encrypt(changedPassword);
		
		Map<String, Object> result = new HashMap<>();
		// 현재 비밀번호 일치여부 확인
		boolean isMatched = userBO.isMatchedPassword(encryptPassword);
		if (isMatched) {
			result.put("result", true);
			// 일치여부 true일 때 새 비밀번호 update
			userBO.updatePassword(loginUser.getLoginid(), newEncryptPassword);
			result.put("code", 100);
		} else {
			result.put("result", false);
		}
		
		return result;
	}
	
	// 회원탈퇴
	@DeleteMapping("/mypage/user_delete")
	public Map<String, Object> deleteUser(User user, HttpSession session) {
		
		// 세션에 저장되어있는 유저 id 가져오기
		User loginUser = (User)session.getAttribute("loginUser");
		int id = loginUser.getId();
		
		Map<String, Object> result = new HashMap<>();
		
		// delete user
		int row = userBO.deleteUserbyId(id);
		if (row > 0) {			
			// 세션 제거
			session.removeAttribute("loginUser");
			
			result.put("code", 100);
			result.put("result", "success");
		} else {			
			result.put("code", 400);
		}
		
		return result;
	}
	
}