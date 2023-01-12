package com.project.user;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.project.user.bo.MemberService;
import com.project.user.bo.NaverLoginBO;
import com.project.user.bo.NaverMemberService;
import com.project.user.bo.UserBO;

@Controller
public class UserController {
	@Autowired
	private NaverLoginBO naverLoginBO;
	@Autowired
	private MemberService ms;
	@Autowired
	private NaverMemberService naver;
	@Autowired
	private UserBO userBO;
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
		//String result = null;	
		String access_Token = ms.getAccessToken(code);
		HashMap<String, Object> userInfo = ms.getUserInfo(access_Token);
			
		//아이디
		Object id = (Object) userInfo.get("id");
		String loginid = String.valueOf(id);
		//닉네임
		String userNickName = (String) userInfo.get("nickname");
		model.addAttribute("nickname", userNickName);
		model.addAttribute("loginid", loginid);
		return "/user/kakaotos";
		
	}
	
	
	//카카오아이디로 로그인 하는사람 추가가입
	@GetMapping("/user/kakao")
	public String kakaoSignUp(@RequestParam ("nickname") String nickname, @RequestParam("loginid") String loginid,
				 Model model) {
			
		
			
		model.addAttribute("nickname", nickname);
		model.addAttribute("loginid", loginid);
		return "/user/kakaosignup";
	}
	//카카오 메인화면 /추가정보 입력 페이지
	@GetMapping("/user/test")
	public String kakaoTest(@RequestParam("loginid") String loginid) {
		String result = null;
		int row = userBO.existingUserAddition(loginid); 
		 if ( row > 0) { 
			 result =  "main/main"; 
		 } else if (row == 0) { 
			 
		 	result = "user/signup_addition"; 
		 }
		 return result;
	}
	
	@RequestMapping(value = "/user/naverlogin", method = { RequestMethod.GET, RequestMethod.POST })
    public String login(Model model, HttpSession session) {
        
        /* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
        
        //https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
        //redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
        System.out.println("네이버:" + naverAuthUrl);
        
        //네이버 
        model.addAttribute("url", naverAuthUrl);

        /* 생성한 인증 URL을 View로 전달 */
        return "user/naverlogin";
    }
	
//	@RequestMapping(value="/users/callback.do", method=RequestMethod.GET)
//	public String naverLogin(@RequestParam(value = "code", required = false) String code, HttpSession session,Model model, 
//			@RequestParam Map<String, String> params, RedirectAttributes redirect ) throws Exception {
//		//String result = null;	
//		String access_Token = naver.getAccessToken(code);
//		HashMap<String, Object> userInfo = naver.getUserInfo(access_Token);
//			
//		//아이디
//		Object id = (Object) userInfo.get("id");
//		String loginid = String.valueOf(id);
//		//닉네임
//		String userNickName = (String) userInfo.get("nickname");
//		model.addAttribute("nickname", userNickName);
//		model.addAttribute("loginid", loginid);
//		return "/user/kakaotos";
//		
//	}
//	@RequestMapping(value = "/users/callback.do", method = { RequestMethod.GET, RequestMethod.POST })
//    public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
//            throws IOException {
//		
//	    String apiResult = null;
//	    
//        System.out.println("여기는 callback");
//        OAuth2AccessToken oauthToken;
//        oauthToken = naverLoginBO.getAccessToken(session, code, state);
//        //로그인 사용자 정보를 읽어온다.
//        apiResult = naverLoginBO.getUserProfile(oauthToken);
//        System.out.println(naverLoginBO.getUserProfile(oauthToken).toString());
//        model.addAttribute("result", apiResult);
//        System.out.println("result"+apiResult);
//        return "user/kakaotos";
//	}
	
	@RequestMapping(value = "/users/callback.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String Naver(@RequestParam(value = "code", required = false) String code, @RequestParam String state, HttpSession session,Model model, 
			@RequestParam Map<String, String> params, RedirectAttributes redirect ) throws IOException,ParseException {
		//String result = null;	
//		String access_Token = naver.get(code);
//		HashMap<String, Object> userInfo = naver.getUserInfo(access_Token);
//			
//		//아이디
//		Object id = (Object) userInfo.get("id");
//		String loginid = String.valueOf(id);
//		//닉네임
//		String userNickName = (String) userInfo.get("nickname");
		System.out.println("여기는 callback");
		OAuth2AccessToken oauthToken;
        oauthToken = naverLoginBO.getAccessToken(session, code, state);
 
        //1. 로그인 사용자 정보를 읽어온다.
		String apiResult = naverLoginBO.getUserProfile(oauthToken);  //String형식의 json데이터
		
		/** apiResult json 구조
		{"resultcode":"00",
		 "message":"success",
		 "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
		**/
		
		//2. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		
		//3. 데이터 파싱 
		//Top레벨 단계 _response 파싱
		JSONObject response_obj = (JSONObject)jsonObj.get("response");
		//response의 nickname값 파싱
		String nickname = (String)response_obj.get("nickname");
		String loginid = (String)response_obj.get("id");
		String email = (String)response_obj.get("email");
		System.out.println(loginid);
		
		//4.파싱 닉네임 세션으로 저장
		session.setAttribute("sessionId",loginid); //세션 생성
		
		model.addAttribute("loginid", loginid);
		model.addAttribute("nickname", nickname);
		model.addAttribute("email", email);
	     
		return "/user/navertos";
		
	}
	@GetMapping("/user/naver")
	public String kakaoSignUp(@RequestParam ("nickname") String nickname, @RequestParam("loginid") String loginid,@RequestParam String email,
				 Model model) {
			
		
			
		model.addAttribute("nickname", nickname);
		model.addAttribute("loginid", loginid);
		model.addAttribute("email", email);
		return "/user/naversignup";
	}
}