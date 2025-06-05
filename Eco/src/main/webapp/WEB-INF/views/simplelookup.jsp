<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Eco</title>
<link rel="stylesheet" type="text/css"
	href="/resources/css/common.css?after">
<style>
.input-area-2 {
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	background-color: white;
	box-sizing: border-box;
	width: 40%;
	font-size: 14px;
}
.form-group-2 {
	display: flex;
	justify-content: space-between;
	gap: 5px;
}
</style>
<script>
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
</script>
</head>
<body>
	<div class="container">
	<a href="/"><img src="/resources/img/icon.png" class="icon"></a>
    <h2>간편 요금 조회</h2>
    <div class="inner-container">
        <form action="signup" method="post" class="signup-form" onsubmit="return validateForm()">

            <div class="form-group">
                <label for="user_pw">납입자 번호</label>
                <input  class="input-area" type="password" name="" id="" autocomplete="off">
            </div>

            <div class="form-group">
                <label for="user_nm">이름</label>
                <input class="input-area" type="text" name="" id="" autocomplete="off">
            </div>

            <div class="form-group">
                <label for="user_local">조회 기간</label>
                <div class="form-group-2">
                <input class="input-area-2" type="date" name="" id="" autocomplete="off">
                ~
                <input class="input-area-2" type="date" name="" id="" autocomplete="off"></div>
            </div>

            <input class="input-submit-area" type="submit" value="조회하기">
        </form>
    </div>
</div>
</body>
</html>