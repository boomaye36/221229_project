package com.project.main.dao;

import org.springframework.stereotype.Repository;
import com.project.main.model.Wait;

import com.project.user.model.User;

@Repository
public interface MainDAO {

	public int insertWait(@Param("user_id")int user_id,@Param("localid") String localid,@Param("user_gender") String user_gender,@Param("preference") String preference);

	public User selectWait(@Param("user_gender") String user_gender,@Param("preference") String preference);

	
	
	//대기방 추가 event
	public int insertWait(Wait wait);
	
	//대기방 조건확인 event
	public Wait selectWaitByGender(Wait wait);
}
