package com.project.user;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.project.user.bo.GoogleLoginBO;
import com.project.user.bo.MemberService;
import com.project.user.bo.NaverLoginBO;
import com.project.user.bo.UserBO;
import com.project.user.model.User;

@Controller
public class UserController {
	@Autowired
	private NaverLoginBO naverLoginBO;
	@Autowired
	private MemberService ms;
	@Autowired
	private GoogleLoginBO googleLoginBO;
	@Autowired
	private UserBO userBO;

	// 로그인 페이지
	@GetMapping("/user/sign-in")
	public String signIn() {
		return "/user/user";
	}

	// 회원가입 페이지
	@GetMapping("/user/sign-up")
	public String signUp() {
		return "/user/signup";
	}

	// 아이디 찾기 페이지
	@GetMapping("/user/id")
	public String id() {
		return "/user/id";
	}

	// 비밀번호 찾기 페이지
	@GetMapping("/user/pwd")
	public String pwd() {
		return "/user/pwd";
	}

	// 회원가입 추가정보 페이지
	@GetMapping("/user/signup_addition")
	public String signUpAdd() {
		return "/user/signup_addition";
	}

	// 약관 동의 페이지
	@GetMapping("/user/tos")
	public String tos() {
		return "/user/tos";
	}

	// 카카오로 로그인 접속
	@RequestMapping(value = "/oauth/kakao", method = RequestMethod.GET)
	public String kakaoLogin(@RequestParam(value = "code", required = false) String code, HttpSession session,
			Model model, @RequestParam Map<String, String> params, RedirectAttributes redirect) throws Exception {
		// String result = null;
		String access_Token = ms.getAccessToken(code);
		HashMap<String, Object> userInfo = ms.getUserInfo(access_Token);

		// 아이디
		Object id = (Object) userInfo.get("id");
		String loginid = String.valueOf(id);
		// 닉네임
		String userNickName = (String) userInfo.get("nickname");
		model.addAttribute("nickname", userNickName);
		model.addAttribute("loginid", loginid);
		if (userBO.isExistUser(loginid)) {
			User loginUser = userBO.getUserByLoginId(loginid);
			session.setAttribute("loginUser", loginUser);

			return "/main/main";
		} else {
			return "/user/kakaotos";
		}
	}

	// 카카오아이디로 로그인 하는사람 추가가입
	@GetMapping("/user/kakao")
	public String kakaoSignUp(@RequestParam("nickname") String nickname, @RequestParam("loginid") String loginid,
			Model model) {

		model.addAttribute("nickname", nickname);
		model.addAttribute("loginid", loginid);
		return "/user/kakaosignup";
	}

	// 카카오 메인화면 /추가정보 입력 페이지
	@GetMapping("/user/test")
	public String kakaoTest(@RequestParam("loginid") String loginid) {
		String result = null;
		int row = userBO.existingUserAddition(loginid);
//		if (row > 0) {
//			result = "/main/main";
//		} else if (row == 0) {
//
//			result = "/user/signup_addition";
//		}
//		return result;
		return "/main/main";
	}

	@RequestMapping(value = "/users/callback.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String Naver(@RequestParam(value = "code", required = false) String code, @RequestParam String state,
			HttpSession session, Model model, @RequestParam Map<String, String> params, RedirectAttributes redirect)
			throws IOException, ParseException {

		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);

		// 1. 로그인 사용자 정보를 읽어온다.
		String apiResult = naverLoginBO.getUserProfile(oauthToken); // String형식의 json데이터

		/**
		 * apiResult json 구조 {"resultcode":"00", "message":"success",
		 * "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
		 **/

		// 2. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;

		// 3. 데이터 파싱
		// Top레벨 단계 _response 파싱
		JSONObject response_obj = (JSONObject) jsonObj.get("response");
		// response의 nickname값 파싱
		String nickname = (String) response_obj.get("nickname");
		String loginid = (String) response_obj.get("id");
		String email = (String) response_obj.get("email");
		System.out.println(loginid);

		// 4.파싱 닉네임 세션으로 저장
		session.setAttribute("sessionId", loginid); // 세션 생성

		model.addAttribute("loginid", loginid);
		model.addAttribute("nickname", nickname);
		model.addAttribute("email", email);
		System.out.println("user-email ########### : " + email);
		
