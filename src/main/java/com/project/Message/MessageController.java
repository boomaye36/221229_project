package com.project.Message;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@ServerEndpoint("/websocket/{room}")


public class MessageController {
	
	private static final Map<String, List<Object>> sessionMap = new HashMap<>();
	
	 
	    public MessageController() {
//	        this.isSessionClosed();
	    }
	    
	    
	    @GetMapping("/test/{room}")
	    public String index() {
	    	
	        return "/main/index";
	    }

	    @OnOpen
	    public void open(Session newUser, @PathParam("room") String room) {
	        System.out.println("connected");
	        if ( ! sessionMap.containsKey(room)) {
	        	List<Object> users = new ArrayList<>();
	        	users.add(newUser);
	        	sessionMap.put(room, users);
	        } else {
	        	List<Object> users = sessionMap.get(room);
	        	users.add(newUser);
	        }
	        
	        int roomSize = sessionMap.get(room).size();

	        System.out.println(room + "방의 현재 접속중인 유저 수 : " + roomSize);
	        System.out.println(sessionMap);
	    }
	    
	    @OnClose
	    public void close(Session closeUser,  @PathParam("room") String room) {
	    	System.out.println("closed");
	    	List<Object> users = sessionMap.get(room);
	    	users.remove(closeUser);
	    	int roomSize = users.size();
	    	if (roomSize == 0 ) {
	    		sessionMap.remove(room);
	    	}
	        System.out.println(room + "방의 현재 접속중인 유저 수 : " + roomSize);
	    }

	    
	    
	    @SuppressWarnings("unchecked")
		public Map<String, String> msgConvert(String msg){
	    	ObjectMapper mapper = new ObjectMapper();
	    	Map<String, String> msgMap = new HashMap<>();
			try {
				msgMap = mapper.readValue(msg, Map.class);
			} catch (JsonMappingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JsonProcessingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    	return msgMap;
	    }
	    
	    @OnMessage
	    public void getMsg(Session recieveSession, String msg, @PathParam("room") String room) throws JsonMappingException, JsonProcessingException {
	    	
	    	Map<String, String> msgMap = msgConvert(msg);
	    	
	    	System.out.println(msg);
	    	String content = msgMap.get("content");
	    	System.out.println(content);
	    	
	    	List<Object> sessionList = sessionMap.get(room);
	    	
	    	
	    	for (int i = 0; i < sessionList.size(); i++) {
	        	
	        	
		        	Session sess = (Session) sessionList.get(i);
		        	// 추가 수정 필요
		        	try {
		        		sess.getBasicRemote().sendText( msg);
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
	        }
	    }

	    // 일정 시간마다 세션 전체에서 닫혀있는 세션이 삭제되지 않았는지 확인
	    @Scheduled(cron = "0 0/10 * * * *")
	    private void isSessionClosed() {
	        if (sessionMap.size() != 0) {
	            try {
	                System.out.println("! = " + sessionMap.size());
	                
	                Iterator<Map.Entry<String, List<Object>>> it = sessionMap.entrySet().iterator();
	                while (it.hasNext()) {
	                	String keyValue = it.next().getKey();
	                    List<Object> sessionList = it.next().getValue();
	                    int closeSess = 0;
	                    for (int i = 0; i < sessionList.size(); i++) {
	                    	Session sess = (Session)sessionList.get(i);
	                    	if (! sess.isOpen()) {
	                    		closeSess ++;
	                    	}
	                    }
	                    if (sessionList.size() == closeSess) {
	                    	System.out.println(keyValue + "방 삭제");
	                    	it.remove();
	                    }
	                }
	                
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        }
	    }
	    
}

	    

