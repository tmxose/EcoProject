<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		#main_use{display: inline-block; width: 200px; height: 40px; border: 1px solid black; text-align: center; line-height: 40px; position: relative; top:1px; border-top-left-radius: 15px; border-top-right-radius: 15px;}
		#main_charge{display: inline-block; width: 180px; height: 35px; border: 1px solid black; position: relative; top:4px; left: -6px; text-align: center; line-height: 35px; border-top-left-radius: 15px; border-top-right-radius: 15px;}
		#main_info{border: 1px solid black; border-radius: 7px; border-top-left-radius: 0;}
		#main .title{clear:both; display: inline-block; margin: 20px; font-size: 20px; font-weight: bold;}
		#main table{width: 80%; margin: 0 auto;}
		#main table, th, td{border: 1px dotted black; border-collapse: collapse;}

		#main form{width: 90%; margin: 0 auto;}
		#main select{width: 100px; height: 25px;}
		#main input{width: 50px; text-align: center;}
		#main_data{margin: 20px auto; width: 90%; height: 200px; border: 1px dotted black;}
	</style>
</head>
<body>
	<div id="wrap">
		<div id="head">
			<img src="#" id="head_icon">
			<div id="head_user">
				<span>(사용자)님, 환영합니다.</span>
				<a href="#">로그아웃</a>
			</div>
			<div id="head_image">(이미지, 생략 가능)</div>
		</div>
        
		<div id="main">
			<div id="main_use"><a href="/usage">사용량</a></div>
			<div id="main_charge"><a href="/charge">요금</a></div>
			<div id="main_info">
				<span class="title">이번 달 나의 에너지 사용 현황</span><br>
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
						<td>${ usage.gas_usage }</td>
						<td>${ usage.elec_usage }</td>
					</tr>
				</table>
				<span class="title">과거 에너지 사용 이력</span>
				<form>
					<span>기간 : </span>
					<select>
						<option>지난 1개월</option>
						<option>지난 3개월</option>
						<option>지난 6개월</option>
						<option>지난 12개월</option>
					</select>
					<input type="submit" value="조회">
				</form>
				<div id="main_data">
					(과거 사용 이력)
				</div>
			</div>
		</div>
	</div>
</body>
</html>