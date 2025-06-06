<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Eco</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/common.css?after">
<link rel="stylesheet" type="text/css" href="/resources/css/usage.css?after">
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
.search-container{
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

.search-area{
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
.search-inner-container{
	display: flex;
	width:100%;
	flex-direction: column;
	align-items: center;
	min-height: 200px;
	border: 1px solid #82cd2b;
	border-radius: 4px;
	padding:10px;
	box-sizing: border-box;
}
.type-tab{
	display: flex; 
	justify-content: center; 
	width: 100%; 
	align-items: center;
	text-align: center;
	padding:10px;	
}
.result-container{
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
.result-inner-container{
	display: flex;
	width:100%;
	flex-direction: column;
	align-items: center;
	min-height: 200px;
	border: 1px solid #82cd2b;
	border-radius: 4px;
	padding:10px;
	box-sizing: border-box;
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
				<div class="title-container"><h2>관리자 페이지</h2></div>
				<!-- 버튼 내비게이션 -->
				<div class="header-container">
					<!-- 위쪽 텍스트 -->
					<div class="header-inner-container">
						<span>${userName} 님, 환영합니다.</span> 
					</div>
					<!-- 아래쪽 버튼 -->
					<div class="header-inner-container">
						<button class="green-btn-2" onclick='location.href="/mypage"'>마이페이지</button>
						<button class="green-btn-2" onclick='location.href="/login/logout"'>로그아웃</button>
					</div>
				</div>
			</div>
			<div class="green-line"></div>
			<div class="main-container">
				<!-- 페이지 이동 버튼 -->
				<button class="green-btn" onclick='location.href="/"'>메인페이지</button> 
				<button class="green-btn" onclick="goToMyUsagePage()">내 사용량 조회</button> 
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
								<th>사용자 번호</th>
								<th>사용자 아이디</th>
								<th>이름</th>
								<th>지역</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
				</div>
				
			</div>
		</div>
		<!-- 사용자 검색 영역 end------------------------------ -->

		<!-- 사용자별 에너지 사용량 관리 영역 start ------------------------ -->
		<div class="inner-container">
			<!-- 에너지 타입 선택 -->
			<div class="type-tab">
				<button class="box1" onclick="selectEnergyType('GAS')">가스 사용량</button>
				<button class="box1" onclick="selectEnergyType('ELEC')">전기 사용량</button>
			</div>
			
			<div id="usageSection" class="result-container">
				<div class="search-area">
					<h3 id="usageTitle">가스 사용내역</h3>
					<button class="green-btn" onclick="showAddForm()">등록</button>
					<button class="green-btn" onclick="enableEdit()">수정</button>
					<button class="green-btn" onclick="deleteUsage()">삭제</button>
				</div>
				<div class="result-inner-container">
					<table id="usageTable" border="1">
						<thead>
							<tr>
								<th>선택</th>
								<th>날짜</th>
								<th>사용량</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
					<!-- 등록 폼 전체 영역 -->
					<div id="addForm" style="display: none; margin-top: 10px;">
						<!-- 가스 등록 폼 -->
						<form id="gasForm" action="/admin/gas/insert" method="post">
							<input type="hidden" name="user_cd" id="gas_user_cd" /> <label>사용
								일자:</label> <input type="date" name="gas_time" required /> <label
								for="gas_cd">가스 타입 선택:</label> <select id="gas_cd" name="gas_cd"
								required>
								<option value="">-- 타입 선택 --</option>
								<c:forEach var="gas" items="${gasList}">
									<option value="${gas.gas_cd}">${gas.type}</option>
								</c:forEach>
							</select> <label for="gas_usage">가스 사용량 (m³):</label> <input type="number"
								id="gas_usage" name="gas_usage" step="0.01" min="0" required />
		
							<button type="submit">가스 사용량 등록</button>
							<button type="button" onclick="hideAddForm()">취소</button>
						</form>
		
						<!-- 전기 등록 폼 -->
						<form id="elecForm" action="/admin/elec/insert" method="post">
							<input type="hidden" name="user_cd" id="elec_user_cd" /> <label>사용
								일자:</label> <input type="date" name="elec_time" required /> <label
								for="elec_cd">전기 타입 선택:</label> <select id="elec_cd"
								name="elec_cd" required>
								<option value="">-- 타입 선택 --</option>
								<c:forEach var="elec" items="${elecList}">
									<option value="${elec.elec_cd}">${elec.type}</option>
								</c:forEach>
							</select> <label for="elec_usage">전기 사용량 (kWh):</label> <input type="number"
								id="elec_usage" name="elec_usage" step="0.01" min="0" required />
		
							<button type="submit">전기 사용량 등록</button>
							<button type="button" onclick="hideAddForm()">취소</button>
						</form>
					</div>
				</div>
	
			</div>
		</div>			
		<!-- 사용자별 에너지 사용량 관리 영역 end ------------------------ -->
	
	</div>
		
	<!-- 여긴 높이 보정용 푸터 입니다. -->
	<footer></footer>
	
	<!-- 데이터 저장 alert메세지 -->
	<c:if test="${not empty msg}">
		<script>
	        alert('${msg}');
	    </script>
	</c:if>

	<script>
let selectedUserCd = null;
let selectedUsageCd = null;
let energyType = "GAS";

function selectEnergyType(type) {
	energyType = type;
	jQuery("#usageTitle").text(type === 'GAS' ? '가스 사용내역' : '전기 사용내역');
	loadUsageData();
	jQuery("#gasForm").hide();
	jQuery("#elecForm").hide();
}

//가스 사용량 등록폼 이벤트리스너
document.getElementById('gasForm').addEventListener('submit', function (e) {
    e.preventDefault();  // 기본 제출 막기

    if (!selectedUserCd) {
        alert('사용자를 선택해주세요.');
        return;
    }

    // user_cd 세팅
    document.getElementById('gas_user_cd').value = selectedUserCd;
    const gasCd = document.getElementById('gas_cd').value;
    // 날짜 포맷 (yyyy-MM-dd로 고정)
    const dateInput = this.querySelector('input[name="gas_time"]').value;
 	
    // 폼 데이터 수집
    const gasUsage = this.querySelector('input[name="gas_usage"]').value;

    // JSON 형태로 데이터 구성
    const jsonData = {
        user_cd: selectedUserCd,
        gas_cd: gasCd,
        gas_usage: parseFloat(gasUsage),
        gas_time: dateInput
    };

    // AJAX 호출
    jQuery.ajax({
        url: '/admin/gas/insert',
        method: 'POST',
        data: JSON.stringify(jsonData),
        contentType: 'application/json',
        dataType: 'json', 
        success: function (response) {
            if (response == 'true' || response == true) {
                alert('가스 사용량 등록 성공');
                loadGasUsageData();
                hideAddForm();
                document.getElementById('gasForm').reset();
            } else {
                alert('가스 사용량 등록 실패');
            }
        },
        error: function () {
            alert('서버 통신 오류가 발생했습니다.');
        }
    });
});

// 전기 사용량 등록폼 이벤트리스너
document.getElementById('elecForm').addEventListener('submit', function (e) {
	 e.preventDefault();  // 기본 제출 막기

	    if (!selectedUserCd) {
	        alert('사용자를 선택해주세요.');
	        return;
	    }

	    // user_cd 세팅
	    document.getElementById('elec_user_cd').value = selectedUserCd;
	    const elecCd = document.getElementById('elec_cd').value;
	    // 날짜 포맷 (yyyy-MM-dd로 고정)
	    const dateInput = this.querySelector('input[name="elec_time"]').value;
	 	
	    // 폼 데이터 수집
	    const elecUsage = this.querySelector('input[name="elec_usage"]').value;

	    // JSON 형태로 데이터 구성
	    const jsonData = {
	        user_cd: selectedUserCd,
	        elec_cd: elecCd,
	        elec_usage: parseFloat(elecUsage),
	        elec_time: dateInput
	    };

	    // AJAX 호출
	    jQuery.ajax({
	        url: '/admin/elec/insert',
	        method: 'POST',
	        data: JSON.stringify(jsonData),
	        contentType: 'application/json',
	        dataType: 'json', 
	        success: function (response) {
	            if (response == 'true' || response == true) {
	                alert('전기 사용량 등록 성공');
	                loadElecUsageData();
	                hideAddForm();
	                document.getElementById('elecForm').reset();
	            } else {
	                alert('전기 사용량 등록 실패');
	            }
	        },
	        error: function () {
	            alert('서버 통신 오류가 발생했습니다.');
	        }
	    });
});
	
function searchUser() {
	const keyword = jQuery("#searchKeyword").val();
	if (!keyword) return alert("사용자 이름을 입력하세요.");

	jQuery.ajax({
		url: "/admin/search-users",
		type: "GET",
		data: { keyword },
		dataType: "json", // JSON으로 받기
		success: function(users) {
			const tbody = jQuery("#userTable tbody").empty();
			jQuery("#usageTable tbody").empty(); 
			users.forEach(user => {
				 // 각 항목을 안전하게 문자열로 변환
				  const rowHtml =
					  '<tr onclick="selectUser(' + user.user_cd + ')">' +
					    '<td>' + user.user_cd + '</td>' +
					    '<td>' + user.user_id + '</td>' +
					    '<td>' + user.user_nm + '</td>' +
					    '<td>' + user.user_local + '</td>' +
					  '</tr>';
				   
				    tbody.append(rowHtml);
			});
		}
	});
}

function selectUser(userCd) {
	selectedUserCd = userCd;

  // 모든 <tr> 태그에서 'selected' 클래스 제거
  document.querySelectorAll("tr").forEach(tr => {
    tr.classList.remove("selected");
  });

  // userCd가 포함된 td를 찾고, 그 td가 포함된 tr에 'selected' 추가
  const trs = document.querySelectorAll("#userTable tbody tr");

  trs.forEach(tr => {
    const tds = tr.querySelectorAll("td");
    for (const td of tds) {
      if (td.textContent.trim() === String(userCd)) {
        tr.classList.add("selected");
        break;
      }
    }
  });

	//공통 호출
	loadUsageData();
}
function loadUsageData() {
	if (!selectedUserCd) return;

	if (energyType === 'GAS') {
		loadGasUsageData();
	} else {
		loadElecUsageData();
	}
}

// 가스사용량 조회
function loadGasUsageData() {
	jQuery.ajax({
		url: '/admin/user/'+selectedUserCd+'/gas-usage',
		type: "GET",
		dataType: "json",
		success: function(data) {
			renderUsageTable(data, 'GAS');
		}
	});
}
// 전기 사용량 조회
function loadElecUsageData() {
	jQuery.ajax({
		url: '/admin/user/'+selectedUserCd+'/elec-usage',
		type: "GET",
		dataType: "json",
		success: function(data) {
			renderUsageTable(data, 'ELEC');
		}
	});
}
function renderUsageTable(data, type) {
	if (!Array.isArray(data)) {
		alert("데이터 형식이 잘못되었습니다.");
		return;
	}

	const tbody = jQuery("#usageTable tbody").empty();
	selectedUsageCd = null;

	data.forEach(row => {
		const usage = type === 'GAS' ? row.gas_usage : row.elec_usage;
		const time = type === 'GAS' ? row.gas_time : row.elec_time;
		const timeStr = new Date(time).toISOString().split("T")[0] || "-";
		const trHtml =
			'<tr data-id="' + row.usage_cd + '">' +
				'<td><input type="radio" name="selectUsage" value="' + row.usage_cd + '" onclick="selectRow(' + row.usage_cd + ')"></td>' +
				'<td class="date">' + timeStr + '</td>' +
				'<td class="usage">' + usage + '</td>' +
			'</tr>';

		tbody.append(trHtml);
	});
}
// 가스 사용량 등록
function addGasUsage(date, usage) {
	jQuery.ajax({
		url: "/admin/gas/insert",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify({
			user_cd: selectedUserCd,
			gas_cd: gasType,
			gas_usage: usage,
			gas_time: date
		}),
		success: function() {
			alert("가스 사용량 등록됨");
			loadGasUsageData();
		}
	});
}

function addElecUsage(date, usage) {
	jQuery.ajax({
		url: "/admin/elec/insert",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify({
			user_cd: selectedUserCd,
			elec_usage: usage,
			elec_time: date,
			use_yn: 'Y'
		}),
		success: function() {
			alert("전기 사용량 등록됨");
			loadElecUsageData();
		}
	});
}


function selectRow(id, usage, date) {
	selectedUsageCd = id;
}

function enableEdit() {
	if (!selectedUsageCd) return alert("수정할 행을 선택하세요.");
	const row = jQuery("tr[data-id='" + selectedUsageCd + "']");
	const usageCell = row.find(".usage");
	
	// 이미 input이 존재하면 중복 편집 방지
	if (usageCell.find("input").length > 0) return;

	const usageVal = usageCell.text();
	usageCell.html("<input type='number' step='0.1' value='" + usageVal + "' />");

	// 기존 버튼이 존재하는 경우 제거
	row.find(".save-button-cell").remove();
	row.append('<td class="save-button-cell"><button onclick="saveEdit(' + selectedUsageCd + ')">저장</button></td>');
}


function saveEdit(id) {
	const row = jQuery("tr[data-id='" + id + "']");
	const newVal = row.find("td.usage input").val();
	
	if (energyType === 'GAS') {
		saveGasEdit(id, newVal);
	} else {
		saveElecEdit(id, newVal);
	}
}
// 가스사용량 수정
function saveGasEdit(id, newVal) {
	jQuery.ajax({
		url: "/admin/gas/update",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify({
			usage_cd: id,
			gas_usage: newVal
		}),
		success: function() {
			alert("가스 사용량이 수정되었습니다.");
			loadGasUsageData();
		}
	});
}
// 전기 사용량 수정
function saveElecEdit(id, newVal) {
	console.log(id,newVal);
	jQuery.ajax({
		url: "/admin/elec/update",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify({
			usage_cd: id,
			elec_usage: newVal
		}),
		success: function() {
			alert("전기 사용량이 수정되었습니다.");
			loadElecUsageData();
		}
	});
}

function deleteUsage() {
	if (!selectedUsageCd) return alert("삭제할 행을 선택하세요.");
	if (!confirm("정말 삭제하시겠습니까?")) return;

	if (energyType === 'GAS') {
		deleteGasUsage();
	} else {
		deleteElecUsage();
	}
}

// 가스 사용량 삭제
function deleteGasUsage() {
	jQuery.ajax({
		url: "/admin/gas/delete",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify({ usage_cd: selectedUsageCd }),
		success: function() {
			alert("가스 사용내역이 삭제되었습니다.");
			loadGasUsageData();
		}
	});
}
// 전기사용량 삭제
function deleteElecUsage() {
	jQuery.ajax({
		url: "/admin/elec/delete",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify({ usage_cd: selectedUsageCd }),
		success: function() {
			alert("전기 사용내역이 삭제되었습니다.");
			loadElecUsageData();
		}
	});
}

function showAddForm() {
    if (!selectedUserCd) {
        alert('사용자를 선택해주세요.');
        return;
    }
    
	jQuery("#addForm").show();

	if (energyType === 'GAS') {
		jQuery("#gasForm").show();
		jQuery("#elecForm").find("input").val("").end().hide();
	} else {
		jQuery("#elecForm").show();
		jQuery("#gasForm").find("input").val("").end().hide();
	}
}

function hideAddForm() {
	jQuery("#addForm").hide();
	jQuery("#gasForm").find("input").val("").end().hide();
	jQuery("#elecForm").find("input").val("").end().hide();
}

</script>
</body>
</html>
