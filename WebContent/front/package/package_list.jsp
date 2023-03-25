<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head.jsp"%>
<%
request.setCharacterEncoding("utf-8");
ArrayList<PackageDate> pdList = (ArrayList<PackageDate>)request.getAttribute("pdList");

String fiDeparture="";
if (request.getParameter("fiDeparture") != null){
	fiDeparture = request.getParameter("fiDeparture");
}
	
String piImg = pdList.get(0).getPi_img1();
String piName = pdList.get(0).getPi_name();
String piCode = pdList.get(0).getPi_code();
%>

<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<%-- <script>
var tmp = "<%=fiDeparture%>";
<%if(fiDeparture != ""){%>
$( document ).ready( function() {
	test(tmp);
})
	
<%} %>
var fiDeparture = "";
var piCode = "";
var piAdult = "";

$( document ).ready( function() {
	$('.tab-link').click(function () {
	    var tab_id = $(this).attr('data-tab');

	    $('.tab-link').removeClass('current');
	    $('.tab-content').removeClass('current');

	    $(this).addClass('current');
	    $("#" + tab_id).addClass('current');
	});
	
	<%
	for(int i=0; i<pdList.size(); i++) {
		PackageDate pd = pdList.get(i);
		fiDeparture = pd.getFi_departure();
		String piAdult = pd.getPi_adult();
	%>
	
	fiDeparture = "<%=fiDeparture%>";
	piAdult = "<%=piAdult%>";
	
	$("#"+fiDeparture).append("<a href='#;' onclick='test(\""+fiDeparture+"\")'><span style='color: #555;'><br/>&nbsp;&nbsp;"+piAdult+"원~</span></a>");
	$("#"+fiDeparture).children().css("background", "white");
	$("#"+fiDeparture).children().css("color", "black");
	<%
	}
	%>
});

function test(fiDeparture) {
	var piCode = "<%=piCode%>";
	var data = new Object();
	data.picode = piCode;
	data.fiDeparture = fiDeparture;
	
	$.ajax({
		type : "POST",
		url : "/greenTourSite/package_list", 
		data : data,
		success : function(packageList) {
			$("#pkgTbody").children().remove();
			
			for (var i = 0; i < packageList.length; i++) {
				var fi_cityleave = packageList[i].fi_cityleave;
				var fi_departure = packageList[i].fi_departure;
				var fr_name = packageList[i].fr_name;
				var pi_code = packageList[i].pi_code;
				var pi_name = packageList[i].pi_name;
				var pi_period = packageList[i].pi_period;
				var pi_price = packageList[i].pi_price;
				var pi_sale = packageList[i].pi_sale;
				var pi_stock = packageList[i].pi_stock;
				var fi_entry = packageList[i].fi_entry;
				
				$("#pkgTbody").append("<tr>"
					+"	<td>"
					+"		<span class='start'>"+fi_departure+"</span><br>"+fi_cityleave
					+"	</td>"
					+"	<td>"
					+"		<span class='ico_air'>"+fr_name+"</span>"
					+"	</td>"
					+"	<td>"+pi_period+"</td>"
					+"	<td class='name'>"
					+"		<a href='package_detail?pi_code="+pi_code+"&fr_name="+fr_name+"&fi_departure="+fi_departure+"&fi_entry="+fi_entry+"'>"+pi_name+"</a>"
					+"	</td>"
					+"	<td>"
					+"		<span class='state_start'>"+pi_price+"원</span>"
					+"	</td>"
					+"	<td>"
					+"		<span class='state_start'>"+(pi_stock-pi_sale)+"/"+pi_stock+"</span>"
					+"	</td>"
					+"</tr>"
				)
			}
			$("#pkgTbody").show();
		}
	});
}
</script>
 --%>
 <style>
span, object, h1, h2, h3, h4, h5, h6, p, pre, a, address, big, code, del, em, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, embed, figure, figcaption, footer, header, hgroup, menu, nav, output, ruby, section, summary, time, mark, audio, video {
    margin: 0;
    padding: 0;
}
a {text-decoration: none;}
ul {list-style: none; padding: 0;}
img{width:100%}
.content_section {margin: 0 auto; width: 1130px}

