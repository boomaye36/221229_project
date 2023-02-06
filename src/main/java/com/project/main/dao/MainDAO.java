package com.project.main.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.project.main.model.Friend;
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
	
	//매칭이력 event
	public List<User> selectRecentUserBySendId(Recent recent);
	
	public List<User> selectUserList(@Param("id")int id);

	public int insertFriend(@Param("user_sendid") int user_sendid, @Param("user_receiveid") int user_receiveid);


	public List<User> selectFriend(@Param("id")int id);
	
	public List<User> selectRealFriend(@Param("id") int id);

	
	public int updateFriend(@Param("user_id")int user_id, @Param("confirm")String confirm);

	
	public int insertBlock(@Param("user_sendid") int user_sendid, @Param("user_receiveid") int user_receiveid);
	
	
	//친구인지 아닌지
	public Boolean selectCheckFriend(@Param("user_sendid") int user_sendid, @Param("user_receiveid") int user_receiveid);
	
	//친구 요청 보냈는지 아닌지
	public Boolean selectAskFriend(@Param("user_sendid") int user_sendid, @Param("user_receiveid") int user_receiveid);
	
	
	

}
