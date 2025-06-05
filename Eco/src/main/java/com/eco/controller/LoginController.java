package com.eco.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
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
	// Google OAuth2 Info
	private final String CLIENT_ID = "851862848030-5533gqa556ubk6f09hqicorf10jnvsk3.apps.googleusercontent.com";
	private final String CLIENT_SECRET = "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";
	private final String REDIRECT_URI = "http://localhost:8080/login/oauth2callback";
	// Naver OAuth2 Info
    private final String NAVER_CLIENT_ID = "6WfWa8u2QHh5FValpecg";
    private final String NAVER_CLIENT_SECRET = "460jNBxXnU";
    private final String NAVER_REDIRECT_URI = "http://localhost:8080/login/oauth2/callback/naver";

	// @Value("${google.client.id}")
	// private String CLIENT_ID;
	// @Value("${google.client.secret}")
	// private String CLIENT_SECRET;
	// @Value("${google.redirect.uri}")
	// private String REDIRECT_URI;

	@GetMapping("")
	public void loginPage() {
		log.info("login Page");
	}

	@PostMapping("")
	public String loginPost(UserVO user, HttpSession session) {
		UserVO rtnUser = service.login(user);
		if (rtnUser != null) {
			// 로그인 처리
			session.setAttribute("currentUserInfo", rtnUser);
			log.info("web login");
			return "redirect: /";
		} else {
			// 재로그인 처리
			return "login";
		}
	}

	// # 구글 로그인 start --------------------------------------------------------
	// 1. 사용자 로그인 URL을 반환
	@GetMapping("/googleLogin")
	public void googleLogin(HttpServletResponse response) throws IOException {
		String oauthUrl = "https://accounts.google.com/o/oauth2/v2/auth" + "?scope=email%20profile"
				+ "&access_type=offline" + "&include_granted_scopes=true" + "&response_type=code" + "&client_id="
				+ CLIENT_ID + "&redirect_uri=" + REDIRECT_URI + "&prompt=select_account";
		response.sendRedirect(oauthUrl);
	}

	// 2. 예외 처리
	@GetMapping("/oauth2callback")
	public String oauth2Callback(@RequestParam("code") String code, HttpSession session) throws IOException {
		// 2-1. code 로 access_token 발급
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

		// 2-2. access_token 으로 사용자 정보 조회
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
		String type = "G";
		
		// 2-3. DB 조회 후 사용자 등록 또는 수정
		UserVO user = service.findByUserId(email, type);
		if (user == null) {
			user = new UserVO();
			user.setUser_id(email);
			user.setUser_pw(""); // 마이 페이지 가입자 로그인
			user.setUser_nm(name);
			user.setUse_yn('Y');
			user.setUser_type("G");
			user.setUser_local("서울");
			service.signup(user);
			log.info("Google Signup");
		}

		// 2-4. 로그인 처리
		session.setAttribute("currentUserInfo", user);
		log.info("Google Login");
		return "redirect: /"; // 로그인 후 이동할 페이지 설정
	}
	// # 구글 로그인 End --------------------------------------------------------

	// # Naver Login Start ---------------------------------------------------
	// 네이버 로그인 페이지로 리다이렉트
    @GetMapping("/naverLogin")
    public void naverLogin(HttpServletResponse response) throws IOException {
        String state = UUID.randomUUID().toString();  // CSRF 방지용 랜덤 문자열
        String redirectURI = URLEncoder.encode(NAVER_REDIRECT_URI, "UTF-8");

        String naverAuthUrl = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
                + "&client_id=" + NAVER_CLIENT_ID
                + "&redirect_uri=" + redirectURI
                + "&state=" + state + "&prompt=login";

        response.sendRedirect(naverAuthUrl);
    }

	// 2. 콜백 처리 - code와 state 받음
    @GetMapping("/oauth2/callback/naver")
    public String naverCallback(@RequestParam("code") String code,
                                @RequestParam("state") String state,
                                HttpSession session) throws IOException {
        // 1. access_token 요청 URL 생성
		String tokenUrl = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
    	        + "&client_id=" + NAVER_CLIENT_ID
    	        + "&client_secret=" + NAVER_CLIENT_SECRET
    	        + "&code=" + code
    	        + "&state=" + state
    	        + "&redirect_uri=" + URLEncoder.encode(NAVER_REDIRECT_URI, "UTF-8");

        URL url = new URL(tokenUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) {
            sb.append(line);
        }
        br.close();

        JSONObject json = new JSONObject(sb.toString());
        String accessToken = json.getString("access_token");

        // 2. access_token으로 사용자 정보 조회
        URL userInfoUrl = new URL("https://openapi.naver.com/v1/nid/me");
        HttpURLConnection userConn = (HttpURLConnection) userInfoUrl.openConnection();
        userConn.setRequestMethod("GET");
        userConn.setRequestProperty("Authorization", "Bearer " + accessToken);

        BufferedReader userBr = new BufferedReader(new InputStreamReader(userConn.getInputStream()));
        StringBuilder userSb = new StringBuilder();
        String userLine;
        while ((userLine = userBr.readLine()) != null) {
            userSb.append(userLine);
        }
        userBr.close();

        JSONObject userInfoJson = new JSONObject(userSb.toString());
        JSONObject responseJson = userInfoJson.getJSONObject("response");

        String email = responseJson.getString("email");
        String name = responseJson.getString("name");
        String type = "N";
        // 3. DB 사용자 조회 및 등록 또는 수정
        UserVO user = service.findByUserId(email, type);
        if (user == null) {
            user = new UserVO();
            user.setUser_id(email);
            user.setUser_pw("");  // 소셜로그인 비밀번호는 빈 문자열로 처리
            user.setUser_nm(name);
            user.setUse_yn('Y');
            user.setUser_type("N");
			user.setUser_local("서울");
            service.signup(user);
            log.info("Naver Signup");
        }

        // 4. 세션에 로그인 정보 저장
        session.setAttribute("currentUserInfo", user);
        log.info("Naver Login");
        return "redirect:/"; // 로그인 후 이동할 페이지
    }
	// # Naver Login End ---------------------------------------------------

    // 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 무효화
        return "redirect:/";  // 홈이나 로그인 페이지로 이동
    }
}
