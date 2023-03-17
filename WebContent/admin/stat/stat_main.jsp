<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head_admin.jsp" %>
<%
request.setCharacterEncoding("utf-8");

CalendarInfo ci = (CalendarInfo)request.getAttribute("ci");
// 달력 출력을 위한 정보(현재 연월일, 검색 연월) 들을 저장하고 있는 인스턴스
StatInfo stat = (StatInfo)request.getAttribute("stat");
StatInfo rq = (StatInfo)request.getAttribute("rq");
StatInfo rqYes = (StatInfo)request.getAttribute("rqYes");
StatInfo rqNo = (StatInfo)request.getAttribute("rqNo");
StatInfo member = (StatInfo)request.getAttribute("member");
StatInfo memberA = (StatInfo)request.getAttribute("memberA");
StatInfo memberB = (StatInfo)request.getAttribute("memberB");
StatInfo memberD = (StatInfo)request.getAttribute("memberD");

ArrayList<StatInfo> paList = (ArrayList<StatInfo>)request.getAttribute("paList");
ArrayList<StatInfo> mpList = (ArrayList<StatInfo>)request.getAttribute("mpList");
ArrayList<StatInfo> plan = new ArrayList<StatInfo>();
plan.addAll(paList);
plan.addAll(mpList);

int sy = ci.getsYear(), sm = ci.getsMonth();
LocalDate sdate = LocalDate.of(sy, sm, 1);			// 달력 시작일
LocalDate edate = sdate.plusMonths(1);				// 시작일의 다음달 1일
edate = edate.minusDays(1);							// 달력 종료일

int sWeek = sdate.getDayOfWeek().getValue();		// 시작일의 요일 번호
int endDay = edate.getDayOfMonth();					// 검색 연월의 말일(루프의 조건)

int minYear = ci.getcYear() - 1, maxYear = ci.getcYear() + 2;
// 연도 선택의 최소값과 최대값

int nextMonth = sm + 1, nextYear = sy + 1;		// 내년과 다음달 값
int prevMonth = sm - 1, prevYear = sy - 1;		// 작년과 이전달 값

String nextYearLink = "location.href='admin_stat?schYear=" + nextYear + "&schMonth=" + sm + "';";
if (nextYear > maxYear)		nextYearLink = "alert('다음 연도가 없습니다.');";

String nextMonthLink = "location.href='admin_stat?schYear=" + sy + "&schMonth=" + nextMonth + "';";
if (nextMonth > 12) {
	nextMonth = 1;	nextYear = sy + 1;
	if (nextYear > maxYear) {
		nextMonthLink = "alert('다음 연도가 없습니다.');";
	} else {
		nextMonthLink = "location.href='admin_stat?schYear=" + nextYear + "&schMonth=" + nextMonth + "';";
	}
}

String prevYearLink = "location.href='admin_stat?schYear=" + prevYear + "&schMonth=" + sm + "';";
if (prevYear < minYear)		prevYearLink = "alert('이전 연도가 없습니다.');";

String prevMonthLink = "location.href='admin_stat?schYear=" + sy + "&schMonth=" + prevMonth + "';";
if (prevMonth < 1) {
	prevMonth = 12;		prevYear = sy - 1;
	if (prevYear < minYear) {
		prevMonthLink = "alert('이전 연도가 없습니다.');";
	} else {
		prevMonthLink = "location.href='admin_stat?schYear=" + prevYear + "&schMonth=" + prevMonth + "';";
	}
}
%>
<style>
.side_menu {
	position : fixed;
	left : 10%; top : 20%;
	border: 1px solid black;
	text-align : center;
	display : inline;
}
.side_menu ul, li {list-style : none; margin: 0; padding: 0;}

.ctg {border : 1px solid black; margin: 5px; background-color : greenyellow;}
.ctg a{width: 100%; cursor:pointer; text-decoration: none; }
.ctg ul {background-color : white;}
.ctg .hide{display:none;}

canvas {
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
}

#stat_container {width: 1130px; margin: 70px auto; text-align: center;}
#searchBox { text-align: center; margin: 0 0 20px 0; }
#cal_controller{display: flex; justify-content: space-around; align-items: center;}
.yearBtn{display: flex; justify-content: space-around;  background-color: white;}
.yearBtn input{border : none; background-color : white;}
.monBtn{height:30px; display: flex; justify-content: space-around;  background-color: white;}
#calendar { border-collapse: collapse; }
#calendar th, #calendar td { border: 1px solid #000; }
#calendar td { height: 100px; font-size: 1.1em; padding: 5px 0 0 5px; }
.txtRed { color: red; font-weight: bold; }
.txtBlue { color: blue; font-weight: bold; }
#txtToday { background: pink; }

