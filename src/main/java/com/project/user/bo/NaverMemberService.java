package com.project.user.bo;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Service;
@Service
public class NaverMemberService {

	public String getAccessToken (String authorize_code) throws ParseException {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://nid.naver.com/oauth2.0/token";

		try {
			URL url = new URL(reqURL);
            
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			// POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			// POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
            
			sb.append("&client_id=HWYnGH9P3uPQNouoAvyz"); //본인이 발급받은 key
			sb.append("&client_secret=p5PxnzHE5w"); //본인이 발급받은 key
			sb.append("&redirect_uri=http://localhost/users/callback.do"); // 본인이 설정한 주소
            
			sb.append("&code=" + authorize_code);
			//sb.append("&code=8R0bZDtbFWpz3rlK8M");
			bw.write(sb.toString());
			bw.flush();
            
			// 결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
            
			// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
            
			while ((line = br.readLine()) != null) {
				result += line;
			}
            
			// Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
			JSONParser parser = new JSONParser();
			JSONObject object = (JSONObject) parser.parse(result);
			access_Token = (String) object.get("access_token");
			refresh_Token = (String) object.get("refresh_token");
            
			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return access_Token;
	}
	
	public HashMap<String, Object> getUserInfo(String access_Token) throws ParseException {

		// 요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
		String reqURL = "https://openapi.naver.com/v1/nid/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");

			// 요청에 필요한 Header에 포함될 내용
			conn.setRequestProperty("Authorization", "Bearer " + "AAAAN5J4wVtTrfsr0OIubSMYHZamWSlnSTiLGyOn4lnBHHl0rQ_KdCcQYDAgr14kSqBIfyb4xUquHGp76FUq_5YKQFg");
//AAAAN5J4wVtTrfsr0OIubSMYHZamWSlnSTiLGyOn4lnBHHl0rQ_KdCcQYDAgr14kSqBIfyb4xUquHGp76FUq_5YKQFg
			int responseCode = conn.getResponseCode();

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}

			JSONParser parser = new JSONParser();
			JSONObject element = (JSONObject) parser.parse(result);
			JSONObject properties = (JSONObject) element.get("properties");
			Object id = element.get("id");
			String nickname = (String) properties.get("nickname");
			
			userInfo.put("nickname", nickname);
			userInfo.put("id", id);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return userInfo;
	}
//	public void naverProfile() {
//        String token = "AAAAN5J4wVtTrfsr0OIubSMYHZamWSlnSTiLGyOn4lnBHHl0rQ_KdCcQYDAgr14kSqBIfyb4xUquHGp76FUq_5YKQFg";// 네이버 로그인 접근 토큰;
//           String header = "Bearer " + token; // Bearer 다음에 공백 추가
//           try {
//               String apiURL = "https://openapi.naver.com/v1/nid/me";
//               URL url = new URL(apiURL);
//               HttpURLConnection con = (HttpURLConnection)url.openConnection();
//               con.setRequestMethod("GET");
//               con.setRequestProperty("Authorization", header);
//               int responseCode = con.getResponseCode();
//               BufferedReader br;
//               if(responseCode==200) { // 정상 호출
//                   br = new BufferedReader(new InputStreamReader(con.getInputStream()));
//               } else {  // 에러 발생
//                   br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
//               }
//               String inputLine;
//               StringBuffer response = new StringBuffer();
//               while ((inputLine = br.readLine()) != null) {
//                   response.append(inputLine);
//               }
//               br.close();
//               System.out.println(response.toString());
//           } catch (Exception e) {
//               System.out.println(e);
//           }
//	}
}
