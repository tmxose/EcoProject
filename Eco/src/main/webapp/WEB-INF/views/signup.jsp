<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Eco</title>
<link rel="stylesheet" type="text/css"
	href="/resources/css/common.css?after">
<script src="/resources/js/signup.js"></script>
<style>
	
</style>
</head>
<body>
	<div class="container">
		<a href="/"><img src="/resources/img/icon.png" class="icon"></a>
		<h2>회원 가입</h2>
		<div class="inner-container">
			<form id="signupForm" action="signup" method="post"
				class="signup-form" onsubmit="return validateForm()">

				<div class="form-group">
					<label for="user_id">아이디</label>
					<div class="id-check-group">
						<input class="input-area" type="text" name="user_id" id="user_id"
							autocomplete="off"> <input class="input-btn-area"
							type="button" onclick="checkDuplicateId()" value="중복확인">

					</div>
				</div>

				<div class="form-group">
					<label for="user_pw">비밀번호</label> <input class="input-area"
						type="password" name="user_pwd" id="user_pwd"
						autocomplete="new-password" oninput="checkPwd()">


					<div class="form-group">
						<label for="user_pw2">비밀번호 확인</label> <input class="input-area"
							type="password" name="user_pwd2" id="user_pwd2"
							autocomplete="new-password" oninput="checkPwd()">
						<div class="invalid_feedback"></div>
					</div>

					<div class="form-group">
						<label for="user_nm">이름</label> <input class="input-area"
							type="text" name="user_nm" id="user_nm" autocomplete="off">
					</div>

					<div class="form-group">
						<label for="user_local">지역 (선택사항)</label> <input
							class="input-area" type="text" name="user_local" id="user_local"
							autocomplete="off">
					</div>

					<input class="input-submit-area" type="submit" value="가입하기">
				</div>
			</form>
		</div>

	<!-- 여긴 높이 보정용 푸터 입니다. -->
	<footer></footer>

	</div>
	<script>
		// 유형성 유무를 저장할 변수를 만들고 초기값 대입
		let isPwdValid = false;

		function checkPwd() {
			const pwd = document.querySelector("#user_pwd").value;
			const pwd2 = document.querySelector("#user_pwd2").value;

			const pwd2Input = document.querySelector("#user_pwd2");
			pwd2Input.classList.remove("is-valid", "is-invalid");
			if (pwd !== pwd2 || pwd === "") {
				pwd2Input.classList.add("is-invalid");
				isPwdValid = false;
			} else {
				pwd2Input.classList.add("is-valid")
				isPwdValid = true;
			}
		}

		document.querySelector("#user_pwd").addEventListener("input", checkPwd);
		document.querySelector("#user_pwd_ck")
				.addEventListener("input", checkPwd);

		document.querySelector("#signupForm").addEventListener("submit",
				function(event) {
					if (!isPwdValid) {
						event.preventDefault();
						alert("비밀번호가 일치하지 않습니다.");
					}
				});
	</script>
</body>
</html>