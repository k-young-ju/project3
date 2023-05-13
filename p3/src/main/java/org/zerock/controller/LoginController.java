package org.zerock.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LoginController {
		@PostMapping("/login")
		public String loginPost(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		String clientId = "snwIq2rIuigoLPb9h3Lk";//애플리케이션 클라이언트 아이디값";
	    String clientSecret = "xXv3nlKR4G";//애플리케이션 클라이언트 시크릿값";
	    String code = request.getParameter("code");
	    String state = request.getParameter("state");
	    String redirectURI = URLEncoder.encode("http://localhost:8080/member/login", "UTF-8");
	    String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
	        + "&client_id=" + clientId
	        + "&client_secret=" + clientSecret
	        + "&redirect_uri=" + redirectURI
	        + "&code=" + code
	        + "&state=" + state;
	    String accessToken = "";
	    String refresh_token = "";
	    try {
	      URL url = new URL(apiURL);
	      HttpURLConnection con = (HttpURLConnection)url.openConnection();
	      con.setRequestMethod("post");
	      int responseCode = con.getResponseCode();
	      BufferedReader br;
	      if (responseCode == 200) { // 정상 호출
	        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	      } else {  // 에러 발생
	        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	      }
	      PrintWriter out = response.getWriter();
	      String inputLine;
	      StringBuilder res = new StringBuilder();
	      while ((inputLine = br.readLine()) != null) {
	        res.append(inputLine);
	      }
	      br.close();
	      if (responseCode == 200) {
	        out.println(res.toString());
	        System.out.println(res.toString());
	      }
	    } catch (Exception e) {
	      // Exception 로깅
	    }
	    return "";
	}
	
}
