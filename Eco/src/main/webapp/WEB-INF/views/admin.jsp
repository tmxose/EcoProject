<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Eco</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	const isLoggedIn = ${not empty sessionScope.currentUserInfo};
</script>
<script src="/resources/js/adminUsage.js"></script>
<link rel="stylesheet" type="text/css"
	href="/resources/css/common.css?after">
<link rel="stylesheet" type="text/css"
	href="/resources/css/usage.css?after">
<style>
table {
	border-collapse: collapse;
	width: 100%;
	margin-top: 10px;
}

th, td {
	border: 1px solid #ccc;
	padding: 8px;
	text-align: center;
}

.selected {
	background-color: #f0f8ff;
}

.search-container {
	width: 80%;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: flex-start;
	gap: 8px;
	padding: 10px;
	box-sizing: border-box;
	background-color: #fefefe;
}

.search-area {
	width: 100%;
	display: flex;
	flex-direction: row;
	justify-content: center;
	align-items: center; /* 추가 */
	gap: 10px;
}

.search-area input[type="text"] {
	height: 36px;
	padding: 0 10px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.search-area button.green-btn {
	height: 36px;
	padding: 0 16px;
	font-size: 14px;
	border: none;
	border-radius: 4px;
	background-color: #82cd2b;
	color: white;
	cursor: pointer;
}

.search-area button.green-btn:hover {
	background-color: #218838;
}

.search-inner-container {
	display: flex;
	width: 100%;
	flex-direction: column;
	align-items: center;
	min-height: 200px;
	border: 1px solid #82cd2b;
	border-radius: 4px;
	padding: 10px;
	box-sizing: border-box;
}

.type-tab {
	display: flex;
	justify-content: space-around;
	width: 80%;
	align-items: center;
	text-align: center;
	box-sizing: border-box;
	padding: 10px;
}

.type-tab-btn {
	display: flex;
	width: 60%;
	line-height: 50px;
	justify-content: center;
	margin: 0;
	background-color: #c5ee8f;
	color: white;
	cursor: pointer;
	border: none;
}

.type-tab-btn.active {
	background-color: #82cd2b; /* 활성화 색상 */
	color: white;
}

.result-container {
	width: 80%;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: flex-start;
	gap: 8px;
	padding: 10px;
	box-sizing: border-box;
	background-color: #fefefe;
}

.result-inner-container {
	display: flex;
	width: 100%;
	flex-direction: column;
	align-items: center;
	min-height: 200px;
	border: 1px solid #82cd2b;
	border-radius: 4px;
	padding: 10px;
	box-sizing: border-box;
}
/* Modal Styles */
.modal-container {
    width: 30%;
    display: none; /* Controlled by JS */
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: white;
    padding: 30px;
    border: 1px solid #82cd2b;
    border-radius: 8px;
    z-index: 1000;
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.modal-field {
    margin-bottom: 15px;
}

.modal-field label {
    display: block;
    margin-bottom: 5px;
}

.modal-input {
    width: calc(100% - 22px);
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.modal-select {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.modal-buttons {
    text-align: right;
}

.modal-buttons .green-btn:first-child {
    margin-right: 10px;
}

.modal-overlay {
    display: none; /* Controlled by JS */
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    z-index: 999;
}
#usageTable tbody tr.selected, #userTable tbody tr.selected {
    background-color: #f0f8ff !important; /* 예시: #ADD8E6 (밝은 파란색) */
}
</style>
</head>
<body>
	<div class="container">
		<div class="inner-container">
			<div class="head-box">
				<!-- 아이콘 -->
				<a href="/"><img src="/resources/img/icon.png" class="icon"></a>
				<!-- 메인화면 글씨 -->
				<div class="title-container">
					<h2>관리자 페이지</h2>
				</div>
				<!-- 버튼 내비게이션 -->
				<div class="header-container">
					<!-- 위쪽 텍스트 -->
					<div class="header-inner-container">
						<span>${currentUserInfo.user_nm} 님, 환영합니다.</span>
					</div>
					<!-- 아래쪽 버튼 -->
					<div class="header-inner-container">
						<button class="green-btn-2" onclick='location.href="/mypage"'>마이페이지</button>
						<button class="green-btn-2"
							onclick='location.href="/login/logout"'>로그아웃</button>
					</div>
				</div>
			</div>
			<div class="green-line"></div>
			<div class="main-container">
				<!-- 페이지 이동 버튼 -->
				<button class="green-btn" onclick='location.href="/"'>메인페이지</button>
				<button class="green-btn" onclick="goToMyUsagePage()">내 사용량
					조회</button>
			</div>
		</div>

		<!-- 사용자 검색 영역 start------------------------------ -->
		<div class="inner-container">
			<div class="search-container">
				<h2>사용자 검색</h2>
				<div class="search-inner-container">
					<div class="search-area">
						<input type="text" id="searchKeyword" placeholder="사용자명 입력" />
						<button class="green-btn" onclick="searchUser()">검색</button>
					</div>
					<table id="userTable">
						<thead>
							<tr>
								<th style="width: 25%">사용자 번호</th>
								<th style="width: 25%">사용자 아이디</th>
								<th style="width: 25%">이름</th>
								<th style="width: 25%">지역</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="4">조회된 사용자가 없습니다.</td>
							</tr>
						</tbody>
					</table>
				</div>

			</div>
		</div>
		<!-- 사용자 검색 영역 end------------------------------ -->

		<!-- 사용자별 에너지 사용량 관리 영역 start ------------------------ -->
		<div class="inner-container">
			<!-- 에너지 타입 선택 -->
			<div class="type-tab">
				<button id="gasBtn" class="type-tab-btn active"
					onclick="selectEnergyType('GAS')">가스 사용량</button>
				<button id="elecBtn" class="type-tab-btn"
					onclick="selectEnergyType('ELEC')">전기 사용량</button>
			</div>

			<div id="usageSection" class="result-container">
				<div class="search-area">
					<h3 id="usageTitle">가스 사용내역</h3>
					<button class="green-btn" onclick="showUsageModal('add')">등록</button>
					<button class="green-btn" onclick="showUsageModal('edit')">수정</button>
					<button class="green-btn" onclick="deleteUsage()">삭제</button>
				</div>
				<div class="result-inner-container">
					<table id="usageTable" border="1">
						<thead>
							<tr>
								<th style="width: 20%;">선택</th>
								<th style="width: 40%;">날짜</th>
								<th style="width: 40%;">사용량</th>
							</tr>
						</thead>
						<tbody>
							<tr><td colspan="3">조회된 사용량 데이터가 없습니다.</td></tr>
						</tbody>
					</table>
					
				</div>
	
			</div>
		</div>			 
		<!-- 사용자별 에너지 사용량 관리 영역 end ------------------------ -->
		<!-- 등록 수정 모달 폼 전체 영역 -->
		<div id="usageModal" class="modal-container">
				<h3 id="modalTitle">사용량 관리</h3>
				<input type="hidden" id="modal_mode"> <input type="hidden"
					id="modal_usage_cd"> <input type="hidden"
					id="modal_user_cd">
				<div class="modal-field">
					<label for="modal_date">사용 일자:</label>
					<input type="date" id="modal_date" class="modal-input" required>
				</div>

				<div class="modal-field">
					<label for="modal_type_select">타입 선택:</label>
					<select id="modal_type_select" class="modal-select" required>
						<option value="">-- 타입 선택 --</option>
						<optgroup label="가스 타입">
							<c:forEach var="gas" items="${gasList}">
								<option value="${gas.gas_cd}" data-energy-type="GAS">${gas.type}</option>
							</c:forEach>
						</optgroup>
						<optgroup label="전기 타입">
							<c:forEach var="elec" items="${elecList}">
								<option value="${elec.elec_cd}" data-energy-type="ELEC">${elec.type}</option>
							</c:forEach>
						</optgroup>
					</select>
				</div>

				<div class="modal-field" style="margin-bottom: 20px;">
					<label for="modal_usage_input">사용량:</label>
					<input type="number" id="modal_usage_input" step="0.01" min="0" class="modal-input" required>
				</div>

				<div class="modal-buttons">
					<button class="green-btn" onclick="saveUsageData()">저장</button>
					<button class="green-btn" onclick="hideUsageModal()">취소</button>
				</div>
			</div>

			<div id="modalOverlay" class="modal-overlay"></div>
		</div>

		<!-- 여긴 높이 보정용 푸터 입니다. -->
		<footer></footer>

		<!-- 데이터 저장 alert메세지 -->
		<c:if test="${not empty msg}">
			<script>
	        	alert('${msg}');
	    	</script>
		</c:if>
</body>
</html>
