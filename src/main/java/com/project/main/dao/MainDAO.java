package com.project.main.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.project.main.model.Recent;
import com.project.main.model.Wait;

import com.project.user.model.User;

@Repository
public interface MainDAO {


	//대기방 추가 event
	public int insertWait(Wait wait);
	
	//대기방 조건확인 event
	public Wait selectWaitByGender(Wait wait);
	
	//매칭된 대상 recent 테이블 insert
	public void insertRecent(Recent recent);
	
	//대기방 대기열 삭제 event
	public int deleteWait(Wait wait);
	
	//대기방 삭제 event
	public int deleteWaitById(@Param("user_receiveid") int user_receiveid);
	
	
	
	public int selectWaitByuserId(int user_id);
	
	public int deleteWaitByuserId(int user_id);
	
	//응답받는사람 기준으로 상대방 정보 가져오기
	public User selectRecentCheck(int user_sendid);
	
}
