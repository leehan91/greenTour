<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<OrderPaInfo> opList = (ArrayList<OrderPaInfo>)request.getAttribute("opList");
OrderPaInfo op = null;
String opCode = ""; 		
for(int i = 0; i<opList.size(); i++) {
	op = opList.get(i);
	opCode = op.getOp_code();
}

%>
<style>
#view_list > tr > th {text-align:"left"}
#content{width:"695px"}
.red {color:#ff0000; font-size:0.8em}
.borNon {border:none;}
.button {width: 90px; height: 70px; margin: 0 auto; text-align: center; display: block;}
.warning{text-align:center; font-size: 3em; margin: 350px auto;}
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
<script>
var frm = documemt.frm;
function submit(){
	alert(frm.reserve.value); 
	break;
if (frm.reserve.value == ""){alert("내용을 입력하세요");}
else{ location.href="pareview_proc_in"};	
}





</script>
<%
if(op != null ){
%>
<h2>리뷰 작성하기</h2>
<hr />

<div align="right" width="300"><span class="red">* </span>는 필수 정보입니다.</div>

<form name="frm" action="pareview_proc_in" method="post">
	<input type="hidden" name="opcode" value="" />
	<table width="1130" border="1" cellpadding="10" align="center" id="view_list">
		<tr>
		<th width="35%">예약자명</th>
		<td width="*">
		<input type="text" class="borNon" name="name" value="<%=op.getOp_customer() %>"
		readonly="readonly" onfocus="this.blur();"/></td>
		</tr>
		<tr>
			<th>아이디</th>
			<td>
			<input type="text" class="borNon" name="uid" value="<%=op.getMi_id() %>"
		readonly="readonly" onfocus="this.blur();"/></td>
			</td>
		</tr>
		<tr>
		
			<th><span class="red">* </span>예약내역</th>
			<td>
				<select name="list">
					<option value="">패키지이름</option>
<%
for(int i = 0 ; i < opList.size() ; i++) {
	OrderPaInfo op2 = opList.get(i); 	

%>
					<option value="<%=op2.getOp_name()%>/<%=op2.getOp_code() %>"><%=op2.getOp_name() %>/<%=op2.getOp_code() %></option>
					
<%}	%>
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
				<input type="text" name="title" style="width:710px;" placeholder="제목을 입력하세요" maxlength="40"/>
			</td>
		</tr>
		<tr>
			<th for="content">내용</th>
			<td>
				<textarea id="content" name="content" cols="100" rows="14" style="resize:none;"></textarea>
			</td>
		</tr>
		
	</table>
	<input type="button" class="button" value="취소" onclick="history.back();" />
	<input type="button" class="button" value="신청" onclick="submit()" />
</form>
<%}else{
%>
	<p class="warning">등록하실 리뷰가 없습니다.<p>
	<input type="button" class="button" value="뒤로가기" onclick="history.back();" />
<%} %>	


</body>
</html>