<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head_admin.jsp"%>
<%
request.setCharacterEncoding("utf-8");
HotelInfo hi = (HotelInfo)request.getAttribute("hi");

String hicode = hi.getHi_code();
%>

<style type="text/css">

#newId{
	color:red;
}

.tg {
	border-collapse: collapse;
	border-spacing: 0;
	margin: 30px 0;
}

.tg td {
	border-color: black;
	border-style: solid;
	border-width: 1px;
	font-family: Arial, sans-serif;
	font-size: 14px;
	overflow: hidden;
	padding: 10px 5px;
	word-break: normal;
	    height: 68px;
}

.tg th {
	border-color: black;
	border-style: solid;
	border-width: 1px;
	font-family: Arial, sans-serif;
	font-size: 14px;
	font-weight: normal;
	overflow: hidden;
	padding: 10px 5px;
	word-break: normal;
}

.tg .tg-0pky {
	border-color: inherit;
	text-align: left;
	vertical-align: top
}

.tg .tg-0lax {
	text-align: left;
	vertical-align: top
}

.desc {
	margin-bottom: 50px;
}

.notice{
	margin-bottom: 20px;
}

.sb {
    float: right;
    font-size: 22px;
}

.content {
	margin : 100px 0;
}

.sel1 {
    width: 60px;
}

.sel2 {
    width: 69px;
}

.hcode {
    font-size: 30px;
}

#sdp{width: 88px;}
#dlp{width: 88px;}
#sup{width: 88px;}
#htel{width: 118px;}
</style>
<div>
	<div class="content">
		<span class="hcode">호텔코드 : <%=hicode %></span>
		<form method="post" id="hotelAddForm" action="/greenTour/hotel_up">
			<table class="tg" style="table-layout: fixed; width: 1130px">
				<colgroup>
					<col style="width: 77px">
					<col style="width: 77px">
					<col style="width: 50px">
					<col style="width: 171px">
					<col style="width: 313px">
					<col style="width: 131px">
					<col style="width: 100px">
					<col style="width: 100px">
					<col style="width: 100px">
				</colgroup>
				<thead>
					<tr>
						<th class="tg-0pky">국가</th>
						<th class="tg-0lax">도시</th>
						<th class="tg-0lax">성급</th>
						<th class="tg-0lax">호텔명</th>
						<th class="tg-0lax">주소</th>
						<th class="tg-0lax">연락처</th>
						<th class="tg-0lax">스탠다드 가격</th>
						<th class="tg-0lax">디럭스 가격</th>
						<th class="tg-0lax">스위트 가격</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="tg-0lax"><p><%=hi.getCc_nation() %></p></td>
						<td class="tg-0lax"><p><%=hi.getCc_city() %></p></td>
						<td class="tg-0lax"><select name="grade">
						<option>1</option>
						<option>2</option>
						<option>3</option>
						<option>4</option>
						<option>5</option>
						</select></td>
						<td class="tg-0lax"><textarea name="name" rows="2" cols="25" style="width:160px; height:50px; resize: none;"><%=hi.getHi_name() %></textarea></td>
						<td class="tg-0lax"><textarea name="addr" rows="2" cols="25" style="width:305px; height:50px; resize: none;"><%=hi.getHi_addr() %></textarea></td>
						<td class="tg-0lax"><input id="htel" name="tel" type="text" value="<%=hi.getHi_tel() %>"/></td>
						<td class="tg-0lax"><input id="sdp" name="standard" type="text" onKeyup="onlyNumber(this)" value="<%=hi.getHi_standard() %>"/></td>
						<td class="tg-0lax"><input id="dlp" name="deluxe" type="text" onKeyup="onlyNumber(this)" value="<%=hi.getHi_deluxe() %>"/></td>
						<td class="tg-0lax"><input id="sup" name="suite" type="text" onKeyup="onlyNumber(this)" value="<%=hi.getHi_suite() %>"/></td>
					</tr>
				</tbody>
			</table>
			<div>
				<textarea class="desc" name="desc" rows="5" cols="25" placeholder="호텔 소개" style="width:1130px; height:150px; resize: none;"><%=hi.getHi_desc() %></textarea>
				<textarea class="notice" name="notice" rows="5" cols="25" placeholder="안내 사항" style="width:1130px; height:150px; resize: none;"><%=hi.getHi_notice() %></textarea>
			</div>
				<input type="hidden" name="code" value="<%=hicode %>" >
				<button class="sb" type="submit">완료</button>
		</form>
	</div>
</div>
</body>
</html>