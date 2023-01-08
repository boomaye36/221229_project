package com.project.user.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserDAO {

	public int existingLoginId(String user_loginid);

	public void insertUser(@Param("user_loginid")String user_loginid, @Param("user_password")String user_password, @Param("user_nickname") String user_nickname,@Param("user_gender") String user_gender,@Param("user_email") String user_email,@Param("user_phonenumber") String user_phonenumber);

}
