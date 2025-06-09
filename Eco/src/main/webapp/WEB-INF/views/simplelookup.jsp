<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    // 오늘 날짜 생성
    java.time.LocalDate today = java.time.LocalDate.now();
	java.time.LocalDate firstDay = today.withDayOfMonth(1);
	java.time.LocalDate lastDay = today.withDayOfMonth(today.lengthOfMonth());

	request.setAttribute("firstDayStr", firstDay.toString());
	request.setAttribute("lastDayStr", lastDay.toString());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Eco</title>
<link rel="stylesheet" type="text/css" href="/resources/css/common.css?after">
<link rel="stylesheet" type="text/css" href="/resources/css/usage.css?after">
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
    	const userNumber = document.querySelector('input[name="user_num"]');
		const userNmInput = document.querySelector('input[name="user_nm"]');
		const userNum = userNumber.value.trim();
		const userNm = userNmInput.value.trim();
        
		if (userNum === "" || userNum === null) {
            alert("아이디를 입력해주세요.");
            userNumber.focus();
            return false; // Prevent form submission

        if (userNm === "" || userNm === null) {
            alert("비밀번호를 입력해주세요.");
            userNmInput.focus();
            return false;
        }
            
        let startDay = document.getElementById("startDate").value;
		let endDay = document.getElementById("endDate").value;
		if(!startDay){
			alert("시작일을 지정하여 주세요")
			return false;
		}
		if(!endDay){
			alert("종료일을 지정하여 주세요")
			return false;
		}
		
		let maxDiff = 90 * 24 * 60 * 60 * 1000;
		let start = new Date(startDay);
		let end = new Date(endDay);
	    let diff = end - start;
		if(diff > maxDiff) {
			alert("최대 3개월 사용량만 조회 가능합니다.");
			return false;
		}
		if(startDay && endDay && startDay > endDay) {
			alert("시작일은 종료일보다 빠른 날짜여야 합니다.");
			return false;
		}
    }
</script>
</head>
<body>
	<div class="container">
		<div class="inner-container">
			<div class="head-box">
				<!-- 아이콘 -->
				<a href="/"><img src="/resources/img/icon.png" class="icon"></a>
				<!-- 메인화면 글씨 -->
				<div class="title-container"><h2>비회원 사용 요금 조회</h2></div>
				<!-- 버튼 내비게이션 -->
				<div class="header-container">
					<!-- 위쪽 텍스트 -->
					<div class="header-inner-container">
						<c:if test="${not empty sessionScope.currentUserInfo}">
							<span>${currentUserInfo.user_nm} 님, 환영합니다.</span>
						</c:if>
					</div>
					<!-- 아래쪽 버튼 -->
					<div class="header-inner-container">
						<c:if test="${not empty sessionScope.currentUserInfo}">
							<button class="green-btn-2" onclick='location.href="/mypage"'>마이페이지</button>
							<button class="green-btn-2" onclick='location.href="/login/logout"'>로그아웃</button>
						</c:if>
						<c:choose>
						    <c:when test="${sessionScope.currentUserInfo.admin_yn.toString() eq 'Y'}">
						        <button class="green-btn-2" type="button" onclick="location.href='/admin'">관리자 기능</button>
						    </c:when>
						    <c:otherwise>
						    </c:otherwise>
						</c:choose>
						<c:if test="${empty sessionScope.currentUserInfo}">
							<button class="green-btn-2" onclick='location.href="/login"'>로그인</button>
							<button class="green-btn-2" onclick='location.href="/signup"'>회원가입</button>
						</c:if>
					</div>
				</div>
			</div>
			<div class="green-line"></div>
			<div class="main-container">
				<button class="green-btn" onclick='location.href="/"'>메인페이지</button> 
			</div>
		</div>
	    <div class="inner-container">
	    	<div class="data-box">
	    		<div class="title">간편 요금 조회</div>
		    	<div class="table-box">
			        <form action="#" method="post" onsubmit="return validateForm()" class="form-box">
			        	<div>
			                <label for="user_num">납입자 번호</label>
			                <input  class="input-area" type="text" name="user_num" id="user_num" autocomplete="off">
	
			                <label for="user_nm">이름</label>
			                <input class="input-area" type="text" name="user_nm" id="user_nm" autocomplete="off">
	
			                <label for="user_local">조회 기간</label>
			                <div class="inner-form-box">
				                <input type="date" name="startDate" id="startDate" autocomplete="off" pattern="yyyy-MM-dd">
				                <p>~</p>
				                <input type="date" name="endDate" id="endDate" autocomplete="off" pattern="yyyy-MM-dd">
			                </div>
			                <div>* 최대 3개월 분의 자료만 조회가 가능합니다.</div>
				            <input class="input-submit-area" type="submit" value="조회하기">
			            </div>
			        </form>
		        </div>
	        </div>
	    </div>
	</div>
</body>
</html>