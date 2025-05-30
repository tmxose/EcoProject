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
	width: 400px;
	height: 500px;
}

td button {
	justify-content: center;
	align-items: center;
	text-align: center;
	margin-left: 23%;
}

td input {
	margin-left: 23%;
}
</style>
</head>
<body>
	<div class="container">
		<table id="table" border="1px solid black" style="margin: 0 auto">
			<tr>
				<td>ID/PW</td>
			</tr>

			<!-- <table border="1" style="width: 100%; margin-top: 5px;"> -->
			<tr>
				<td colspan="2"><input type="text" value="ID"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="text" value=""></td>

			</tr>
			<!-- 					</table> -->
			<tr>
				<td><in>로그인</button></td>
			</tr>
			<tr>
				<td><button>회원가입</button></td>
			</tr>
			<tr>
				<td colspan="2"><button>SNS 로그인</button></td>
			</tr>
			<tr>
				<td colspan="2"><button>SNS 회원가입</button></td>
			</tr>
		</table>
	</div>
</body>
</html>