		if (userBO.isExistUser(loginid)) {
			User loginUser = userBO.getUserByLoginId(loginid);
			session.setAttribute("loginUser", loginUser);

			return "/main/main";
		} else {
			return "/user/navertos";
		}

	}
	
	@RequestMapping(value = "/redirect", method = { RequestMethod.GET, RequestMethod.POST })
	public String Google(@RequestParam(value = "code", required = false) String code, @RequestParam(value = "state", required = false) String state,
			HttpSession session, @RequestParam(value = "scope", required = false) String scope, Model model, @RequestParam Map<String, String> params, RedirectAttributes redirect)
			throws IOException, ParseException {
			OAuth2AccessToken access_Token = googleLoginBO.getAccessToken(session, code);
			//System.out.println("###############access" + access_Token);
			String token = access_Token.toString();
			System.out.println("$$$$$$$$$" + token);
			Pattern pattern = Pattern.compile("[=](.*?)[,]");
			String re = "";

			Matcher matcher = pattern.matcher(token);
			if (matcher.find()) {
				String answer = matcher.group(1);
				//System.out.println("++++++++++++++" + answer);

				  String reqURL = "https://www.googleapis.com/oauth2/v1/userinfo?alt=json&access_token="+answer;
				    //String reqURL = "https://www.googleapis.com/userinfo/v2/me?access_token=ya29.a0AVvZVsp9nJ8UrMT2bKU6LU1P9Bm7okrkadq37dOzD3ls7n0W9hWkKjC-IyXmxzBhA5QyLu5frwxZrnMe5XWIC4WOpZx-AYNJHU7zxhblwUVF1e-ntPrjWtmHkmE3hrvUoI-w7wJ_CB6Sr9Tkt3cRuyAFcrMGaCgYKAb8SARESFQGbdwaIprBJz81Q3Cpk4wCt56egkg0163";
				    
				        URL url = new URL(reqURL);
				        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

				        //요청에 필요한 Header에 포함될 내용
				        conn.setRequestProperty("Authorization", "Bearer " + access_Token);

				        int responseCode = conn.getResponseCode();
				        System.out.println("responseCode : "+responseCode);
					        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
					        
					        String line = "";
					        String result = "";
					        
					        while ((line = br.readLine()) != null) {
					            result += line;
					        }
					        JsonParser parser = new JsonParser();
					        System.out.println("result : "+result);
					        JsonElement element = parser.parse(result);
					        
					        String name = element.getAsJsonObject().get("name").getAsString();
					        String email = element.getAsJsonObject().get("email").getAsString();
					        String loginid = "GOOGLE_"+element.getAsJsonObject().get("id").getAsString();
					        System.out.println("##########eamil = " + email);
					        model.addAttribute("loginid", loginid);
							model.addAttribute("nickname", name);
							model.addAttribute("email", email);
							
							if (userBO.isExistUser(loginid)) {
								User loginUser = userBO.getUserByLoginId(loginid);
								session.setAttribute("loginUser", loginUser);
								re = "/main/main";
							} else {
								re = "/user/googletos";
							}
			}
			return re;
		  
	}		  
		    
	

	
	@GetMapping("/user/naver")
	public String kakaoSignUp(@RequestParam("nickname") String nickname, @RequestParam("loginid") String loginid,
			@RequestParam String email, Model model) {

		model.addAttribute("nickname", nickname);
		model.addAttribute("loginid", loginid);
		model.addAttribute("email", email);
		return "/user/naversignup";
	}
	@GetMapping("/user/google")
	public String googleSignUp(@RequestParam("nickname") String nickname, @RequestParam("loginid") String loginid,
			@RequestParam String email, Model model) {
		
		model.addAttribute("nickname", nickname);
		model.addAttribute("loginid", loginid);
		model.addAttribute("email", email);
		return "/user/googlesignup";
	}

	// 아이디 찾기
	@GetMapping("/user/id_find")
	public String idFind(@RequestParam("phonenumber") String phonenumber, @RequestParam("email") String email,
			Model model) {
		User findId = userBO.findId(phonenumber, email);

		model.addAttribute("findid", findId.getLoginid());
		model.addAttribute("nickname", findId.getNickname());
		return "/user/id";
	}
}