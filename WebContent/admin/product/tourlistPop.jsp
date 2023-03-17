<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="vo.PackageTour"%>
<%@page import="java.util.*" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<PackageTour> tourList = (ArrayList<PackageTour>)request.getAttribute("tourList");
String day = (String)request.getAttribute("day");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.tourlist{ width: 820px; border-radius: 5px; border-radius: 5px;}
th, tr, td { border: 1px solid lightgrey; padding: 10px;}
.on { cursor: pointer;}
</style>

<body>
<script>
var day = <%=day%>;
function insert(val){
	var ptinfo = val;// ptname/ptcode/ptprice
	var frm = opener.document.frm;
	// var frmday = "day"+day;
	// console.log(frmday);
	// 오프너 (팝업을 연 화면)의 폼을 받아옴
	if(day==1)	frm.day1.value = ptinfo;
	else if(day==2)	frm.day2.value = ptinfo;
	else if(day==3)	frm.day3.value = ptinfo;
	else if(day==4)	frm.day4.value = ptinfo;
	else if(day==5)	frm.day5.value = ptinfo;
	else if(day==6)	frm.day6.value = ptinfo;
	else if(day==7)	frm.day7.value = ptinfo;
	self.close();
}

function openPop(ptcode){
	callPop(ptcode);
}

function callPop(val){
	awin = window.open("mypackagetour_pop?ptcode="+val,"tourdesc","left=100,top=50,width=720,height=800","location=no");	
					// 팝업창 객체가 awin 에 들어감 ( 팝업창 주소 / 팝업창 이름 / 팝업창 크기,위치,각종옵션등 )  
}
</script>

<div class="tourlist">
		<form action="#" name="frmtour">
			
			<div class="tourinfo">
				<table width="830" cellpadding="0" cellspacing="0" id="list">
			         <tr>
			            <th width="15%">지역</th>
			            <th width="25%">상품명</th>
			            <th width="30%">상품설명</th>
			            <th width="20%">비용</th>
			            <th width="10%">선택</th>
			            
			         </tr>
			         
			         <%for(int i = 0; i < tourList.size(); i++){
						PackageTour pt = tourList.get(i);
						String ptname = pt.getPt_name();
						
						%>

					   <tr align="center" class ="on">
				
					      <td onclick="openPop('<%=pt.getPt_code()%>');"><%=pt.getCc_id() %></td>
					      <td onclick="openPop('<%=pt.getPt_code()%>');"><%=pt.getPt_name() %></td>
					      <td onclick="openPop('<%=pt.getPt_code()%>');"><%=pt.getPt_summary() %></td>
					      <td align="right" onclick="openPop('<%=pt.getPt_code()%>');"><%=pt.getPt_price() %>원</td>
					      
					      <td>
					      <input type="hidden" id="ptcode<%=i%>" value="<%=pt.getPt_name()+'/'+pt.getPt_code()+'/'+ pt.getPt_price()%>">
					      <input type="radio" name="radiobox" id="chktour<%=i%>" value="" onchange="insert(document.getElementById('ptcode<%=i%>').value)">
					      </td>					
	
					   </tr>
					<% } %>
				</table>

			</div>
			</form>
		</div>





</body>
</html>