.calendar {position: relative; table-layout: fixed; width: 738px; border-top: 1px solid #ccc;
border-bottom: 1px solid #ccc; z-index: 1;}

.calendar th:first-child {color: #ed4949; border-left: 1px solid #ccc;}
.calendar th.sat {color: #297fb8; border-right: 1px solid #ccc;}
.calendar th {height: 44px; font-size: 14px;}
.calendar tbody tr td:first-child {color: #ed4949;}

.calendar td {width: 101px; height: 70px; font-size: 13px; color: #aaa; font-weight: bold;
border: 1px solid #ccc; background: #f5f5f5;vertical-align: top;}
.calendar td a {position: relative; display: block; height: 47px; background: #fff;}
.calendar td .price {padding: 20px 0 10px 10px;}
.calendar td .day {display: block; padding: 6px 0 0 10px;}
.calendar td a .day {color: #111;}
.calendar td.sat a .day {color: #297fb8;}
.calendar td.sun a .day {color: #ed4949;}

table {border-collapse: collapse; border-spacing: 0;}

.tab-link.current{position: relative; z-index: 1; background: #3f4b5b; border-color: #3f4b5b;
font-weight: bold;}

.tab-content{display: none;}
.tab-content.current{display: block; border-bottom: 1px solid #e2e2e2;}

.tabs_menu li {background: #f5f5f5;}

.tabs_menu li a.current {position: relative; z-index: 1;background: white; border-color: #bbb;
color: black; font-weight: bold; border-bottom: none; font-size: 18px;}
.tabs_menu > li > a {display: block; margin-left: -1px; padding: 12px 0; box-sizing: border-box;
text-align: center; font-size: 18px; border: 1px solid #bbb; color: #888;}
.desc {margin: 18px 0;}
.day_select {height: 586px; margin-bottom: 30px; overflow: hidden;}
.product {padding: 0 0 80px;}
.title {height: 29px; padding: 33px 0 0; margin: 0 0 23px; font-size: 22px; color: #111;
letter-spacing: -0.05em; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;}
.day_select {height: 587px; margin-bottom: 30px; overflow: hidden;}
.desc p {display: inline-block; padding-left: 34px;}
.desc p span{padding-top: 4px; padding-left: 73px; font-size: 12px; color: #555; vertical-align: bottom;}
.info_product {float: left; width: 331px; height: 523px; padding: 30px 29px 30px 30px;
border-top: 2px solid #111; border-bottom: 1px solid #ccc; border-left: 1px solid #ccc;}
.data {position: relative; float: right; height: 589px; border-top: 2px solid #111;}
.data_tab {height: 55px; margin: 0 0 10px;}
.tabs_menu > li {float: left; width: 25%;}
.table {position: relative;	padding-top: 53px; margin: 0 0 20px; overflow: hidden;}
.table_inner {width: 100%; 	height: 600px; 	overflow: hidden; overflow-y: scroll;}
.goods {table-layout: fixed;}
.goods thead tr {position: absolute; top: 0; right: 0; left: 0; z-index: 1;}
.goods thead th {height: 53px; font-size: 14px; background: #3f4b5b; color: #fff;
border-right: 1px solid black;}
.ico_align{color: white;}
.col1 {width: 152px;}
.col2 {width: 125px;}
.col3 {width: 112px;}
.col4 {width: 496px;}
.col5 {width: 131px;}
.col6 {width: 115px;}
.goods td {position: relative; padding: 10px 10px 12px 10px; font-size: 13px; border-left: 1px solid #ccc;
border-bottom: 1px solid #ccc; word-wrap: break-word; word-break: break-all; letter-spacing: -0.04em; text-align: center;}
.goods tbody tr td:nth-child(1) { 	width: 159px;	border-left: none;}
.goods tbody tr td:nth-child(2) {	width: 111px;}
.goods tbody tr td:nth-child(3) {	width: 110px;}
.goods tbody tr td:nth-child(4) {	width: 581px;}
.goods tbody tr td:nth-child(5) {	width: 134px;}

</style>
<div class="product">
	<div class="content_section">
		<h2 class="title"><%=piName%></h2>
		<div class="day_select">
			<div class="info_product">
				<p>
					<img src="/greenTour/front/img/<%=piImg%>">
				</p>
				<ul>
					<li><span>MD Pick</span> <span><%=piName%></span></li>
				</ul>
			</div>
			<div class="data">
				<div class="data_tab">
					<ul class="tabs_menu">
						<li><a class="tab-link current" data-tab="tab-1">2월</a></li>
						<li><a class="tab-link" data-tab="tab-2">3월</a></li>
						<li><a class="tab-link" data-tab="tab-3">4월</a></li>
						<li><a class="tab-link" data-tab="tab-4">5월</a></li>
					</ul>
				</div>
				<div class="desc"><p>출발일자를 선택하여 원하시는 여행상품을 확인하세요.<span>※ 유류할증료가 포함된 상품가 입니다.</span></p></div>
				<div class="month">
				
				
				
				
				
				
				<!-- 달력 선택 영역 -->
					<div id="tab-1" class="tab-content current">
						<div class="tab_con" id="cal_2023_2">
							<table summary="2023.02" data-month="2023.02" class="calendar"
								style="display: table;">
								<thead>
									<tr>
										<th scope="col" class="sun">일</th>
										<th scope="col" class="mon">월</th>
										<th scope="col" class="tue">화</th>
										<th scope="col" class="wen">수</th>
										<th scope="col" class="thu">목</th>
										<th scope="col" class="fri">금</th>
										<th scope="col" class="sat">토</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td id="2023-01-29"
											class="sun other_month disabled unavailable"><span>&nbsp;</span><span
											class="day"></span></td>
										<td id="2023-01-30"
											class="mon other_month disabled unavailable"><span>&nbsp;</span><span
											class="day"></span></td>
										<td id="2023-01-31"
											class="tue other_month disabled unavailable"><span>&nbsp;</span><span
											class="day"></span></td>
										<td id="2023-02-01"
											class="wen selected disabled unavailable"><span
											class="day">1</span></td>
										<td id="2023-02-02" class="thu disabled unavailable"><span
											class="day">2</span></td>
										<td id="2023-02-03" class="fri disabled unavailable"><span
											class="day">3</span></td>
										<td id="2023-02-04" class="sat disabled unavailable"><span
											class="day">4</span></td>
									</tr>
									<tr>
										<td id="2023-02-05" class="sun disabled unavailable"><span
											class="day">5</span></td>
										<td id="2023-02-06" class="mon disabled unavailable"><span
											class="day">6</span></td>
										<td id="2023-02-07" class="tue disabled unavailable"><span
											class="day">7</span></td>
										<td id="2023-02-08" class="wen disabled unavailable"><span
											class="day">8</span></td>
										<td id="2023-02-09" class="thu disabled unavailable"><span
											class="day">9</span></td>
										<td id="2023-02-10" class="fri disabled unavailable"><span
											class="day">10</span></td>
										<td id="2023-02-11" class="sat disabled unavailable"><span
											class="day">11</span></td>
									</tr>
									<tr>
										<td id="2023-02-12" class="sun disabled unavailable"><span
											class="day">12</span></td>
										<td id="2023-02-13" class="mon disabled unavailable"><span
											class="day">13</span></td>
										<td id="2023-02-14" class="tue disabled unavailable"><span
											class="day">14</span></td>
										<td id="2023-02-15" class="wen disabled unavailable"><span
											class="day">15</span></td>
										<td id="2023-02-16" class="thu disabled unavailable"><span
											class="day">16</span></td>
										<td id="2023-02-17" class="fri disabled unavailable"><span
											class="day">17</span></td>
										<td id="2023-02-18" class="fri disabled unavailable"><span
											class="day">18</span></td>
									</tr>
									<tr>
										<td id="2023-02-19" class="sun disabled unavailable"><span
											class="day">19</span></td>
										<td id="2023-02-20" class="sun disabled unavailable"><span
											class="day">20</span></td>
										<td id="2023-02-21" class="tue disabled unavailable"><span
											class="day">21</span></td>
										<td id="2023-02-22" class="sun disabled unavailable"><span
											class="day">22</span></td>
										<td id="2023-02-23" class="thu disabled unavailable"><span
											class="day">23</span></td>
										<td id="2023-02-24" class="fri disabled unavailable"><span
											class="day">24</span></td>
										<td id="2023-02-25" class="sat disabled unavailable"><span
											class="day">25</span></td>
									</tr>
									<tr>
										<td id="2023-02-26" class="sun disabled unavailable"><span
											class="day">26</span></td>
										<td id="2023-02-27" class="mon disabled unavailable"><span
											class="day">27</span></td>
										<td id="2023-02-28" class="tue disabled unavailable"><span
											class="day">28</span></td>
										<td id=""
											class="wen other_month disabled unavailable holiday"><span>&nbsp;</span><span
											class="day"></span></td>
										<td id=""
											class="thu other_month disabled unavailable"><span>&nbsp;</span><span
											class="day"></span></td>
										<td id=""
											class="fri other_month disabled unavailable"><span>&nbsp;</span><span
											class="day"></span></td>
										<td id=""
											class="sat other_month disabled unavailable"><span>&nbsp;</span><span
											class="day"></span></td>
									</tr>
									<tr>
										<td class="empty_date">&nbsp;<span class="day"></span></td>
										<td class="empty_date">&nbsp;<span class="day"></span></td>
										<td class="empty_date">&nbsp;<span class="day"></span></td>
										<td class="empty_date">&nbsp;<span class="day"></span></td>
										<td class="empty_date">&nbsp;<span class="day"></span></td>
										<td class="empty_date">&nbsp;<span class="day"></span></td>
										<td class="empty_date">&nbsp;<span class="day"></span></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div id="tab-2" class="tab-content current">
						<div class="tab_con" id="cal_2023_3">
							<table summary="2023.03" data-month="2023.03" class="calendar"
								style="display: table;">
								<thead>
									<tr>
										<th scope="col" class="sun">일</th>
										<th scope="col" class="mon">월</th>
										<th scope="col" class="tue">화</th>
										<th scope="col" class="wen">수</th>
										<th scope="col" class="thu">목</th>
										<th scope="col" class="fri">금</th>
										<th scope="col" class="sat">토</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td id="" class="sun other_month disabled unavailable"><span>&nbsp;</span><span
											class="day"></span></td>
										<td id="" class="mon other_month disabled unavailable"><span>&nbsp;</span><span
											class="day"></span></td>
										<td id="" class="tue other_month disabled unavailable"><span>&nbsp;</span><span
											class="day"></span></td>
										<td id="2023-03-01" class="sat disabled unavailable"><span
											class="day">1</span></td>
										<td id="2023-03-02" class="sat disabled unavailable"><span
											class="day">2</span></td>
										<td id="2023-03-03" class="sat disabled unavailable"><span
											class="day">3</span></td>
										<td id="2023-03-04" class="sat disabled unavailable"><span
											class="day">4</span></td>
									</tr>
									<tr>
										<td id="2023-03-05" class="sun disabled unavailable"><span
											class="day">5</span></td>
										<td id="2023-03-06" class="mon disabled unavailable"><span
											class="day">6</span></td>
										<td id="2023-03-07" class="tue disabled unavailable"><span
											class="day">7</span></td>
										<td id="2023-03-08" class="wen disabled unavailable"><span
											class="day">8</span></td>
										<td id="2023-03-09" class="thu disabled unavailable"><span
											class="day">9</span></td>
										<td id="2023-03-10" class="fri disabled unavailable"><span
											class="day">10</span></td>
										<td id="2023-03-11" class="sat disabled unavailable"><span
											class="day">11</span></td>
									</tr>
									<tr>
										<td id="2023-03-12" class="sun disabled unavailable"><span
											class="day">12</span></td>
										<td id="2023-03-13" class="mon disabled unavailable"><span
											class="day">13</span></td>
										<td id="2023-03-14" class="tue disabled unavailable"><span
											class="day">14</span></td>
										<td id="2023-03-15" class="wen disabled unavailable"><span
											class="day">15</span></td>
										<td id="2023-03-16" class="thu disabled unavailable"><span
											class="day">16</span></td>
										<td id="2023-03-17" class="fri disabled unavailable"><span
											class="day">17</span></td>
										<td id="2023-03-18" class="sat disabled unavailable"><span
											class="day">18</span></td>
									</tr>
									<tr>
										<td id="2023-03-19" class="sun disabled unavailable"><span
											class="day">19</span></td>
										<td id="2023-03-20" class="mon disabled unavailable"><span
											class="day">20</span></td>
										<td id="2023-03-21" class="tue disabled unavailable"><span
											class="day">21</span></td>
										<td id="2023-03-22" class="wen disabled unavailable"><span
											class="day">22</span></td>
										<td id="2023-03-23" class="thu disabled unavailable"><span
											class="day">23</span></td>
										<td id="2023-03-24" class="fri disabled unavailable"><span
											class="day">24</span></td>
										<td id="2023-03-25" class="sat disabled unavailable"><span
											class="day">25</span></td>
									</tr>
									<tr>
										<td id="2023-03-26" class="sun disabled unavailable"><span
											class="day">26</span></td>
										<td id="2023-03-27" class="mon disabled unavailable"><span
											class="day">27</span></td>
										<td id="2023-03-28" class="tue disabled unavailable"><span
											class="day">28</span></td>
										<td id="2023-03-29" class="wen disabled unavailable"><span
											class="day">29</span></td>
										<td id="2023-03-30" class="thu disabled unavailable"><span
											class="day">30</span></td>
										<td id="2023-03-31" class="fri disabled unavailable"><span
											class="day">31</span></td>
										<td id="" class=""><span>&nbsp;</span><span
											class="day"></span></td>
									</tr>
									<tr>
										<td class="empty_date">&nbsp;<span class="day"></span></td>
										<td class="empty_date">&nbsp;<span class="day"></span></td>
										<td class="empty_date">&nbsp;<span class="day"></span></td>
										<td class="empty_date">&nbsp;<span class="day"></span></td>
										<td class="empty_date">&nbsp;<span class="day"></span></td>
										<td class="empty_date">&nbsp;<span class="day"></span></td>
										<td class="empty_date">&nbsp;<span class="day"></span></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div id="tab-3" class="tab-content current">
						<div class="tab_con active" id="cal_2023_4">
							<table summary="2023.04" data-month="2023.04" class="calendar"
								style="display: table;">
								<thead>
									<tr>
										<th scope="col" class="sun">일</th>
										<th scope="col" class="mon">월</th>
										<th scope="col" class="tue">화</th>
										<th scope="col" class="wen">수</th>
										<th scope="col" class="thu">목</th>
										<th scope="col" class="fri">금</th>
										<th scope="col" class="sat">토</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td id="" class="sun other_month disabled unavailable"><span>&nbsp;</span><span
											class="day"></span></td>
										<td id="" class="mon other_month disabled unavailable"><span>&nbsp;</span><span
											class="day"></span></td>
										<td id="" class="tue other_month disabled unavailable"><span>&nbsp;</span><span
											class="day"></span></td>
										<td id="" class="wen other_month disabled unavailable"><span>&nbsp;</span><span
											class="day"></span></td>
										<td id="" class="thu other_month disabled unavailable"><span>&nbsp;</span><span
											class="day"></span></td>
										<td id="" class="fri other_month disabled unavailable"><span>&nbsp;</span><span
											class="day"></span></td>
										<td id="2023-04-01" class="sat selected disabled unavailable"><span
											class="day">1</span></td>
									</tr>
									<tr>
										<td id="2023-04-02" class="sun disabled unavailable"><span
											class="day">2</span></td>
										<td id="2023-04-03" class="tue disabled unavailable"><span
											class="day">3</span></td>
										<td id="2023-04-04" class="tue disabled unavailable"><span
											class="day">4</span></td>
										<td id="2023-04-05" class="wen disabled unavailable"><span
											class="day">5</span></td>
										<td id="2023-04-06" class="thu disabled unavailable"><span
											class="day">6</span></td>
										<td id="2023-04-07" class="fri disabled unavailable"><span
											class="day">7</span></td>
										<td id="2023-04-08" class="sat disabled unavailable"><span
											class="day">8</span></td>
									</tr>
									<tr>
										<td id="2023-04-09" class="sun disabled unavailable"><span
											class="day">9</span></td>
										<td id="2023-04-10" class="mon disabled unavailable"><span
											class="day">10</span></td>
										<td id="2023-04-11" class="tue disabled unavailable"><span
											class="day">11</span></td>
										<td id="2023-04-12" class="wen disabled unavailable"><span
											class="day">12</span></td>
										<td id="2023-04-13" class="wen disabled unavailable"><span
											class="day">13</span></td>
										<td id="2023-04-14" class="fri disabled unavailable"><span
											class="day">14</span></td>
										<td id="2023-04-15" class="sat disabled unavailable"><span
											class="day">15</span></td>
									</tr>
									<tr>
										<td id="2023-04-16" class="sun disabled unavailable"><span
											class="day">16</span></td>
										<td id="2023-04-17" class="mon disabled unavailable"><span
											class="day">17</span></td>
										<td id="2023-04-18" class="tue disabled unavailable"><span
											class="day">18</span></td>
										<td id="2023-04-19" class="wen disabled unavailable"><span
											class="day">19</span></td>
										<td id="2023-04-20" class="thu disabled unavailable"><span
											class="day">20</span></td>
										<td id="2023-04-21" class="fri disabled unavailable"><span
											class="day">21</span></td>
										<td id="2023-04-22" class="sat disabled unavailable"><span
											class="day">22</span></td>
									</tr>
									<tr>
										<td id="2023-04-23" class="sun disabled unavailable"><span
											class="day">23</span></td>
										<td id="2023-04-24" class="mon disabled unavailable"><span
											class="day">24</span></td>
										<td id="2023-04-25" class="tue disabled unavailable"><span
											class="day">25</span></td>
										<td id="2023-04-26" class="wen disabled unavailable"><span
											class="day">26</span></td>
										<td id="2023-04-27" class="thu disabled unavailable"><span
											class="day">27</span></td>
										<td id="2023-04-28" class="fri disabled unavailable"><span
											class="day">28</span></td>
										<td id="2023-04-29" class="fri disabled unavailable"><span
											class="day">29</span></td>
									</tr>
									<tr>
										<td id="2023-04-30" class="sun disabled unavailable"><span
											class="day">30</span></td>
										<td id="" class="mon other_month disabled unavailable"><span>&nbsp;</span><span
											class="day"></span></td>
										<td id="" class="tue other_month disabled unavailable"><span>&nbsp;</span><span
											class="day"></span></td>
										<td id="" class="wen other_month disabled unavailable"><span>&nbsp;</span><span
											class="day"></span></td>
										<td id="" class="thu other_month disabled unavailable"><span>&nbsp;</span><span
											class="day"></span></td>
										<td id=""
											class="fri other_month disabled unavailable holiday"><span>&nbsp;</span><span
											class="day"></span></td>
										<td id="" class="sat other_month disabled unavailable"><span>&nbsp;</span><span
											class="day"></span></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div id="tab-4" class="tab-content current">
						<div class="tab_con" id="cal_2023_5">
					        <table summary="2023.05" data-month="2023.05" class="calendar" style="display: table;">
					            <thead>
					                <tr>
					                    <th scope="col" class="sun">일</th>
					                    <th scope="col" class="mon">월</th>
					                    <th scope="col" class="tue">화</th>
					                    <th scope="col" class="wen">수</th>
					                    <th scope="col" class="thu">목</th>
					                    <th scope="col" class="fri">금</th>
					                    <th scope="col" class="sat">토</th>
					                </tr>
					            </thead>
					            <tbody>
					                <tr>
					                    <td id="" class="sun other_month disabled unavailable"><span>&nbsp;</span><span
					                            class="day"></span></td>
					                    <td id="2023-05-01" class="mon selected disabled unavailable"><span class="day">1</span></td>
					                    <td id="2023-05-02" class="tue disabled unavailable"><span class="day">2</span></td>
					                    <td id="2023-05-03" class="wen disabled unavailable"><span class="day">3</span></td>
					                    <td id="2023-05-04" class="thu disabled unavailable"><span class="day">4</span></td>
					                    <td id="2023-05-05" class="fri disabled unavailable holiday"><span class="day">5</span></td>
					                    <td id="2023-05-06" class="sat disabled unavailable"><span class="day">6</span></td>
					                </tr>
					                <tr>
					                    <td id="2023-05-07" class="sun disabled unavailable"><span class="day">7</span></td>
					                    <td id="2023-05-08" class="mon disabled unavailable"><span class="day">8</span></td>
					                    <td id="2023-05-09" class="tue disabled unavailable"><span class="day">9</span></td>
					                    <td id="2023-05-10" class="tue disabled unavailable"><span class="day">10</span></td>
					                    <td id="2023-05-11" class="thu disabled unavailable"><span class="day">11</span></td>
					                    <td id="2023-05-12" class="fri disabled unavailable"><span class="day">12</span></td>
					                    <td id="2023-05-13" class="sat disabled unavailable"><span class="day">13</span></td>
					                </tr>
					                <tr>
					                    <td id="2023-05-14" class="sun disabled unavailable"><span class="day">14</span></td>
					                    <td id="2023-05-15" class="mon disabled unavailable"><span class="day">15</span></td>
					                    <td id="2023-05-16" class="tue disabled unavailable"><span class="day">16</span></td>
					                    <td id="2023-05-17" class="wen disabled unavailable"><span class="day">17</span></td>
					                    <td id="2023-05-18" class="thu disabled unavailable"><span class="day">18</span></td>
					                    <td id="2023-05-19" class="fri disabled unavailable"><span class="day">19</span></td>
					                    <td id="2023-05-20" class="sat disabled unavailable"><span class="day">20</span></td>
					                </tr>
					                <tr>
					                    <td id="2023-05-21" class="sun disabled unavailable"><span class="day">21</span></td>
					                    <td id="2023-05-22" class="mon disabled unavailable"><span class="day">22</span></td>
					                    <td id="2023-05-23" class="tue disabled unavailable"><span class="day">23</span></td>
					                    <td id="2023-05-24" class="tue disabled unavailable"><span class="day">24</span></td>
					                    <td id="2023-05-25" class="thu disabled unavailable"><span class="day">25</span></td>
					                    <td id="2023-05-26" class="fri disabled unavailable"><span class="day">26</span></td>
					                    <td id="2023-05-27" class="fri disabled unavailable"><span class="day">27</span></td>
					                </tr>
					                <tr>
					                    <td id="2023-05-28" class="sun disabled unavailable"><span class="day">28</span></td>
					                    <td id="2023-05-29" class="mon disabled unavailable"><span class="day">29</span></td>
					                    <td id="2023-05-30" class="tue disabled unavailable"><span class="day">30</span></td>
					                    <td id="2023-05-31" class="wen disabled unavailable"><span class="day">31</span></td>
					                    <td id="" class="thu other_month disabled unavailable"><span>&nbsp;</span><span
					                            class="day"></span></td>
					                    <td id="" class="fri other_month disabled unavailable"><span>&nbsp;</span><span
					                            class="day"></span></td>
					                    <td id="" class="sat other_month disabled unavailable"><span>&nbsp;</span><span
					                            class="day"></span></td>
					                </tr>
					                <tr>
					                    <td class="empty_date">&nbsp;<span class="day"></span></td>
					                    <td class="empty_date">&nbsp;<span class="day"></span></td>
					                    <td class="empty_date">&nbsp;<span class="day"></span></td>
					                    <td class="empty_date">&nbsp;<span class="day"></span></td>
					                    <td class="empty_date">&nbsp;<span class="day"></span></td>
					                    <td class="empty_date">&nbsp;<span class="day"></span></td>
					                    <td class="empty_date">&nbsp;<span class="day"></span></td>
					                </tr>
					            </tbody>
					        </table>
					    </div>
					</div>
					<!-- 달력 선택 영역 끝 -->
				</div>
			</div>
		</div>
	</div>
	<div class="product_sell">
		<div class="table">
			<div class="table_inner">
				<table class="goods"> 
					<colgroup>
						<col style="width:153px;">
						<col style="width:123px;">
						<col style="width:112px;">
						<col style="width:496px;">
						<col style="width:131px;">
						<col style="width:115px;">
					</colgroup>
					<thead>
						<tr>
							<th scope="col" class="col1"><a href="#!" class="ico_align" data-sort="start">출/도착정보</a></th>
							<th scope="col" class="col2"><a href="#!" class="ico_align" data-sort="air">항공</a></th>
							<th scope="col" class="col3">여행기간</th>
							<th scope="col" class="col4">상품명</th>
							<th scope="col" class="col5"><a href="#!" class="ico_align" data-sort="price">상품가격</a></th>
							<th scope="col" class="col6"><a href="#!" class="ico_align" data-sort="seat">잔여좌석</a></th>
						</tr>
					</thead>
					<tbody id="pkgTbody" style="display: none;">
					<tr>
						<td><span class='start'>fi_departure</span><br>fi_cityleave</td>
						<td><span class='ico_air'>"+fr_name+"</span></td>
						<td>pi_period</td>
						<td class='name'>
							<a href='package_detail?pi_code="+pi_code+"&fr_name="+fr_name+"&fi_departure="+fi_departure+"&fi_entry="+fi_entry+"'>pi_name</a>
						</td>
						<td>
							<span class='state_start'>"+pi_price+"원</span>
						</td>
						<td>
							<span class='state_start'>"+(pi_stock-pi_sale)+"/"+pi_stock+"</span>
						</td>
					</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
</body>
</html>