<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<link rel="stylesheet" type="text/css"
	href="/resources/css/common.css?after">

<script>
	let isIdChecked = false; // 아이디 중복 확인 완료 여부

    function validateForm() {
    	const userIdInput = document.querySelector('input[name="user_id"]');
		const userPwInput = document.querySelector('input[name="user_pw"]');
		const userNmInput = document.querySelector('input[name="user_nm"]');
			
		const userId = userIdInput.value.trim();
		const userPw = userPwInput.value.trim();
		const userNm = userNmInput.value.trim();
        
		if (userId === "" || userId === null) {
            alert("아이디를 입력해주세요.");
            userIdInput.focus();
            return false; // Prevent form submission
        }
        if (!isIdChecked) {
            alert("아이디 중복 확인을 해주세요.");
            userIdInput.focus();
            return false;
        }
        if (userPw === "" || userPw === null) {
            alert("비밀번호를 입력해주세요.");
            userPwInput.focus();
            return false;
        }
        if (userNm === "" || userNm === null) {
            alert("이름을 입력해주세요.");
            userNmInput.focus();
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
	<div class="container">
	<a href="/"><img src="/resources/img/icon.png" class="icon"></a>
    <h2>회원가입 페이지입니다.</h2>
    <div class="inner-container">
        <form action="signup" method="post" class="signup-form" onsubmit="return validateForm()">
            
            <div class="form-group">
                <label for="user_id">아이디</label>
                <div class="id-check-group">
                    <input class="input-area" type="text" name="user_id" id="user_id" autocomplete="off">
                    <input class="input-btn-area" type="button" onclick="checkDuplicateId()" value="중복확인">
                </div>
            </div>

            <div class="form-group">
                <label for="user_pw">비밀번호</label>
                <input  class="input-area" type="password" name="user_pw" id="user_pw" autocomplete="new-password">
            </div>

            <div class="form-group">
                <label for="user_nm">이름</label>
                <input class="input-area" type="text" name="user_nm" id="user_nm" autocomplete="off">
            </div>

            <div class="form-group">
                <label for="user_local">지역 (선택사항)</label>
                <input class="input-area" type="text" name="user_local" id="user_local" autocomplete="off">
            </div>

            <input class="input-submit-area" type="submit" value="가입하기">
        </form>
    </div>
</div>
</body>
</html>