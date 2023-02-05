package com.project.config;

import org.springframework.context.event.EventListener;
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

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.socket.messaging.SessionConnectEvent;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@ServerEndpoint("/websocket/{room}")


public class MessageController {
	
	
	
	 //private static final List<Map<String, Object>> sessionList = new ArrayList<Map<String, Object>>();
	 
	private static Map<String, List<Object>> sessionMap = new HashMap<>();
	
	 
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
/*	        Map<String, Object> map = new HashMap<String, Object>();
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
*/
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
	    	// 세션리스트에서 유저 찾아서 삭제해야함 
	    	
/*
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
*/
	    	List<Object> users = sessionMap.get(room);
	    	users.remove(closeUser);
	    	int roomSize = users.size();
	    	if (roomSize == 0 ) {
	    		sessionMap.remove(room);
	    	}
	        System.out.println(room + "방의 현재 접속중인 유저 수 : " + roomSize);
	    }

	    
	    
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
						sess.getBasicRemote().sendText( msgMap.get("id") +" : "+ content);
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
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

/*	    
	    // 세션 저장 구조가 바꼈으므로 수정 필요
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
	    
=======
*/
}
