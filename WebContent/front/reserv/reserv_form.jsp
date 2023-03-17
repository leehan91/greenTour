<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
// 예약코드, 상품명, 출발일자, 출발지, 도착지, 인원, 여행기간, 예약자, 연락처, 이메일, 보유마일리지, 사용마일리지, 금액  

String korName = request.getParameter("korName");
String engLast = request.getParameter("engLast");
String engFirst = request.getParameter("engFirst");
String birth = request.getParameter("birth");
String phone = request.getParameter("phone");
String email = request.getParameter("email");
String korean = request.getParameter("korean");
String foreigner = request.getParameter("foreigner");
String male = request.getParameter("male");
String female = request.getParameter("female");
int total = Integer.parseInt(request.getParameter("total"));
%>
<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-c3ow{border-color:inherit;text-align:center;vertical-align:top}
.tg .tg-7btt{border-color:inherit;font-weight:bold;text-align:center;vertical-align:top}
</style>

<h2>패키지 예약 확인</h2>
<form name = "checkInfo">
<table class="tg">
<thead>
  <tr>
    <th class="tg-7btt">예약코드</th>
    <th class="tg-c3ow">oi202020</th>
    <th class="tg-7btt">상품명</th>
    <th class="tg-c3ow" colspan="2">상품명</th>
    <th class="tg-7btt">출발일자</th>
    <th class="tg-c3ow">23.23.23</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-7btt">출발지</td>
    <td class="tg-c3ow">인천</td>
    <td class="tg-7btt">도착지</td>
    <td class="tg-c3ow">홍콩</td>
    <td class="tg-7btt">인원 (성인 : 0명 / 아동 : 0명)</td>
    <td class="tg-7btt">여행기간</td>
    <td class="tg-c3ow">3박 4일</td>
  </tr>
  <tr>
    <td class="tg-7btt">예약자</td>
    <td class="tg-c3ow"><%=korName %></td>
    <td class="tg-7btt">연락처</td>
    <td class="tg-c3ow"><%=phone %></td>
    <td class="tg-7btt">이메일</td>
    <td class="tg-c3ow" colspan="2"><%=email %></td>
  </tr>
  <tr>
    <td class="tg-7btt">보유마일리지</td>
    <td class="tg-c3ow" colspan="2">10000</td>
    <td class="tg-7btt">마일리지 사용</td>
    <td class="tg-c3ow" colspan="3">5000</td>
  </tr>
  <tr>
    <td class="tg-7btt">결제 수단</td>
    <td class="tg-c3ow" >카드</td>
    <td class="tg-c3ow">휴대폰</td>
    <td class="tg-c3ow">무통장</td>
    <td class="tg-7btt">금액</td>
    <td class="tg-c3ow" colspan="2"><%=total %></td>
  </tr>
</tbody>
</table>
</form>

</body>
</html> 