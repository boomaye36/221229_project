package com.project.main.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.project.user.model.User;

@Repository
public interface MainDAO {

	public int insertWait(@Param("user_id")int user_id,@Param("localid") String localid,@Param("user_gender") String user_gender,@Param("preference") String preference);

	public User selectWait(@Param("user_gender") String user_gender,@Param("preference") String preference);

}
