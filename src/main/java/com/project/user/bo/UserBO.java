package com.project.user.bo;

import java.util.Date;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project.common.FileManagerService;
import com.project.user.dao.UserDAO;
import com.project.user.model.User;
import com.project.util.Naver_Sens_V2;

@Service
public class UserBO {

	@Autowired
	private UserBO userBO;
	@Autowired
	private UserDAO userDAO;
	@Autowired
	private FileManagerService fileManagerService;

	//회원가입 필수정보 insert
	public int addUser(User user) {
		return userDAO.insertUser(user);
	}
	
	//회원가입시 id 중복 event
	public int existingLoginId(String loginid) {
		return userDAO.existingLoginId(loginid);

	}
	
	//로그인시 아이디 및 비밀번호 일치여부 확인 event
	public User getUserByLoginIdAndPassword(User user) {
		return userDAO.selectUserByLoginIdAndPassword(user);
	}
	
	//회원가입 선택정보 insert
	public int updateUser(User user , MultipartFile user_profilephoto) {
		String imagePath = null;
		if (user_profilephoto != null) {
			imagePath = fileManagerService.saveFile( user_profilephoto);
			user.setProfilephoto(imagePath);
		}
		return userDAO.updateUser(user);
		
	}
	
	//문자메세지 만들기
	public String sendRandomMessage(String tel) {
	    Naver_Sens_V2 message = new Naver_Sens_V2();
	    Random rand = new Random();
	    String numStr = "";
	    for (int i = 0; i < 6; i++) {
	        String ran = Integer.toString(rand.nextInt(10));
	        numStr += ran;
	    }
	    System.out.println("회원가입 문자 인증 => " + numStr);

	    message.send_msg(tel, numStr);

	    return numStr;
	}
	
	public boolean ConfirmSMS(String pnconfirm, String user_phonenumber){
		String numStr = userBO.sendRandomMessage(user_phonenumber);
		if (pnconfirm == numStr) {
			return true;
		}else {
			return false;
		}
	}
}
