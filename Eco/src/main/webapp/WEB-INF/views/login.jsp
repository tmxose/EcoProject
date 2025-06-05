<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Eco</title>
<link rel="stylesheet" type="text/css"
	href="/resources/css/common.css?after">
<link
	href="https://fonts.googleapis.com/css2?family=Oswald&display=swap"
	rel="stylesheet">
	<link
	href="https://fonts.googleapis.com/css2?family=Nunito+Sans&display=swap"
	rel="stylesheet">
<style>
.login-container{
height: 600px;
display: flex;
	justify-content: center;
	flex-direction: column;
	align-items: center;
	width: 100%;
	box-sizing: border-box;
}
.login-table {
	text-align: center;
	width: 400px;
	
	border: 1px solid black;
	/* margin: 100px auto; */
	padding: 10px;
	border-collapse: separate;
	border-spacing: 6px 8px;
}

.login-td {
	font-family: 'Oswald', sans-serif;
	font-size: 25pt;
	padding-bottom: 10px;
}
.td1, .td2{
	font-family: 'Nunito Sans', sans-serif;
	font-size: 13pt;
}

input[type="text"],
input[type="password"]{
	width: 200px;
	padding: 6px;
	margin-top: 4px;
}

input[type="submit"],
input[type="button"]{
	margin: 8px 4px;
}

.login-form{
justify-content: center;
align-items: center;
}
</style>
</head>
<body>
	<div class="login-container">
		<form action="login" method="post" class="login-form">
			<table class="login-table">
				<tr>
					<td class="login-td" colspan="2">Login</td>
				</tr>
				<tr>
					<td class="td1">ID</td>
					<td class="td1"><input type="text" name="user_id"></td>
				</tr>
				<tr>
					<td class="td2">PassWord</td>
					<td  class="td2"><input type="password" name="user_pw"></td>

				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="로그인"/>
					<input type="button" onclick="location.href='/signup'" value="회원가입"/></td>
				</tr>
				<tr>
					<td colspan="2"><a href="/login/googleLogin"> <img
							class="login-button" src="../../resources/img/google_signin.png"
							alt="Google 로그인">
					</a></td>
				</tr>
				<tr>
					<td colspan="2"><a href="/login/naverLogin"> <img
							class="login-button" src="../../resources/img/naver_login.png"
							alt="네이버 로그인">
					</a></td>
				</tr>

			</table>
		</form>
	</div>
</body>
</html>