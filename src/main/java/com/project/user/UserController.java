package com.project.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.project.user.bo.MemberService;

@Controller
public class UserController {
	
	@Autowired
	private MemberService ms;
	
	
	//로그인 페이지
	@GetMapping("/user/sign-in")
	public String signIn() {
		return "/user/user";
	}
	
	//회원가입 페이지
	@GetMapping("/user/sign-up")
	public String signUp() {
		return "/user/signup";
	}
	
	//아이디 찾기 페이지
	@GetMapping("/user/id")
	public String id() {
		return "/user/id";
	}
	
	//비밀번호 찾기 페이지
	@GetMapping("/user/pwd")
	public String pwd() {
		return "/user/pwd";
	}
	
	//회원가입 추가정보 페이지
	@GetMapping("/user/signup_addition")
	public String signUpAdd() {
		return "/user/signup_addition";
	}
	
	//약관 동의 페이지
	@GetMapping("/user/tos")
	public String tos() {
		return "/user/tos";
	}
	
	//카카오로 로그인 접속
	@RequestMapping(value="/oauth/kakao", method=RequestMethod.GET)
	public String kakaoLogin(@RequestParam(value = "code", required = false) String code, HttpSession session,Model model, 
			@RequestParam Map<String, String> params, RedirectAttributes redirect ) throws Exception {
			
		String access_Token = ms.getAccessToken(code);
		HashMap<String, Object> userInfo = ms.getUserInfo(access_Token);
			
		//아이디
		Object id = (Object) userInfo.get("id");
		String loginid = String.valueOf(id);
		//닉네임
		String userNickName = (String) userInfo.get("nickname");
		//이메일
		String userEmail = (String) userInfo.get("email");
		
		//redirect.addAttribute(kakaoId, params);	 
		//redirect.addAttribute(userNickName, params);	 
		String nickname = (String) userInfo.get("nickname");
			 
		/*
		//로그인하는 정보가 있는경우 메인페이지로 
		 int row = userBo.existKakaoUserByKakaoId(kakaoId); 
		 if ( row > 0) { 
			 User checkingUser = userBo.getKakaoUserByKakaoId(kakaoId);
			 session.setAttribute("loginUser", checkingUser); 
			 return "/main"; 
		 } else if (row == 0) { 
		 	Map<String, String> map = new HashMap<String, String>();
		 	map.put("kakaoId", kakaoId); map.put("userNickName", userNickName);
		 	map.put("userEmail", userEmail); redirect.addFlashAttribute("map", map);
		 	return "redirect:/user/sign-up/kakao"; 
		 }
		*/
		
		model.addAttribute("nickname", userNickName);
		model.addAttribute("loginid", loginid);
	
		return "/user/kakaosignup";
	}
	
	
	//카카오아이디로 로그인 하는사람 추가가입
	@RequestMapping("/user/sign-up/kakao")
	public String kakaoSignUp(@RequestParam Map<String, String> params,
				HttpServletRequest request, Model model) {
			
		Map<String, ?> result = RequestContextUtils.getInputFlashMap(request);
		params= (Map<String, String>) result.get("map");
		//String email = params.get("userEmail");
		String nickname = params.get("userNickName");
		String loginid = params.get("kakaoId");
			
		//model.addAttribute("userEmail", email);
		model.addAttribute("nickname", nickname);
		model.addAttribute("loginid", loginid);
		return "kakaosignup";
	}
}