package com.project.user.dao;

import java.util.Date;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.project.user.model.User;

@Repository
public interface UserDAO {

	public int existingLoginId(String user_loginid);

	public void insertUser(@Param("user_loginid")String user_loginid, @Param("user_password")String user_password, @Param("user_nickname") String user_nickname,@Param("user_gender") String user_gender,@Param("user_email") String user_email,@Param("user_phonenumber") String user_phonenumber, @Param("path") String path);

	public User selectUserByLoginIdAndPassword(@Param("user_loginid")String user_loginid, @Param("user_password")String user_password);

	public void UpdateUser(@Param("user_birth")Date user_birth, @Param("user_area")String user_area, @Param("user_intro")String user_intro,@Param("imagePath") String imagePath, @Param("user_id") int user_id);
	
	

}
