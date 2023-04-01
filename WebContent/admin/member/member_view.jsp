<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head_admin.jsp" %>
<%request.setCharacterEncoding("utf-8");
MemberInfo mi = (MemberInfo)request.getAttribute("mi");
ArrayList<OrderPaInfo> opList = (ArrayList<OrderPaInfo>)request.getAttribute("opList");
ArrayList<OrderMpInfo> omList = (ArrayList<OrderMpInfo>)request.getAttribute("omList");

PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage(), psize = pageInfo.getPsize();
int rcnt = pageInfo.getRcnt(), pcnt = pageInfo.getPcnt(), spage = pageInfo.getSpage();

String pw = mi.getMi_pw();
pw = pw.substring(0,2) + "****";
String regist = mi.getMi_registration();
regist = regist.substring(0,8) + "******";
%>
<script>
function canRequ(val){
 	var frmMiid = document.memFrm.miid.value;
 	var code = document.getElementById(val).innerHTML;
	alert(code);
	$.ajax({
		type : "Get",
		url : "member_reserve_cancel",
		data : {"code" : code, "frmMiid" : frmMiid },
		success : function(chkRs){
			if (chkRs == 0){
				alert("예약 삭제에 실패했습니다.\n 다시 시도하세요.");
			}
			location.reload();
		}
	})
	
}

var cmenu = 1;

function showList(num){
	var menu1 = document.getElementById("menu1");
	var menu2 = document.getElementById("menu2");
	
	if (num == 1) {
		menu1.style.display = "revert";
		menu2.style.display = "none";

	} else if (num == 2) {
		menu1.style.display = "none";
		menu2.style.display = "revert";
	}
	/* 2. 모든 메뉴를 숨긴 후 눌린 버튼에 해당하는 메뉴만 보여줌 */
	var menu1 = document.getElementById("menu1");	menu1.style.display = "none";
	var menu2 = document.getElementById("menu2");	menu2.style.display = "none";
	for (var i = 1 ; i <= 2 ; i++) {
		var tmp = document.getElementById("menu" + i);
		tmp.style.display = "none";
	}
	var menu = document.getElementById("menu" + num);
	menu.style.display = "revert";
	
	/* 3. 현재 보이는 메뉴를 숨기고 눌린 버튼에 해당하는 메뉴만 보여줌 */
	var obj1 = document.getElementById("menu" + cmenu);	// 현재 메뉴를 객체로 받아옴
	obj1.style.display = "none";	// 현재 메뉴를 숨김
	var obj2 = document.getElementById("menu" + num);	// 버튼을 누른 객체를 받아옴
	obj2.style.display = "revert";	// 버튼을 누른 객체를 보여줌
	cmenu = num;	// 현재 보이는 메뉴를 버튼을 누른 객체 번호로 변경
	
}
</script>

<style type="text/css">
.main {display:flex; justify-content: space-around; margin-top:100px;}
.ctgr {width:200px;}
.btns {display:flex; justify-content: space-evenly; margin-bottom: 10px;}
.btn {display: inline-flex; border: 1px solid #000; width: 100px; height: 50px; background-color: #d3d3d3;
     justify-content: space-evenly; align-items: center;}
#memberView-container {width : 830px; text-align: center;}

