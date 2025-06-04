<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용량 등록</title>
<link rel="stylesheet" type="text/css" href="/resources/css/common.css?after">
<link rel="stylesheet" type="text/css" href="/resources/css/usage.css?after">
</head>
<body>
	<div class="container">
		<div class="inner-container">
			<div class="head-box">
				<a href="/"><img src="/resources/img/icon.png" class="icon"></a>
				<div class="header-container">
					<c:if test="${not empty sessionScope.currentUserInfo}">
						<span>${currentUserInfo.user_nm} 님, 환영합니다.</span>
						<button class="green-btn-2" onclick='location.href="/login/logout"'>로그아웃</button>
					</c:if>
					<c:if test="${empty sessionScope.currentUserInfo}">
						<button class="green-btn" onclick='location.href="/login"'>로그인</button>
						<button class="green-btn" onclick='location.href="/signup"'>회원가입</button>
					</c:if>
				</div>
			</div>
			<div class="main-container">
				<!-- 내 정보 보기 버튼 (로그인 안 되어 있으면 로그인 페이지로 이동) -->
				<button class="green-btn" onclick='location.href="/usage"'>내 사용량 조회</button> 
				<button class="green-btn" onclick='location.href="/"'>메인 페이지</button>
			</div>
		</div>
		<div class="green-line"></div>
		<div class="inner-container">
		    <!-- 가스 사용량 등록 폼 -->
		    <div class="data-box">
		    	<div class="title">가스 사용량 등록</div>
			    <form action="/usage/gas/insert" method="post" class="table-box-2">
			    	<label>사용 일자:</label>
					<input type="date" name="gas_time" required>
			    
			        <label for="gas_cd">가스 타입 선택:</label>
			        <select id="gas_cd" name="gas_cd" required>
			            <c:forEach var="gas" items="${gasList}">
			                <option value="${gas.gas_cd}">${gas.type}</option>
			            </c:forEach>
			        </select>
			        <br/>
			
			        <label for="gas_usage">가스 사용량 (단위: m³):</label>
			        <input type="number" id="gas_usage" name="gas_usage" step="0.01" min="0" required />
			        <br/>
			        <button class="green-btn-2" type="submit">가스 사용량 등록</button>
			    </form>
			    <div>최근 5회 등록된 사용량 데이터</div>
	   		</div>
	   		
		    <!-- 전기 사용량 등록 폼 -->
		    <div class="data-box">
		    <div class="title">전기 사용량 등록</div>
		    <form action="/usage/elec/insert" method="post" class="table-box-2">
		    	<label>사용 일자:</label>
				<input type="date" name="elec_time" required>
		        <label for="elec_cd">전기 타입 선택:</label>
		        <select id="elec_cd" name="elec_cd" required>
		            <c:forEach var="elec" items="${elecList}">
		                <option value="${elec.elec_cd}">${elec.type}</option>
		            </c:forEach>
		        </select>
		        <br/>
		        <label for="elec_usage">전기 사용량 (단위: kWh):</label>
		        <input type="number" id="elec_usage" name="elec_usage" step="0.01" min="0" required />
		        <br/>
		        <button class="green-btn-2" type="submit">전기 사용량 등록</button>
		    </form>
		    </div>
    	</div>
	</div>
	
	<!-- 데이터 저장 alert메세지 -->
	<c:if test="${not empty msg}">
	    <script>
	        alert('${msg}');
	    </script>
	</c:if>
	
</body>
</html>