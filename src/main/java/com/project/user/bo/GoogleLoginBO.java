package com.project.user.bo;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.project.util.GoogleLoginApi;
@Service
public class GoogleLoginBO {
	private final static String CLIENT_ID = "233418186817-v6nlobapoh55eda8bsujrdiabo9p78d1.apps.googleusercontent.com";
	   private final static String CLIENT_SECRET = "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";
	   private final static String REDIRECT_URI = "http://localhost/redirect";
	   private final static String SESSION_STATE = "oauth_state";
	   
	   /* 네아로 인증 URL 생성 Method */
	   public String getAuthorizationUrl(HttpSession session) {

	      /* 세션 유효성 검증을 위하여 난수를 생성 */
	      String state = generateRandomString();
	      /* 생성한 난수 값을 session에 저장 */
	      setSession(session, state);

	      /* Scribe에서 제공하는 인증 URL 생성 기능을 이용하여 네아로 인증 URL 생성 */
	      OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID).apiSecret(CLIENT_SECRET)
	            .callback(REDIRECT_URI).state(state) // 앞서 생성한 난수값을 인증 URL생성시 사용함
	            .build(GoogleLoginApi.instance());

	      return oauthService.getAuthorizationUrl();
	   }

	   /* 네아로 Callback 처리 및 AccessToken 획득 Method */
	   public OAuth2AccessToken getAccessToken(HttpSession session, String code) throws IOException {

	      /* Callback으로 전달받은 세선검증용 난수값과 세션에 저장되어있는 값이 일치하는지 확인 */

	         OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID).apiSecret(CLIENT_SECRET)
	               .callback(REDIRECT_URI).build(GoogleLoginApi.instance());

	         /* Scribe에서 제공하는 AccessToken 획득 기능으로 네아로 Access Token을 획득 */
	         OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
	         return accessToken;
	     
	   }

	   /* 세션 유효성 검증을 위한 난수 생성기 */
	   private String generateRandomString() {
	      return UUID.randomUUID().toString();
	   }

	   /* http session에 데이터 저장 */
	   private void setSession(HttpSession session, String state) {
	      session.setAttribute(SESSION_STATE, state);
	   }

	   /* http session에서 데이터 가져오기 */
	   private String getSession(HttpSession session) {
	      return (String) session.getAttribute(SESSION_STATE);
	   }

	   /* 프로필 조회 API URL */
	   private final static String PROFILE_API_URL = "https://people.googleapis.com/v1/contactGroups";
	   
	   public String getUserProfile(OAuth2AccessToken oauthToken) throws IOException {

		      OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID).apiSecret(CLIENT_SECRET)
		            .callback(REDIRECT_URI).build(GoogleLoginApi.instance());

		      OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL, oauthService);
		      oauthService.signRequest(oauthToken, request);
		      Response response = request.send();
		      return response.getBody();
		   }
	   
	   public void getGoogleUserInfo(String access_Token) {
			 //요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
		    HashMap<String, Object> googleUserInfo = new HashMap<>();
		    //String reqURL = "https://www.googleapis.com/oauth2/v1/userinfo?alt=json&access_token="+access_Token;
		    String reqURL = "https://www.googleapis.com/userinfo/v2/me?access_token="+access_Token;
		    try {
		        URL url = new URL(reqURL);
		        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

		        //요청에 필요한 Header에 포함될 내용
		        conn.setRequestProperty("Authorization", "Bearer " + access_Token);

		        int responseCode = conn.getResponseCode();
		        System.out.println("responseCode : "+responseCode);
		        if(responseCode == 200){
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
			        String id = "GOOGLE_"+element.getAsJsonObject().get("id").getAsString();
			        
			        googleUserInfo.put("name", name);
			        googleUserInfo.put("email", email);
			        googleUserInfo.put("id", id);
			        
			        System.out.println("login Controller : " + googleUserInfo);
		        }
		    } catch (IOException e) {
		        e.printStackTrace();
		    }
	   }
}
