<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head.jsp"%>
<%
request.setCharacterEncoding("utf-8");
PackageInfo pi = (PackageInfo)request.getAttribute("pi");
FlightInfo fi = (FlightInfo)request.getAttribute("fi");
ArrayList<PackageTour> tl = pi.getTourList();

String picode = pi.getPi_code();
%>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>

<script>
$(window).scroll(function(){
	var scrollTop = $(document).scrollTop();
	var scrollRe = 570;
	if (scrollTop < 807) {
		scrollTop = 0;
		$(".sec_statement").stop();
		$(".sec_statement").animate( { "top" : scrollTop},1500);
	} else if (scrollTop > 807) {
		$(".sec_statement").stop();
		$(".sec_statement").animate( { "top" : scrollTop - scrollRe},1500);
	}
});

function people(option, value) {
	var total = Number($("#opPay").val());
	var adultHap = $("#piAdult").val() * $("#sel_01").val();
	var childHap = $("#piChild").val() * $("#sel_02").val();
	
	if(option == 1) { // 성인
		adultHap = $("#piAdult").val() * value;
		$("#adultCurr").html(adultHap);
	} else { // 아동
		childHap = $("#piChild").val() * value;
		$("#childCurr").html(childHap);
	}
	
	total = adultHap + childHap;
	$("#opPay").val(total);
	$("#totalNum").html(total);
}

$( document ).ready( function() {
	$('.package_slider').slick({
		dots:true,
		customPaging: function(slick, index) {
			var targetImage = slick.$slides.eq(index).find('img').attr('src');
			return '<img src=" ' + targetImage + ' "/>';
		}
	});
});

$( document ).ready( function() {
	$('.tab-link').click(function () {
	    var tab_id = $(this).attr('data-tab');
	
	    $('.tab-link').removeClass('current');
	    $('.tab-content').removeClass('current');
	
	    $(this).addClass('current');
	    $("#" + tab_id).addClass('current');
	
	});
});
</script>
<style>
span, object, h1, h2, h3, h4, h5, h6, p, pre, a, address, big, code, del, em, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, embed, figure, figcaption, footer, header, hgroup, menu, nav, output, ruby, section, summary, time, mark, audio, video {
    margin: 0;
    padding: 0;
}

img {
	width: 100%;
	height: 100%;
}

ul {
	list-style: none;
	padding: 0;
}

.maincontainer { width: 1130px;}

.sec_item { margin: 0 0 25px; }

.sec_item > ul > li {
    display: flex;
    justify-content: flex-end;
}

.si_title {
	margin: 0 0 39px;
    padding: 70px 0 0;
}

.si_title > p > span {
	color: #333;
    font-size: 0.9375em;
}

.si_title > h3 {
    overflow: hidden;
    font-weight: bold;
    color: #111;
    font-size: 1.25em;
}

.product_code {
	padding-right: 15px;
	font-size: 0.8125em;
    font-weight: bold;
    color: #111;
}
.box2 {
	margin: 15px auto;
}
.fare_charged{
	margin: 15px auto;
}
.code_num {
	font-size: 0.8125em;
    color: #ed4949;
    font-weight: bold;
}

.itinerary {
	table-layout: fixed;
    width: 100%;
    word-wrap: break-word;
    word-break: break-all;
    border-top: 2px solid #3f4b5b;
}

.itinerary > tbody > tr > th {
padding: 20px;
    color: #555;
    border-bottom: 1px solid #ccc;
    background: #f5f5f5;
}

.itinerary > tbody > tr > td {
position: relative;
    padding: 20px;
    color: #555;
    border-bottom: 1px solid #ccc;
}

.summary .itinerary td {
    padding: 20px 0 20px 20px;
}

.schedule {
	margin: 0 0 40px;
}

.sec_statement .inner {
	border: 1px solid #3f4b5b;
	border-top-width: 2px;
	background: #fff;
}

.sec_statement .in_util2 {
	padding: 0 14px;
	border-bottom: 1px solid #3f4b5b;
}

.sec_statement .fare {
	max-height: 165px;
	margin: 0 -14px;
	margin-bottom: -1px;
	overflow: hidden;
	overflow-y: auto;
	border-bottom: 1px solid #3f4b5b;
}

.sec_statement .in_util3 .total_fee {
	position: relative;
	padding: 9px 14px 12px;
	border-bottom: 1px solid #e2e2e2;
}

.sec_statement .in_util4 {
	padding: 14px 14px;
	border-bottom: 1px solid #3f4b5b;
	background: #f5f5f5;
}

