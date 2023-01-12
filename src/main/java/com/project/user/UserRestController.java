package com.project.user;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import com.project.common.SHA256;
import com.project.user.bo.UserBO;
import com.project.user.model.User;

@RestController
@RequestMapping("/user")
public class UserRestController {

	@Autowired
	private UserBO userBO;

	//회원가입 (필수정보) insert
	@PostMapping("/user_insert")
	public Map<String, Object> addUser(User user, HttpSession session) throws NoSuchAlgorithmException {
		
		//암호화
		SHA256 sha256 = new SHA256();
		String encryptPassword = sha256.encrypt(user.getPassword());
		//암호화 된 정보 셋팅
		user.setPassword(encryptPassword);
		
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
	@PostMapping("/user_update")
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
		} else {
			result.put("code", 400);
		}
		return result;

	}
	
	//인증번호 보내기 event
	@PostMapping("/sendMessage")
	public Map<String, Object> sendSMS(@RequestParam("phoneNumber")String phoneNumber, HttpSession session) {
		String confirmNo = userBO.sendRandomMessage(phoneNumber);
		session.setAttribute("confirmNo", confirmNo);
		
		Map<String, Object> result = new HashMap<>();
		result.put("code", 100);
		return result;
	}
	
	//인증번호 일치여부 event
	@PostMapping("/confirmMessage")
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
	
}