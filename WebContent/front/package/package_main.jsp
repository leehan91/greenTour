<%@page import="com.sun.javafx.geom.PickRay"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head.jsp"%>

<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>

 
<script>
var befActive; // 이전 active값
var defaultValue = "JPN"; // 일본

function city(chkRs) {
	$("#"+befActive).removeClass("active"); // 이전 클릭된 active값 제거
	var data = new Object();
	data.ccid = chkRs;
	data.gbn = 1;
	$.ajax({
		type : "POST",
		url : "/greenTourSite/package_main", 
		data : data,
		success : function(packageMain) {
			$("#"+chkRs).addClass("active"); // 현재 클릭한곳에 active값 추가
			for (var i = 0; i < packageMain.length; i++) {
				var ccId = packageMain[i].cc_id;
				var pIcode = packageMain[i].pi_code;
				var pIname = packageMain[i].pi_name;
				var pIperiod = packageMain[i].pi_period;
				var pIimg1 = packageMain[i].pi_img1;
				var pIadult = packageMain[i].pi_adult;
				
				$('.city' + i).find('img').attr("src", "/greenTourSite/front/img/"+packageMain[i].pi_img1);
				$('.city' + i).find('a').attr("href", "package_list?picode=" + packageMain[i].pi_code);
				$('.city' + i).find('.info').find('.name').text(packageMain[i].pi_name+' '+pIperiod);
				$('.city' + i).find('.info').find('.price').find('strong').text(packageMain[i].pi_adult);
			}
		}
	});
	
	befActive = chkRs; // 현재값이 전에 선택한 값이 됨
}


function slideData(chkRs) {
	var data = new Object();
	data.ccid = chkRs;
	data.gbn = 2;
	
	$.ajax({
		type : "POST",
		url : "/greenTourSite/package_main",
		data : data,
		success : function(packageMain) {
			$(".multiple-items").remove();
			$(".tourslide").append("<div class='multiple-items'></div>");
			
			for (var i = 0; i < packageMain.length; i++) {
				var ccId = packageMain[i].cc_id;
				var pIcode = packageMain[i].pi_code;
				var pIname = packageMain[i].pi_name;
				var pIperiod = packageMain[i].pi_period;
				var pIimg1 = packageMain[i].pi_img1;
				var pIadult = packageMain[i].pi_adult;
				
				$(".multiple-items").append(
					"<a class='sltag' href='package_list?picode="+pIcode+"'>"
					+"<div class='slider_content'>"
					+"	<span class='slimg'>"
					+"	<img src='/greenTourSite/front/img/"+pIimg1+"'>"
					+"	</span>"
					+"	<div class='info'>"
					+"    	<span class='title'>"+pIname+"&nbsp"+pIperiod+"</span>"
	            	+"    	<span class='price'><strong>"+pIadult+"</strong>원~</span>"
	            	+"	</div>"
		        	+"</div>"
		        	+"</a>"
				)
			}
				
			$('.multiple-items').slick({
				infinite: true,
				slidesToShow: 3,
				slidesToScroll: 3,
			});
		}
	});
}


$(function(){
	city(defaultValue);
	slideData(defaultValue);
});

</script>

<style>

img {
	width: 100%;
	height: 100%;
}

.content {
	width: 1130px;
	margin: 40px auto 30px auto;
}

.ctgr {
	padding-top: 25px;
	display: flex;
	justify-content: space-between;
}

.ctgr>a>span {
	border: 1px solid lightgrey;
	line-height: 60px;
	width: 150px;
	height: 60px;
	display: inline-block;
	text-align: center;
	font-size: 23px;
	border-radius: 23px;
	box-shadow: 2px 5px 10px #e4e4e4;
}

.content {
	position: relative;
	padding-top: 61px;
	margin: 0 0 70px;
	overflow: hidden;
	z-index: 1;
}

.recommand {
	position: relative;
	height: 630px;
}

ul {
	list-style: none;
}

.background {
	background: url(/greenTourSite/front/img/greentourhot.jpg) no-repeat center 0;
	background-size: cover;
	height: 220px;
}

.recommand>ul {
	top: 0px;
	left: 0px;
	z-index: 99;
	opacity: 1;
	display: block;
}

.city0 {
	position: absolute;
	left: 0;
	top: 0;
	width: 555px;
	height: 630px;
}

.city0 .info {
	position: absolute;
	left: 0;
	bottom: 0;
	width: 495px;
	padding: 30px;
}

.city0 .info .name {
	display: block;
	font-size: 25px;
	max-height: 67px;
	margin: 0 0 10px;
	line-height: 1.5;
	font-weight: bold;
	word-break: break-all;
	word-wrap: break-word;
	overflow: hidden;
	color:white;
}

.city0 .info .price {
	display: block;
	color:white;
	font-size: 20px;
}

.price {
	display: block;
	font-size: 19px;
}

.city1 {
	position: absolute;
	right: 0;
	top: 0;
	width: 546px;
	height: 300px;
}

.city1 .info {
	position: absolute;
	left: 0;
	bottom: 0;
	width: 506px;
	padding: 20px;
}

.city1 .info .name {
	display: block;
	height: 30px;
	margin: 0 0 13px;
	font-size: 22px;
	line-height: 1.5;
	font-weight: bold;
	white-space: nowrap;
	text-overflow: ellipsis;
	word-break: break-all;
	word-wrap: break-word;
	overflow: hidden;
	color:white;
}

.city1 .info .price {
	display: block;
	color:white;
	font-size: 18px;
}

.city2 {
	position: absolute;
	left: 585px;
	bottom: 0;
	width: 258px;
	height: 300px;
}

.city2 .info {
	position: absolute;
	left: 0;
	bottom: 0;
	width: 218px;
	padding: 20px;
}

