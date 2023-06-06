<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
<link href="../resources/css/UpdateUser.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
		var session = '<%= session.getAttribute("id")%>'

		$(function() {
		
		$('#pwReSet').click(function() {

		    var pw = $('#pw').val();
		    var pw2 = $('#pw2').val();

		    var isValid = true; // 유효성 검사 플래그

		    if (pw === '') {
		        isValid = false;
		        alert("비밀번호를 입력해주세요");
		    }
		    
		    if (isValid) {
		        $('#pwDoubleChk').val(true); // 유효성 검사가 통과되었을 경우 hidden input 값을 변경
		        $.ajax({
		            url: "ResetPw",
		            type: 'post',
		            data: {
		            	session: session,
		                pw: pw,
		                pw2 : pw2
		            },
		            success: function(result) {
		                if (result == 1) {
		                	alert("성공!!")
		                    location.href = "../home/gazeeMain.jsp";
		                } else {
		                    alert("비밀번호 재설정이 어렵습니다");
		                }
		                console.log(result);
		            },
		            error: function(xhr, status, error) {
		                console.log(error);
		            }
		        });
		    } else {
		        $('#pwDoubleChk').val(false); // 유효성 검사를 통과하지 못한 경우 hidden input 값을 변경
		    }
		});	
		
		//작성
		// 05-17 00:25 추가
			$('#btn_Img').click(function() {				
			
			var formData = new FormData($("#uploadForm")[0]);
			
			$.ajax({
				url: "profile",
				type: "POST",
				data: formData,
				cache: false,
				contentType: false,
				processData: false,
				success: function(response) {
					// Handle success response
					console.log("Upload successful!");
				},
				error: function(jqXHR, textStatus, errorThrown) {
					// Handle error response
					console.error("Upload failed: " + errorThrown);
				}
			});
		   })
		
			$('#btn_Img').click(function(){
				uploadFiles();
			})
	}) 
	
	$(function(){
	    $('#pw').keyup(function(){
	      $('#chkNotice').html('');
	    });
	    $('#pw2').keyup(function(){
				
	        if($('#pw').val() != $('#pw2').val()){
	          $('#chkNotice').html('비밀번호 일치하지 않음<br><br>');
	          $('#chkNotice').attr('color', '#f82a2aa3');
	        } else{
	          $('#chkNotice').html('비밀번호 일치함<br><br>');
	          $('#chkNotice').attr('color', '#199894b3');	
	        }

	    });
	});
			 
					function nickCheck() {					
						var isValid = true; // 유효성 검사 플래그
						
					    if (nickname === '') {
					        isValid = false;
					        alert("닉네임을 입력해주세요");
					    }
						
						var nickname = $('#nickname').val()
						if ($('#nickname').val() != '') {				
							// 아이디를 서버로 전송 > DB 유효성 검사 > 결과 반환받기
							$.ajax({		   					
								type: 'GET',
							    url: 'nicknameCheck',
							    data: {
							    	nickname: nickname
							    },
							    success: function(result) {	
						        //추가한것임.
						        	if (result == "3") {
						        		$('#result').text("3글자 이상 입력해주세요.");
						        		$('#result').attr('color', 'red');
									} else if (result == "no") {
										$('#result').text("사용중인 닉네임 입니다.");
							    		$('#result').attr('color', 'red');
									} else {
										$('#result').text("사용가능한 닉네임 입니다.");
							    		$('#result').attr('color', '#693FAA');
						            	$('#nickReSet').click(function() {
							            	$.ajax({
												url: "changeNick",
										    	type: 'post',
										        data: {
										    		session: session,
										            nickname: nickname
										        },
										        success: function(result) {
										            if (result == 1) {
										            	alert("성공!!")			                										                
										                location.reload();
										            }
										            console.log(result);
										        },
										        error: function(xhr, status, error) {
										            console.log(error);
										        }
										    });
							           	})										
									};
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
				
				
					function leave() {
					    var confirmed = confirm("정말로 회원을 탈퇴하시겠습니까?");
					    if (confirmed) {
					
					        $.ajax({
					            url: "leave",
					            type: "POST",
					            data: {
					            	session: session
					            },
					            success: function(result) {
					            	
					                if (result === "탈퇴성공") {
					                    alert("회원 탈퇴가 완료되었습니다.");
					                    location.href = "../home/gazeeMain.jsp";
					                    
					                } else {
					                    alert("회원 탈퇴에 실패했습니다. 다시 시도해주세요.");
					                }
					            },
					            error: function(xhr, status, error) {
					                console.log(error);
					            }
					        });
					    } else {
					        // 취소 시 처리할 로직을 추가해주세요.
					        alert("함께 해주셔서 감사합니다.")
					    }
					}
</script>
<style>
#btn_pwReSet{
	width: 100px;
	height: 40px;
	background : #693FAA;
	color: #FFF;
	gap : 10px;
}
#btn_leave{
	width: 150px;
	height: 40px;
	background : #693FAA;
	color: #FFF;
	gap : 10px;
}
#btn_updateUser{
	background: #F6F6F6; 
	width: 150px; 
	height: 40px; 
	font-style: #6f42c1
}
button{
	border-color: #693FAA;
	border-radius: 3px;

}
</style>
	<div id="content_wrap">
		<div id="content">
					 <div style="padding: 10px 0px; display: flex; gap: 50px;">
					<div style="display: flex; gap: 40px; width: 50%;">				
						<div style="display: flex; flex-flow: column; align-items: flex-start; justify-content: center;">
							<div id="updateUserBox" style="width: 400px !important;">
								<div class="head">
									<h2 style="text-align: center;">닉네임수정 </h2>
									<span class="star"></span>
								</div>
									<div class="input_profileReset">
										<label class="nametag">닉네임<span class="star">*</span></label>
										<input type="text" id="nickname" class="form-control" placeholder="닉네임">
										<div class="nicknameBox">		
											<button type="button" id="nickCheck" onclick="nickCheck()">중복확인</button>
											<input type="hidden" id ="NicknameCheck"/>
										</div>									
											<div id="result" size="1" style="color:#693FAA"></div>
									</div>
							  			<button type="submit" id="nickReSet">변 경</button>
										<div class="head">										</div>									
											<h2 style="text-align: center;">이미지수정 </h2>
									<form id="uploadForm" enctype="multipart/form-data">
										파일 업로드: <input type="file" name="file">
										<input type="button" value="Upload" onclick="uploadFiles()"> 업로드 할 파일.
									</form>
							  </div>
						</div>
					</div>
					<div style="width: 1px; background: #cdcdcd;"></div>
					<div style="display: flex; flex-flow: column; width: 50%; justify-content: center;">
							<div id="reSetPwBox">								
									<div class="head">
										<h2 style="text-align: center;">비밀번호 재설정</h2>
										<span class="star">*</span>입력사항
									</div>
									<div class="input_newPw">
										<label class="nametag">새 비밀번호<span class="star">*</span></label>				
										<input class="form-control" type="password" id="pw" placeholder="새 비밀번호"/>
										<input type="hidden" id ="pwCheck"/>
									</div>
									<div class="input_newPwCheck">
										<label class="nametag">비밀번호확인<span class="star">*</span></label>	
										<input class="form-control" type="password" id="pw2" placeholder="새 비밀번호 확인"/>
										<input type="hidden" id ="pwCheckCheck"/>
									</div>
									<font id="chkNotice" size="2"></font>						    
							</div>
									<button type="submit" id="pwReSet">바꾸기</button>							
					</div>
				  </div>
				</div>		
			</div>
				 <div class="head"></div>
					 <div id="btnBox" style="padding-top: 10px;">
						<button type="submit" id="btn_leave" onclick="leave()">회원탈퇴</button>
					</div>




