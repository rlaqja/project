<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<script type="text/javascript">
	 $(function() {
			$('#buyerCon').click(function() {
				let no = $('#no').text()
						$.ajax({
							url:"buyerCon",
							type:'post',
							data:{
								no : no
							},
							success: function(result) {
								console.log(result)
								location.href="mypage.jsp"
							},//success
						})//ajax
			})
		})
		
		 $('.trackingNo').on("click", function(e) {
		 var str = ""
	        var tdArr = new Array();	
	        var btn = $(this);
	        
	        var tr = btn.parent().parent();
	        var td = tr.children();
	        
	        var trackingNo = td.eq(5).text().trim();
	        var deliveryCom = td.eq(4).text();
	 		console.log(trackingNo)       
	 		console.log(deliveryCom)       
		    e.preventDefault();
	 		
		    var url = "";
		    
		    if (deliveryCom == "CJ대한통운") {
		    	url ="http://nplus.doortodoor.co.kr/web/detail.jsp?slipno="+trackingNo;
			}else if (deliveryCom == "한진택배") {
				url ="https://www.hanjin.co.kr/kor/CMS/DeliveryMgr/WaybillResult.do?mCode=MN038&schLang=KR&wblnumText2="+trackingNo;
			}else {
				url ="https://www.ilogen.com/m/personal/trace/"+trackingNo;
			}
		    window.location.href = url;
		  });
	</script>
<div id="purchsList">
      <h5>구매 목록(내역)</h5>
      <table class="table table-striped" style="border: 0px !important" >
       <thead>
         <tr>
	        <th>상품사진</th>
	        <th>상품이름</th>
	        <th>금액</th>
	        <th>판매자</th>
	        <th>거래상태</th>
	        <th>택배사</th>
	        <th>운송장번호</th>
	        <th>직거래 날짜</th>
	        <th>구매확정</th>
	     </tr>
        </thead>
        <tbody>
      	<c:forEach var="i" begin="1" end="${fn:length(list)}">
      	<p id="no" style="display: none">${list[i-1].no}</p>
		<tr>
			<td><img alt="제품이미지" src="http://awswlqccbpkd17595311.cdn.ntruss.com/${list4[i-1].productImageName}?type=f&w=60&h=60"></td>
			<td><a href="../product/productDetail.jsp?productId=${list2[i-1].productId}">
				    ${list2[i-1].productName}
				</a>
			</td>			 
			<td>${list2[i-1].price}</td>
			<td>${list3[i-1].nickname}</td>
			<td>${sellStatus[i-1]}</td>
			 <td id="companyName">${list[i-1].deliveryCom}</td>
			 <td>
				  <a href="#" class="trackingNo" data-trackingno="${list[i-1].trackingNo}">
				    ${list[i-1].trackingNo}
				  </a>
				</td> 
			<td><fmt:formatDate value="${directDate[i-1].dealDirectDate}" pattern="yyyy-MM-dd HH:mm"/></td>	
			<td> <button id="buyerCon" >구매확정</button></td>
		</tr>
		</c:forEach>
		</tbody>
	</table>   
      <br>
</div>