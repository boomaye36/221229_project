package com.project.main;

import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.common.StringUtil;
import com.project.main.bo.MainBO;
import com.project.main.model.Friend;
import com.project.main.model.Recent;
import com.project.user.bo.UserBO;
import com.project.user.model.User;

@Controller
public class MainController {
	@Autowired
	private UserBO userBO;

	@Autowired
	private MainBO mainBO;

	// 메인페이지
	@GetMapping("/main")
	public String main(HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		model.addAttribute("loginUser", loginUser);
		return "/main/main";
	}

	// 랜덤통화
	@GetMapping("/call")
	public String call(Recent recent, Model model, HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");
		recent.setUser_sendid(loginUser.getId());

		List<User> list = mainBO.getRecentUserBySendId(recent);
		model.addAttribute("list", list);
		return "/main/call";
	}

	// 친구추천
	@GetMapping("/recommend")
	public String recommend(HttpSession session, Model model) {
		User user = (User) session.getAttribute("loginUser");
		int id = user.getId();
		List<User> userList = mainBO.getUserList(id);
		model.addAttribute("userList", userList);
		return "/main/recommend";
	}

	// 라운지(친구목록)
	@GetMapping("/lounge")
	public String friend(HttpSession session, Model model) {
		User user = (User) session.getAttribute("loginUser");
		int id = user.getId();
		List<User> requestList = mainBO.getFriend(id);
		List<User> friendList = mainBO.getRealFriend(id);
		model.addAttribute("requestList", requestList);
		model.addAttribute("friendList", friendList);

		return "/main/lounge";
	}
	
    @GetMapping(value={"/lounge/chat/{room}","/lounge/chat/"})
    public String Chat(HttpSession session, Model model,
    		@PathVariable("room") Optional<String> room) {
    	User user = (User) session.getAttribute("loginUser");
		int id = user.getId();
		List<User> requestList = mainBO.getFriend(id);
		List<User> friendList = mainBO.getRealFriend(id);
		model.addAttribute("requestList", requestList);
		model.addAttribute("friendList", friendList);
		
		// Optional 로 받은 room id가 null이 아닌 숫자인지 확인 후 int 변환
		String StringRoomNumber = room.orElse("");
		if (StringRoomNumber == "" || ! StringUtil.isNumeric(StringRoomNumber)) {
			return "redirect:/lounge";
		} 
		int roomNum = Integer.parseInt(StringRoomNumber);
		
		// room id 로 friend 테이블 호출 > 
		// 채팅 방 넘버와 접속된 유저 확인 - 채팅방이 없거나 내 userid가 채팅방에 맞지 않다면 리다이렉트
		Friend friend = mainBO.getFriendById(roomNum);
		
		int opponentId = 0;
		if (ObjectUtils.isEmpty(friend)) {
			return "redirect:/lounge";
		} else if (id ==friend.getUser_sendid()) {
			opponentId = friend.getUser_receiveid();
		} else if (id == friend.getUser_receiveid()){
			opponentId = friend.getUser_sendid();
		} else {
			return "redirect:/lounge";
		}
		model.addAttribute("opponentId", opponentId);
		
        return "/main/chat";
    }


	// 내정보
	@GetMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		User user = (User) session.getAttribute("loginUser");
		model.addAttribute("user", user);

		return "/main/mypage";
	}

	// 내정보 수정
	@GetMapping("/mypage/user")
	public String mypageUser(HttpSession session, Model model) {
		User user = (User) session.getAttribute("loginUser");
		model.addAttribute("user", user);

		return "/main/mypage_user";
	}

	// 비밀번호 수정
	@GetMapping("/mypage/pwd")
	public String mypagePwd(HttpSession session, Model model) {
		User user = (User) session.getAttribute("loginUser");
		model.addAttribute("user", user);

		return "/main/mypage_pwd";
	}

	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {

		session.removeAttribute("loginUser");
		return "redirect:/user/sign-in";
	}

	// 영상통화 테스트
	
	 @RequestMapping("/calltest") 
	 public String test() { 
	
		 return "/main/test"; 
	}
	 
	 // SSE 테스트
	 @RequestMapping("/ssetest")
	 public String ssetest() {
		 return "/main/sse_test";
	 }
	 
}
