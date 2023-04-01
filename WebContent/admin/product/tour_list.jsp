<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head_admin.jsp"%>
<%
request.setCharacterEncoding("utf-8");

ArrayList<PackageTour> ptList = (ArrayList<PackageTour>)request.getAttribute("ptList");
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
ul, li, a{list-style: none; padding:0; color:#000; text-decoration:none;}

.list{border:1px solid #000; height:690px;}
.list th {border:1px solid #ddd;}
.list tr td, #list tr th {
    position: relative;
    padding: 10px 10px 12px 10px;
    font-size: 13px;
    border: 1px solid #ccc;
    word-wrap: break-word;
    word-break: break-all;
    letter-spacing: -0.04em;
}
.list tbody tr td  a{
     padding-left: 5px;
}
#sch td{margin: 0 auto;}
#edit {	width:20px; }

</style>
<script>

function getSelectedValues() {
	// 체크박스들 중 선택된 체크박스들의 값들을 쉼표로 구분하여 문자열로 리턴하는 함수	
	var del1 = document.frm.del;
	var value = ""; // del 컨트롤 배열에서 선택된 체크박스의 값들을 누적 저장할 변수
	for (var i = 1 ; i < del1.length ; i ++){
		if (del1[i].checked){
			value += "," + del1[i].value; 	
		}
	}
	return value.substring(1);
}

function delP(){
	// 사용자가 선택한 상품(들)을 삭제시키는 함수
	var ptcode = getSelectedValues();
	// 선택한 ptcode 값들이 쉼표를 기준으로 '1,2,3,4' 문자열로 저장됨
	if (ptcode == "")		alert("삭제할 상품을 선택하세요."); 
	else 					listDel(ptcode);
}

function listDel(ptcode){
	// 리스트내 특정 상품을 삭제하는 함수
 	
	
	if (confirm("정말 삭제하시겠습니까?")){
		$.ajax({
			type : "POST",
			url : "/greenTourSite/tour_proc_del",
			data : {"ptcode" : ptcode},
			success : function(chkRs){
				if (chkRs == 0){
					alert("상품 삭제에 실패했습니다.\n 다시 시도하세요.");
				}
				location.reload();
			}
		})
	}
}

</script>
</head>
<body>
<main class="side_menu">
	<ul class="ctgr">
		<li><a href="member_list">회원 관리</a></li><hr />
		<li><a href="">도시 관리</a></li><hr />
		<li><a href="">게시판 관리</a></li><hr />
		<li class = "fold">
         <a href="/greenTourSite/admin_package_list">상품 관리</a><br />
         <span>&nbsp;&nbsp;&nbsp;<a href="/greenTourSite/admin_package_list"> - 패키지 관리</a></span><br />
	         <span>&nbsp;&nbsp;&nbsp;<a href="/greenTourSite/hotel_list"> - 호텔 관리</a></span><br />
	         <span>&nbsp;&nbsp;&nbsp;<strong><a href="/greenTourSite/tour_list"> - 관광 상품 관리</a></strong><br />
      </li><hr />
		<li><a href="">고객센터</a></li><hr />
		<li class = "fold"><a href="/greenTourSite/admin_amount">통계</a></li>
	</ul>
<form name="frm" />
<table width="830" class="list">
<tr>
<th width="6%">NO</th>
<th width="7%">국가</th>
<th width="7%">도시</th>
<th width="16%">관광 상품명</th>
<th width="*">주소</th>
<th width="17%">등록일</th>
<th width="5%">수정</th>
<th width="5%">선택</th>
</tr>
<%
if(ptList.size() > 0){ // 게시글 목록이 있으면
	int num = rcnt - (psize * (cpage - 1));
	for (int i = 0 ; i < ptList.size() ; i++){
		PackageTour pt = ptList.get(i);
		
		String country, city;
		String ptcode = pt.getPt_code();
		country = pt.getCc_id().substring(0,3);
		city = pt.getCc_id().substring(3);
		String addr = pt.getPt_addr();
		String name = pt.getPt_name();
	
		if (name.length() > 9)		name = name.substring(0,9)+"..";
		if (addr.length() > 40)
			addr = addr.substring(0,37) + "...";
		
		
%>
<tr align="center">
	<td><%=num %></td>
	<td><%=country %></td>
	<td><%=city %></td>
	<td align="left">&nbsp;&nbsp;<%=name %></td>
	<td align="left"><%=addr %></td>
	<td><%=pt.getPt_date() %></td>
	<td><a href="tour_form_up?ptcode=<%=ptcode %>">
	<img id="edit" src="/greenTourSite/front/img/edit.png"></a></td>
	<td><input type="checkbox" name="del" class="del" value="<%=ptcode %>" /></td>
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
<table id="sch" width="830" cellpadding="0" align="center">
<tr>
<td width="600" align="center" >
<%
if (rcnt > 0 ){ // 게시글이 있으면 - 페이징 영역을 보여줌
	String lnk = "tour_list?cpage=";
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
<td width="*" align="right" style="display:flex; justify-content: space-around;">
	<input type="button" align="right"value="상품 추가" onclick="location.href='tour_form_in'"/>
	<input type="button" align="right"value="상품 삭제" onclick="delP();" />
</td>
</tr>
<tr><td colspan ="2" align="center" cellpadding="13">
	<form name="frmSch" method="get" >
		<select name="schtype">
			<option value="">검색조건</option>
			<option value="code" <% if (schtype.equals("code")) {%>selected="selected"<%} %>>관광 상품 코드</option>
			<option value="name" <% if (schtype.equals("name")) {%>selected="selected"<%} %>>관광 상품명</option>
		</select>
		<input id="keyword" type="text" name="keyword" value="<%=keyword %>"/>
		<input type="submit" value="검색"/>
		<input type="button" value="전체글" onclick="location.href='tour_list;"/>
	</form>
</td></tr>
</table>
</main>
</body>
</html>