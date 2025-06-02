<%@page import="com.eco.domain.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="/resources/css/common.css?after">
	<style>
		*{margin: 0; padding: 0;}
		#wrap{width: 90%; margin : 0 auto}

		#head{width: 100%;}
		#head_icon{height: 50px; margin: 10px}
		#head_user{float: right; margin-top: 20px;}
		#head_image{clear: both; height: 250px;}

		#main{width: 100%;}
		#main_charge{display: inline-block; width: 200px; height: 40px; border: 1px solid black; text-align: center; line-height: 40px; position: relative; top:1px; left: -6px; border-top-left-radius: 15px; border-top-right-radius: 15px;}
		#main_use{display: inline-block; width: 180px; height: 30px; border: 1px solid black; position: relative; top:6px; text-align: center; line-height: 30px; border-top-left-radius: 15px; border-top-right-radius: 15px;}
		#main_info{border: 1px solid black; border-radius: 7px; border-top-left-radius: 0;}
		#main .title{clear:both; display: inline-block; margin: 20px; font-size: 20px; font-weight: bold;}
		#main table{width: 80%; margin: 0 auto;}
		#main table, th, td{border: 1px dotted black; border-collapse: collapse;}

		#main form{width: 90%; margin: 0 auto;}
		#main input[type="submit"]{width: 50px; text-align: center;}
		#main input[type="date"]{width: 120px; text-align: right;}
		
		#main_data{margin: 20px auto; width: 90%; border: 1px dotted black;}
		#main_data table{margin : 25px auto}
		#main_data table caption{margin-bottom : 10px}		
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
	<div id="wrap">
		<div id="head">
			<a href="/"><img src="/resources/img/icon.png" id="head_icon"></a>
			<div id="head_user">
				<span>${userName} 님, 환영합니다.</span>
				<a href="/login/logout">로그아웃</a>
			</div>
			<div id="head_image">(이미지, 생략 가능)</div>
		</div>
         
		<div id="main">
			<div id="main_use"><a href="/usage">사용량</a></div>
			<div id="main_charge"><a href="/charge">요금</a></div>
			<div id="main_info">
				<span class="title">이번 달 나의 에너지 사용 요금</span><br>
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
						            ${gasCharge.totalCharge}
						        </c:when>
						        <c:otherwise>
						            ${gasChargeMsg}
						        </c:otherwise>
						    </c:choose>
						</td>
						<td>
							<c:choose>
						        <c:when test="${not empty elecCharge}">
						            ${elecCharge.totalCharge}
						        </c:when>
						        <c:otherwise>
						            ${elecChargeMsg}
						        </c:otherwise>
						    </c:choose>
						</td>
					</tr>
				</table>
				<span class="title">과거 요금 이력</span>
				<form method="get" action="/charge/period" onsubmit="return validateDates(this)">
					<span>기간 : </span>
					<input type="date" name="startDate" id="startDate" value="${startDate}" pattern="yyyy-MM-dd">
					 ~ <input type="date" name="endDate" id="endDate" value="${endDate}" pattern="yyyy-MM-dd">
					<input type="submit" value="조회">
				</form>
				<div id="main_data">
					<table>
						<caption>가스 요금 상세 내역</caption>
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
						<caption>전기 요금 상세 내역</caption>
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
			</div>
		</div>
	</div>
</body>
</html>