<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head_admin.jsp"%>
<%
	ArrayList<PackageInfo> packageList = (ArrayList<PackageInfo>) request.getAttribute("packageList");
	PackageInfo pai = (PackageInfo) request.getAttribute("pai");
	PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
	int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage(), psize = pageInfo.getPsize();
	int rcnt = pageInfo.getRcnt(), pcnt = pageInfo.getPcnt(), spage = pageInfo.getSpage();
	String schtype = pageInfo.getSchtype(), keyword = pageInfo.getKeyword();

	if (schtype == null)
		schtype = "";
	if (keyword == null)
		keyword = "";

	String schargs = "", args = "";
	if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) { // 검색 조건(schtype)과 검색어(keyword)가 있으면 검색관련 쿼리스트링 생성
		schargs = "&schtype=" + schtype + "&keyword=" + keyword;
	}
	args = "&cpage=" + cpage + schargs;
%>
<style>
ul, li, a {
	list-style: none;
	padding: 0;
	color: #000;
	text-decoration: none;
}

body {
	width: 1130px;
	margin: 0 auto;
}

.main {
	display: flex;
	justify-content: space-evenly;;
	margin-top: 100px;
}

.ctgr {
	width: 200px;
}

.list {
	width: 830px;
}

.list tr {
	height: 30px;
}

.list th, #list td {
	padding: 8px 3px;
}

.list th {
	border: solid black 1px;
}

.list td {
	border: solid black 1px;
	font-size: 0.8em;
}

#exist {
	display: none;
}

#exist p {border:1px solid black; margin:0; padding:30px 0;}

#none {
	display: block;
}
</style>
<script>
	function info(picode) {
		$.ajax({
			type : "POST",
			url : "/greenTourSite/admin_package_info",
			data : {
				"picode" : picode
			},
			success : function(chkRs) {
				if (chkRs != null) {
					var arr = chkRs.split("/");
					var exist = document.getElementById("exist");
					var none = document.getElementById("none");
					document.getElementById("ccname").innerHTML = arr[0];
					document.getElementById("pitour").innerHTML = arr[1];
					document.getElementById("hiname").innerHTML = arr[2];
					document.getElementById("pifood").innerHTML = arr[3];
					document.getElementById("pistock").innerHTML = arr[4];
					//exist.style.cssText = "display: block";
					exist.style.display = "block";
					none.style.display = "none";

				}
			}
		});
	}
	
	function packageDel(picode) {
		if (confirm("정말 삭제하시겠습니까?")) {
			location.href = "package_delete?picode=" + picode;
		}
	}
