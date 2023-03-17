<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
ArrayList<CsPareview> csPareview = (ArrayList<CsPareview>)request.getAttribute("csPareview");


PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage();
int pcnt = pageInfo.getPcnt(), psize = pageInfo.getPsize();
int rcnt = pageInfo.getRcnt(), spage = pageInfo.getSpage();
String schtype = pageInfo.getSchtype(), keyword = pageInfo.getKeyword();
String schargs = "", args = "";
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")){
	// 검색조건(schtype)과 검색어(keyword)가 있으면 검색관련 쿼리스트링 생성
	schargs = "&schtype=" + schtype + "&keyword=" + keyword;
}
args = "&cpage=" + cpage + schargs;
%>
<style>
#list th, #list td {padding:8px 3px;}
#list th { border-bottom: double black 3px;}
#list td { border-bottom: dotted black 1px;}
#keyword {width:500px;}

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

<p style="background-color:rgb(112,173,71); color:white; font-weight:bolder; width: 200px; height: 33px; padding: 20px; text-align:center; border: 1px solid lightgrey; border-radius: 10px; font-size: 20px;">패키지 후기</p>

<table width="1130" cellpadding="0" cellspacing="0" id="list">
<tr>
<th width="5%">번호</th><th width="5%">도시</th><th width="15%">패키지명</th><th width="*">제목</th>
<th width="20%">별점</th><th width="10%">작성자</th><th width="10%">작성일</th><th width="5%">조회수</th>
</tr>
<%
if(csPareview.size() > 0){ // 게시글 목록이 있으면
	int num = rcnt - (psize * (cpage - 1));
	for (int i = 0 ; i < csPareview.size() ; i++){
		CsPareview cp = csPareview.get(i);
		String title = cp.getCp_title();
		if (title.length() > 30)
			title = title.substring(0,27) + "...";
		title = "<a href='pareview_list?cpidx=" + cp.getCp_idx() + args + "'>" + title +"</a>";
%>
<tr align="center">
	<td><%=num %></td>
	<td><%=cp.getCc_name() %></td>
	<td><%=cp.getOp_name() %></td>
	<td align="left">&nbsp;&nbsp;<%=title %></td>
	<td>
		<div class="mb-3" name="myform" id="myform" >
		 <fieldset>
			<input type="radio" name="reviewStar" value="5" id="rate1"><label
				for="rate1">★</label>
			<input type="radio" name="reviewStar" value="4" id="rate2"><label
				for="rate2">★</label>
			<input type="radio" name="reviewStar" value="3" id="rate3"><label
				for="rate3">★</label>
			<input type="radio" name="reviewStar" value="2" id="rate4"><label
				for="rate4">★</label>
			<input type="radio" name="reviewStar" value="1" id="rate5"><label
				for="rate5">★</label>
		</fieldset>
		(<%=cp.getCp_score() %>)
		</div>
	</td>
	<td><%=loginInfo.getMi_name() %></td>
	<td><%=cp.getCp_date() %></td>
	<td><%=cp.getCp_read() %></td>
</tr>
<%
		num--;
	}
} else {// 게시글 목록이 없으면
	out.print("<tr><td colspan='8' align='center'>");
	out.println("검색결과가 없습니다.</td></tr>");
}
%>
</table>


<br />
<table width="1130" cellpadding="0" align="center">
<tr>
<td width="850" align="center">
<%
if (rcnt > 0 ){ // 게시글이 있으면 - 페이징 영역을 보여줌
	String lnk = "pareview_list?cpage=";
	pcnt = rcnt / psize;
	if (rcnt % psize > 0) 	pcnt++;	//전체 페이지 수 (마지막 페이지 번호)
	
	if (cpage == 1){
		out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
	} else{
		out.print("<a href='" + lnk + 1 +schargs +"'>[처음]</a>&nbsp;&nbsp;&nbsp;");
		out.println("<a href='" + lnk + (cpage - 1) + schargs +"'>[이전]</a>&nbsp;&nbsp;");
	}
	spage = (cpage - 1)/ bsize * bsize + 1;	// 현재 블록에서의 시작 페이지 번호
	for (int i = 1, j = spage ; i <= bsize && j <= pcnt ; i++, j++){
		// i : 블록에서 보여줄 페이지의 개수만큼 루프를 돌릴 조건으로 사용되는 변수
		// j : 실제 출력할 페이지 번호로 전체 페이지 개수(마지막 페이지 번호)를 넘지 않게 사용해야 함
		if (cpage == j){
			out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
		} else {
			out.print("&nbsp;<a href='"+ lnk +j + schargs + "'>");
			out.println(j +"</a>&nbsp;");
		}
	}
	if (cpage == pcnt){
		out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
	} else{
		out.print("&nbsp;&nbsp;<a href='" + lnk + (cpage + 1) + schargs +"'>[다음]</a>");
		out.println("&nbsp;&nbsp;&nbsp;<a href='" + lnk + pcnt + schargs +"'>[마지막]</a>");
	}
}
%>
</td>
<td width="*" align="right">
	<input type="button" align="right"value="글등록" onclick="location.href='pareview_form_in';"/>
</td>
</tr>
<tr><td colspan ="2">
	<form name="frmSch" method="get" align="center" >
		<select name="schtype">
			<option value="">검색조건</option>
			<option value="city" <% if (schtype.equals("city")) {%>selected="selected"<%} %>>도시명</option>
			<option value="package" <% if (schtype.equals("package")) {%>selected="selected"<%} %>>패키지명</option>
			<option value="writer" <% if (schtype.equals("writer")) {%>selected="selected"<%} %>>작성자</option>
		</select>
		<input id="keyword" type="text" name="keyword" value="<%=keyword %>"/>
		<input type="submit" value="검색"/>
		<input type="button" value="전체글" onclick="location.href='pareview;"/>
	</form>
</td></tr>
</table>

</body>
</html>