.statBox {display : flex; justify-content: space-around; text-align: left; margin : 10px auto; border : 1px solid black; width:980px; }
.statBox div {padding : 10px 20px;}
.statBox ul {padding : 0;}
.statBox li {list-style: none; padding : 0 5px;}

</style>
<script>
$(document).ready(function(){
    $(".side_menu> .ctg > a").click(function(){
        var submenu = $(this).next("ul");
        if( submenu.is(":visible") ){
            submenu.slideUp();
	  }else{
            submenu.slideDown();
        }
    });
});
</script>
<div class="side_menu">
  <div class="ctg">
      <a href="/greenTourSite/member_list" class="menulink">회원 관리</a>
      <ul class ="hide">
  		<li><a href="">회원 목록</a></li>
		<li><a href="">예약 관리</a></li>
      </ul>
  </div>
  <div class="ctg">
      <a href="/greenTourSite/admin_package_list" class="menulink">상품 관리</a>
      <ul class ="hide">
		<li><a href="/greenTourSite/admin_package_list">패키지 관리</a></li>
		<li><a href="/greenTourSite/hotel_list">호텔 관리</a></li>
		<li><a href="/greenTourSite/tour_list">관광 상품 관리</a></li>
      </ul>
  </div>
  <div class="ctg">
      <a href="#" class="menulink">고객 센터</a>
      <ul class ="hide">
		<li><a href="">공지사항</a></li>
		<li><a href="">자주 찾는 질문</a></li>
		<li><a href="">전체 문의</a></li>
		<li><a href="">칭찬의 소리</a></li>
      </ul>
  </div>
    <div class="ctg">
      <a href="/greenTourSite/admin_stat" class="menulink">통계</a>
      <ul class ="hide">
		<li><a href="/greenTourSite/admin_stat">통계 홈</a></li>
		<li><a href="/greenTourSite/admin_amount">월간 매출액</a></li>
		<li><a href="#">도시별 판매액</a></li>
      </ul>
  </div>
</div>

<div id = "stat_container">
	<h2>그린 투어 통계</h2>
<div id="searchBox">
	<form id = "cal_Controller" name="frmCalendar">
	<div class= "yearBtn">
		<input type="button" value="<<" onclick="<%=prevYearLink %> " style="cursor:pointer"/>
		&nbsp;&nbsp;<h2 style = "font-size : 1.8em"><%=sy %>년</h2> &nbsp;&nbsp;
		<input type="button" value=">>" onclick="<%=nextYearLink %> " style="cursor:pointer"/>
	</div>
	<div class = "monBtn">
		<input type="button" value="이전 달" onclick="<%=prevMonthLink %>" />&nbsp;&nbsp;&nbsp;
		<select name="schMonth" onchange="this.form.submit()">
<% for (int i = 1; i <= 12; i++) { %>
			<option value="<%=i %>" <% if (i == sm) { %>selected="selected" <% } %>><%=i %></option>
<% } %>
		</select>월&nbsp;&nbsp;&nbsp;	
		<input type="button" value="오늘" onclick="location.href='admin_stat'"/>&nbsp;
		<input type="button" value="다음 달" onclick="<%=nextMonthLink  %>" />&nbsp;
	</div>
	</form>
</div>
<br />
<table width="980" align="center" id="calendar">
	<tr height="40">	
		<th width="140" >월</th>
		<th width="140" >화</th>
		<th width="140" >수</th>
		<th width="140" >목</th>
		<th width="140" >금</th>
		<th width="140" class="txtBlue">토</th>
		<th width="140" class="txtRed">일</th>
	</tr>
