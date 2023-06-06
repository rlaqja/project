<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
<link href="../resources/css/style.css" rel="stylesheet" type="text/css">
<link href="../resources/css/NewPw.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
	<div id="wrap">
		 <h2>회원님의 이메일로</h2><br/>
		 <h2>가입된 아이디가 있습니다.</h2>
		<div id="content_wrap">
			<div id="content">
			   <div id = "idCheckBox">
				   <div class="head"></div>
					    <div id="FindIdBox" class="form-control">
					        <!-- ... -->
					        <span id="showId"></span> <!-- 아이디를 출력할 위치 -->
					        <!-- ... -->
					</div>	
				   <div class="head"></div>
			    </div>
			</div>
		</div>
		<button type="submit" id="idReset" onclick="member.jsp">확 인</button>
	</div>