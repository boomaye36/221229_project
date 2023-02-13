package com.project.Message.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.project.Message.model.Chat;
@Repository
public interface ChatDAO {

	public int insertChat(Chat chat);
	
	public List<Chat> selectChatList(@Param("userid") int userid, 
			@Param("opponentid") int opponentid,@Param("chatLogSize") int chatLogSize);
	
}
