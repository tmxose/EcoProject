package com.eco.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.eco.domain.UserVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OAuthServiceImpl implements OAuthService {
	@Value("${google.client.id}")
	private String clientId;

	@Value("${google.client.secret}")
	private String clientSecret;

	@Value("${google.redirect.uri}")
	private String redirectUri;

	private final UserService userService; // UserVO 관련 서비스

	// 구글 로그인 URL
	@Override
	public String getGoogleLoginUrl() {
		return "https://accounts.google.com/o/oauth2/v2/auth" + "?scope=email%20profile" + "&access_type=offline"
				+ "&include_granted_scopes=true" + "&response_type=code" + "&client_id=" + clientId + "&redirect_uri="
				+ redirectUri + "&prompt=select_account";
	}

	@Override
	public UserVO processGoogleLogin(String code) {
		try {
			// 1. Access Token 요청
			URL url = new URL("https://oauth2.googleapis.com/token");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			String data = "code=" + code + "&client_id=" + clientId + "&client_secret=" + clientSecret
					+ "&redirect_uri=" + redirectUri + "&grant_type=authorization_code";

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

			// 2. 사용자 정보 요청
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

			// 3. 사용자 DB 처리
			String type = "G";
			UserVO user = userService.findByUserId(email, type);
			if (user == null) {
				user = new UserVO();
				user.setUser_id(email);
				user.setUser_pw("");
				user.setUser_nm(name);
				user.setUse_yn('Y');
				user.setUser_type("G");
				user.setUser_local("서울");
				user.setUser_email(email);
				userService.signup(user);
			}

			return user;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}
