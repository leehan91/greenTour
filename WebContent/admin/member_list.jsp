<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head_admin.jsp" %>
<%
request.setCharacterEncoding("utf-8");

ArrayList<MemberInfo> memberList = (ArrayList<MemberInfo>)request.getAttribute("memberList");
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
.main {display:flex; justify-content:space-between; margin-top:100px;}
.ctgr {width:200px;}
.memberList {width:830px;}
</style>
<div class="main">
	<div class="ctgr">
		<p><a href="">회원 관리</a></p><hr />
		<p><a href="">도시 관리</a></p><hr />
		<p><a href="">게시판 관리</a></p><hr />
		<p><a href="">상품 관리</a></p><hr />
		<p><a href="">고객센터</a></p><hr />
		<p><a href="/greenTourSite/admin_amount">통계</a></p>
	</div>
	<div class="memberList">
		<h2>회원 목록</h2><hr />
		
		<!-- 검색창 -->
		
		<table>
			<tr>
				<th width="5%">순번</th>
				<th width="15%">ID</th>
				<th width="15%">이름</th>
				<th width="20%">e-mail</th>
				<th width="20%">최종방문일</th>
				<th width="20%">가입일</th>
				<th width="5%">회원상태</th>
			</tr>
			<%
if (memberList.size() > 0) {		// 게시글 목록이 있으면
	int num = rcnt - (psize * (cpage - 1));
	for (int i = 0; i < memberList.size(); i++) {
		MemberInfo mi = memberList.get(i);
		
		String title = mi.getMi_name();
		if (title.length() > 8)		title = title.substring(0, 5) + "...";
		title = "<a href='member_view?miid=" + mi.getMi_id() + args + "'>" + title + "</a>";	
		
%>
	<tr align="center">
		<td width="5%"><%=num %></td>
		<td width="15%"><%=mi.getMi_id() %></td>
		<td width="15%" align="center">&nbsp;&nbsp;<%=title %></td>
		<td width="15%"><%=mi.getMi_email() %></td>
		<td width="20%"><%=mi.getMi_lastlogin() %></td>
		<td width="20%"><%=mi.getMi_joindate() %></td>
		<td width="10%"><%=mi.getMi_status() %></td>
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
			<form name="frmSch" method="get">
				<fieldset>
					<legend>회원 검색</legend>
					<select name="schtype">
						<option value="">검색 조건</option>
						<option value="name" <% if (schtype.equals("name")) { %>selected="selected"<% } %>>이름</option>
						<option value="id" <% if (schtype.equals("id")) { %>selected="selected"<% } %>>ID</option>
						<option value="status" <% if (schtype.equals("status")) { %>selected="selected"<% } %>>회원 상태</option>
					</select>
					<input type="text" name="keyword" value="<%=keyword %>" />
					<input type="submit" value="검색" />
				</fieldset>
			</form>
		</td>
	</tr>	
		</table>
	</div>
</div>
</body>
</html>