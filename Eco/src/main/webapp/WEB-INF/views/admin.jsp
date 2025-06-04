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
    <!-- 사용자 검색 영역 -->
    <h2>사용자 검색</h2>
    <input type="text" id="searchKeyword" placeholder="사용자명 입력" />
    <button onclick="searchUser()">검색</button>

    <!-- 사용자 리스트 -->
    <table id="userTable">
        <thead>
            <tr>
                <th>사용자번호</th>
                <th>사용자ID</th>
                <th>이름</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>

    <button onclick="loadUsage()">조회</button>

    <!-- 사용 내역 영역 -->
    <h2>냉난방 사용 내역</h2>
    <table id="usageTable">
        <thead>
            <tr>
                <th>월</th>
                <th>가스사용량</th>
                <th>수정</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>

<script>
let selectedUserCd = null; // 선택된 사용자 번호
let selectedUsageId = null; // 선택된 사용내역 ID

// 사용자 검색 함수
function searchUser() {
    const keyword = $("#searchKeyword").val();
    if (!keyword) {
        alert("사용자명을 입력하세요");
        return;
    }

    $.ajax({
        url: "/admin/user/search", // ← 서버 컨트롤러 주소 연결 필요
        method: "GET",
        data: { keyword: keyword },
        success: function(users) {
            const tbody = $("#userTable tbody").empty();
            users.forEach(user => {
                const row = $("<tr>").append(
                    $("<td>").text(user.user_cd),
                    $("<td>").text(user.user_id),
                    $("<td>").text(user.user_nm)
                ).click(() => {
                    selectedUserCd = user.user_cd;
                    $("#userTable tr").removeClass("selected");
                    row.addClass("selected");
                });
                tbody.append(row);
            });
        },
        error: () => alert("사용자 검색 실패")
    });
}

// 사용자 냉난방 내역 조회
function loadUsage() {
    if (!selectedUserCd) {
        alert("사용자를 선택하세요");
        return;
    }

    $.ajax({
        url: "/admin/user/" + selectedUserCd + "/usage", // ← 서버 컨트롤러 주소 연결 필요
        method: "GET",
        success: function(data) {
            const tbody = $("#usageTable tbody").empty();
            data.forEach(usage => {
                const row = $("<tr>").append(
                    $("<td>").text(usage.month),
                    $("<td>").html(`<input type="number" value="${usage.gas_usage}" id="gas_${usage.usage_id}" />`),
                    $("<td>").html(`<button onclick="updateUsage(${usage.usage_id})">수정</button>`),
                    $("<td>").html(`<button onclick="deleteUsage(${usage.usage_id})">삭제</button>`)
                );
                tbody.append(row);
            });
        },
        error: () => alert("사용내역 조회 실패")
    });
}

// 사용내역 수정
function updateUsage(usageId) {
    const newUsage = $(`#gas_${usageId}`).val();

    $.ajax({
        url: "/admin/usage/update", // ← 서버 컨트롤러 주소 연결 필요
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify({ usage_id: usageId, gas_usage: newUsage }),
        success: function(response) {
            if (response.success) {
                alert("수정되었습니다");
                loadUsage(); // 수정 후 다시 로딩
            } else {
                alert("수정 실패");
            }
        },
        error: () => alert("요청 실패")
    });
}

// 사용내역 삭제
function deleteUsage(usageId) {
    if (!confirm("삭제하시겠습니까?")) return;

    $.ajax({
        url: "/admin/usage/delete", // ← 서버 컨트롤러 주소 연결 필요
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify({ usage_id: usageId }),
        success: function(response) {
            if (response.success) {
                alert("삭제되었습니다");
                loadUsage(); // 삭제 후 다시 로딩
            } else {
                alert("삭제 실패");
            }
        },
        error: () => alert("요청 실패")
    });
}
</script>

</body>
</html>