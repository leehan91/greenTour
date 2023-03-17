<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String keyword = request.getParameter("keyword");
String date = request.getParameter("date");

ArrayList<PackageInfo> piList = (ArrayList<PackageInfo>)request.getAttribute("piList");
ArrayList<HotelInfo> hiList = (ArrayList<HotelInfo>)request.getAttribute("hiList");
ArrayList<CsPareview> cpList = (ArrayList<CsPareview>)request.getAttribute("cpList");


%>
<style>
#package {display:flex; justify-content: space-between; border:1px solid lightgrey; padding: 20px;flex-wrap: wrap;margin-bottom:20px;}
#package > div {display:flex; width:33%; height:250px; flex-wrap: wrap; margin-bottom:20px;}
#package > div a{width:100%; display: flex; flex-wrap: wrap; justify-content: space-around;}
#package > div img {width:300px; height: 192px; border-radius: 20px;}
#package > div span {margin:0 * 0 0; size: 0.8rem; display:block;}

#hotel {display:flex; justify-content: space-between; border:1px solid lightgrey; padding: 20px;flex-wrap: wrap;margin-bottom:20px;}
#hotel > div {display:flex; width:33%; height:250px; flex-wrap: wrap; margin-bottom:20px;}
#hotel > div a{width:100%; display: flex; flex-wrap: wrap; justify-content: space-around;}
#hotel > div  img {width:300px; height: 192px; border-radius: 20px;}
#hotel > div  span {margin:0 auto; size: 0.8rem; display:block;}

#list {margin-bottom : 50px;}
#list th, #list td {padding:8px 3px;}
#list th { border-bottom: double black 3px;}
#list td { border-bottom: dotted black 1px;}
</style>
<p style="background-color:rgb(112,173,71); color:white; font-weight:bolder; 
width: 200px; height: 33px; padding: 20px; text-align:center; border: 1px solid lightgrey; 
border-radius: 10px; font-size: 20px;">패키지</p>
<div name="package" id="package">
<%
for (int i = 0; i < piList.size(); i++){
	PackageInfo pi = piList.get(i);
%>
	<div>
		<a href="package_list?picode=<%=pi.getPi_code()%>&fiDeparture=<%=date %>">
		<img src="front/img/<%=pi.getPi_img1() %>" alt="패키지 <%=i+1 %>"/>
		<span>
		<b>[<%=pi.getPi_country() %>]<br/>
		<%=pi.getPi_name() %> <%=pi.getPi_period() %></b>
		<strong><%=pi.getPi_price() %>원</strong>
		</span>
		</a>
	</div>
<%} %>
</div>
<%	
// 호텔 
if (hiList != null){%>
<p style="background-color:rgb(112,173,71); color:white; font-weight:bolder; width: 200px; height: 33px; padding: 20px; text-align:center; border: 1px solid lightgrey; border-radius: 10px; font-size: 20px;">호텔</p>
<div name="hotel" id="hotel">
<%
for (int i = 0; i < hiList.size(); i++){
	HotelInfo hi = hiList.get(i);
%>
	<div>
		<a href="package_list?hicode=<%=hi.getHi_code()%>">
		<img src="front/img/<%=hi.getHi_img1() %>" alt="패키지 <%=i+1 %>"/>
		<span>
		<b>[<%=hi.getHi_grade() + "성급" %>]<br/>
		<%=hi.getHi_name() %></b>
		<strong><%=hi.getHi_price() %>원</strong>
		</span>
		</a>
	</div>
<%}
} 
	// 패키지 리뷰 
if(cpList != null){
%>
</div>
<p style="background-color:rgb(112,173,71); color:white; font-weight:bolder; width: 200px; height: 33px; padding: 20px; text-align:center; border: 1px solid lightgrey; border-radius: 10px; font-size: 20px;">패키지 리뷰</p>

<table width="1130" cellpadding="0" cellspacing="0" id="list">
<tr>
<th width="5%">도시</th><th width="15%">패키지명</th><th width="*">제목</th>
<th width="20%">별점</th><th width="10%">작성자</th><th width="10%">작성일</th>
</tr>
<%

	if(cpList.size() > 0){ // 게시글 목록이 있으면
		for (int i = 0 ; i < cpList.size() ; i++){
			CsPareview cp = cpList.get(i);
			String title = cp.getCp_title();
			if (title.length() > 30)
				title = title.substring(0,27) + "...";
			title = "<a href='pareview_list?cpidx=" + cp.getCp_idx() + "'>" + title +"</a>";
	%>
	<tr align="center">
		
		<td><%=cp.getCc_name() %></td>
		<td><%=cp.getOp_name() %></td>
		<td align="left">&nbsp;&nbsp;<%=title %></td>
		<td>(<%=cp.getCp_score() %>)</td>
		<td><%=cp.getMi_id() %></td>
		<td><%=cp.getCp_date() %></td>
	</tr>
	<%
		}
	} else {// 게시글 목록이 없으면
		out.print("<tr><td colspan='6' align='center'>");
		out.println("작성된 리뷰가 없습니다.</td></tr>");
	}
}
%>
</table>
</body>
</html>