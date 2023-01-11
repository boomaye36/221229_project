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

	public int existingLoginId(String user_loginid) {
		return userDAO.existingLoginId(user_loginid);

	}
	public void addUser(String user_loginid, String user_password, String user_nickname, String user_gender, String user_email, String user_phonenumber, String path) {
		userDAO.insertUser(user_loginid, user_password, user_nickname, user_gender, user_email, user_phonenumber, path);
	}
	
	public User getUserByLoginIdAndPassword(String user_loginid, String user_password) {
		return userDAO.selectUserByLoginIdAndPassword(user_loginid, user_password);
	}
	public void UpdateUser(Date user_birth, String user_area, String user_intro, MultipartFile user_profilephoto, int user_id) {
		String imagePath = null;
		if (user_profilephoto != null) {
			imagePath = fileManagerService.saveFile( user_profilephoto);
		}
		userDAO.UpdateUser(user_birth, user_area, user_intro, imagePath, user_id);
		
	}
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
