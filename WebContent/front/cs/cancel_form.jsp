<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<OrderPaInfo> orderCancelList = (ArrayList<OrderPaInfo>)request.getAttribute("orderCancelList");

%>
<style>
input[type=text] {border:0;}
.main {display:flex; justify-content:space-between; margin-top:100px;}
.ctgr {width:200px;}
#info {width:830px;}
#info p {margin:0; padding:30px; border:1px solid black;}
</style>
<div class="main">
	<div class="ctgr">
		<p><a href="mypage_reserve">예약 내역</a></p><hr />
		<p><a href="mypage_mileage">마일리지</a></p><hr />
		<p><a href="">1:1 게시판 문의내역</a></p><hr />
		<p><a href="">My 리뷰</a></p><hr />
		<p>회원정보수정</p>
	</div>
	<div class="reserve">
		<h2>예약 취소</h2><hr />
		<br /><br/>
<% if (orderCancelList.size() > 0) {
	for (int i = 0; i < orderCancelList.size(); i++) {
		OrderPaInfo op = orderCancelList.get(i);
		
		String title = op.getOp_name();
		if (title.length() > 15)		title = title.substring(0, 13) + "...";
%>
		<form id="info" action="cancel_complete">
			<p>예약자명 : &nbsp;&nbsp;&nbsp;<input type="text" value="<%=op.getOp_customer() %>" readonly="readonly"/></p>
			<p>아이디 :  &nbsp;&nbsp;&nbsp;<input type="text" value="<%=op.getMi_id() %>" readonly="readonly" /></p>
			<p>패키지 명 : &nbsp;&nbsp;&nbsp;<input type="text" value="<%=op.getOp_name() %>" readonly="readonly" /></p>
			<p>예약 번호 : &nbsp;&nbsp;&nbsp;<input type="text" value="<%=op.getOp_code() %>" readonly="readonly" name="code"/></p>
			<p>여행 기간 : &nbsp;&nbsp;&nbsp;<input type="text" value="<%=op.getOp_period() %>" readonly="readonly" /></p>
			<p>
			예약 취소 사유 : &nbsp;&nbsp;&nbsp; 
				<select name="ctgr">
					<option>단순변심</option>
					<option>업체 측 사유</option>
					<option>여행 일정 변경</option>
				</select>
			</p>
			<p>내용&nbsp;&nbsp;&nbsp;<textarea style="width:750px;" cols="50" rows="10" name="content"></textarea></p>
			<div align="right";><input type="button" style="width:50px; height:50px;" value="취소" />
			<input type="submit" style="width:50px; height:50px;" value="신청" /></div>
		</form>
<%
	}
} else {
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어오셨습니다');");
	out.println("history.back();");
	out.println("</script>");
	out.close();
}
%>
	</div>
</div>
</body>
</html>