.city2 .info .name {
	display: block;
	height: 30px;
	margin: 0 0 11px;
	font-size: 20px;
	line-height: 1.4;
	font-weight: bold;
	white-space: nowrap;
	text-overflow: ellipsis;
	word-break: break-all;
	word-wrap: break-word;
	overflow: hidden;
	color:white;
}

.city2 .info .price {
	display: block;
	color:white;
	font-size: 16px;
}

.city3 {
	position: absolute;
	right: 0;
	bottom: 0;
	width: 257px;
	height: 300px;
}

.city3 .info {
	position: absolute;
	left: 0;
	bottom: 0;
	width: 217px;
	padding: 20px;
}

.city3 .info .name {
	display: block;
	height: 30px;
	margin: 0 0 11px;
	font-size: 20px;
	line-height: 1.4;
	font-weight: bold;
	white-space: nowrap;
	text-overflow: ellipsis;
	word-break: break-all;
	word-wrap: break-word;
	overflow: hidden;
	color:white;
}

.city3 .info .price {
	display: block;
	color:white;
	font-size: 16px;
	
}

.keyword {
	padding: 20px 36px;
}

.keyword>h2 {
	color: white
}

.links>a {
	display: inline-block;
	color: white;
	margin-left: 5px;
	padding: 0 10px;
	font-size: 18px;
}

.active {
	background-color: #3dd28d;
	color:white;
	box-shadow: 2px 5px 10px #e4e4e4;
}

.tourslide{
	margin-bottom: 70px;
}

.multiple-items{
	border: 1px solid #ccc;
    border-right: none;
    background: #fff;
    height: 343px;
    width: 1132px;
}

.multiple-items .slick-arrow{
	font-size: 0;
    line-height: 0;
    position: absolute;
    top: -12%;
    display: block;
    width: 20px;
    height: 20px;
    padding: 0;
}


.slick-next {
    right: 32px;
}

.slick-prev {
    left: 90%;
}
.slick-prev:before, .slick-next:before {
    font-family: 'slick';
    font-size: 47px;
    line-height: 1;
    opacity: .75;
    color: black;
}

.slimg{
	display: block;
	height: 212px;
    margin: 0 0 22px;
}
.sltag{
	display: block;
    z-index: 100;
    padding: 20px 20px 0;
    border-right: 1px solid #ccc;
}

.slider_content .info{
	height: 88px;
}

.title {
	display: block;
    width: 325px;
    height: 38px;
    font-size: 14px;
    color: #111;
    overflow: hidden;
    white-space: normal;
}
</style>

<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>



<div class="maincontainer">
	<!-- 카테고리 -->
	<div class="ctgr">
		<a href="#!" onclick="city('JPN'); slideData('JPN');"><span id="JPN" class="active">일본</span></a>
		<a href="#!" onclick="city('THA'); slideData('THA');"><span id="THA">태국</span></a>
		<a href="#!" onclick="city('PHL'); slideData('PHL');"><span id="PHL">필리핀</span></a>
		<a href="#!" onclick="city('HKG'); slideData('HKG');"><span id="HKG">홍콩</span></a>
		<a href="#!" onclick="city('SGP'); slideData('SGP');"><span id="SGP">싱가포르</span></a>
		<a href="#!" onclick="city('VNM'); slideData('VNM');"><span id="VNM">베트남</span></a>
		<a href="#!" onclick="city('TWN'); slideData('TWN');"><span id="TWN">대만</span></a>
	</div>
	<!-- 추천상품 -->
	<div class="content">
		<h2>추천상품</h2>
		<div class="recommand">
			<ul>
				<li class="city0">
					<a href="">
					  <img src="" alt="">
				        <div class="info">
				            <span class="name">1</span>
				            <span class="price"><strong></strong>원~</span>
				        </div>
					</a>
				</li>
				<li class="city1">
					<a href="">
					  <img class="recoimg" src="" alt="">
				        <div class="info">
				            <span class="name"></span>
				            <span class="price"><strong></strong>원~</span>
				        </div>
					</a>
				</li>
				<li class="city2">
					<a href="">
					  <img class="recoimg" src="" alt="">
				        <div class="info">
				            <span class="name"></span>
				            <span class="price"><strong></strong>원~</span>
				        </div>
					</a>
				</li>
				<li class="city3">
					<a href="">
					  <img class="recoimg" src="" alt="">
				        <div class="info">
				            <span class="name"></span>
				            <span class="price"><strong></strong>원~</span>
				        </div>
					</a>
				</li>
			</ul>
		</div>
	</div>
	<!-- 키워드 -->
	<div class="background">
		<div class="keyword">
			<h2>HOT 키워드<br />
				<sub>키워드를 클릭하면 해당 상품을 보실 수 있습니다.</sub>
			</h2>
			<div class="links_wrap">
				<div class="links">
					<a href="sch_keyword?keyword=오키나와" style="background: #2DB400;">#오키나와가봤니?</a>
					<a href="sch_keyword?keyword=홍콩" style="background: #2DB400;">#야경이 이쁜 홍콩</a>
					<a href="sch_keyword?keyword=태국" style="background: #2DB400;">#동남아는 태국이지</a>
					<a href="sch_keyword?keyword=푸켓" style="background: #2DB400;">#바다가 이쁜 푸켓</a>
					<a href="sch_keyword?keyword=싱가포르" style="background: #2DB400;">#꼭 가봐야하는 싱가포르</a>
				</div>
			</div>
		</div>
	</div>
	<!-- 패키지 슬라이더 -->
	<div class="tourslide">
	<h3>23년 인기여행지</h3>
		<div class="multiple-items">
		</div>
	</div>
</div>
</body>
</html>