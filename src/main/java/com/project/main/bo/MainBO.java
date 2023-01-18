package com.project.main.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.main.dao.MainDAO;

@Service
public class MainBO {
@Autowired 
private MainDAO mainDAO;
	public int addWait(int user_id, String localid, String user_gender, String preference) {
		return mainDAO.insertWait(user_id, localid, user_gender, preference);
	}
}
