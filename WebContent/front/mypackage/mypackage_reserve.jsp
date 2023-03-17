<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
MyPackageMy mm = (MyPackageMy)request.getAttribute("mypackagemy");

String ccid = mm.getCc_id();
String city = mm.getMm_destination();
String ficode = mm.getFi_code();
int fridx = mm.getFr_idx();
int adult = mm.getMm_adult();
int child = mm.getMm_child();
int atotal = mm.getMm_atotal();	// atotal = 항공가격
String hicode = mm.getHi_code();
int htotal = mm.getMm_htotal();	// htotal = 호텔가격
String mmcode = mm.getMm_code();
String mmname = mm.getMm_name();

String hgrade = mm.getMm_hgrade();
String agrade = mm.getMm_agrade();
String tour = mm.getMm_tour();	//ptcode 들 
int ttotal = mm.getMm_ttotal();	// ttotal = 투어가격 

String tours = (String)request.getAttribute("tours"); // 투어 이름들 ", " <-구분자
String hotel = (String)request.getAttribute("hotel");
String sdate = (String)request.getAttribute("sdate");
String edate = (String)request.getAttribute("edate");
int total = Integer.parseInt((String)request.getAttribute("total"));
String air = (String)request.getAttribute("air");



%>

<style>
th, tr, td { border: 1px solid lightgrey; padding: 10px;}
.btn{margin-top:20px; display: flex; justify-content: flex-end;}
.cancel, .book { border: 1px solid lightgrey; padding: 20px; margin: 20px 0 0 20px; border-radius: 12px; cursor: pointer;}
.book{}
</style>
<script>
function goBook(){
	if ( ! $('input[name=payment]:checked').val()) {
		alert('결제수단을 선택해주세요.');
		return false;
	}else{
		document.frm.submit();
	}
	

}
</script>

<div style="margin:50px;"></div>

<h2><마이 패키지> 선택 내역 확인 & 결제</h2>

<div class="mypackage_reserve">
				<form name="frm" action="mypackage_main_result" method="post">
				<table width="1130" cellpadding="0" cellspacing="0" id="list">
			         <tr>
			            <td width="10%">패키지코드</td>
			            <td><%=mmcode %></td>
			            <td>상품명</td>
			            <td colspan="3"><%=mmname %></td>
			            <td>출발일자</td>
			            <td><%=sdate %></td>			            
			         </tr>
			         <tr>
			         	<td>출발지</td>
			         	<td>인천</td>
			         	<td>도착지</td>
			         	<td><%=city %>
			         	<td>인원</td>
			         	<td><%=adult+child%>인 (성인 : <%=adult %>명 / 아동 : <%=child %>명)</td>
			         	<td>도착일자</td>
			         	<td><%=edate %></td>
			         	
			         </tr>
			         <tr>
			         	<td>호텔</td>
			         	<td><%=hotel %></td>
			         	<td>호텔등급</td>
			         	<td><%=hgrade %></td>
			         	<td>항공</td>
			         	<td><%=air %></td>
			         	<td>좌석등급</td>
			         	<td><%=agrade %></td>
			         </tr>	
					 <tr>
					 	<td>예약자</td>
					 	<td><%=miname %></td>
					 	<td>연락처</td>
					 	<td colspan="2"><%=miphone %></td>
					 	<td>이메일</td>
					 	<td colspan="2"><%=miemail %></td>
					 </tr>
					  <tr>
					 	<td>보유마일리지</td>
					 	<td colspan="3"><%=mileage %></td>
					 	<td>사용마일리지</td>
					 	<td colspan="3">0</td><!-- 마일리지 사용기능 미적용 -->
					 	
					 </tr>
					 <tr>
					 	<td>선택한 관광상품</td>
					 	<td colspan="7"><%if(tours.equals(""))tours = "자유여행 - 관광상품 미선택"; %> <%=tours %></td>
					 
					 </tr>
					 <tr>
					 	<td>항공가격</td>
					 	<td><%=atotal %>원</td>
					 	<td>호텔가격</td>
					 	<td colspan="2"><%=htotal %>원</td>
					 	<td>관광상품 가격</td>
					 	<td colspan="2"><%=ttotal %>원</td>
					 </tr>
					 <tr>
					 	<td>결제수단</td>
					 	<td colspan="3">카드 <input type="radio" name="payment" value="a"></td>
					 	<td colspan="2">휴대폰 <input type="radio" name="payment" value="b"></td>
					 	<td colspan="3">무통장 <input type="radio" name="payment" value="c"></td>
			
					 </tr>
					
					 
					 
				</table>
				 <div style="margin:10px;"></div>
					 
					 <h3 align="right">총 금액 : <%=total %> 원 </h3>
				<div class="btn">
					<div class="cancel" onclick="history.back();">취소</div>
					<div class="book" onclick="goBook();" >결제</div>
				</div>
								
					<input type="hidden" name="mmcode" value="<%=mmcode %>">
					<input type="hidden" name="mmname" value="<%=mmname %>">
					<input type="hidden" name="cityname" value="<%=city %>">
					<input type="hidden" name="ccid" value="<%=ccid %>">
					<input type="hidden" name="sdate" value="<%=sdate %>">
					<input type="hidden" name="edate" value="<%=edate %>">
					<input type="hidden" name="adult" value="<%=adult %>">
					<input type="hidden" name="child" value="<%=child %>">
					<input type="hidden" name="hicode" value="<%=hicode %>">
					<input type="hidden" name="hotel" value="<%=hotel %>">
					<input type="hidden" name="hgrade" value="<%=hgrade %>">
					<input type="hidden" name="air" value="<%=air %>">
					<input type="hidden" name="agrade" value="<%=agrade %>">
					<input type="hidden" name="ficode" value="<%=ficode %>">
					<input type="hidden" name="fridx" value="<%=fridx %>">
					<input type="hidden" name="miname" value="<%=miname %>">
					<input type="hidden" name="miphone" value="<%=miphone %>">
					<input type="hidden" name="mileage" value="<%=mileage %>">
					<input type="hidden" name="tours" value="<%=tours %>">
					<input type="hidden" name="atotal" value="<%=atotal %>">
					<input type="hidden" name="htotal" value="<%=htotal %>">
					<input type="hidden" name="ttotal" value="<%=ttotal%>">
					<input type="hidden" name="total" value="<%=total %>">
				</form>
				</div>
				
					 
</body>
</html>