package com.project.main.dao;

import org.springframework.stereotype.Repository;
import com.project.main.model.Wait;

@Repository
public interface MainDAO {
	
	
	//대기방 추가 event
	public int insertWait(Wait wait);
	
	//대기방 조건확인 event
	public Wait selectWaitByGender(Wait wait);
}
