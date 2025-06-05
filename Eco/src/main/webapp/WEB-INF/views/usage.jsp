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
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/resources/css/common.css?after">
<link rel="stylesheet" type="text/css" href="/resources/css/usage.css?after">
<style>
.box1{background-color: #82cd2b; font-weight: bold; color: white;}
.box2{background-color: #c5ee8f; color: #82cd2b;}
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
				<div class="title">이번 달 냉/난방 사용 현황</div>
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
							        <c:when test="${not empty gasUsage}">
							            ${gasUsage.gasUsageAmount} ㎥
							        </c:when>
							        <c:otherwise>
							            ${gasUsageMsg}
							        </c:otherwise>
							    </c:choose>
							</td>
							<td>
								<c:choose>
							        <c:when test="${not empty elecUsage}">
							            ${elecUsage.elecUsageAmount} kWh
							        </c:when>
							        <c:otherwise>
							            ${elecUsageMsg}
							        </c:otherwise>
							    </c:choose>
							</td>
						</tr>
					</table>
				</div>
				<div class="title">냉/난방 사용 이력</div>
				<form method="get" action="/usage/period" onsubmit="return validateDates(this)" class="form-box">
					<span>기간 : </span>
					<input type="date" name="startDate" id="startDate" value="${not empty param.startDate ? param.startDate : firstDayStr}" pattern="yyyy-MM-dd">
					 ~ <input type="date" name="endDate" id="endDate" value="${not empty param.endDate ? param.endDate : lastDayStr}" pattern="yyyy-MM-dd">
					<input type="submit" class="green-btn-2" value="조회">
				</form>				
				<div class="table-box">
					<table>
						<caption class="text-bold">가스 사용 상세 내역</caption>
						<tr>
							<th>userCD</th>
							<th>사용자명</th>
							<th>타입</th>
							<th>표준원가</th>
							<th>사용량</th>
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
										<td><fmt:formatDate pattern="yyyy-MM-dd" value="${ item.gas_time }"/></td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="6">${ gasUsageDetailMsg }</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
					<table>
						<caption class="text-bold">전기 사용 상세 내역</caption>
						<tr>
							<th>userCD</th>
							<th>사용자명</th>
							<th>타입</th>
							<th>표준원가</th>
							<th>사용량</th>
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
										<td><fmt:formatDate pattern="yyyy-MM-dd" value="${ item.elec_time }"/></td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="6">${ elecUsageDetailMsg }</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>