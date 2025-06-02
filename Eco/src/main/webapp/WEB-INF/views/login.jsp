<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" type="text/css"
	href="/resources/css/common.css?after">
<style>
html, body {
	height: 100%;
	margin: 0;
	display: flex;
	justify-content: center;
	align-items: center;
}
table {
	text-align: center;
	width: 400px;
	height: 400px;
	width: 400px;
	border: 1px solid black;
	margin: 0 auto;
}

td button {
	justify-content: center;
	align-items: center;
	text-align: center;
}
</style>
</head>
<body>
	<div class="container">
		<form action="login" method="post">
			<table>
				<tr>
					<td>ID/PW</td>
				</tr>
				<tr>
					<td class="td1">ID<input type="text" name="user_id"></td>
				</tr>
				<tr>
					<td class="td2">PassWord<input type="password" name="user_pw"></td>

				</tr>
				<tr>
					<td style="text-align: center; margin: 5%"><input
						type="submit" value="로그인"></input><input type="submit"
						value="회원가입"></input></td>
				</tr>

				<tr>
					<td colspan="2"><a href="/login/googleLogin"><img
							src="https://developers.google.com/identity/images/btn_google_signin_dark_normal_web.png"
							alt="Google 로그인"></a></td>
				</tr>
				<tr>
					<td colspan="2"><a href="/login/googleLogin"> Google 계정으로 로그인</a></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>