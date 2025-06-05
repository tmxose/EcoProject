<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
<link rel="stylesheet" type="text/css"
	href="/resources/css/common.css?after">

<script>
	let isIdChecked = true

	document.addEventListener("DOMContentLoaded", function() {
		document.querySelector('input[name="user_id"]').addEventListener("input", function() {
			isIdChecked = false;
		});
	});
	
	function validateForm() {
		const userIdInput = document.querySelector('input[name="user_id"]');
		const userPwInput = document.querySelector('input[name="user_pw"]');
		const userNmInput = document.querySelector('input[name="user_nm"]');
		const originalUserId = document.querySelector('input[name="original_id"]').value.trim();
			
		const userId = userIdInput.value.trim();
		const userPw = userPwInput.value.trim();
		const userNm = userNmInput.value.trim();
	    
		if (userId === "" || userId === null) {
	        alert("아이디는 비워둘 수 없습니다.");
	        userIdInput.focus();
	        return false; // Prevent form submission
	    }
	    if (userId !== originalUserId && !isIdChecked) {
	        alert("아이디 중복 확인을 해주세요.");
	        userIdInput.focus();
	        return false;
	    }
	    if (userPw === "" || userPw === null) {
	        alert("비밀번호는 비워둘 수 없습니다.");
	        userPwInput.focus();
	        return false;
	    }
	    if (userNm === "" || userNm === null) {
	        alert("이름은 비워둘 수 없습니다.");
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
	// 탈퇴 최종 확인
	function confirmDelete() {
        return confirm("정말로 회원을 탈퇴하시겠습니까?\n탈퇴 후에는 계정 복구가 불가능합니다.");
    }
</script>
</head>
<body>
	<div class="container">
    <h2>회원 정보 수정</h2>
    <div class="inner-container">
        <form action="mypageUpdate" method="post" class="signup-form" onsubmit="return validateForm()">
            
            <div class="form-group">
                <label for="user_id">아이디</label>
                <div class="id-check-group">
                    <input class="input-area" type="text" name="user_id" id="user_id" value="${ userId }" autocomplete="off">
                    <input class="input-btn-area" type="button" value="중복확인" onclick="checkDuplicateId()">
                </div>
            </div>

            <div class="form-group">
                <label for="user_pw">비밀번호</label>
                <input  class="input-area" type="password" name="user_pw" id="user_pw" value="${ userPw }" autocomplete="new-password">
            </div>

            <div class="form-group">
                <label for="user_nm">이름</label>
                <input class="input-area" type="text" name="user_nm" id="user_nm" value="${ userName }" autocomplete="off">
            </div>

            <div class="form-group">
                <label for="user_local">지역 (선택사항)</label>
                <input class="input-area" type="text" name="user_local" id="user_local" value="${ userLocal }" autocomplete="off">
            </div>
			<input type="hidden" name="user_cd" value="${userCd}">
			<input type="hidden" name="original_id" value="${ userId }">
            <input class="input-submit-area" type="submit" value="수정하기">
        </form>
        <form action="mypageDelete" method="post" class="signup-form" onsubmit="return confirmDelete()">
        	<input type="hidden" name="user_cd" value="${userCd}">
            <input class="input-submit-area" type="submit" value="회원탈퇴">
        </form>
    </div>
</div>

</body>
</html>