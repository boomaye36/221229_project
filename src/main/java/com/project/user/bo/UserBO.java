package com.project.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.user.dao.UserDAO;

@Service
public class UserBO {

	@Autowired
	private UserDAO userDAO;
	public int existingLoginId(String user_loginid) {
		return userDAO.existingLoginId(user_loginid);

	}
	public void addUser(String user_loginid, String user_password, String user_nickname, String user_gender, String user_email, String user_phonenumber) {
		userDAO.insertUser(user_loginid, user_password, user_nickname, user_gender, user_email, user_phonenumber);
	}
}
