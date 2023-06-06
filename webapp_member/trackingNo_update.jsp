<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body onload="window.resizeTo(1000,600)">
<div>
	<form action="update" method="get">
							운송장 번호 등록하기 <br> 
		아이디 :<input name="id" value="<%= session.getAttribute("id") %>"><br>
		
			<div class="input-group mt-3 mb-3">
				<div class="input-group-prepend">
					<button type="button"
						class="btn btn-outline-secondary dropdown-toggle"
						data-toggle="dropdown">택배사</button>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="#">한진</a> <a
							class="dropdown-item" href="#">CJ</a> <a
							class="dropdown-item" href="#">로젠</a>
					</div>
				</div>
				<input name="text" class="form-control" placeholder="운송번호">
			</div>
			
			운송장번호 입력:<input name="trackingNo" value=" "><br>

		<label></label><br>
		<button type="submit">운송번호 등록하기</button>
	</form>
</div>
	<input type="button" value="닫 기" onclick="self.close();" />
	<input type="button" value="이동 후 닫기" />
</body>
</html>