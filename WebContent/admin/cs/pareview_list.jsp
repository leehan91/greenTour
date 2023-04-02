<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head_admin.jsp" %>
<%
request.setCharacterEncoding("utf-8");

ArrayList<CsPareview> cpList = (ArrayList<CsPareview>)request.getAttribute("cpList");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage(), psize = pageInfo.getPsize();
int rcnt = pageInfo.getRcnt(), pcnt = pageInfo.getPcnt(), spage = pageInfo.getSpage();
String schtype = pageInfo.getSchtype(), keyword = pageInfo.getKeyword();

String schargs = "", args = "";
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {		// 검색 조건(schtype)과 검색어(keyword)가 있으면 검색관련 쿼리스트링 생성
	schargs = "&schtype=" + schtype + "&keyword=" + keyword;	
}
args = "&cpage=" + cpage + schargs;
%>
<style>

.ctgr {width:200px;}
.memberList {width:830px;}
</style>
<main class="side_menu">
	<ul class="ctgr">
		<li><a href="member_list">회원 관리</a><br/>
		 <span>&nbsp;&nbsp;&nbsp;<a href="member_list"> - 회원 목록</a></span><br/>
		 <span>&nbsp;&nbsp;&nbsp;<a href="member_reservation_list"> - 예약 취소</a></span>
		</li><hr />
		<li><a href="">도시 관리</a></li><hr />
		<li><a href="">게시판 관리</a></li><hr />
		<li><a href="/greenTour/admin_package_list">상품 관리</a><br /></li><hr />
		<li><a href="admin_pareview_list">고객센터</a></li><hr />
		<li><a href="/greenTour/admin_amount">통계</a></li>
	</ul>
	<div class="memberList">
		<h2>회원 목록</h2><hr />
		
		<!-- 검색창 -->
		
		<table>
			<tr>
				<th width="5%">번호</th>
				<th width="15%">제목</th>
				<th width="15%">작성자</th>
				<th width="20%">작성일</th>
				<th width="20%">삭제여부</th>
				
			</tr>
			<%
if (cpList.size() > 0) {		// 게시글 목록이 있으면
	int num = rcnt - (psize * (cpage - 1));
	for (int i = 0; i < cpList.size(); i++) {
		CsPareview cp = cpList.get(i);
		
%>
	<tr align="center">
		<td width="5%"><%=num %></td>
		<td width="15%"><%=cp.getCp_title() %></td>
		<td width="15%" align="center">&nbsp;&nbsp;<%=cp.getMi_id() %></td>
		<td width="15%"><%=cp.getCp_date() %></td>
		<td width="20%"><%=cp.getCp_isdel() %></td>
	</tr>
<%
		num--;
	}
} else {		// 게시글 목록이 없으면
	out.println("<tr><td colspan='7' align='center'>검색 결과가 없습니다.</td></tr>");
}
%>
</table>
<br />
<table width="700" cellpadding="5">
	<tr>
		<td width="600">
<%
if (rcnt > 0) {		// 게시글이 있으면 - 페이징 영역을 보여줌
	String lnk = "member_list?cpage=";
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
	<tr>
		<td colspan="2">
			<%-- <form name="frmSch" method="get">
				<fieldset>
					<legend>회원 검색</legend>
					<select name="schtype">
						<option value="">검색 조건</option>
						<option value="name" <% if (schtype.equals("name")) { %>selected="selected"<% } %>>이름</option>
						<option value="title" <% if (schtype.equals("title")) { %>selected="selected"<% } %>>제목</option>
					</select>
					<input type="text" name="keyword" value="<%=keyword %>" />
					<input type="submit" value="검색" />
				</fieldset>
			</form> --%>
		</td>
	</tr>	
		</table>
	</div>
</main>
</body>
</html>