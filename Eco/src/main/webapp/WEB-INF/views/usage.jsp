<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
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
				<span>(�����)��, ȯ���մϴ�.</span>
				<a href="#">�α׾ƿ�</a>
			</div>
			<div id="head_image">(�̹���, ���� ����)</div>
		</div>
        
		<div id="main">
			<div id="main_use"><a href="#">��뷮</a></div>
			<div id="main_charge"><a href="#">���</a></div>
			<div id="main_info">
				<span class="title">�̹� �� ���� ������ ��� ��Ȳ</span><br>
				<table>
					<colgroup>
						<col width="50%">
						<col width="50%">
					</colgroup>
					<tr>
						<th>���ð���</th>
						<th>����</th>
					</tr>
					<tr>
						<td>����</td>
						<td>����</td>
					</tr>
				</table>
				<span class="title">���� ������ ��� �̷�</span>
				<form>
					<span>�Ⱓ : </span>
					<select>
						<option>���� 1����</option>
						<option>���� 3����</option>
						<option>���� 6����</option>
						<option>���� 12����</option>
					</select>
					<input type="submit" value="��ȸ">
				</form>
				<div id="main_data">
					(���� ��� �̷�)
				</div>
			</div>
		</div>
	</div>
</body>
</html>