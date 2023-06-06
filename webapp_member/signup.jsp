<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
<link href="../resources/css/signUp.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
$(function() {
	$('#btn_SingUp').click(function() {
	    var id = $('#id').val();
	    var pw = $('#pw').val();
	    var name = $('#name').val();
	    var tel = $('#tel').val();
	    var nickname = $('#nickname').val();
	    const email = $('#userEmail1').val() + $("select[name='userEmail2'] option:selected").text(); // 이메일 주소값 얻어오기!
	    var birth = $('#birth').val();
	    var gender = $('input:radio[name=gender]:checked').val();

	    var isValid = true; // 유효성 검사 플래그

	    // 유효성 검사 로직
	    if (id === '') {
	        isValid = false;
	        alert("아이디를 입력해주세요");
	    }
	    if (pw === '') {
	        isValid = false;
	        alert("비밀번호를 입력해주세요");
	    }
	    if (name === '') {
	        isValid = false;
	        alert("이름을 입력해주세요");
	    }
	    if (tel === '') {
	        isValid = false;
	        alert("전화번호를 입력해주세요");
	    }
	    if (nickname === '') {
	        isValid = false;
	        alert("닉네임을 입력해주세요");
	    }
	    if (email === '') {
	        isValid = false;
	        alert("이메일을 입력해주세요");
	    }
	    if ($('#mail-check-input').val() !== code) {
	        isValid = false;
	        alert("인증번호가 일치하지 않습니다.");
	    }
	    
	    if (isValid) {
	        $('#idDoubleChk').val(true); // 유효성 검사가 통과되었을 경우 hidden input 값을 변경
	        $.ajax({
	            url: "insert",
	            type: 'post',
	            data: {
	                id: id,
	                pw: pw,
	                name: name,
	                tel: tel,
	                nickname: nickname,
	                email: email,
	                birth: birth,
	                gender: gender
	            },
	            success: function(result) {
	                if (result == 1) {
	                    location.href = "../home/gazeeMain.jsp";
	                } else {
	                    alert("아이디 6글자 이상 입력하셔야합니다.");
	                }
	                console.log(result);	                
	            },
	            error: function(xhr, status, error) {
	                console.log(error);
	            }
	        });
	    } else {
	        $('#idDoubleChk').val(false); // 유효성 검사를 통과하지 못한 경우 hidden input 값을 변경
	    }
	});						
							
	// 인증번호 비교 
	// blur -> focus가 벗어나는 경우 발생
	$('#mail-check-input').blur(
			function() {
				const inputCode = $(this).val();
				const $resultMsg = $('#mail-check-warn');

				console.log("input : " +inputCode)
				console.log("code : " +code)
				if (inputCode === code) {
					$resultMsg.html('인증번호가 일치합니다.');
					$resultMsg.css('color', 'green');
					$('#mail-Check-Btn').attr('disabled', true);
					$('#userEamil1').attr('readonly', true);
					$('#userEamil2').attr('readonly', true);
					$('#userEmail2').attr('onFocus',
							'this.initialSelect = this.selectedIndex');
					$('#userEmail2').attr('onChange',
							'this.selectedIndex = this.initialSelect');
				} else {
					$resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!');
					$resultMsg.css('color', 'red');
				}
			});
})
	function emailCheck() {	
		/* console.log('이메일1 : ' + $('#userEmail1').val()); // 이메일 오는지 확인
		console.log('이메일2 : ' + $("select[name='userEmail2']").text()); // 이메일 오는지 확인 */
		const email = $('#userEmail1').val() + $("select[name='userEmail2'] option:selected").text(); // 이메일 주소값 얻어오기!
			
		const checkInput = $('.mail-check-input') // 인증번호 입력하는곳 
		
		 $.ajax({
			type : 'post',
			url : "mailCheck", // GET방식이라 Url 뒤에 email을 뭍힐수있다.
			data:{
				email : email				
			},
			success : function(data) {
				console.log("data : " +  data);
				checkInput.attr('disabled',false);
				code = data;
				alert('인증번호가 전송되었습니다.')
			}
		}); // end ajax 
	}; // end send eamil
	
	function idCheck() {	
	 var id = $('#id').val()
		 if ($('#id').val() != '') {				
		        // 아이디를 서버로 전송 > DB 유효성 검사 > 결과 반환받기
		        $.ajax({		   					
		            type: 'GET',
		            url: 'idCheck',
		            data: {
		            	 id: id
		            	},
		            success: function(result) {	
		            	  $('#result').text(result);
		            	  $('#result').attr('color', '#693FAA');
		            	  
		            },
		            error: function(a, b, c) {
		                console.log(a, b, c);
		            }		   					
		        });		   				
		    } else {
		        alert('아이디를 입력하세요.');
		        $('#id').focus();
		    }	
	}; 

	$(function(){
	    $('#pw').keyup(function(){
	      $('#chkNotice').html('');
	    });
	    $('#pwCheck').keyup(function(){

	        if($('#pw').val() != $('#pwCheck').val()){
	          $('#chkNotice').html('비밀번호 일치하지 않음<br><br>');
	          $('#chkNotice').attr('color', '#f82a2aa3');
	        } else{
	          $('#chkNotice').html('비밀번호 일치함<br><br>');
	          $('#chkNotice').attr('color', '#199894b3');
	        }

	    });
	});
	
	 function nickCheck() {			
		 var nickname = $('#nickname').val()
			 if ($('#nickname').val() != '') {				
			        // 아이디를 서버로 전송 > DB 유효성 검사 > 결과 반환받기
			        $.ajax({		   					
			            type: 'GET',
			            url: 'nicknameCheck',
			            data: {
			            	nickname: nickname
			            	},
			            success: function(nick) {	
			            	  $('#nick').text(result);
			            	  $('#nick').attr('color', '#693FAA');
			            	  
			            },
			            error: function(a, b, c) {
			                console.log(a, b, c);
			            }		   					
			        });		   				
			    } else {
			        alert('닉네임을 입력하세요.');
			        $('#nickname').focus();
			    }	
		}; 
