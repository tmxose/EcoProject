<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

.container {
	width: 90%;
	margin: auto;
	padding: 20px;
}
</style>
</head>
<body>
	<div class="container">
		<h2>사용자 검색</h2>
		<input type="text" id="searchKeyword" placeholder="사용자명 입력" />
		<button onclick="searchUser()">검색</button>

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

		<button onclick="loadUsageData()">조회</button>

		<!-- 에너지 타입 선택 -->
		<div style="margin-top: 20px;">
			<button onclick="selectEnergyType('GAS')">가스 사용량</button>
			<button onclick="selectEnergyType('ELEC')">전기 사용량</button>
		</div>

		<div id="usageSection">
			<h3 id="usageTitle">가스 사용내역</h3>
			<button onclick="enableEdit()">수정</button>
			<button onclick="deleteUsage()">삭제</button>
			<button onclick="showAddForm()">등록</button>

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

			<div id="addForm" style="display: none; margin-top: 10px;">
				날짜: <input type="date" id="newDate"> 사용량: <input
					type="number" step="0.1" id="newUsage">
				<button onclick="addUsage()">등록</button>
				<button onclick="hideAddForm()">취소</button>
			</div>
		</div>
	</div>

	<script>
let selectedUserCd = null;
let selectedUsageCd = null;
let energyType = "GAS";

function selectEnergyType(type) {
	energyType = type;
	jQuery("#usageTitle").text(type === 'GAS' ? '가스 사용내역' : '전기 사용내역');
	loadUsageData();
}

function searchUser() {
	const keyword = jQuery("#searchKeyword").val();
	if (!keyword) return alert("검색어를 입력하세요.");

	jQuery.ajax({
		url: "/admin/search-users",
		type: "GET",
		data: { keyword },
		dataType: "json", // JSON으로 받기
		success: function(users) {
			const tbody = jQuery("#userTable tbody").empty();
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
	loadUsageData();
}

function loadUsageData() {
	if (!selectedUserCd) return;

	const url = energyType === 'GAS'
		? "/admin/user/" + selectedUserCd + "/gas-usage"
		: "/admin/user/" + selectedUserCd + "/elec-usage";


	jQuery.ajax({
		url: url,
		type: "GET",
		dataType: "json", // JSON으로 명시
		success: function(data) {
			// 배열인지 확인
			if (!Array.isArray(data)) {
				alert("서버 응답이 배열이 아닙니다.");
				console.error("data:", data);
				return;
			}

			const tbody = jQuery("#usageTable tbody").empty();
			selectedUsageCd = null;

			data.forEach(function(row) {
				const usage = energyType === 'GAS' ? row.gas_usage : row.elec_usage;
				const time = row.gas_time || row.elec_time;
				const trHtml = 
					'<tr data-id="' + row.usage_cd + '">' +
						'<td><input type="radio" name="selectUsage" value="' + row.usage_cd + 
						'" onclick="selectRow(' + row.usage_cd + ', ' + usage + ', \'' + time + '\')"></td>' +
						'<td class="date">' + time.substring(0,10) + '</td>' +
						'<td class="usage">' + usage + '</td>' +
					'</tr>';
				tbody.append(trHtml);
			});
		},
		error: function(xhr, status, error) {
			alert("사용내역 로드 중 오류가 발생했습니다.");
			console.error("AJAX error:", status, error);
		}
	});
}

function selectRow(id, usage, date) {
	selectedUsageCd = id;
}

function enableEdit() {
	if (!selectedUsageCd) return alert("수정할 행을 선택하세요.");
	const row = jQuery("tr[data-id='" + selectedUsageCd + "']");
	const usageVal = row.find(".usage").text();
	row.find(".usage").html("<input type='number' step='0.1' value='" + usageVal + "' />");
	row.append("<td><button onclick='saveEdit(" + selectedUsageCd + ")'>저장</button></td>");
}
function saveEdit(id) {
	const row = jQuery("tr[data-id='" + id + "']");
	const newVal = row.find("input").val();
	const url = energyType === 'GAS' ? "/admin/gas/update" : "/admin/elec/update";

	jQuery.ajax({
		url: url,
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify({
			usage_cd: id,
			[energyType === 'GAS' ? 'gas_usage' : 'elec_usage']: newVal
		}),
		success: function() {
			alert("수정되었습니다.");
			loadUsageData();
		}
	});
}

function deleteUsage() {
	if (!selectedUsageCd) return alert("삭제할 행을 선택하세요.");
	if (!confirm("정말 삭제하시겠습니까?")) return;

	const url = energyType === 'GAS' ? "/admin/gas/delete" : "/admin/elec/delete";

	jQuery.ajax({
		url: url,
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify({ usage_cd: selectedUsageCd }),
		success: function() {
			alert("삭제되었습니다.");
			loadUsageData();
		}
	});
}

function showAddForm() {
	jQuery("#addForm").show();
}

function hideAddForm() {
	jQuery("#addForm").hide();
}

function addUsage() {
	const date = jQuery("#newDate").val();
	const usage = jQuery("#newUsage").val();
	if (!date || !usage) return alert("모든 값을 입력해주세요.");

	const url = energyType === 'GAS' ? "/admin/gas/insert" : "/admin/elec/insert";
	const payload = {
		user_cd: selectedUserCd,
		[energyType === 'GAS' ? 'gas_usage' : 'elec_usage']: usage,
		[energyType === 'GAS' ? 'gas_time' : 'elec_time']: date,
		use_yn: 'Y'
	};

	jQuery.ajax({
		url: url,
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(payload),
		success: function() {
			alert("등록되었습니다.");
			hideAddForm();
			loadUsageData();
		}
	});
}
</script>
</body>
</html>
