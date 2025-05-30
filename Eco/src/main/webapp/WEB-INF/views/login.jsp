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

.container {
	
}

#table {
	text-align: center;
	width: 400px;
	height: 400px;
	width: 400px;
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


			<table id="table" border="1px solid black" style="margin: 0 auto">
				<tr>
					<td>ID/PW</td>
				</tr>

				<!-- <table border="1" style="width: 100%; margin-top: 5px;"> -->
				<tr>
					<td class="td1">ID<input type="text" name="user_id"></td>
				</tr>
				<tr>
					<td class="td2">PassWord<input type="password" name="user_pw"></td>

				</tr>
				<!-- 					</table> -->
				<tr>
					<td style="text-align: center; margin: 5%"><input type="submit" value="로그인"></input><input
						type="submit" value="회원가입"></input></td>
				</tr>

				<tr>
					<td colspan="2"><button>SNS 로그인</button></td>
				</tr>
				<tr>
					<td colspan="2"><button>SNS 회원가입</button></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>