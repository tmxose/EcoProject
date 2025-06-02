<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<script>
    function validateForm() {
        const userId = document.querySelector('input[name="user_id"]').value;
        const userPw = document.querySelector('input[name="user_pw"]').value;
        const userNm = document.querySelector('input[name="user_nm"]').value;

        if (userId === "" || userId === null) {
            alert("아이디를 입력해주세요.");
            return false; // Prevent form submission
        }
        if (userPw === "" || userPw === null) {
            alert("비밀번호를 입력해주세요.");
            return false;
        }
        if (userNm === "" || userNm === null) {
            alert("이름을 입력해주세요.");
            return false;
        }

        return true;
    }
</script>
</head>
<body>
	<h2>회원가입 페이지 입니다.</h2>
	<form action="signup" method="post" onsubmit="return validateForm()">
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