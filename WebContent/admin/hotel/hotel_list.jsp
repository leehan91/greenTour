<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head_admin.jsp"%>
<%
request.setCharacterEncoding("utf-8");

ArrayList<HotelInfo> hotelList = (ArrayList<HotelInfo>)request.getAttribute("hotelList");
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
<script>
function hotelDel() {
	
	var tempList = $(".test:checked");
	/* var hicodeList = [];
	
	for(var i=0; i<tempList.length; i++) {
		hicodeList[i] = tempList[i].value;
	}

	var data = new Object();
	data.hicodeList = hicodeList */
	
	var hicodeList = "";
	
	for(var i=0; i<tempList.length; i++) {
		hicodeList += tempList[i].value + "|";
	}

	var data = new Object();
	data.hicodeList = hicodeList
	
	// 장바구니 내 특정 상품을 삭제하는 함수
	// alert(value);
		if (confirm("정말 삭제하시겠습니까?")) {
			$.ajax({
				type : "POST", 
				url : "/greenTourSite/hotel_del_ctrl", 
				data : data,
				success : function(chkRs) {
					if (chkRs == 0) {		// 삭제에 실패했을 경우
						alert("호텔 상품 삭제에 실패하였습니다.\n다시 시도하세요.");
						return;
					}
					location.reload();
				}
			});
			
		}
	}
	

function aa() {
	location.href = '/greenTourSite/hotel_add';
}
	
	
</script>
<style>
.hotel_list{width:830px;}
.sch {
	margin: 0 auto;
}
.goods {border:1px solid #000;}
.goods tbody tr td, .goods thead tr th  {
    position: relative;
    padding: 10px 10px 12px 10px;
    font-size: 13px;
    border: 1px solid #ccc;
    word-wrap: break-word;
    word-break: break-all;
    letter-spacing: -0.04em;
}
.goods tbody tr td  a{
     padding-left: 5px;
}
   
.goods tbody tr td:nth-child(2) {
	text-align: center;
}
.goods tbody tr td:nth-child(3) {
	text-align: center;
}
.goods tbody tr td:nth-child(4) {
	text-align: center;
}

#edit {
	width:20px
}
</style>
<body>

<main class="side_menu">
	<ul class="ctgr">
		<li><a href="member_list">회원 관리</a></li><hr />
		<li><a href="">도시 관리</a></li><hr />
		<li><a href="">게시판 관리</a></li><hr />
		<li>
         <a href="/greenTourSite/admin_package_list">상품 관리</a><br />
         <span>&nbsp;&nbsp;&nbsp;<a href="/greenTourSite/admin_package_list"> - 패키지 관리</a></span><br />
	     <span>&nbsp;&nbsp;&nbsp;<strong><a href="/greenTourSite/hotel_list"> - 호텔 관리</a></strong></span><br />
	     <span>&nbsp;&nbsp;&nbsp;<a href="/greenTourSite/tour_list"> - 관광 상품 관리</a><br />
      	</li><hr />
		<li><a href="">고객센터</a></li><hr />
		<li><a href="/greenTourSite/admin_amount">통계</a></li>
	</ul>
	<div class="hotel_list">
		<div class="table">
			<div class="table_inner">
				<table class="goods"> 
					<colgroup>
						<col style="width:105px;">
						<col style="width:55px;">
						<col style="width:55px;">
						<col style="width:55px;">
						<col style="width:101px;">
						<col style="width:290px;">
						<col style="width:110px;">
						<col style="width:45px;">
						<col style="width:45px;">
					</colgroup>
					<thead>
						<tr>
							<th scope="col" class="col1"><a href="#!" class="ico_align" data-sort="code">호텔코드</a></th>
							<th scope="col" class="col2"><a href="#!" class="ico_align" data-sort="nation">국가</a></th>
							<th scope="col" class="col3"><a href="#!" class="ico_align" data-sort="city">도시</a></th>
							<th scope="col" class="col4"><a href="#!" class="ico_align" data-sort="star">성급</a></th>
							<th scope="col" class="col5">호텔명</th>
							<th scope="col" class="col6">호텔 주소</th>
							<th scope="col" class="col7">연 락 처</th>
							<th scope="col" class="col8">수정</th>
							<th scope="col" class="col9">선택</th>
						</tr>
					</thead>
					<tbody>
					<%
					if (hotelList.size() > 0) {		// 게시글 목록이 있으면
						int num = rcnt - (psize * (cpage - 1));
						for (int i = 0; i < hotelList.size(); i++) {
							HotelInfo hi = hotelList.get(i);
							String hicode = hi.getHi_code();
							String addr = hi.getHi_addr();
							
							if (addr.length() > 40)
								addr = addr.substring(0,37) + "...";
						
					%>
						<tr>
							<td scope="col"><%=hicode %></td>
							<td scope="col"><%=hi.getCc_nation() %></td>
							<td scope="col"><%=hi.getCc_city() %></td>
							<td scope="col"><%=hi.getHi_grade() %></td>
							<td scope="col"><%=hi.getHi_name() %></td>
							<td scope="col"><%=addr %></td>
							<td scope="col">+<%=hi.getHi_tel() %></td>
							<td scope="col"><a href="hotel_edit?hicode=<%=hicode %>"><img id="edit" src="/greenTourSite/front/img/edit.png"></a></td>
							<td scope="col"><input type='checkbox' name='del' class="test" value="<%=hicode %>"/><br /></td>
						</tr>
					<%
							num--;
						}
					} else {		// 게시글 목록이 없으면
						out.println("<tr><td colspan='5' align='center'>검색 결과가 없습니다.</td></tr>");
					}
					%>
					</tbody>
				</table>
				<br />
				<table class="sch">
					<tr>
						<td>
				<%
				if (rcnt > 0) {		// 게시글이 있으면 - 페이징 영역을 보여줌
					String lnk = "hotel_list?cpage=";
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
						<td colspan="2" style="padding: 13px;">
							<form name="frmSch" method="get">
									<select name="schtype">
										<option value="">검색 조건</option>
										<option value="name" <% if (schtype.equals("name")) { %>selected="selected"<% } %>>호텔명</option>
										<option value="nation" <% if (schtype.equals("nation")) { %>selected="selected"<% } %>>국가</option>
										<option value="city" <% if (schtype.equals("city")) { %>selected="selected"<% } %>>도시</option>
										<option value="code" <% if (schtype.equals("code")) { %>selected="selected"<% } %>>호텔코드</option>
									</select>
									<input type="text" name="keyword" value="<%=keyword %>" />
									<input type="submit" value="검색" />
									<input type="button" value="전체 글" onclick="location.href='hotel_list';" />
							</form>
						</td>
						<td width="*">
							<input type="button" value="호텔 추가" onclick="aa()"/>
						</td>
						<td width="*">
							<input type="button" value="호텔 삭제 " onclick="hotelDel();" />
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</main>
</body>
</html>