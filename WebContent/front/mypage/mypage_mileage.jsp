<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");

ArrayList<OrderPaInfo> orderList = (ArrayList<OrderPaInfo>)request.getAttribute("orderList");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
MemberInfo mi = (MemberInfo)request.getAttribute("mi");

int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage(), psize = pageInfo.getPsize();
int rcnt = pageInfo.getRcnt(), pcnt = pageInfo.getPcnt(), spage = pageInfo.getSpage();

String schargs = "", args = "";
args = "&cpage=" + cpage + schargs;
%>
<style>
.main {display:flex; justify-content:space-between; margin-top:100px;}
.ctgr {width:200px;}
.reserve {width:830px;}

#button1 {width:830px; height:50px;}
#cancel {font-size:0.8em; color:red;}
#cancelbtn {width:100px; height:50px;}
#list tr { height: 30px; }
#list th, #list td { padding: 8px 3px; }
#list th { border: solid black 1px; }
#list td { border: solid black 1px; font-size:0.8em;}
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
		<h2>나의 마일리지</h2><hr />
		<table width="830" cellpadding="0" cellspacing="0" id="list">
			<tr>
				<th width="15%">예약 일자</th>
				<th width="15%">예약 번호</th>
				<th width="15%">적립 마일리지</th>
				<th width="15%">사용 마일리지</th>
				<th width="15%">남은 마일리지</th>
			</tr>
<%
if ((orderList.size() > 0)) {
	int num = rcnt - (psize * (cpage - 1));
	for (int i = 0; i < orderList.size(); i++) {
		OrderPaInfo op = orderList.get(i);

		
		String title = op.getOp_name();
		if (title.length() > 15)		title = title.substring(0, 13) + "...";
		
%>
	<tr align="center">
		<td width="15%"><%=op.getOp_time() %></td>
		<td width="15%"><%=op.getOp_code() %></td>
		<td width="15%"><%=op.getOp_umile() %></td>
		<td width="15%"><%=op.getOp_smile() %></td>
		<td width="15%"><%=mi.getMi_mileage() %></td>
	</tr>
<%
		num--;
	}
} else {		// 게시글 목록이 없으면
	out.println("<tr><td colspan='5' align='center'>검색 결과가 없습니다.</td></tr>");
}
%>
		</table>
		<br />
		<table width="700" cellpadding="5" align="center" style="text-align:center;">
			<tr>
				<td width="600">
<%
if (rcnt > 0) {		// 게시글이 있으면 - 페이징 영역을 보여줌
	String lnk = "mypage_reserve?cpage=";
	pcnt = rcnt / psize;
	if (rcnt % psize > 0)		pcnt++;		// 전체 페이지 수(마지막 페이지 번호)
	
	if (cpage == 1) {
		out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
	} else {
		out.println("<a href='" + lnk + 1 + schargs + "'>[처음]</a>&nbsp;&nbsp;&nbsp;");
		out.println("<a href='" + lnk + (cpage - 1) + schargs + "'>[이전]</a>&nbsp;&nbsp;");
	}
	
	spage = (cpage - 1) / bsize * bsize + 1;		// 현재 블록에서의 시작 페이지 번호
	for (int i = 1, j = spage; i <= bsize && j <= pcnt; i++, j++) {
	// i : 블록에서 보여줄 페이지의 개수 만큼 루프를 돌릴 조건으로 사용되는 변수
	// j : 실제 출력할 페이지 번호로 전체 페이지 개수(마지막 페이지 번호)를 넘지 않게 사용해야 함
		if (cpage == j)		out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
		else 				out.println("&nbsp;<a href='" + lnk + j + schargs + "'>" + j + "</a>&nbsp;");
	}
	
	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");	
	} else {
		out.println("&nbsp;&nbsp;<a href='" + lnk + (cpage + 1) + schargs + "'>[다음]</a>");
		out.println("&nbsp;&nbsp;&nbsp;<a href='" + lnk + pcnt + schargs + "'>[마지막]</a>");
	}
}
%>
				</td>
			</tr>
		</table>
	</div>
</div>
</body>
</html>