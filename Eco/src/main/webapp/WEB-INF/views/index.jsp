<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
<link rel="stylesheet" type="text/css"
	href="/resources/css/common.css?after">
<link rel="stylesheet" type="text/css"
	href="/resources/css/usage.css?after">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
	<div class="container">
		<div class="inner-container">
			<div class="head-box">
				<a href="/"><img src="/resources/img/icon.png" class="icon"></a>
				<div class="header-container">
					<c:if test="${not empty sessionScope.currentUserInfo}">
						<span>${currentUserInfo.user_nm} 님, 환영합니다.</span>
					<button class="green-btn-2" onclick='location.href="/mypage"'>마이페이지</button>
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
				<button class="green-btn" onclick="goToMyUsagePage()">내 사용량 조회</button> 
				<button class="green-btn" onclick="goToUsageInsertPage()">내 사용량 등록</button>
			</div>
		</div>
		<div class="green-line"></div>
		<div class="chart-container">
			<h2>지역별 사용량 비교</h2>
			<canvas class="usageChart" id="usgaeChart"></canvas>
		</div>
	</div>

	<script>
	 	const isLoggedIn = ${not empty sessionScope.currentUserInfo};
	 
		// 사용량 확인 페이지 이동
		function goToMyUsagePage() {
			if (isLoggedIn) {
				location.href = '/usage'; // 실제 내 정보 보기 페이지로 변경
			} else {
				alert('로그인이 필요합니다.');
				location.href = '/login';
			}
		}
		// 사용량 등록 페이지 이동
		function goToUsageInsertPage() {
			if (isLoggedIn) {
				location.href = '/usage/insert-form'; // 실제 내 정보 보기 페이지로 변경
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
	                    label: '도시가스',
	                    data: gasUsageList,
	                    backgroundColor: 'rgba(255, 99, 132, 0.5)'
	                },
	                {
	                    label: '전기',
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
	<c:if test="${not empty msg}">
	    <script>
	        alert('${msg}');
	    </script>
	</c:if>
</body>
</html>
