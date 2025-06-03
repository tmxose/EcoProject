<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용량 등록</title>
<link rel="stylesheet" type="text/css"
	href="/resources/css/common.css?after">
</head>
<body>
	<div class="container">
	  <h2>냉난방 사용량 등록</h2>

    <!-- 가스 사용량 등록 폼 -->
    <h3>가스 사용량 등록</h3>
    <form action="/usage/gas/insert" method="post">
        <label for="gas_cd">가스 타입 선택:</label>
        <select id="gas_cd" name="gas_cd" required>
            <c:forEach var="gas" items="${gasList}">
                <option value="${gas.gas_cd}">${gas.type}</option>
            </c:forEach>
        </select>
        <br/>

        <label for="gas_usage">가스 사용량 (단위):</label>
        <input type="number" id="gas_usage" name="gas_usage" step="0.01" min="0" required />
        <br/>
        <button type="submit">가스 사용량 등록</button>
    </form>

    <hr/>
    
    <!-- 전기 사용량 등록 폼 -->
    <h3>전기 사용량 등록</h3>
    <form action="/usage/elec/insert" method="post">
        <label for="elec_cd">전기 타입 선택:</label>
        <select id="elec_cd" name="elec_cd" required>
            <c:forEach var="elec" items="${elecList}">
                <option value="${elec.elec_cd}">${elec.type}</option>
            </c:forEach>
        </select>
        <br/>

        <label for="elec_usage">전기 사용량 (단위):</label>
        <input type="number" id="elec_usage" name="elec_usage" step="0.01" min="0" required />
        <br/>
        <button type="submit">전기 사용량 등록</button>
    </form>
	</div>
</body>
</html>