<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
CsPareview cp = (CsPareview)request.getAttribute("cp");

int cpidx = cp.getCp_idx();
int cpage = Integer.parseInt(request.getParameter("cpage"));
String args = "?cpage=" + cpage;		// 링크에서 사용할 쿼리 스트링
String schtype = request.getParameter("schtype");
String keyword = request.getParameter("keyword");
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
	args += "&schtype=" + schtype + "&keyword=" + keyword;
}

%>
<style>
.reList { width: 700px; }
.reWriter {
	width: 700px; padding: 5px; 
	display: flex; 
	justify-content: space-between; 
	border: 1px solid #000;
}
.reContent {
	width: 700px; padding: 5px; 
	border: 1px solid #000; 
	border-top: none;
	margin-bottom: 5px;
}
/* 별점 css */
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
<h2>리뷰 작성하기</h2>
<table width="1130" border="1" cellpadding="10" align="center" id="view_list">
		<tr>
		<th width="35%">예약자명</th>
		<td width="*">
		<input type="text" class="borNon" name="writer" value="<%=loginInfo.getMi_name() %>"
		readonly="readonly" onfocus="this.blur();"/></td>
		</tr>
		<tr>
			<th>아이디</th>
			<td>
			<input type="text" class="borNon" name="uid" value="<%=loginInfo.getMi_id() %>"
		readonly="readonly" onfocus="this.blur();"/></td>
			</td>
		</tr>
		<tr>
			<th><span class="red">* </span>예약내역</th>
			<td>
				<select name="reserve">
					<option value="" selected="selected">예약내역</option>
					<option value="packages" >패키지</option>
					<option value="mypackage" >나의 패키지</option>
				</select>
			</td>
		</tr>
		<tr>
			<th><span class="red">* </span>별점</th>
			<!-- 별점 css inc_head에 있습니다. -->
			<td>
				<div class="mb-3" id="myform" >
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
				</div>
			</td>
		</tr>
		<tr>
			<th><span class="red">* </span>제목</th>
			<td>
				<input type="text" name="title" style="width:710px;" value="<%=cp.getCp_title() %>" maxlength="40"/>
			</td>
		</tr>
		<tr>
			<th for="content">내용</th>
			<td>
				<textarea id="content" name="content" value="<%=cp.getCp_content() %>" cols="100" rows="14" style="resize:none;"></textarea>
			</td>
		</tr>
		
	</table>
<br /><hr align="left" width="700" /><br />
<p style="width: 700px" align="center">
	<input type="button" value="목록" onclick="location.href='notice_list<%=args %>';" />
</p>
<br /><hr align="left" width="700" /><br />
</body>
</html>