</script>

<title>가지가지</title>
</head>
<body>
	<div id="wrap">
		<div id="header">
			<jsp:include page="../home/Header.jsp" flush="true"/>
		</div>
		<div id="content_wrap">
			<div id="content">
				<div id="signUpBox">
					<h1>회원가입</h1>
					<div class="head">
						<span class="star">*</span>필수입력사항
					</div>
						<div class="input_signUp">
							<label class="nametag">아이디<span class="star">*</span></label>
							<div class="idBox">
								<input minlength="6" type="text" id="id" class="form-control" placeholder="아이디">
								<button type="button" id="Id-Check-Btn" onclick="idCheck()">중복확인</button>
								<input type="hidden" id ="idCheck"/>
							</div>
						</div>
							<div id="result" size="1" style="color:#693FAA"></div>
						<div class="input_signUp">
							<label class="nametag">비밀번호<span class="star">*</span></label>				
							<input class="form-control" type="password" id="pw" placeholder="비밀번호"/>
							<input type="hidden" id ="PwCheck"/>
						</div>
						<div class="input_signUp">
							<label class="nametag">비밀번호확인<span class="star">*</span></label>	
							<input class="form-control" type="password" id="pwCheck" placeholder="비밀번호 확인"/>
							<input type="hidden" id ="pwCheckCheck"/>
						</div>
							<font id="chkNotice" size="2"></font>
						<div class="input_signUp">
							<label class="nametag">이름<span class="star">*</span></label>
							<input type="text" id="name" class="form-control" placeholder="이름">
							<input type="hidden" id ="NameCheck"/>
						</div>
						<div class="input_signUp">
							<label class="nametag">전화번호<span class="star">*</span></label>
							<input type="text" id="tel" class="form-control" placeholder="전화번호">
							<input type="hidden" id ="TelCheck"/>
						</div>
						<div class="input_signUp">
							<label class="nametag">닉네임<span class="star">*</span></label>
							<input type="text" id="nickname" class="form-control" placeholder="닉네임">
								<div class="nicknameBox">		
									<button type="button" id="nickCheck"  onclick="nickCheck()">중복확인</button>
									<input type="hidden" id ="NicknameCheck"/>
								</div>
						</div>									
							<div id="nick" size="1" style="color:#693FAA"></div>
						<div class="email-form input_signUp">
							<div style="display: flex; align-items: center;">
								<label class="nametag">이메일<span class="star">*</span></label>
								<div style="width: 100%; display: flex; gap: 5px;">
									<input type="text" class="form-control" id="userEmail1" placeholder="이메일">
									<select name="userEmail2" class="form-control">
										<option value="naver">@naver.com</option>
										<option value="daum">@daum.net</option>
										<option value="gmail">@gmail.com</option>												
									</select>
									<button type="button" id="mail_Check_Btn" onclick="emailCheck()">이메일 인증</button>
								</div> 
							</div>
							<div class= "mail-check-box" style="width: 100%; margin-top: 16px;">
								<label class="nametag">인증번호 확인<span class="star">*</span></label>
								<input class="form-control mail-check-input" id="mail-check-input" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">								
								<input type="hidden" id ="emailCheck"/>
							</div>
							<span id="mail-check-warn"></span>
						</div>
						<div class="input_signUp">
							<label class="nametag">생년월일</label>
							<input type="date" id="birth" class="form-control" placeholder="생년월일">
							<input type="hidden" id ="BirthCheck"/>
						</div>
						<div class="input_signUp">
							<label class="nametag">성별</label>
							<div style="width: 100%; height: 46px; display: flex;">
								<div class="gender_radio">
									<span class="genderTag">여성</span>
									<input type="radio" name="gender" id="female" value="female">
								</div>
								<div class="gender_radio">
									<span class="genderTag">남성</span>
									<input type="radio" name="gender" id="male" value="male">
								</div>
							</div>
						</div>
						<div class="head"></div>
						<button type="submit" id="btn_SingUp">회원가입</button>
				 </div>
			</div>
		</div>
	<jsp:include page="../home/Footer.jsp" flush="true"/>
	</div>
</body>
</html>