.tg  {border-collapse:collapse;border-spacing:0; margin: 0 auto; width: 830px; height: 700px;}
.tg tbody{text-align: center;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-kbue{background-color:lightgrey;border-color:inherit;font-weight:bold;}
.tg .tg-0pky{border-color:inherit;}

.tgi  {border-collapse:collapse;border-spacing:0;width:720px; margin: 0 auto;}
.tgi td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tgi th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tgi .tgi-0pky{border-color:inherit;text-align:left;vertical-align:top}
.tgi .tgi-0lax{text-align:left;vertical-align:top}

</style>

<div class="main">
	<div class="ctgr">
		<p><a href="member_list">회원 관리</a></p><hr />
		<p><a href="">도시 관리</a></p><hr />
		<p><a href="">게시판 관리</a></p><hr />
		<p><a href="admin_package_list">상품 관리</a></p><hr />
		<p><a href="">고객센터</a></p><hr />
		<p><a href="/greenTourSite/admin_amount">통계</a></p>
	</div>
	<div id ="memberView-container">
		<form name = "memFrm" action = "member_correc" post ="get">
			<input type="hidden" name="miid" value="<%=mi.getMi_id() %>" />
			<table class="tg">
				<thead>
				  <tr>
				    <th class="tg-0pky" colspan="4"><h2>회원상세정보</h2></th>
				  </tr>
				</thead>
				<tbody>
				  <tr>
				    <th class="tg-kbue">ID</th>
				    <th class="tg-0pky"><%=mi.getMi_id() %></th>
				    <th class="tg-kbue">이름</th>
				    <th class="tg-0pky"><%=mi.getMi_name() %></th>
				  </tr>
				  <tr>
				    <td class="tg-kbue">비밀번호</td>
				    <td class="tg-0pky"><%=pw %></td>
				    <td class="tg-kbue">휴대폰</td>
				    <td class="tg-0pky"><%=mi.getMi_phone() %></td>
				  </tr>
				  <tr>
				    <td class="tg-kbue">회원상태</td>
				    <td class="tg-0pky" colspan="3">
				    	<select name="memStatus">
				<%		
				String[] arr1 = {"a", "b", "c"};
				String[] arr2 = {"정상", "휴면", "삭제"};
						for (int i = 0; i < arr1.length; i++) {
							String stat = arr1[i];
							String text = arr2[i];
							String selected= "";
								
							if (mi.getMi_status() == arr1[i])	selected = " selected='selected'";
				%>
								<option value="<%= arr1[i] %>" <%=selected %>><%=arr2[i] %></option>
				<%}%>
				    	</select>
				    </td>
				  </tr>
				  <tr>
				    <td class="tg-kbue">이메일</td>
				    <td class="tg-0pky"><%=mi.getMi_email() %></td>
				    <td class="tg-kbue">주민번호</td>
				    <td class="tg-0pky"><%=regist %></td>
				  </tr>
				  <tr>
				    <td class="tg-kbue">가입일</td>
				    <td class="tg-0pky"><%=mi.getMi_joindate() %></td>
				    <td class="tg-kbue">최종 방문일</td>
				    <td class="tg-0pky"><%=mi.getMi_lastlogin() %></td>
				  </tr>
				  <tr>
				    <td class="tg-kbue">최종수정일</td>
				    <td class="tg-0pky"><%=mi.getMi_date() %></td>
				    <td class="tg-kbue">마일리지</td>
				    <td class="tg-0pky"><%=mi.getMi_mileage() %></td>
				  </tr>
				  <tr>
				    <td class="tg-kbue">예약관리</td>
				    <td class="tg-0pky" colspan="3">
				<%if(opList.size() > 0 || omList.size() > 0){
				%>
				  		  <div class="btns">
					  		<span class="btn op" onclick="showList(1);">패키지</span>
					  		<span class="btn om" onclick="showList(2);">나만의 패키지</span>
						  </div>
				    	<table class="tgi">
						   <tr>
						    <th class="tgi-0pky">예약번호<br> [예약일자]</th>
						    <th class="tgi-0lax">상품명</th>
						    <th class="tgi-0lax">출발일<br>도착일</th>
						    <th class="tgi-0lax">예약취소</th>
						   </tr>
						  
						  <tbody id="menu1">
				<%
					for (int i = 0; i < opList.size(); i++) {
						OrderPaInfo op = opList.get(i);
						String opTime = op.getOp_time();
						String date = opTime.substring(0,16);
						String status = op.getOp_status();
						String code = op.getOp_code();
				%>
						  <tr>
						    <td class="tgi-0lax"><span id="code<%=i%>"><%=code %></span><br>[<%=date %>]</td>
						    <td class="tgi-0lax"><%=op.getOp_name() %></td>
						    <td class="tgi-0lax"><%=op.getOp_leave() %><br><%=op.getFi_entry() %> </td>
						    
				<%		if(status.equals("a")){		
								    out.println("<td class='tgi-0lax'><span>입금대기중</span></td>");
						} else if(status.equals("b")){
								    out.println("<td class='tgi-0lax'><span>예약완료</span></td>");
						} else if(status.equals("c")) {%>
							<td class="tgi-0lax"><input type="button" value="취소요청 확인" onclick="canRequ('code<%=i %>');"/></td>
						<%
						} else if(status.equals("d")) {
								    out.println("<td class='tgi-0lax'><span>취소완료</span></td>");
						}
							out.println("</tr>");
					}%>
						  </tbody>
  				    	  <tbody id="menu2" style="display:none;">
				<%
					for (int i = 0; i < omList.size(); i++) {
						OrderMpInfo om = omList.get(i);
						String omTime = om.getOm_time();
						String date = omTime.substring(0,16);
						String status = om.getOm_status();
						String code = om.getOm_code();
				%>
						  <tr>
						    <td class="tgi-0lax"><span id="code"><%=code %></span><br>[<%=date %>]</td>
						    <td class="tgi-0lax"><%=om.getOm_name() %></td>
						    <td class="tgi-0lax"><%=om.getOm_leave() %><br> </td>
						    
				<%		if(status.equals("a")){		
								    out.println("<td class='tgi-0lax'><span>입금대기중</span></td>");
						} else if(status.equals("b")){
								    out.println("<td class='tgi-0lax'><span>예약완료</span></td>");
						} else if(status.equals("c")) {%>
						<td class="tgi-0lax"><input type="button" value="취소요청 확인" onclick="canRequ('code<%=i %>');"/></td>
					<%
						} else if(status.equals("d")) {
								    out.println("<td class='tgi-0lax'><span>취소완료</span></td>");
						}
								out.println("</tr>");
					}%>
						  </tbody>
						</table><br/>
				<%
				}else {
  				    	out.println("<h3>예약 내역이 없습니다.<h3>");
			 	} %>

			 
			 <% if(rcnt > 0) {
				String lnk = "member_view?cpage=";
				pcnt = rcnt / psize;
				if (rcnt % psize >0)	pcnt++;
				spage = (cpage - 1) / bsize * bsize + 1;
				for (int i = 1, j = spage; i <= bsize && j <= pcnt; i++, j++) {
					// i : 블록에서 보여줄 페이지의 개수 만큼 루프를 돌릴 조건으로 사용되는 변수
					// j : 실제 출력할 페이지 번호로 전체 페이지 개수(마지막 페이지 번호)를 넘지 않게 사용해야 함
						if (cpage == j)		out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
						else 				out.println("&nbsp;<a href='" + lnk + j + "'>" + j + "</a>&nbsp;");
					}
			 }
			 %>
					</td>
				  </tr>
				</tbody>
			</table>
			<br/>
			
			<input type = "submit" value = "수정" />
			<input type = "button" value = "목록" onclick="location.href='member_list'"/>
		</form>
	</div>
</div>
</body>
</html>