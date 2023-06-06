<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="short icon" href="#">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
<link href="../resources/css/style.css" rel="stylesheet" type="text/css">
<link href="../resources/css/alarm.css" rel="stylesheet" type="text/css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>   
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript" src="../resources/js/WebSocket.js"></script>
<script type="text/javascript" src="../resources/js/sockjs-0.3.4.js"></script>
<script type="text/javascript" src="../resources/js/stomp.js"></script>
<script type="text/javascript">
	  $(function() { 
		
		 var session = '<%= session.getAttribute("id")%>'
		 console.log(session)
		 
		 if (session !== "null") {
			/* 웹소켓 연결 */
			handlePageLoad(session);
			
			/* 안 읽은 메세지 체크 */
			unreadMessageCheck(session);
		 }
		
		$('document').ready(function() {
			$.ajax({
				url: 'balance',
				data: {
					id : session
				},
				success: function(result) {	
					$('.container').append(result)
				}
			})
		})
		
		$.ajax({
			url:'profile',
			data:{
				id: session
			},
			success: function(result) {
				console.log(result)
				let userProfile = document.getElementById('userProfile');
				userProfile.style.backgroundImage = result;
				userProfile.style.backgroundRepeat = 'no-repeat';
			}
		})
		
		$.ajax({
			url: '../pay/record',
			data: {
				memberId: session
			},
			success: function(result) {
				let userAmount = document.getElementById('userAmount');			
				userAmount.textContent = result.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");;
			}
		})
		
		//작성
		// 05-15 23:40 추가
		  $('#purchsList').click(function() {
			   $('.container').empty();
			$.ajax({
				url : 'purchsList',
				data : {
					id : session
				},
				success : function(result) {
					console.log(result)
					$('.container').append(result)
				}
			})
		})   
		   $('#sellList').click(function() {
			   $('.container').empty();
			$.ajax({
				url : 'sellList',
				data : {
					id : session
				},
				success : function(result) {
					// console.log(result)
					$('.container').append(result)
				}
			})
		})   
		   $('#basketList').click(function() {
			   $('.container').empty();
			$.ajax({
				url : 'basketList',
				data : {
					id : session
				},
				success : function(result) {
					// console.log(result)
					$('.container').append(result)
				}
			})
		})   
		   $('#updateuser').click(function() {
			   $('.container').empty();
			$.ajax({
				url : 'updateuser',
				success : function(x) {					
					$('.container').append(x)
				}
			})
		})   			
	  })
</script> 
<style type="text/css">
 <style>
body {
	text-align: center;
}

.fakeimg {
	width: 100%;
	margin-top: 50px;
}

  table, td, th {
	border: 0px solid black;
	border-collapse: collapse;
} 

 table {
	width: 200px;
	height: 100px;
} 

th, td {
	text-align: center;
} 
#seedcheck {
 	width: 210px;
 	height: 100px;
 	margin: 0 auto;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	padding: 30px;
	background-color: #6f42c1;
	border-radius: 30px;
	text-align: center;
}
 #updateuser2 {
 	width: 1000px;
 	margin: 0 auto;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	padding: 30px;
	background-color: #6f42c1;
	border-radius: 30px;
	text-align: center;
}
.btn{
	color: #fff;
}
.modal {
	position: absolute;
	top: 0;
	left: 0;
	width: 300px;
	height: 300px;
	background-color: pink;
	visibility: hidden;
}
.modal-close {
	width:100%;
}

#modal{
	display : none;
	z-index : 1;
	background-color: rgba(0,0,0,.3);
	position:fixed;
	left:0;
	top: 0;
	width:100%;
	height:100%;	
}
#modal>#invoice{
	width:300px;
	margin:225px auto;
	padding:20px;
	position: relative;
	background-color:#fff;
}

#modal .close{
	position:absolute;
	top:4px;
	right:4px;	
	font-size:20px;
	border:0;
	background-color: #fff;
}

#modal .close:hover,
#modal .close:focus {
  color : #000;
  text-decoration: none;
  cursor :pointer; 
}

input[id="hamburger"]+label {
	top: 5px;
}
</style>
<title>가지가지</title>
</head>
<body>
	<div id="wrap">
		<div id="header">
			<jsp:include page="../home/Header.jsp" flush="true" />
		</div>
		<div id="content_wrap">
			<div id="content">
				<div style="padding: 30px 100px; display: flex; gap: 50px;">
					<div style="display: flex; gap: 40px; width: 50%;">
						<div id="userProfile" style="width: 120px; height: 120px; border-radius: 160px; background: #000;"></div>
						<div style="display: flex; flex-flow: column; align-items: flex-start; justify-content: center;">
							<span style="font-size: 24px; font-weight: bold;"><%= session.getAttribute("nickname") %>님</span>
							<span style="font-size: 24px;">안녕하세요</span>
						</div>
					</div>
					<div style="width: 1px; background: #cdcdcd;"></div>
					<div style="display: flex; flex-flow: column; width: 50%; justify-content: center;">
						<span style="font-size: 18px;">보유 가지머니</span>
						<a href="#"><span style="font-size: 36px; font-weight: bold;" id="userAmount"></span></a>
					</div>
				</div>

				<nav class="navbar navbar-expand-sm bg-dark navbar-dark" style=" border-radius: 10px;">
					<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
						<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse justify-content-center" id="collapsibleNavbar">
						<ul class="navbar-nav">
							<li class="nav-item">
								<button class="btn" id="purchsList">구매내역</button>
							</li>
							<li class="nav-item">
								<button class="btn" id="sellList">판매내역</button>
							</li>
							<li class="nav-item">
								<button class="btn" id="basketList">찜 목록</button>
							</li>
							<li class="nav-item">
								<button class="btn" id="updateuser">회원수정/탈퇴</button>
							</li>
						</ul>
					</div>
				</nav>
				<div class="container" style="margin-top: 30px"></div>
			</div>
		</div>
		<jsp:include page="../home/SideBar.jsp" flush="true"/>
		<jsp:include page="../home/Footer.jsp" flush="true" />
	</div>
</body>
</html>