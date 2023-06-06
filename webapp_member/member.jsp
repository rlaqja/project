<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../resources/css/alarm.css" rel="stylesheet" type="text/css">
<link href="../resources/css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript" src="../resources/js/sockjs-0.3.4.js"></script>
<script type="text/javascript" src="../resources/js/stomp.
js"></script>
<script type="text/javascript" src="../resources/js/WebSocket.js"></script>
<script type="text/javascript">
	$(function() {
		$('#b1').click(function() {
			var id = $('#id').val();
			var pw = $('#pw').val();
			
			if(id != '') {
				if(pw != ''){
					$.ajax({
						url:"login",
						type:'post',
						data:{
							id: id,
							pw: pw
						},
						success: function(result) {
							alert(result)
							$.ajax({
								url: '../chat/myChatRoomIds',
								data: {
									memberId: id
								},
								success: function(roomIds) {
									subscribeToChatRooms(roomIds);
									location.href = document.referrer;
								},
								error: function(e) {
									console.log(e)
								}
							})
						},//success
					})//ajax
				}else {
					alert("비밀번호를 입력해주세요");
				}
			}else{
				alert("아이디를 입력해주세요");
			}
		})
	})
</script>
<style>
	body {
		text-align: center;
	} 
	
	 #loginbox {	
		display: flex;
		flex-flow : column;
		align-items: center;
		gap : 10px;
	}
	
	.container  {
		display: flex;
		flex-flow: column;
		align-items: center;
	}
	
	.form-control {
		margin: 10px;
	}
	
	button{
		border-style: none;
		border-radius: 3px;
	}
</style>
</head>
<body>
	<div id="wrap">
		<div id="newMessagePushAlarm"></div>
		<div id="header">
			<jsp:include page="../home/Header.jsp" flush="true"/>
		</div>
		<div id="content_wrap">
			<div id="content">
		     	<div id="loginbox" >
		<h2>로그인</h2>
		<!-- <div class="container"> -->
			    <input id="id" type="text"  placeholder="아이디를 입력해주세요." style="width: 350px; height: 40px; background: #F6F6F6"> 
				<input id="pw" type="password" placeholder="비밀번호를 입력해주세요." style="width: 350px; height: 40px; background: #F6F6F6">			
			<!-- <button type="submit" class="container" style="width:-50px">서버로 전송</button>-->
			
			<button id="b1" style="width: 350px; height: 40px; background : #693FAA; color: #FFF; cursor: pointer;">로그인</button>				
			<button type="button" style="background: #F6F6F6; width: 350px; height: 40px; font-style: #6f42c1; cursor: pointer;" onClick="location.href='signup.jsp'">회원가입</button>
			<br>
                </div>
					<button type="button" 
					style="background: #FFFFFF; cursor: pointer;" onClick="location.href='findpw.jsp'">비밀번호 찾기</button>
					<button type="button" 
					style="background: #FFFFFF; cursor: pointer;" onClick="location.href='findid.jsp'">아이디 찾기</button>
			</div>
		</div>
	<jsp:include page="../home/Footer.jsp" flush="true"/>
	</div>
</body>
</html>