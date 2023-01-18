package com.project.main.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.project.main.model.Wait;

import com.project.user.model.User;

@Repository
public interface MainDAO {


	public User selectWait(@Param("user_gender") String user_gender,@Param("preference") String preference);

	
	
	//대기방 추가 event
	public int insertWait(Wait wait);
	
	//대기방 조건확인 event
	public Wait selectWaitByGender(Wait wait);
	
	//매칭된 대상 insert
	public void insertRecent(@Param("user_sendid")int user_sendid,@Param("user_receiveid")int user_receiveid);
	//대기방 삭제 event
	public int deleteWaitById(Wait wait);
}