<%
	if (sWeek != 1) {	// 1일이 월요일이 아닐 경우 ()
		out.println("<tr>");
		for (int i = 1; i < sWeek; i++)	out.println("<td></td>");
	}
	String txtClass= "", txtID = "";
	for (int i = 1, n = sWeek; i <= endDay; i++, n++) {
	// i : 날짜의 일(day)을 출력하기 위한 변수 / n : 일주일이 지날 때 마다 다음 줄로 내리기 위한 변수
		
		txtClass = "";		// 요일별 색상 스타일을 적용하기 위한 html 클래스용 변수
		txtID = "";			// 오늘 날짜인 경우 배경색 스타일을 적용하기 위한 html 아이디용 변수
		
		if (n % 7 == 1)		out.println("<tr>");	// 요일번호가 1(월요일)이면 <tr>을 열어줌
		
		if (n % 7 == 6)		txtClass = " style=\"color: blue; font-weight: bold;\"";	// 요일 번호가 6(토)이면 글자색을 파란색으로 변경하는 html 클래스를 적용
		if (n % 7 == 0)		txtClass = " style=\"color: red; font-weight: bold;\"";	// 요일 번호가 7(일)이면 글자색을 빨간색으로 변경하는 html 클래스를 적용
		
		if (sy == ci.getcYear() && sm == ci.getcMonth() && i == ci.getcDay())	txtID = " id=\"txtToday\"";
		// 현재 출력할 날짜가 오늘일 경우 배경색을 변경하는 html 아이디를 적용
		
		if(plan.size() > 0){	//	 일정이 있다면
			String schDate = sy + "-" + (sm < 10 ? "0" + sm : sm) + "-" + (i < 10 ? "0" + i : i);
			// 일정 일자와 비교할 날짜데이터
			if(paList.size() > 0){	//	 패키지만 있을 경우
				out.println("<td" + txtID + " valign=\"top\">" + "<p "+ txtClass + " >"	+ i + "</p>");
				out.println("<p>PA : "+ stat.getSi_paRate()  + "</p></td>");
			} else if (mpList.size() > 0){
				out.println("<td" + txtID + " valign=\"top\">" + "<p "+ txtClass + " >"	+ i + "</p>");
				out.println("<p>MP : "+ stat.getSi_mpRate()  + "</p></td>");
			}
//			else if (mpList.size() > 0 && paList.size() > 0){
//				out.println("<td" + txtID + " valign=\"top\">" + "<p "+ txtClass + " >"	+ i + "</p>");
//				out.println("<p>PA : "+ stat.getSi_paRate()  + "</p>");
//				out.println("<p>MP : "+ stat.getSi_mpRate()  + "</p></td>");
//			}
			
		if (n % 7 == 0) {
			out.println("</tr>");
		} else if (i == endDay) {
		// 말일까지 출력했으나 요일번호가 7의 배수가 아니어서 종료가 되지 않았을 겨우
		// 빈 칸으로 나머지를 채운 후 종료</tr>
			for (int j = n % 7; j < 7; j++)		out.println("<td></td>");
			out.println("</tr>");
		}
	}else{

		out.println("<td" + txtID + " valign=\"top\">" + "<p "+ txtClass + " >"	+ i + "</td>");	
		if (n % 7 == 0) {
			out.println("</tr>");
		} else if (i == endDay) {
		// 말일까지 출력했으나 요일번호가 7의 배수가 아니어서 종료가 되지 않았을 겨우
		// 빈 칸으로 나머지를 채운 후 종료</tr>
			for (int j = n % 7; j < 7; j++)		out.println("<td></td>");
			out.println("</tr>");
		}
	}
	}
	%>
</table>
<div class = "statBox">
	<div name = "rateStat" style = "width :30%" >
		<h3>판매량 통계</h3>
		<ul>
			<li>패키지 판매량 :<%=stat.getSi_paRate() %> </li>
			<li>나만의 패키지 판매량 :<%=stat.getSi_mpRate() %> </li>
			<li>총 판매량 : <%=stat.getSi_paRate() +  stat.getSi_mpRate()%></li>
		</ul>
	</div>
	<div name = "amountStat" style = "width :35%">
		<h3>판매액 통계</h3>
		<ul>
			<li>패키지 판매액 :<%=stat.getSi_paAmount() %> 원</li>
			<li>나만의 패키지 판매액 :<%=stat.getSi_mpAmount() %> 원</li>
			<li>총 판매액 :<%=stat.getSi_totalAmount() %> 원</li>
		</ul>
	</div>	
	<div name = "memberStat" style = "width :15%">
		<h3>회원 수</h3>
		<ul>
			<li>전체 : <%=member.getSi_member() %></li>
			<li>정상 회원:<%=memberA.getSi_memberA() %> </li>
			<li>휴면 회원:<%=memberB.getSi_memberB() %> </li>
			<li>탈퇴 회원:<%=memberD.getSi_memberD() %> </li>
		</ul>
	</div>	
	<div name = "rqStat" style = "width :20%">
		<h3>문의 글</h3>
		<ul>
			<li>전체 :<%=rq.getSi_TotalReq() %> </li>
			<li><a href="">답변 미완료:<%=rqNo.getSi_NoReq() %> </a></li>
			<li>답변 완료:<%=rqYes.getSi_YesReq() %> </li>
		</ul>
	</div>		
	
</div>
</div>
</body>
</html>