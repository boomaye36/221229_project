package com.project.config;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@ServerEndpoint("/websocket/{room}")
public class MessageController {
	
	
	
	 private static final List<Map<String, Object>> sessionList = new ArrayList<Map<String, Object>>();
	 
	 
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
	        Map<String, Object> map = new HashMap<String, Object>();
			map.put("roomNum", room);
			map.put("session", newUser);
			sessionList.add(map);
			
	    	int roomSize = 0;
	    	for (Map<String, Object> size:sessionList) {
	    		String roomN = (String) size.get("roomNum");
	    		if (roomN.equals(room)) {
	    			roomSize ++;
	    		}
	    		
	    	}
	        System.out.println(room + "방의 현재 접속중인 유저 수 : " + roomSize);
	        System.out.println(sessionList);
	    }
	    
	    @OnClose
	    public void close(Session closeUser,  @PathParam("room") String room) {
	    	System.out.println("closed");
	    	// 세션리스트에서 유저 찾아서 삭제해야함 
	    	for (int i = 0; i < sessionList.size(); i++) {
	    		Map<String, Object> map = sessionList.get(i);
	    		Session sess = (Session) map.get("session");
	    		if (closeUser.equals(sess)) {
	    			if (map.get("roomNum").equals(room)) {
	    				sessionList.remove(map);
	    				break;
	    			}
	    		}
	    		sessionList.remove(map);
	    	}
	    	int roomSize = 0;
	    	for (Map<String, Object> size:sessionList) {
	    		String roomN = (String) size.get("roomNum");
	    		if (roomN.equals(room)) {
	    			roomSize ++;
	    		}
	    	}
	        System.out.println(room + "방의 현재 접속중인 유저 수 : " + roomSize);
	    }

	    @OnMessage
	    public void getMsg(Session recieveSession, String msg, @PathParam("room") String room) {
	    	
	        for (int i = 0; i < sessionList.size(); i++) {
	        	
	        	if (sessionList.get(i).get("roomNum").equals(room)) {
	        	
		        	Session sess = (Session) sessionList.get(i).get("session");
		        	// 추가 수정 필요
		        	try {
						sess.getBasicRemote().sendText( "나 : " + msg);
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
	        	}
				/*
				 * if (! recieveSession.getId().equals(session.get(i).getId())) { try {
				 * session.get(i).getBasicRemote().sendText("유저" +
				 * (Integer.parseInt(session.get(i).getId()) + 1) + " : " + msg); } catch
				 * (IOException e) { e.printStackTrace(); } } else { try {
				 * session.get(i).getBasicRemote().sendText("나 : " + msg); } catch (IOException
				 * e) { e.printStackTrace(); } }
				 */
	        }
	    }

	    @Scheduled(cron = "* * * * * *")
	    private void isSessionClosed() {
	        if (sessionList.size() != 0) {
	            try {
	                System.out.println("! = " + sessionList.size());
	                for (int i = 0; i < sessionList.size(); i++) {
	                	Session sess = (Session) sessionList.get(i).get("session");
	                    if (! sess.isOpen()) {
	                    	sessionList.remove(i);
	                    }
	                }
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        }
	    }
}
