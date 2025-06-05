<%@page import="com.eco.domain.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="ko_KR" />
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
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/resources/css/common.css?after">
<link rel="stylesheet" type="text/css" href="/resources/css/usage.css?after">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
.box1{width: 40%; line-height: 50px; display: inline-block; margin: 0; background-color: #c5ee8f; color: #82cd2b}
.box2{width: 40%; line-height: 50px; display: inline-block; margin: 0; background-color: #82cd2b; font-weight: bold; color: white;}
</style>
	<script>
		function validateDates(form) {
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
				<a href="/"><img src="/resources/img/icon.png" class="icon"></a>
				<div class="header-container">
					<span>${userName} 님, 환영합니다.</span> 
					<button class="green-btn-2" onclick='location.href="/mypage"'>마이페이지</button>
					<button class="green-btn-2" onclick='location.href="/login/logout"'>로그아웃</button>
				</div>
			</div>
			<div class="main-container">
				<!-- 내 정보 보기 버튼 (로그인 안 되어 있으면 로그인 페이지로 이동) -->
				<button class="green-btn" onclick='location.href="/"'>메인페이지</button> 
				<button class="green-btn" onclick='location.href="/usage/insert-form"'>내 사용량 등록</button>
			</div>
		</div>
		<div class="green-line"></div>
		<div class="inner-container">
			<div class="select-box">
				<a href="/usage" class="box1">사용량</a>
				<a href="/charge" class="box2">요금</a>
			</div>
			<div class="data-box">
				<div class="title">이번 달 냉/난방 요금 현황</div>
				<div class="table-box">
					<table>
						<colgroup>
							<col width="50%">
							<col width="50%">
						</colgroup>
						<tr>
							<th>도시가스</th>
							<th>전기</th>
						</tr>
						<tr>
							<td>
								<c:choose>
							        <c:when test="${not empty gasCharge}">
							            <fmt:formatNumber value="${gasCharge.totalCharge}" type="currency" />
							        </c:when>
							        <c:otherwise>
							            ${gasChargeMsg}
							        </c:otherwise>
							    </c:choose>
							</td>
							<td>
								<c:choose>
							        <c:when test="${not empty elecCharge}">
							        	<fmt:formatNumber value="${elecCharge.totalCharge}" type="currency" />
							        </c:when>
							        <c:otherwise>
							            ${elecChargeMsg}
							        </c:otherwise>
							    </c:choose>
							</td>
						</tr>
					</table>
				</div>
				<div class="title">냉/난방 요금 이력</div>
				<form method="get" action="/charge/period" onsubmit="return validateDates(this)" class="form-box">
					<span>기간 : </span>
					<input type="date" name="startDate" id="startDate" value="${not empty param.startDate ? param.startDate : firstDayStr}" pattern="yyyy-MM-dd">
					 ~ <input type="date" name="endDate" id="endDate" value="${not empty param.endDate ? param.endDate : lastDayStr}" pattern="yyyy-MM-dd">
					<input type="submit" class="green-btn-2" value="조회">
				</form>
				<div class="table-box">
					<table>
						<caption class="text-bold">가스 요금 상세 내역</caption>
						<tr>
							<th>userCD</th>
							<th>사용자명</th>
							<th>타입</th>
							<th>표준원가</th>
							<th>사용량</th>
							<th>요금</th>
							<th>날짜</th>
						</tr>
						<c:choose>
							<c:when test="${not empty gasUse}">
								<c:forEach var="item" items="${gasUse}">
						            <tr>
						                <td>${item.userCd}</td>
						                <td>${item.userNm}</td>
						                <td>${item.usageType}</td>
						                <td>${item.unitCharge}</td>
						                <td>${item.gas_usage}</td>
						                <td>${item.gas_usage * item.unitCharge}</td>
						                <td><fmt:formatDate pattern="yyyy-MM-dd" value="${ item.gas_time }"/></td>
						            </tr>
						        </c:forEach>
						    </c:when>
							<c:otherwise>
								<tr>
									<td colspan="7">${ gasChargeDetailMsg }</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
					<table>
						<caption class="text-bold">전기 요금 상세 내역</caption>
						<tr>
							<th>userCD</th>
							<th>사용자명</th>
							<th>타입</th>
							<th>표준원가</th>
							<th>사용량</th>
							<th>요금</th>
							<th>날짜</th>
						</tr>
						<c:choose>
							<c:when test="${not empty elecUse}">
								<c:forEach var="item" items="${elecUse}">
						            <tr>
						                <td>${item.userCd}</td>
						                <td>${item.userNm}</td>
						                <td>${item.usageType}</td>
						                <td>${item.unitCharge}</td>
						                <td>${item.elec_usage}</td>
						                <td>${item.elec_usage * item.unitCharge}</td>
						                <td><fmt:formatDate pattern="yyyy-MM-dd" value="${ item.elec_time }"/></td>
						            </tr>
						        </c:forEach>
						    </c:when>
							<c:otherwise>
								<tr>
									<td colspan="7">${ elecChargeDetailMsg }</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
				</div>
				<div class="chart-container">
					<canvas class="usageChart" id="monthChart"></canvas>
				</div>
			</div>
		</div>
	</div>
	
	<script>
		let jData = JSON.parse('<c:out value="${json}" escapeXml="false"/>');
		
		let monthList = new Array();
		let gasMonthList = new Array();
		let elecMonthList = new Array();
		
		for(i=0; i<jData.length;i++){
			let j = jData[i];
			monthList.push(j.user_month);
			gasMonthList.push(j.gaschargeMonth);
			elecMonthList.push(j.elecChargeMonth);
		}
		
		const ctx = document.getElementById('monthChart').getContext('2d');
	    const myChart = new Chart(ctx, {
	        type: 'line',
	        data: {
	            labels: monthList,
	            datasets: [
	                {
	                    label: '도시가스',
	                    data: gasMonthList,
	                    backgroundColor: 'rgba(95, 164, 0, 0.2)',
	                    borderColor: 'rgba(95, 164, 0, 1)',
	                    borderWidth: 2,
	                    tension: 0.3
	                },
	                {
	                    label: '전기',
	                    data: elecMonthList,
	                    backgroundColor: 'rgba(255, 166, 0, 0.2)',
	                    borderColor: 'rgba(255, 166, 0, 1)',
	                    borderWidth: 2,
	                    tension: 0.3
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