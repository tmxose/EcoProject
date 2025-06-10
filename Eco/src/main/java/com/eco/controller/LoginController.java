package com.eco.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.eco.domain.UserVO;
import com.eco.service.OAuthService;
import com.eco.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequiredArgsConstructor
@RequestMapping("/login")
public class LoginController {
	
	//@Value 사용을위해 @AllArgsConstructor 주석 처리후 @RequiredArgsConstructor 생성
	// service객체에는 final 할당
	
	// 사용자 서비스
	private final UserService service;
	private final OAuthService oAuthService;
	 
	// Naver OAuth2 Info
    @Value("${naver.client.id}")
    private String NAVER_CLIENT_ID; 
    @Value("${naver.client.secret}")
    private String NAVER_CLIENT_SECRET;
    @Value("${naver.redirect.uri}")
    private String NAVER_REDIRECT_URI; 
        
    // 로그인 페이지 진입
	@GetMapping("")
	public String loginPage() {
		return "login";
	}

	// 로그인 버튼 클릭시 실행
	@PostMapping("")
	public String loginPost(UserVO user, HttpSession session, Model model) {
		UserVO rtnUser = service.login(user);
		if (rtnUser != null) {
			// 로그인 성공 처리
			session.setAttribute("currentUserInfo", rtnUser);
			return "redirect: /";
		} else { 
			// 로그인 실패 처리
	        model.addAttribute("errorMessage", "아이디 및 비밀번호가 틀립니다.");
			return "login";
		}
	}

	// # 구글 로그인 start --------------------------------------------------------
	// 1. 사용자 로그인 URL을 반환
	@GetMapping("/googleLogin")
	public void googleLogin(HttpServletResponse response) throws IOException {
		response.sendRedirect(oAuthService.getGoogleLoginUrl());
	}

	// 2. 예외 처리
	@GetMapping("/oauth2callback")
	public String oauth2Callback(@RequestParam("code") String code, HttpSession session) throws IOException {
        UserVO user = oAuthService.processGoogleLogin(code);
        if (user != null) {
            session.setAttribute("currentUserInfo", user);
        }
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
			user.setUser_email(email);
            service.signup(user);
        }

        // 4. 세션에 로그인 정보 저장
        session.setAttribute("currentUserInfo", user);
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