.sec_statement .in_util4 .lst_btns li.state_available {
	width: 110px;
	margin-right: 0;
	overflow: hidden;
}
	
.sec_statement {
	position: absolute;
	top: 0;
    right: -253px;
    width: 227px;
    padding: 0 0 80px;
    z-index: 1;
}

.sec_statement .fare .tit {
	display: block;
	margin: 3px 0 5px;
	font-size: 0.75em;
	color: #555;
	font-weight: bold;
	letter-spacing: -0.07em;
}

.sec_statement .fare li {
	position: relative;
	padding: 8px 0 9px;
	border-top: 1px solid #e2e2e2;
	overflow: hidden;
	margin: 0 14px;
}

.sec_statement .fare .select {
	position: absolute;
	right: 0;
	top: 10px;
	width: 46px;
	height: 20px;
	font-size: 0.75em;
	color: #555;
	border: 1px solid #bbb;
}

.sec_statement .fare .price {
	display: block;
	width: 100%;
	height: 21px;
	letter-spacing: -0.03em;
	text-align: right;
	overflow: hidden;
}

.sec_statement .price {
	color: #0daa62;
}

.content_section {
	position: relative;
    width: 877px;
    padding-bottom: 40px;
}

.point{
	margin: 0 0 40px;
}

.include {
	margin: 0 0 40px;
	border-top: none;
}

.include .title{
	height: 51px;
    padding-left: 30px;
    margin-top: -1px;
    line-height: 51px;
    color: #333;
    font-size: 0.9375em;
    font-weight: bold;
    border-top: 1px solid #c6c6c6;
    border-left: 1px solid #c6c6c6;
    border-right: 1px solid #c6c6c6;
    background: #f5f5f5;
}

.include_content{
	border: 1px solid #c6c6c6;
    border-top: none;
    padding: 12px 0 10px;
}

.include_content > li{
	position: relative;
    margin: 0 19px;
    padding: 12px 0;
    font-size: 0.8125em;
    background: #fff;
    overflow: hidden;
}

.caution {
	position: relative;
    margin: 0 0 30px;
    padding: 25px 25px 5px;
    background: #f5f5f5;
    border: 1px solid #ccc;
}

.caution > p {
	margin: 0 0 25px;
    font-size: 0.75em;
    line-height: 1.8;
}

.tabs_menu_wrap {
	height: 55px;
}

.tabs_menu > li {
float: left;
width: 25%;
}

.tabs_menu li a.current {
    position: relative;
    z-index: 1;
    background: #3f4b5b;
    border-color: #3f4b5b;
    color: white;
    font-weight: bold;
}

.tabs_menu > li > a {
    display: block;
    margin-left: -1px;
    padding: 12px 0;
    box-sizing: border-box;
    text-align: center;
    font-size: 0.8125em;
    border: 1px solid #bbb;
    border-bottom: 3px solid #3f4b5b;
}

.active{
	position: relative;
    z-index: 1;
    background: #3f4b5b;
    border-color: #3f4b5b;
    color: #fff;
    font-weight: bold;
}

.layout {
	max-width:600px;
	margin:10px auto;
	position: relative;
}

.layout > a {
	color: #666;
}

.layout > ul {
  margin:0;
  padding: 0;
}



.slide {
	display:none;
}
.slide > li {
	list-style: none;
}

.slick-dots {
  position: sticky;
  width: 610px;
  height: 80px;
  margin-top:5px;
  margin-left: -5px;
  display:flex;
  justify-content: center;
}
  
.slick-dots > li {
	list-style: none;
	display: inline-block;
	width: 112px;
    height: 70px;
	margin: 5px;
}


.slick-dots li img {
  opacity: 0.5;
  width: 100%;
  height: auto;
}

.slick-dots li.slick-active img {
  opacity: 1;
}

.slick-prev:before, .slick-next:before {
    font-family: 'slick';
    font-size: 47px;
    line-height: 1.2;
    opacity: .75;
    color: white;
}

.slick-arrow {
  top: 154px;
  background-color: rgba(255,255,255,0.5);
  width: 51px;
}
.slick-prev {
  position: absolute;
  height: 49px;
  z-index: 99;
  left: 0;
  border-radius: 0 20px 20px 0;
}
.slick-next {
  position: absolute;
  height: 49px;
  z-index: 99;
  right: 0;
  border-radius: 20px 0 0 20px;
}
.slick-arrow .icon {
  display: block;
}


.tab-link.current{
	position: relative;
	z-index: 1;
	background: #3f4b5b;
	border-color: #3f4b5b;
	font-weight: bold;
}

