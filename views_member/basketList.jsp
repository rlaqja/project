<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
.likeitem {
	line-height: 60px;
	
	
}
</style>

<div class="basketList" style="margin-top:30px">
      <h5>내 가지바구니</h5>
      <table class="table table-striped" style="border: 0px !important" >
       <thead>
         <tr>
	        <th>사진</th>
	        <th>상품제목</th>
	        <th>가격</th>
	     </tr>
        </thead>
        <tbody>
    		  <c:forEach var="i" begin="1" end="${fn:length(list)}">    			
		<tr class="likeitem">
			<td><img alt="제품이미지" src="http://awswlqccbpkd17595311.cdn.ntruss.com/${list3[i-1].productImageName}?type=f&w=60&h=60"></td>
			<td><a href="../product/productDetail.jsp?productId=${list2[i-1].productId}">
				    ${list2[i-1].productName}
				</a>
			</td>				
			<td>${list2[i-1].price}</td>
		</tr>
		</c:forEach>
		</tbody>
	</table>   
      <br>
</div>
	
		
</body>
</html>