let isIdChecked = false; // 아이디 중복 확인 완료 여부

function validateForm() {
    const userIdInput = document.querySelector('input[name="user_id"]');
    const userPwInput = document.querySelector('input[name="user_pw"]');
    const userNmInput = document.querySelector('input[name="user_nm"]');
        
    const userId = userIdInput.value.trim();
    const userPw = userPwInput.value.trim();
    const userNm = userNmInput.value.trim();
    
    if (userId === "" || userId === null) {
        alert("아이디를 입력해주세요.");
        userIdInput.focus();
        return false; // Prevent form submission
    }
    if (!isIdChecked) {
        alert("아이디 중복 확인을 해주세요.");
        userIdInput.focus();
        return false;
    }
    if (userPw === "" || userPw === null) {
        alert("비밀번호를 입력해주세요.");
        userPwInput.focus();
        return false;
    }
    if (userNm === "" || userNm === null) {
        alert("이름을 입력해주세요.");
        userNmInput.focus();
        return false;
    }

    return true;
}
// 아이디 중복 확인
function checkDuplicateId() {
        const userId = document.querySelector('input[name="user_id"]').value;
        if (!userId) {
            alert("아이디를 입력하세요.");
            return;
        }

        fetch("/check-id?user_id=" + encodeURIComponent(userId))
            .then(res => res.text())
            .then(result => {
                if (result === "duplicate") {
                    alert("이미 사용 중인 아이디입니다.");
                    isIdChecked = false;
                } else {
                    alert("사용 가능한 아이디입니다!");
                    isIdChecked = true;
                }
            })
            .catch(err => {
                console.error("중복 확인 에러:", err);
                isIdChecked = false;
            });
}