.tab-content{
	display: none;
}
.tab-content.current{
    display: block;
    border: 1px solid #e2e2e2;
}

.cs_center {
	position: relative;
    height: 205px;
    border: 1px solid #e2e2e2;
    overflow: hidden;
}

.cs_center::before {
	position: absolute;
    left: 380px;
    top: 0;
    height: 100%;
    width: 1px;
    content: '';
    background: #e2e2e2;
}
.cs_title {
	position: absolute;
	left: 63px;
	top: 32px;
	color: #555;
	font-size: 1.06251em;
}
.inquiry{
	float: left;
	padding: 60px 65px 0 65px;
}
.cscall{
	display: block;
	font-size: 2.5em;
	font-weight: bold;
	color: #0daa62;
	margin: 0 0 25px;
}
.csbtn {
	margin-left: -10px;
}
.csbtn > a {
	position: relative;
    float: left;
    margin-left: 10px;
    display: block;
    width: 93px;
    height: 32px;
    padding: 0 20px 0 5px;
    line-height: 30px;
    font-size: 0.75em;
    text-align: center;
    color: #333;
    border: 1px solid #ccc;
    border: 1px solid #ccc;
    border-radius: 3px;
    text-decoration-line: none;
}

.csbtn > a::after {
	position: absolute;
    right: 21px;
    top: 6%;
    display: block;
    width: 5px;
    height: 9px;
    margin-top: -4px;
    content: '>';
    font-size: 22px;
}
.hour {
    float: left;
    width: 419px;
    box-sizing: border-box;
    padding: 34px 0 0 43px;
    font-size: 0.8125em;
    line-height: 1.7;
}
.hour > dt {
	position: relative;
    padding-left: 10px;
    font-weight: bold;
}

.hour > dt::before {
    position: absolute;
    left: 0;
    top: 10px;
    display: inline-block;
    width: 2px;
    height: 2px;
    content: '';
    background: #333333;
    border-radius: 100%;
}

.hour > dd {
    padding-left: 10px;
    margin: 0 0 8px;
}

#list tr { height: 30px; }
#list th, #list td { padding: 8px 3px; }
#list th { border: solid black 1px; }
#list td { border: solid black 1px; font-size:0.8em;}

