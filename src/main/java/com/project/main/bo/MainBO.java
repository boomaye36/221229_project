package com.project.main.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.main.dao.MainDAO;
import com.project.user.model.User;
import com.project.main.model.Wait;

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
	
	
	//대기방 삭제 event
	public int deleteWait(int user_receiveid, int user_sendid) {
		//wait 테이블에 있는지

		
		
		// recent 테이블에 양방향 insert
		mainDAO.insertRecent(user_sendid, user_receiveid);
		mainDAO.insertRecent(user_receiveid, user_sendid);
		//현재 로그인한 사람 delete
		int result = mainDAO.deleteWaitById(user_receiveid);
		if ( result > 0) {
			return result;
		} 
		return 0;
	}
}
