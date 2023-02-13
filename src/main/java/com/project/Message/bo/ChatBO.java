package com.project.Message.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.Message.dao.ChatDAO;
import com.project.Message.model.Chat;

@Service
public class ChatBO {

	@Autowired
	private ChatDAO chatDAO;
	
	public int addChat(Chat chat) {
		return chatDAO.insertChat(chat);
	}
	
	private static final int chatLogSize = 10; 
	public List<Chat> getChatList(int userid, int opponentid){
		return chatDAO.selectChatList(userid, opponentid,chatLogSize);
	}
}