</script>
<div class="main">
	<div class="bar">
		<ul class="ctgr">
			<li><a href="/greenTourSite/member_list">회원 관리</a></li>
			<hr />
			<li><a href="">도시 관리</a></li>
			<hr />
			<li><a href="">게시판 관리</a></li>
			<hr />
			<li>
         <a href="/greenTourSite/admin_package_list">상품 관리</a><br />
         <span>&nbsp;&nbsp;&nbsp;<a href="/greenTourSite/admin_package_list"> - 패키지 관리</a></span><br />
	         <span>&nbsp;&nbsp;&nbsp;<a href="/greenTourSite/hotel_list"> - 호텔 관리</a></span><br />
	         <span>&nbsp;&nbsp;&nbsp;<a href="/greenTourSite/tour_list"> - 관광 상품 관리</a><br />
      </li><hr />
			<li><a href="">고객센터</a></li>
			<hr />
			<li><a href="/greenTourSite/admin_amount">통계</a></li>
		</ul>
	</div>

	<div class="list">
	<form action="package_up" style="margin: 0 auto;">
		<table cellpadding="0" cellspacing="0" width="830">
			<tr style="font-size: 0.8em;">
				<th width="10%">상품코드</th>
				<th width="10%">여행 기간</th>
				<th width="*%">상품명</th>
				<th width="10%">상품가격</th>
				<th width="15%">상품 상세보기</th>
				<th width="10%">삭제</th>
				<th width="10%">수정</th>
			</tr>
			<%
				if (packageList.size() > 0) {
					int num = rcnt - (psize * (cpage - 1));
					for (int i = 0; i < packageList.size(); i++) {
						PackageInfo pi = packageList.get(i);

						String title = pi.getPi_name();
						if (title.length() > 18)
							title = title.substring(0, 13) + "...";
			%>
			<tr align="center">
				<td width="10%">
				<input style="border:none;" type="text" size="9" readonly="readonly" readonly onfocus="this.blur();" name="picode" value="<%=pi.getPi_code() %>" />
				</td>
				<td width="10%"><%=pi.getPi_period()%></td>
				<td width="*%"><%=title%></td>
				<td width="10%"><%=pi.getPi_price()%>원</td>
				<td width="15%">
						<input type="button" value="<%=pi.getPi_code()%>"
							onclick="info(this.value);" />
				</td>
				<td width="10%">
						<input type="button" value="삭제" onclick="packageDel('<%=pi.getPi_code() %>')" /></td>
				<td width="10%">
						<input type="submit" value="수정하기" />
				</td>
			</tr>
			<%
				num--;
					}
				} else {
					out.println("<tr><td colspan='7' align='center'>검색 결과가 없습니다.</td></tr>");
				}
			%>
		</table>
	</form>
	<br />
		<table width="830" cellpadding="5">
			<tr align="center">
				<td width="600" style="border: none;">
					<%
						if (rcnt > 0) { // 게시글이 있으면 - 페이징 영역을 보여줌
							String lnk = "admin_package_list?cpage=";
							pcnt = rcnt / psize;
							if (rcnt % psize > 0)
								pcnt++; // 전체 페이지 수(마지막 페이지 번호)

							if (cpage == 1) {
								out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
							} else {
								out.println("<a href='" + lnk + 1 + schargs + "'>[처음]</a>&nbsp;&nbsp;&nbsp;");
								out.println("<a href='" + lnk + (cpage - 1) + schargs + "'>[이전]</a>&nbsp;&nbsp;");
							}

							spage = (cpage - 1) / bsize * bsize + 1; // 현재 블록에서의 시작 페이지 번호
							for (int i = 1, j = spage; i <= bsize && j <= pcnt; i++, j++) {
								// i : 블록에서 보여줄 페이지의 개수 만큼 루프를 돌릴 조건으로 사용되는 변수
								// j : 실제 출력할 페이지 번호로 전체 페이지 개수(마지막 페이지 번호)를 넘지 않게 사용해야 함
								if (cpage == j)
									out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
								else
									out.println("&nbsp;<a href='" + lnk + j + schargs + "'>" + j + "</a>&nbsp;");
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
			<tr></tr>
			<tr>
				<td colspan="2">
					<form name="frmSch" method="get">
						<fieldset>
							<legend>패키지 검색</legend>
							<select name="schtype">
								<option value="">검색 조건</option>
								<option value="name" <%if (schtype.equals("name")) {%>
									selected="selected" <%}%>>패키지명</option>
								<option value="period" <%if (schtype.equals("period")) {%>
									selected="selected" <%}%>>기간</option>
								<option value="code" <%if (schtype.equals("code")) {%>
									selected="selected" <%}%>>상품코드</option>
							</select> <input type="text" name="keyword" value="<%=keyword%>" /> <input
								type="submit" value="검색" />
						</fieldset>
					</form>
				</td>
			</tr>
		</table>
		<div id="exist">
			<h4 align="center">패키지 상세 정보</h4>
			<!-- 선택된 패키지에 따라 값 가져오기 -->
			<p style="border-bottom:none;"><span>여행도시 :</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="ccname"></span></p>
			<p style="border-bottom:none;"><span>관광 상품 :</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="hiname"></span></p>
			<p style="border-bottom:none;"><span>호텔 :</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="pitour"></span></p>
			<p style="border-bottom:none;"><span>식사 :</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="pifood"></span></p>
			<p><span>수량 :</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="pistock"></span></p><br />
		</div>
		<span id="none" style="border:none; text-align:center;">상세정보가 없습니다.</span>
		<div align="right"><form><input type="button" value="상품 추가하기" onclick="location.href='admin_add_package_form'" /></form></div>
	</div>
</div>

</body>
</html>