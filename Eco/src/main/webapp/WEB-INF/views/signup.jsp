<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
</head>
<body>
	<h2>회원가입 페이지 입니다.</h2>
	<form action="signup" method="post">
		<p>user_id</p>
		<input type="text" name="user_id">
		<p>user_pw</p>
		<input type="password" name="user_pw">
		<p>user_nm</p>
		<input type="text" name="user_nm">
		<input type="submit" value="가입하기"> 
	</form>
</body>
</html>