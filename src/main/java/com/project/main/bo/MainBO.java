package com.project.main.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.main.dao.MainDAO;
import com.project.main.model.Friend;
import com.project.main.model.Recent;
import com.project.main.model.Wait;
import com.project.user.model.User;

@Service
public class MainBO {
	@Autowired 
	private MainDAO mainDAO;
	
	
	
	//대기방 추가 event
	public Wait addWait(Wait wait) {
		
		//조건 event
		//wait 테이블에 있던 사람 
		Wait result = mainDAO.selectWaitByGender(wait);
		
		//조건에 null 일경우 대기방 추가
		if(result == null) {
			mainDAO.insertWait(wait);
		} 
		//조건이 null 아닌경우 받아온 값 컨트롤러로 리턴
		else {
			
			return result;
		}
		return null;
	}
	
	
	//recent 테이블 insert event
	public int insertRecent(Recent recent) {
		
		
		//현재 로그인한 사람 delete
		int result = mainDAO.deleteWaitById(recent.getUser_receiveid());
		
		// recent 테이블에 양방향 insert
		mainDAO.insertRecent(recent);
		
		if ( result > 0) {
			return result;
		} 
		return 0;
	}
	
	
	//대기방 대기열 delete 
	public int deleteWait(Wait wait) {
		return mainDAO.deleteWait(wait);
	}
	
	//페이지 아웃시 대기방 대기열 delete
	public int checkWait(int user_id) {
		
		int result = mainDAO.selectWaitByuserId(user_id);
		if (result > 0) {
			return mainDAO.deleteWaitByuserId(user_id);
		} else {
			return 0;
		}
	}
	
	
	
	//응답받는사람 기준으로 상대방 정보 가져오기
	public User recentCheck(int user_sendid) {
		
		return mainDAO.selectRecentCheck(user_sendid);
	}
	
	
	//매칭이력 event
	public List<User> getRecentUserBySendId(Recent recent) {
		
		return mainDAO.selectRecentUserBySendId(recent);
	}
	
	// 친구 추천 목록
	public List<User> getUserList(int id){
		return mainDAO.selectUserList(id);
	}
	
	// 친구 추가
	public int addFriend(int user_sendid, int user_receiveid) {
		return mainDAO.insertFriend(user_sendid, user_receiveid);
	}
	
	//친구 요청 목록
	public List<User> getFriend(int id){
		return mainDAO.selectFriend(id);
				
	}
	// 친구 목록 
	public List<User> getRealFriend(int id){
		return mainDAO.selectRealFriend(id);
	}
	// 친구 수락 / 거절 
	public int updateFriend(int user_id, String confirm) {
		return mainDAO.updateFriend(user_id, confirm);
	}
}
