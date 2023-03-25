<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
CsPareview cp = (CsPareview)request.getAttribute("cp");
int cpidx = cp.getCp_idx();
int cpage = Integer.parseInt(request.getParameter("cpage"));
String args = "?cpage=" + cpage;		// 링크에서 사용할 쿼리 스트링
String schtype = request.getParameter("schtype");
String keyword = request.getParameter("keyword");
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
	args += "&schtype=" + schtype + "&keyword=" + keyword;
}

%>
<style>
.reList { width: 1130px; }
.reWriter {
	width: 1130px; padding: 5px; 
	display: flex; 
	justify-content: space-between; 
	border: 1px solid #000;
}
.reContent {
	width: 1130px; padding: 5px; 
	border: 1px solid #000; 
	border-top: none;
	margin-bottom: 5px;
}
/* 별점 css */
#myform {
	display: form;
}
#myform fieldset{
    display: inline-block;
    direction: rtl;
    border:0;
}
#myform fieldset legend{
    text-align: right;
}
#myform input[type=radio]{
    display: none;
}
#myform label{
    font-size: 2em;
    color: transparent;
    text-shadow: 0 0 0 #f0f0f0;
}
#myform label:hover{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#myform label:hover ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#myform input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
</style>
<h2 margin-top="300">리뷰 작성하기</h2>
<table width="1130" border="1" cellpadding="10" align="center" id="view_list">
		<tr>
		<th width="35%">예약자명</th>
		<td width="*">
		<span><%=cp.getMi_name() %></span></td>
		</tr>
		<tr>
			<th>아이디</th>
			<td>
			<span><%=cp.getMi_id() %></span></td>
			</td>
		</tr>
		<tr>
			<th><span class="red"></span>예약내역</th>
			<td>
				<span><%=cp.getCp_name() %>/<%=cp.getOp_code() %></span>
			</td>
		</tr>
		<tr>
			<th><span class="red"></span>별점</th>
			<!-- 별점 css inc_head에 있습니다. -->
			<td><span><%=cp.getCp_score() %></span></td>
		</tr>
		<tr>
			<th><span class="red"></span>제목</th>
			<td><span><%=cp.getCp_title() %></span></td>
		</tr>
		<tr>
			<th for="content">내용</th>
			<td><span><%=cp.getCp_content() %></span></td>
		</tr>
		
	</table>
<br /><hr align="left" width="1130" /><br />
<p style="width: 1130px" align="center">
	<input type="button" value="목록" onclick="location.href='pareview_list<%=args %>';" />
</p>
<br /><hr align="left" width="1130" /><br />
</body>
</html>