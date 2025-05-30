<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
<link rel="stylesheet" type="text/css"
	href="/resources/css/common.css?after">
</head>
<body>
	<div class="container">
		<div class="inner-container">
			<button onclick="location.href='/login'">로그인</button>
			<button onclick="location.href='/signup'">회원가입</button>
			<button onclick="location.href='/usage'">내 사용량 조회</button>
		</div>
		<div class="inner-container">
			<h2>지역별 평균 사용량</h2>
			<p>지역별 평균 사용량 내용</p>
		</div>
	</div>
</body>
</html>