package com.project.main.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.main.dao.MainDAO;
import com.project.main.model.Wait;

@Service
public class MainBO {
	@Autowired 
	private MainDAO mainDAO;
	
	
	
	//대기방 추가 event
	public Wait addWait(Wait wait) {
		
		//조건 event
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
}
