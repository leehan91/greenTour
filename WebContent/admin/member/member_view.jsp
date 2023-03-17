<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head_admin.jsp" %>
<%request.setCharacterEncoding("utf-8");
MemberInfo mi = (MemberInfo)request.getAttribute("mi");
ArrayList<OrderPaInfo> opList = (ArrayList<OrderPaInfo>)request.getAttribute("opList");
ArrayList<OrderMpInfo> omList = (ArrayList<OrderMpInfo>)request.getAttribute("omList");

String pw = mi.getMi_pw();
pw = pw.substring(0,2) + "****";
String regist = mi.getMi_registration();
regist = regist.substring(0,8) + "******";
%>
<script>
function canRequ(){
 	var frmMiid = document.memFrm.miid.value;
 	var code = $("#code").text();

	$.ajax({
		type : "Get",
		url : "/greenTourSite/member_reserve_cancel",
		data : {"code" : code, "frmMiid" : frmMiid },
		success : function(chkRs){
			if (chkRs == 0){
				alert("상품 삭제에 실패했습니다.\n 다시 시도하세요.");
			}
			location.reload();
		}
	})
	
}
	
</script>

<style type="text/css">
.main {display:flex; justify-content: space-around; margin-top:100px;}
.ctgr {width:200px;}
#memberView-container {
	width : 830px;
	text-align: center;
}

.th{display:none;}
.tg  {border-collapse:collapse;border-spacing:0; margin: 0 auto; width: 90%; height: 700px;}
.tg tbody{text-align: center;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-kbue{background-color:lightgrey;border-color:inherit;font-weight:bold;}
.tg .tg-0pky{border-color:inherit;}

.tgi  {border-collapse:collapse;border-spacing:0;width:100%;}
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
<h2>회원상세정보</h2>
<form name = "memFrm" action = "member_correc" post ="get">
<input type="hidden" name="miid" value="<%=mi.getMi_id() %>" />
<table class="tg">
<thead>
  <tr class="th">
    <th class="tg-kbue">ID</th>
    <th class="tg-0pky"><%=mi.getMi_id() %></th>
    <th class="tg-kbue">이름</th>
    <th class="tg-0pky"><%=mi.getMi_name() %></th>
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

				
<%		}%>
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
    	<table class="tgi">
			<thead>
				  <tr>
				    <th class="tgi-0pky">예약번호<br> [예약일자]</th>
				    <th class="tgi-0lax">상품명</th>
				    <th class="tgi-0lax">출발일<br>도착일</th>
				    <th class="tgi-0lax">예약현황</th>
				    <th class="tgi-0lax">예약취소</th>
				  </tr>
			</thead>
<%
if (opList.size() > 0) {		// 예약 내역이 있으면
	for (int i = 0; i < opList.size(); i++) {
		OrderPaInfo op = opList.get(i);
		String opTime = op.getOp_time();
		String date = opTime.substring(0,16);
		String status = op.getOp_status();
		String code = op.getOp_code();
%>
				<tbody>
				  <tr>
				    <td class="tgi-0lax"><span id="code"><%=code %></span><br>[<%=date %>]</td>
				    <td class="tgi-0lax"><%=op.getOp_name() %></td>
				    <td class="tgi-0lax"><%=op.getOp_leave() %><br><%=op.getFi_entry() %> </td>
				    <td class="tgi-0lax" name="reserve_status"><%=status %></td>
				    
				    
<%if(status.equals("a")){%>				    
				    <td class="tgi-0lax"><span>입금대기중</span></td>
<%} else if(status.equals("b")) {%>
				    <td class="tgi-0lax"><span>예약완료</span></td>
<%} else if(status.equals("c")) {%>
				    <td class="tgi-0lax"><input type="button" value="취소요청 확인" onclick="canRequ();"/>
				    </td>
<%} else if(status.equals("d")) {%>
				    <td class="tgi-0lax"><span>취소완료</span></td>
<%} %>
				  </tr>		  	
				</tbody>

<%} %>
	</table>	
		
<%}else{%>
	    	<table class="tgi">
			<thead>
				  <tr>
				    <th >예약 내역이 없습니다.</th>
				  </tr>
			</thead>
			</table>
<% } %>
    </td>
  </tr>
</tbody>
</table>
<input type = "submit" value = "수정" />
<input type = "button" value = "목록" onclick="location.href='member_list'"/>
</form>
</div>
</main>
</body>

</html>