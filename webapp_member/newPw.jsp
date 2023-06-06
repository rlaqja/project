<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
<link href="../resources/css/style.css" rel="stylesheet" type="text/css">
<link href="../resources/css/NewPw.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
	<script type="text/javascript">
	$(function() { 
		$('#btn_ReSet').click(function() {
			
		    //var id = $('#id').val();
		    var pw = $('#pw').val();
		    var pw2 = $('#pw2').val();
			var id = '${id}'; 
			
		    var isValid = true; // 유효성 검사 플래그

		    // 유효성 검사 로직
		  
		    if (pw === '') {
		        isValid = false;
		        alert("비밀번호를 입력해주세요");
		    }
		    if (pw2 === '') {
		        isValid = false;
		        alert("비밀번호가 같지 않습니다.");
		    }
		   
		    if (isValid) {
		        $('#idDoubleChk').val(true); // 유효성 검사가 통과되었을 경우 hidden input 값을 변경
		        $.ajax({
		            url: "updatePw",
		            type: 'post',
		            data: {	      
		            	id: id,
		                pw: pw,
		                pw2: pw2
		                
		            },
		            success: function(result) {		         		              
		                console.log(result);uy
		                location.href="member.jsp"
		            }		            
		        });
		    } else {
		        $('#idDoubleChk').val(false); // 유효성 검사를 통과하지 못한 경우 hidden input 값을 변경
		    }
		});	
	})

		$(function() {
			$('#pw').keyup(function() {
				$('#chkNotice').html('');
			});
			$('#pw2').keyup(function() {

				if ($('#pw').val() != $('#pw2').val()) {
					$('#chkNotice').html('비밀번호 일치하지 않음<br><br>');
					$('#chkNotice').attr('color', '#f82a2aa3');
				} else {
					$('#chkNotice').html('비밀번호 일치함<br><br>');
					$('#chkNotice').attr('color', '#199894b3');
				}
			});
		});
		
	</script>
	<div id="wrap">
		<div id="content_wrap">
			<div id="content">
	 			 <h2>새 비밀번호 설정</h2>
			   <div id = "PwresetBox">
					<div class="head">
						<span class="star">*</span>입력사항
					</div>
					<div class="input_newPw">
						<label class="nametag">새 비밀번호<span class="star">*</span></label>				
						<input class="form-control" type="password" id="pw" placeholder="비밀번호"/>
						<input type="hidden" id ="PwCheck"/>
					</div>
					<div class="input_newPwCheck">
						<label class="nametag">비밀번호확인<span class="star">*</span></label>	
						<input class="form-control" type="password" id="pw2" placeholder="비밀번호 확인"/>
						<input type="hidden" id ="pwCheckCheck"/>
					</div>
					<font id="chkNotice" size="2"></font>
			    </div>
			</div>
		</div>
		<button type="submit" id="btn_ReSet">확 인</button>
	</div>
