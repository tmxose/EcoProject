<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div id="wrap">
		<div>
			<img src="" id="logo_icon">
			<span>(사용자)님, 환영합니다.</span>
			<a href="#">로그아웃</a>
			<div>(이미지, 생략 가능)</div>
		</div>
		<div>
			<div>사용량</div>
			<div>요금</div>
			<div>
				<span>이번 달 나의 에너지 사용량</span>
				<div>
					도시가스
				</div>
				<div>
					전기
				</div>
				<span>과거 사용 이력</span>
				<form>
					<span>기간 : </span>
					<select>
						<option>지난 1개월</option>
						<option>지난 3개월</option>
						<option>지난 6개월</option>
						<option>지난 12개월</option>
					</select>
					<input type="submit" value="조회하기">
				</form>
				<div>
					(과거 사용 이력)
				</div>
			</div>
		</div>
	</div>
</body>
</html>