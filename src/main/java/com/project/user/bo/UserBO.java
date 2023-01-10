package com.project.user.bo;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project.common.FileManagerService;
import com.project.user.dao.UserDAO;
import com.project.user.model.User;

@Service
public class UserBO {

	@Autowired
	private UserDAO userDAO;
	@Autowired
	private FileManagerService fileManagerService;

	public int existingLoginId(String user_loginid) {
		return userDAO.existingLoginId(user_loginid);

	}
	public void addUser(String user_loginid, String user_password, String user_nickname, String user_gender, String user_email, String user_phonenumber) {
		userDAO.insertUser(user_loginid, user_password, user_nickname, user_gender, user_email, user_phonenumber);
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
}
