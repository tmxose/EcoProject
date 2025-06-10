package com.eco.service;

import com.eco.domain.UserVO;

public interface OAuthService {
	 public String getGoogleLoginUrl();
	 public UserVO processGoogleLogin(String code);
}