</style>
<div class="maincontainer">
	<!-- 패키지 정보 -->
	<div class="sec_item">
		<div class="si_title">
			<p>
				<span><%=pi.getPi_keyword() %></span>
			</p>
			<h3><%=pi.getPi_name() %></h3>
		</div>
		<div class="layout">
			<ul class="package_slider">
				<li>	
					<img src="/greenTourSite/front/img/<%=pi.getPi_img1() %>">
				</li>
				<li>	
					<img src="/greenTourSite/front/img/<%=pi.getPi_img2() %>">
				</li>
				<li>	
					<img src="/greenTourSite/front/img/<%=pi.getPi_img3() %>">
				</li>
				<li>	
					<img src="/greenTourSite/front/img/<%=pi.getPi_img4() %>">
				</li>
				<li>	
					<img src="/greenTourSite/front/img/<%=pi.getPi_img5() %>">
				</li>
			</ul>
		</div>
		
		<ul>
			<li>
			<span class="product_code">상품코드</span>
			<span class="code_num"><%=pi.getPi_code() %></span>
			</li>
		</ul>
	</div>
	<!-- 간략 일정 -->
	<div class="content_section">
	<div class="schedule">
		<div class="summary">
			<table class="itinerary">
				<colgroup>
					<col style="width: 16.8%">
					<col style="width: 61.2%">
					<col style="width: 25%">
				</colgroup>
				<tbody>
					<tr>
						<th>일정</th>
						<td colspan="2"><span class="txt_wrap"><%=pi.getPi_period() %>
								<ul class="txt_sum">
									<li>인천 <%=fi.getFi_departure() %> 출발 - <%=pi.getCc_name() %> <%=fi.getFi_cityarrive() %> 도착</li>
									<li><%=pi.getCc_name() %> <%=fi.getFi_cityleave() %> 출발 - 인천 <%=fi.getFi_entry() %> 도착</li>
								</ul>
						</span></td>
					</tr>
					<tr>
						<th>항공편</th>
						<td colspan="2"><span class="txt_wrap"><%=fi.getFr_name() %> </span></td>
					</tr>
					<tr>
						<th>방문도시</th>
						<td colspan="2"><span class="txt_wrap"> 센다이 </span></td>
						<td></td>
					</tr>
					<tr>
						<th>예약인원</th>
						<td colspan="2">
							<div class="personal_wrap">
								<div class="seats"><%=pi.getPi_sale() %>/<%=pi.getPi_stock() %></div>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<!-- 핵심 상품 포인트 -->
	<div class="point">
	<h3>핵심 상품 포인트</h3>
		<div class="summary">
			<table class="itinerary">
				<colgroup>
					<col style="width: 16.8%">
					<col style="width: 61.2%">
					<col style="width: 25%">
				</colgroup>
				<tbody>
					<tr>
						<th>관광</th>
						<td colspan="2">
						<%			
						for (int i = 0; i < tl.size(); i++) {
						PackageTour pt = tl.get(i);
						%>
						<span class="txt_wrap">●&nbsp;<%=pt.getPt_name() %></span><br/>
						<% } %>
						</td>
					</tr>
					<tr>
						<th>보험</th>
						<td colspan="2"><span class="txt_wrap"><%=pi.getPn_insur() %> </span></td>
						<td></td>
					</tr>
					<tr>
						<th>가이드</th>
						<td colspan="2">
							<div class="personal_wrap">
								<div class="seats"><%=pi.getPn_guide() %></div>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<!-- 포함/불포함 사항 -->
	<div class="include">
		<h4 class="title">포함사항</h4>
		<ul class="include_content">
			<li>
				<p><%=pi.getPn_include() %></p>
			</li>
		</ul>
		<h4 class="title">불포함사항</h4>
		<ul class="include_content">
			<li>
				<p><%=pi.getPn_declude() %></p>
			</li>
		</ul>
	</div>
	<!-- 예약시 유의사항 -->
	<div class="caution">
	<h3 class="title">예약시 유의사항</h3>
		<p>
		<%=pi.getPn_warning() %>
		</p>
	</div>
	<!-- 탭 -->
	<div class="tabs">
		<div class="tabs_menu_wrap">
			<ul class="tabs_menu">
				<li><a class="tab-link current" data-tab="tab-1">일정표</a></li>
				<li><a class="tab-link"  data-tab="tab-2">호텔정보</a></li>
				<li><a class="tab-link"  data-tab="tab-3">여행약관 &amp; 참고사항</a></li>
				<li><a class="tab-link"  data-tab="tab-4">여행안전정보</a></li>
			</ul>
		</div>
		<div id="tab-1" class="tab-content current">
			<div id="detail">
				<p align="center" style="font-size:1.5em;">1일차</p><br />
				<ul style="display:flex; justify-content:space-between; font-size:1.1em; border:1px solid black;" align="center">
					<li style="width:150px; text-align:left;">인천 출발</li>
					<li style="width:150px; text-align:center;">-----------></li>
					<li style="width:150px; text-align:right;"><%=pi.getCc_name() %> 도착</li>
				</ul>
				<div style="border:1px solid black; border-top:none;">
				● 인천 국제공항 출발<br />
				● <%=pi.getCc_name() %> 도착<br />
				</div>
				<p style="border:1px solid black; border-top:none;">숙소 : <%=pi.getHi_name() %> </p>
				<p style="border:1px solid black; border-top:none;">석식 : <%=pi.getPi_food() %> </p>
				<p style="border:1px solid black; border-top:none;">스폐셜 혜택 : <%=pi.getPn_guide() %> </p>
			</div><br /><br />
			<%
			System.out.println(pi.getPi_period().substring(2, 3));
			int period = Integer.parseInt(pi.getPi_period().substring(2, 3));
			for (int i = 0; i < tl.size(); i++) {
				PackageTour pt = tl.get(i);
			%>
			<div id="detail">
			<p align="center" style="font-size:1.5em;"><%=i+2 %>일차</p><br />
				<div style="border:1px solid black;">
				● <%=pt.getPt_name() %><hr />
				★ <%=pt.getPt_summary()%><hr />
				★ <%=pt.getPt_desc() %>
			</div><br /><br />
			</div>
			<% } %>
			<div id="detail">
				<p align="center" style="font-size:1.5em;"><%=period %>일차</p><br />
				<ul style="display:flex; justify-content:space-between; font-size:1.1em; border:1px solid black;" align="center">
					<li style="width:150px; text-align:left;"><%=pi.getCc_name() %> 출발</li>
					<li style="width:150px; text-align:center;">-----------></li>
					<li style="width:150px; text-align:right;">인천 도착</li>
				</ul>
				<div style="border:1px solid black; border-top:none;">
				● <%=pi.getCc_name() %> 출발<br />
				● 인천 국제공항 도착<br />
				</div>
			</div>
		</div>
		<div id="tab-2" class="tab-content">
			<table width="877" cellpadding="0" cellspacing="0" id="list">
				<tr>
					<th>일차</th>
					<th>도시</th>
					<th>호텔</th>
				</tr>
				<%
				for (int i = 1; i < period; i++) {
					out.println("<tr align='center'>");
					out.println("<td>" + i + "일차</td>");
					out.println("<td>" + pi.getCc_name() + "</td>");
					out.println("<td>" + pi.getHi_name() + "일차</td>");
					out.println("</tr>");
				}
				%>
			</table>
		</div>
		<div id="tab-3" class="tab-content">
			<div style="border:1px solid black">
				보험 : <%=pi.getPn_insur() %><br />
				포함사항 : <%=pi.getPn_include() %><br />
				불포함사항 : <%=pi.getPn_declude() %>
			</div>
		</div>
		<div id="tab-4" class="tab-content">
			<div style="border:1px solid black">
				<%=pi.getPn_safe() %>
			</div>
		</div>
	</div>
	<!-- 예약센터 -->
	<div class="cs_center">
		<h3 class="cs_title">그린투어 여행 예약센터</h3>
		<div class="inquiry">
			<span class="cscall">1234-1234</span>
			<div class="csbtn">
               	<a href="notice_list">1:1 문의하기</a>
				<a href="faq_list">자주묻는 질문</a>
			</div>
		</div>
		<dl class="hour">
			<dt>해외 여행 상담</dt>
			<dd>평일 09:00 ~ 18:00 (토/일요일 및 공휴일 휴무)</dd>
			<dt>항공권 및 호텔, 국내여행, 제휴카드상담, 기업단체문의</dt>
			<dd>평일 09:00 ~ 18:00 (토/일요일 및 공휴일 휴무)</dd>
			<dt>여행불편접수</dt>
			<dd>평일 09:00 ~ 18:00 (토/일요일 및 공휴일 휴무)</dd>
		</dl>
	</div>
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	<!-- 인원 선택 -->
	<div class="sec_statement">
		<form method="post" id="">
		<div class="inner">
			<div class="in_util2">
				<input type="hidden" id="piAdult" value="<%=pi.getPi_adult() %>"/>
				<input type="hidden" id="piChild" value="<%=pi.getPi_child() %>"/>
				<ul class="fare ">
					<li><label for="sel_01" class="tit">성인</label> <select
						name="sel_01" id="sel_01" class="select pricesel" onchange="people(1, this.value);">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
					</select> <span class="price"><span class="curr" id="adultCurr"><%=pi.getPi_adult() %></span></span></li>
					<li><label for="sel_02" class="tit">아동</label> <select
						name="sel_01" id="sel_02" class="select pricesel" onchange="people(2, this.value);">
							<option value="0">0</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
					</select> <span class="price"><span class="curr" id="childCurr">0</span></span></li>
				</ul>
				<div class="box2">
					<span class="tit_ess"> 현지 필수 경비 : 현지에서 별도로 지불해야 하는 필수 경비입니다.<br>
								불포함 사항 내역을 확인해주시기 바랍니다.
						</span>
				</div>
				<div class="fare_charged">
					<ul class="lst">
						<li><span class="item"> 객실1인 사용료 : 객실 1인
										사용료는 전일정동안 호텔객실을 성인 1인이 사용할 경우, 상품가 이외에 추가로 발생하는 금액입니다.
								</span>
							</span>
						</span><br /> <span class="txt"><span class="price">150,000원</span>
								(성인 기준)</span></li>
					</ul>
				</div>
			</div>
			<div class="in_util3">
				<div class="total_fee">
					<input type="hidden" id="opPay" value="0"/>
					<span class="tit_all">총 합계</span> <span class="num" id="totalNum"><%=pi.getPi_adult()%>원 <span
						class="ico_tog"></span></span>
				</div>
			</div>
			</form>
			<form name ="goReservFrm" action ="package_reserv" method = "post">
			<div class="in_util4">
				 <input type ="hidden" name = "piCode" value ="<%=pi.getPi_code() %>" />
               <input type ="hidden" name = "departure" value ="<%=fi.getFi_departure() %>" />
               <input type ="submit" name ="dlg_specialterm" value = "예약하기" />
<!-- <ul class="lst_btns"><li class="state_available"><a href="#" class="dlg_open" id="dlg_specialterm"><span class="ico_chk"></span>예약하기</a></li></ul>  -->

		</div>
		</form>
	</div>
	</div>
</div>
</body>
</html>