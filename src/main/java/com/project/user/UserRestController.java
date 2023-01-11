package com.project.user;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.*;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.project.common.EncryptUtils;
import com.project.user.bo.UserBO;
import com.project.user.model.User;

@RestController
@RequestMapping("/user")
public class UserRestController {

	@Autowired
	private UserBO userBO;

	@RequestMapping("/is_duplicated_id")
	public Map<String, Object> isDuplicatedId(@RequestParam("user_loginid") String user_loginid) {
		Map<String, Object> result = new HashMap<>();
		int existRowCount = userBO.existingLoginId(user_loginid);
		if (existRowCount > 0) {
			result.put("result", true);
			result.put("code", 100);
		} else {
			result.put("errorMessege", false);
			result.put("code", 400);
		}
		return result;
	}

	@PostMapping("/user_insert")
	public Map<String, Object> addUser(@RequestParam("user_loginid") String user_loginid,
			@RequestParam("user_password") String user_password, @RequestParam("user_nickname") String user_nickname,
			@RequestParam("user_phonenumber") String user_phonenumber, @RequestParam("user_gender") String user_gender,
			@RequestParam("user_email") String user_email, HttpSession session

	) {

		String encryptPassword = EncryptUtils.md5(user_password);

		Map<String, Object> result = new HashMap<>();
		userBO.addUser(user_loginid, encryptPassword, user_nickname, user_gender, user_email, user_phonenumber);
		result.put("code", 100);
		return result;
	}

	@PostMapping("/sign_in")
	public Map<String, Object> signIn(@RequestParam("user_loginid") String user_loginid,
			@RequestParam("user_password") String user_password, HttpSession session) {

		String encryptPassword = EncryptUtils.md5(user_password);

		Map<String, Object> result = new HashMap<>();
		User user = userBO.getUserByLoginIdAndPassword(user_loginid, encryptPassword);
		if (user != null) {
			result.put("code", 100);
			session.setAttribute("user_loginid", user.getUser_loginid());
			session.setAttribute("user_id", user.getId());

		} else {
			result.put("code", 400);
		}
		return result;
	}
	@PostMapping("/user_update")
	public Map<String, Object> userUpdate(@RequestParam("user_birth") Date user_birth,HttpSession session,
			@RequestParam("user_area") String user_area,
			@RequestParam("user_intro") String user_intro,
			@RequestParam("user_profilephoto") MultipartFile user_profilephoto){
		Map<String, Object> result = new HashMap<>();
		Integer user_id = (Integer) session.getAttribute("user_id");
		System.out.println("user_birth ################" + user_birth);
		userBO.UpdateUser(user_birth, user_area, user_intro, user_profilephoto, user_id);
		result.put("code", 100);
		return result;

	}
//	@PostMapping("/phoneAuth")
//	public Boolean phoneAuth(String tel) {
//
//	    try { // 이미 가입된 전화번호가 있으면
//	        if(memberService.memberTelCount(tel) > 0) 
//	            return true; 
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	    }
//
//	    String code = memberService.sendRandomMessage(tel);
//	    session.setAttribute("rand", code);
//	    
//	    return false;
//	}
//
//	@PostMapping("/phoneAuthOk")
//	public Boolean phoneAuthOk() {
//	    String rand = (String) session.getAttribute("rand");
//	    String code = (String) request.getParameter("code");
//
//	    System.out.println(rand + " : " + code);
//
//	    if (rand.equals(code)) {
//	        session.removeAttribute("rand");
//	        return false;
//	    } 
//
//	    return true;
//	}
	@PostMapping("/sendMessage")
	public Map<String, Object> sendSMS(@RequestParam("user_phonenumber")String phoneNumber, HttpSession session) {
		String confirmNo = userBO.sendRandomMessage(phoneNumber);
		session.setAttribute("confirmNo", confirmNo);
		
		Map<String, Object> result = new HashMap<>();
		result.put("code", 100);
		return result;
	}
	
	@PostMapping("/confirmMessage")
	public Map<String, Object> confirmSMS(@RequestParam("pnconfirm")String pnconfirm, @RequestParam("user_phonenumber")String phoneNumber, HttpSession session) {
	    String confirmNo = (String) session.getAttribute("confirmNo");

		
		Map<String, Object> result = new HashMap<>();
		if (pnconfirm.equals(confirmNo)) {
			result.put("code", 100);
			session.removeAttribute("confirmNo");

		}else {
			result.put("code", 400);
		}
		return result;
	}
	
	@RequestMapping(value = "/login/getKakaoAuthUrl")
	public @ResponseBody String getKakaoAuthUrl(
			HttpServletRequest request) throws Exception {
		String reqUrl = 
				"https://kauth.kakao.com/oauth/authorize"
				+ "?client_id=418dc386faffd1f38a0fc71c77f2a8b4"
				+ "&redirect_uri=https://localhost:8080/user/login"
				
				+ "&response_type=code";
		
		return reqUrl;
	}
	
	// 카카오 연동정보 조회
	@RequestMapping(value = "/login/oauth_kakao")
	public String oauthKakao(
			@RequestParam(value = "code", required = false) String code
			, Model model) throws Exception {

		System.out.println("#########" + code);
        String access_Token = getAccessToken(code);
        System.out.println("###access_Token#### : " + access_Token);
        
        
        HashMap<String, Object> userInfo = getUserInfo(access_Token);
        System.out.println("###access_Token#### : " + access_Token);
        System.out.println("###userInfo#### : " + userInfo.get("email"));
        System.out.println("###nickname#### : " + userInfo.get("nickname"));
       
        JSONObject kakaoInfo =  new JSONObject(userInfo);
        model.addAttribute("kakaoInfo", kakaoInfo);
        
        return "/home"; //본인 원하는 경로 설정
	}
	
    //토큰발급
	public String getAccessToken (String authorize_code) {
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        try {
            URL url = new URL(reqURL);

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //  URL연결은 입출력에 사용 될 수 있고, POST 혹은 PUT 요청을 하려면 setDoOutput을 true로 설정해야함.
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            //	POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=418dc386faffd1f38a0fc71c77f2a8b4");  //본인이 발급받은 key
            sb.append("&redirect_uri=https://localhost:8080/user/login");     // 본인이 설정해 놓은 경로
            sb.append("&code=" + authorize_code);
            bw.write(sb.toString());
            bw.flush();

            //    결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            //    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);

            br.close();
            bw.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return access_Token;
    }
	
    //유저정보조회
    public HashMap<String, Object> getUserInfo (String access_Token) {

        //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
        HashMap<String, Object> userInfo = new HashMap<String, Object>();
        String reqURL = "https://kapi.kakao.com/v2/user/me";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            //    요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

            String nickname = properties.getAsJsonObject().get("nickname").getAsString();
            String email = kakao_account.getAsJsonObject().get("email").getAsString();
            
            userInfo.put("accessToken", access_Token);
            userInfo.put("nickname", nickname);
            userInfo.put("email", email);

        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return userInfo;
    }
}