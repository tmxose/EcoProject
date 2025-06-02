<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
<link rel="stylesheet" type="text/css" href="/resources/css/common.css?after">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
	<div class="container">
		<div class="inner-container">
			<c:if test="${not empty sessionScope.currentUserInfo}">
				<p>환영합니다, ${currentUserInfo.user_nm} 님!</p>
				<button onclick="location.href='/login/logout'">로그아웃</button>
			</c:if>
			
			<c:if test="${empty sessionScope.currentUserInfo}">
				<button onclick="location.href='/login'">로그인</button>
				<button onclick="location.href='/signup'">회원가입</button>
				<a href="/login/googleLogin">
					<img class="login-button" src="../../resources/img/google_signin.png"
					alt="Google 로그인">
				</a>
				<a href="/login/naverLogin">
  					<img class="login-button" src="../../resources/img/naver_login.png" alt="네이버 로그인">
				</a>

			</c:if>

			<!-- 내 정보 보기 버튼 (로그인 안 되어 있으면 로그인 페이지로 이동) -->
			<button onclick="goToMyUsagePage()">내 사용량 조회</button>
		</div>
		
		<div class="inner-container">
			<h2>지역별 평균 사용량</h2>
			<p>지역별 평균 사용량 내용</p>
		</div>
	</div>
	<canvas id="usgaeChart" width="600" height="400"></canvas>
	
	<script>
		function goToMyUsagePage() {
			const isLoggedIn = '${not empty sessionScope.currentUserInfo}' === 'true';
			if (isLoggedIn) {
				location.href = '/usage'; // 실제 내 정보 보기 페이지로 변경
			} else {
				alert('로그인이 필요합니다.');
				location.href = '/login';
			}
		}
		
		
		let jData = JSON.parse('${ json }');
		
		let localList = new Array();
		let gasUsageList = new Array();
		let elecUsageList = new Array();
		
		for(i=0; i<jData.length;i++){
			let j = jData[i];
			localList.push(j.user_local);
			gasUsageList.push(j.gasUsageAmount);
			elecUsageList.push(j.elecUsageAmount);
		}
		
		const ctx = document.getElementById('usgaeChart').getContext('2d');
	    const myChart = new Chart(ctx, {
	        type: 'bar',
	        data: {
	            labels: localList,
	            datasets: [
	                {
	                    label: 'Gas Usage',
	                    data: gasUsageList,
	                    backgroundColor: 'rgba(255, 99, 132, 0.5)'
	                },
	                {
	                    label: 'Electric Usage',
	                    data: elecUsageList,
	                    backgroundColor: 'rgba(54, 162, 235, 0.5)'
	                }
	            ]
	        },
	        options: {
	            scales: {
	                y: {
	                    beginAtZero: true
	                }
	            }
	        }
	    });
	</script>
</body>
</html>
