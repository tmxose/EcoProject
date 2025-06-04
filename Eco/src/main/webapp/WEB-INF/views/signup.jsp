<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<script>
	let isIdChecked = false; // 아이디 중복 확인 완료 여부

    function validateForm() {
        const userId = document.querySelector('input[name="user_id"]').value;
        const userPw = document.querySelector('input[name="user_pw"]').value;
        const userNm = document.querySelector('input[name="user_nm"]').value;

        if (userId === "" || userId === null) {
            alert("아이디를 입력해주세요.");
            userId.focus();
            return false; // Prevent form submission
        }
        if (!isIdChecked) {
            alert("아이디 중복 확인을 해주세요.");
            userId.focus();
            return false;
        }
        if (userPw === "" || userPw === null) {
            alert("비밀번호를 입력해주세요.");
            userPw.focus();
            return false;
        }
        if (userNm === "" || userNm === null) {
            alert("이름을 입력해주세요.");
            userNm.focus();
            return false;
        }

        return true;
    }
    // 아이디 중복 확인
    function checkDuplicateId() {
    	 const userId = document.querySelector('input[name="user_id"]').value;
    	    if (!userId) {
    	        alert("아이디를 입력하세요.");
    	        return;
    	    }

    	    fetch("/check-id?user_id=" + encodeURIComponent(userId))
    	        .then(res => res.text())
    	        .then(result => {
    	            if (result === "duplicate") {
    	                alert("이미 사용 중인 아이디입니다.");
    	                isIdChecked = false;
    	            } else {
    	                alert("사용 가능한 아이디입니다!");
    	                isIdChecked = true;
    	            }
    	        })
    	        .catch(err => {
    	            console.error("중복 확인 에러:", err);
    	            isIdChecked = false;
    	        });
    }
</script>
</head>
<body>
	<h2>회원가입 페이지 입니다.</h2>
	<form action="signup" method="post" onsubmit="return validateForm()">
		<p>아이디</p>
		<input type="text" name="user_id">
		<input type="button" onclick="checkDuplicateId()" value="중복확인">
		<p>비밀번호</p>
		<input type="password" name="user_pw">
		<p>이름</p>
		<input type="text" name="user_nm">
		<p>지역(선택사항)</p>
		<input type="text" name="user_local">
		<input type="submit" value="가입하기"> 
	</form>
</body>
</html>