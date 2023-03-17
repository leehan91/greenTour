<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
OrderMpInfo om = (OrderMpInfo)request.getAttribute("orderMpInfo");

String omcode = om.getOm_code(), ommiid = om.getMi_id(), omname = om.getOm_name();
String omleave = om.getOm_leave(), omarrive = om.getOm_arrive(), om_spoint = om.getOm_spoint();
String ccid = om.getCc_id(), omcustomer = om.getOm_customer(), omphone = om.getOm_phone();
String omemail = om.getOm_email(), ompayment = om.getOm_payment();
int ompay = om.getOm_pay(), omadult = om.getOm_adult(), omchild = om.getOm_child();
int omumile = om.getOm_umile(), omsmile = om.getOm_smile();
String omstatus = om.getOm_status(), omtime = om.getOm_time(), mmcode = om.getMm_code();
if(ompayment.equals("a"))ompayment = "카드 결제";
else if (ompayment.equals("b"))ompayment = "휴대폰 결제";
else if (ompayment.equals("c"))ompayment = "계좌이체";


if(omstatus.equals("a")) omstatus = "입금대기중";
else if(omstatus.equals("b")) omstatus = "예약 완료";

%>


<style>
th, tr, td { border: 1px solid lightgrey; padding: 10px;}
.btn{margin-top:20px; display: flex; justify-content: flex-end;}
.cancel, .book { border: 1px solid lightgrey; padding: 20px; margin: 20px 0 0 20px; border-radius: 12px; cursor: pointer;}
.book{}
</style>

<div style="margin-top:50px;"></div>
<div class="mypackage_reserve">
<table width="1130" cellpadding="0" cellspacing="0" id="list">
			         <tr>
			            <td>예약코드</td>
			            <td><%=omcode %></td>
			            <td>상품명</td>
			            <td colspan="3"><%=omname %></td>
			            <td>출발일자</td>
			            <td><%=omleave %></td>			            
			         </tr>
			         <tr>
			         	<td>출발지</td>
			         	<td>KORICN</td>
			         	<td>도착지</td>
			         	<td><%=ccid %></td>
			         	<td>인원</td>
			         	<td><%=omadult + omchild %>명</td>
			         	<td>도착일자</td>
			         	<td><%=omarrive %></td>
			         	
			         </tr>
			         <tr>
			         	<td>예약자명</td>
			         	<td><%=omcustomer %></td>
			         	<td>연락처</td>
			         	<td colspan="2"><%=omphone %></td>
			         	<td>이메일</td>
			         	<td colspan="2"><%=omemail %></td>
			         	
			         </tr>	
					 
					  <tr>
					  	<td>결제액</td>
					  	<td><%=ompay %></td>
					 	<td>보유마일리지</td>
					 	<td colspan="2"><%=omumile %></td>
					 	<td>사용마일리지</td>
					 	<td colspan="2">0</td><!-- 마일리지 사용기능 미적용 omsmile -->
					 	
					 </tr>
					 <tr>
					 	<td>결제수단</td>
			         	<td><%=ompayment %></td>
					 	<td>예약상태</td>
					 	<td colspan="3"><%=omstatus %></td>
					 	<td>결제일</td>
					 	<td colspan="3"><%=omtime %></td>
					 </tr>
					 <tr>
					 	<td style="border : 0;"><input type="button" value="메인화면으로" onclick="location.href='index'"></td>
					 	<td style="border : 0;"><input type="button" value="나만의 패키지 상세내역 보기" onclick=""></td>
					 	
					 </tr>			 				 
				</table>
		</div>

</body>
</html>