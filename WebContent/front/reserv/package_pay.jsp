<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head.jsp" %>   
<%
request.setCharacterEncoding("utf-8");
// 예약코드, 상품명, 출발일자, 출발지, 도착지, 인원, 여행기간, 예약자, 연락처, 이메일, 보유마일리지, 사용마일리지, 금액 
OrderPaInfo op = (OrderPaInfo)request.getAttribute("orderPaInfo");
String opCode = (String)request.getAttribute("opCode");
int mile = (int)request.getAttribute("mile");


%>
<style type="text/css">
#chk_container{text-align : center; margin : 30px auto;}
.tg  {border-collapse:collapse;border-spacing:0; margin : 10px auto;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
.tg .tg-0lax{text-align:left;vertical-align:top}
</style>
<div id = "chk_container">
<h2>패키지 예약 확인</h2>
<form id = "chkReserv" name = "chkFrm" action = "package_pay_view" method = "post">
<table class="tg">
<thead>
  <tr>
    <th class="tg-0pky">예약코드</th>
    <th class="tg-0lax"><%=opCode %></th>
    <th class="tg-0lax">상품명</th>
    <th class="tg-0lax" colspan="3"><%=op.getOp_name() %></th>
    <th class="tg-0lax">출발일자</th>
    <th class="tg-0lax"><%=op.getOp_leave() %></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-0lax">출발지</td>
    <td class="tg-0lax"><%=op.getOp_spoint() %></td>
    <td class="tg-0lax">도착지</td>
    <td class="tg-0lax"><%=op.getCc_id() %></td>
    <td class="tg-0lax">인원</td>
    <td class="tg-0lax">총원 : <%=op.getOp_adult() + op.getOp_child() %> (성인 : <%=op.getOp_adult() %> 아동 : <%=op.getOp_child() %>)</td>
    <td class="tg-0lax">여행기간</td>
    <td class="tg-0lax"><%=op.getOp_period() %></td>
  </tr>
  <tr>
    <td class="tg-0lax">예약자</td>
    <td class="tg-0lax" colspan="2"><%=op.getOp_customer() %></td>
    <td class="tg-0lax">연락처</td>
    <td class="tg-0lax" colspan="2"><%=op.getOp_phone() %></td>
    <td class="tg-0lax">이메일</td>
    <td class="tg-0lax"><%=op.getOp_email() %></td>
  </tr>
  <tr>
    <td class="tg-0lax">결제수단</td>
    <td class="tg-0lax"><input type="radio" name="payment" value="a" id="payA" /><label for="payA">카드 결제</label></td>
    <td class="tg-0lax"><input type="radio" name="payment" value="b" id="payB" /><label for="payA">휴대폰 결제</label></td>
    <td class="tg-0lax"><input type="radio" name="payment" value="c" id="payC" /><label for="payA">무통장 입금</label></td>
    <td class="tg-0lax">금액</td>
    <td class="tg-0lax" colspan="3"><%=op.getOp_pay() %></td>
  </tr>
</tbody>
</table>
<input type = "hidden" name = "opCode" value = "<%=opCode %>" />
<input type = "hidden" name = "piCode" value = "<%=op.getPi_code() %>" />
<input type = "hidden" name = "opName" value = "<%=op.getOp_name() %>" />
<input type = "hidden" name = "ccid" value = "<%=op.getCc_id() %>" />
<input type = "hidden" name = "fiCode" value = "<%=op.getFi_code() %>" />
<input type = "hidden" name = "departure" value = "<%=op.getOp_leave() %>" />
<input type = "hidden" name = "customer" value = "<%=op.getOp_customer() %>" />
<input type = "hidden" name = "spoint" value = "<%=op.getOp_spoint() %>" />
<input type = "hidden" name = "period" value = "<%=op.getOp_period() %>" />
<input type = "hidden" name = "phone" value = "<%=op.getOp_phone() %>" />
<input type = "hidden" name = "email" value = "<%=op.getOp_email() %>" />
<input type = "hidden" name = "total" value = "<%=op.getOp_pay() %>" />
<input type = "hidden" name = "adult" value = "<%=op.getOp_adult()%>" />
<input type = "hidden" name = "child" value = "<%=op.getOp_child() %>" />
<input type = "submit" name = "goPay" value = "결제하기">
<input type = "button" name = "back" value = "뒤로가기" onclick="history.back();" >
</form>
</div>


</body>
</html> 