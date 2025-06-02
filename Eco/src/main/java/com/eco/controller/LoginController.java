package com.eco.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.eco.domain.UserVO;
import com.eco.service.UserService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/login")
public class LoginController {

	private UserService service;
	// Google OAuth2 ����
	private final String CLIENT_ID = "851862848030-5533gqa556ubk6f09hqicorf10jnvsk3.apps.googleusercontent.com";
	private final String CLIENT_SECRET = "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";
	private final String REDIRECT_URI = "http://localhost:8080/login/oauth2callback";

	// @Value("${google.client.id}")
//	private String CLIENT_ID;
//	@Value("${google.client.secret}")
//	private String CLIENT_SECRET;
//	@Value("${google.redirect.uri}")
//	private String REDIRECT_URI;

	@GetMapping("")
	public void loginPage() {
		log.info("login form");
	}

	@PostMapping("")
	public String loginPost(UserVO user, HttpSession session) {
		UserVO rtnUser = service.login(user);
		if (rtnUser == null) {
			// 로그인 처리
			session.setAttribute("currentUserInfo", rtnUser);
			log.info(rtnUser.getUser_nm());
			return "redirect: /usage";
		} else {
			// 재로그인 처리
			return "login";
		}
	}

	// 1. 사용자 로그인 URL을 반환
	@GetMapping("/googleLogin")
	public void googleLogin(HttpServletResponse response) throws IOException {
		String oauthUrl = "https://accounts.google.com/o/oauth2/v2/auth" + "?scope=email%20profile"
				+ "&access_type=offline" + "&include_granted_scopes=true" + "&response_type=code" + "&client_id="
				+ CLIENT_ID + "&redirect_uri=" + REDIRECT_URI;
		response.sendRedirect(oauthUrl);
	}

	// 2. 예외 처리
	@GetMapping("/oauth2callback")
	public String oauth2Callback(@RequestParam("code") String code, HttpSession session) throws IOException {
		// 2-1. code �� access_token ��û
		String tokenUrl = "https://oauth2.googleapis.com/token";
		URL url = new URL(tokenUrl);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setDoOutput(true);

		String data = "code=" + code + "&client_id=" + CLIENT_ID + "&client_secret=" + CLIENT_SECRET + "&redirect_uri="
				+ REDIRECT_URI + "&grant_type=authorization_code";

		OutputStream os = conn.getOutputStream();
		os.write(data.getBytes());
		os.flush();
		os.close();

		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = br.readLine()) != null)
			sb.append(line);
		br.close();

		JSONObject json = new JSONObject(sb.toString());
		String accessToken = json.getString("access_token");

		// 2-2. access_token ���� ���� ���� ��û
		URL userInfoUrl = new URL("https://www.googleapis.com/oauth2/v2/userinfo?access_token=" + accessToken);
		HttpURLConnection userConn = (HttpURLConnection) userInfoUrl.openConnection();
		BufferedReader userReader = new BufferedReader(new InputStreamReader(userConn.getInputStream()));
		StringBuilder userSb = new StringBuilder();
		String userLine;
		while ((userLine = userReader.readLine()) != null)
			userSb.append(userLine);
		userReader.close();

		JSONObject userInfo = new JSONObject(userSb.toString());
		String email = userInfo.getString("email");
		String name = userInfo.getString("name");

		// 2-3. DB ��ȸ �� ���� ó��
		UserVO user = service.findByUserId(email);
		if (user == null) {
			user = new UserVO();
			user.setUser_id(email);
			user.setUser_pw(""); // 마이 페이지 가입자 로그인
			user.setUser_nm(name);
			user.setUse_yn('Y');
			service.signup(user);
		}

		// 2-4. ���� ����
		session.setAttribute("currentUserInfo", user);
		return "redirect: /"; // �α��� �� �̵��� ������
	}
}
