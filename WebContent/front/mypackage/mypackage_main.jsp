<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<CtgrCity> cityList = (ArrayList<CtgrCity>)request.getAttribute("cityList");
String nation = request.getParameter("nation");
%>



<style>
.topbar_container{ background-image: url("front/mypackage/image/thiwan.svg"); background-size : cover;
	display: flex; justify-content: center;   
}
.topbar_container > div {
	margin: 50px; width:150px; height:60px; 
	line-height : 30px; text-align: center; border: 1px solid lightgrey; border-radius: 10px; opacity:0.5;
}
.nation{
		display: flex; flex-wrap:nowrap; justify-content: center;
}

.nation > div {
	font-size:20px; margin: 20px; width:220px; height:50px; line-height : 50px; 
	text-align: center; border: 1px solid lightgrey;  
}

.nation > div > p { padding-top:20px; border-bottom: }

.citys{
	display: flex; flex-wrap:nowrap; justify-content: center;  cursor: pointer;
}

.citys > div {
	font-size:20px; margin: 10px; width:100px; height:50px; 
	line-height : 50px; text-align: center;  border: 1px solid lightgrey; border-bottom : 3px solid lightgrey;
	
}



.mp_all{
	display: flex;
	flex-wrap: nowrap;
	justify-content: space-between;
}
.change{
	width: 70%;
}
.mp_sidebar{
	width: 22%; border:1px solid lightgrey; padding: 20px; height: 137px; margin-top:20px; font-size: 18px;
}

.mp_sidebar > input { margin: 10 0;}

#on { font-weight: bolder; color: rgb(112,173,71); border : 2px solid lightgrey; opacity : 1;}

frm > input {width: 10px;}

#map_container{  border:1px solid lightgrey; width: 70%; }

.map { color : black; background-color: white;}

#japan { background-image: url("front/mypackage/image/japan.svg"); background-size : cover;}
#thai { background-image: url("front/mypackage/image/thai.jpg"); background-size : contain;}
#phil { background-image: url("front/mypackage/image/phil.jpg"); background-size : cover;}
#hong { background-image: url("front/mypackage/image/hong.jpg"); background-size : cover;}
#sing { background-image: url("front/mypackage/image/sing.svg"); background-size : cover;}
#vet { background-image: url("front/mypackage/image/vet.jpg"); background-size : cover;}
#taiwan { background-image: url("front/mypackage/image/taiwan.svg"); background-size : cover;}


</style>

<script>
/* function selectNation(nation){
	alert(nation);
	$.ajax({
		type : "POST",
		url : "/greenTourSite/mypackage_main_citys",
		data : {"nation" : nation },
		success : function(chkRs){
			if(chkRs == 0){	// 실패했을 경우 
				alert("나라 선택에 오류가 발생했습니다. 다시 시도해주세요.")
				return;
			} else {		// 장바구니 담기에 성공했을 경우
				location.reload();				
			}
		}		
	})
}  */



function selcity(city){
	var frm = document.frm;
	frm.city.value = city;
	document.getElementById("sdate").click();
	

}

function selsdate(date){
	document.frm.sdate.value = date;
}
function seledate(date){
	document.frm.edate.value = date;
}

function sleep(ms) {
	  const wakeUpTime = Date.now() + ms;
	  while (Date.now() < wakeUpTime) {}
	}

function next(){
	var frm = document.frm;
	if(frm.sdate.value == "" || frm.edate.value == "" || frm.city.value == ""){
		alert('도시와 날짜를 입력해주세요');
	} else {
		if(confirm('목적지 <' + frm.city.value + '>, 출발날짜는 ' + frm.sdate.value +' 입니다. \n확인을 클릭하시면 항공편을 검색합니다.')){
			
			frm.submit()
		}
	}
	
}
function nationClk(val){
	location.href="mypackage_main_citys?nation="+val;
}
</script>

<div style="margin:50px;"></div>
<div class="topbar_container">
	<div id="on"><span>여행지 & 날짜<br />STEP1</span></div>
	<div><span>항공편 <br />STEP2</span></div>
	<div><span>호텔 <br />STEP3</span></div>
	<div><span>관광상품 <br />STEP4</span></div>
</div>

<div class="mp_all">
	<div class="change">
		<section class="nation_section"> 
				
				<div class="nation">
					<div id="japan" class="citys" onclick="nationClk('JPN');"><p>일본</p></div>
					<div id="thai" class="citys" onclick="nationClk('THA');"><p>태국</p></div>
					<div id="phil" class="citys" onclick="nationClk('PHL');"><p>필리핀</p></div>
					<div id="hong" class="citys" onclick="nationClk('HKG');"><p>홍콩</p></div>
					<div id="sing" class="citys" onclick="nationClk('SGP');"><p>싱가폴</p></div>
					<div id="vet" class="citys" onclick="nationClk('VNM');"><p>베트남</p></div>
					<div id="taiwan" class="citys" onclick="nationClk('TWN');"><p>대만</p></div>
				</div>
		 
				
			<!-- 	
				<input type="button" name="nation" value="JPN" onclick="selectNation(this.value);">일본
				<input type="button" name="nation" value="THA" onclick="selectNation(this.value);">태국
				<input type="button" name="nation" value="PHL" onclick="selectNation(this.value);">필리핀
				<input type="button" name="nation" value="HKG" onclick="selectNation(this.value);">홍콩
				<input type="button" name="nation" value="SGP" onclick="selectNation(this.value);">싱가폴
				<input type="button" name="nation" value="VNM" onclick="selectNation(this.value);">베트남
				<input type="button" name="nation" value="TWN" onclick="selectNation(this.value);">대만 
			-->
				
			
			<div style="margin:30px;"></div>
			
			<div class="citys">
				<%
				if(cityList != null){
					for(int i = 0; i < cityList.size(); i++) { 
						CtgrCity cc = new CtgrCity();
						cc = cityList.get(i);
					%>
				
					<div onclick="selcity(this.innerHTML);"><%=cc.getCc_name()%></div>
				
				<% }
				} %>
			</div>
		</section>
		
		<!-- <section class="date_section">
			<div><input type="date" onchange="selsdate(this.value)"><input type="date" onchange="seledate(this.value)"></div>
			
		</section> -->
	</div> <!-- change div end -->

	<div class="mp_sidebar">
		<form name="frm" action="mypackage_main_air">
			여행지 : <input name="city" type="text" value="" placeholder="여행지를 선택하세요." readonly="readonly"><hr />
			여행시작 날짜 : <input id="sdate" name="sdate" type="date" value="2023-02-20" placeholder="여행시작 날짜" ><br />
			여행종료 날짜 : <input id="edate" name="edate" type="date" value="2023-02-24" placeholder="여행종료 날짜"><hr />
			<!-- 성인 : <input name="adult" type="number" value="" placeholder="성인 0" disabled="disabled" style="text-align: right;">명<br />
			아동 : <input name="child" type="number" value="" placeholder="아동 0" disabled="disabled" style="text-align: right; ">명<hr />
			항공 : <input name="air" type="text" value="" placeholder="항공편" disabled="disabled"><br />
			호텔 : <input name="hotel" type="text" value="" placeholder="호텔" disabled="disabled"><hr /> -->
			
			<input type="button" value="이전" onclick="history.back();" disabled="disabled">
			<input type="button" value="다음" onclick="next();">	
		</form>				
	</div>
</div>

<div style="margin:50px;"></div>
<div id="map_container">
<div id="map" style="height: 500px; margin: 5px;">
</div>
</div>
<div style="margin:100px;"></div>

</body>
<!-- <script defer src="./js/map.js"></script>  -->
  <script
    defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDxUglNer4qAoVPxbPGjz5QMCN3O4ds4xE&callback&callback=initMap"
  ></script>
<script>
var map;

function initMap() {
	const iconBase =
	    "https://developers.google.com/maps/documentation/javascript/examples/full/images/";
	
	var JPN = { lat : 36.668448781552364, lng : 138.17347289326497};
	var THA = { lat : 15.428354563428227, lng : 100.9939436285068};
	var PHL = { lat : 13.14353997685644, lng : 121.79584326353798};
	var HKG = { lat : 22.31137878744336, lng : 114.17644344410796};
	var SGP = { lat : 1.3589630937070802, lng : 103.83292039938684}; 
	var VNM = { lat : 14.206386280771165, lng : 108.22927556136318};  
	var TWN = { lat : 23.85200709424168, lng : 120.99394423169964};
	var KOR = { lat : 37.02172889455281, lng: 124.29229689309878 }
	var loc = "", nation = "<%=nation%>";
	var loc = KOR;
	
	if (nation == "JPN")		loc = JPN;
	else if (nation == "THA")	loc = THA;
	else if (nation == "PHL")	loc = PHL;
	else if (nation == "HKG")	loc = HKG;
	else if (nation == "SGP")	loc = SGP;
	else if (nation == "VNM")	loc = VNM;
	else if (nation == "TWN")	loc = TWN;
	
	
	map = new google.maps.Map( document.getElementById('map'), {
      zoom: 6,
      center: loc,
      disableDefaultUI: true
    });


  
  const citys = [
	  	{ label: "오사카", name: "오사카", lat: 34.67164877990306, lng: 135.5021716210019 }, 
	    { label: "도쿄", name: "도쿄", lat: 35.762422645743285, lng: 139.75321238627524 }, 
	    { label: "오키나와", name: "오키나와", lat: 26.79746150090726, lng: 128.2645049625388 }, 
	    { label: "푸켓", name: "푸켓", lat: 7.956751050707231, lng: 98.34204027031991 }, 
	    { label: "방콕", name: "방콕", lat: 13.763995453753177, lng: 100.50688059965341 },
	    /* { label: "파타야", name: "파타야", lat: 13.763995453753177, lng: 100.50688059965341 }, */
	    { label: "보라카이", name: "보라카이", lat: 11.967973415054683, lng: 121.92389733649222 }, 
	    { label: "세부", name: "세부", lat: 10.317821677723716, lng: 123.88868609162779 },  
	    { label: "홍콩", name: "홍콩", lat: 22.31137878744336, lng: 114.17850337547956 },  
	    { label: "싱가포르", name: "싱가포르", lat: 1.3620482226504667, lng: 103.86346732629715 },  
	    { label: "다낭", name: "다낭", lat: 16.072603335390376, lng: 108.18342192221237 },  
	    { label: "나트랑", name: "나트랑", lat: 12.252751314223346, lng: 109.1884782849672 },  
	    { label: "타이페이", name: "타이페이", lat: 25.038428801313696, lng: 121.56355908166204 },  
	    { label: "가오슝", name: "가오슝", lat: 22.63432073082335, lng: 120.29298115076455 },  
	    { label: "화련", name: "화련", lat: 24.001921438282125, lng: 121.59421069080682 },  
	    { label: "지우펀", name: "지우펀", lat: 25.112649936986966, lng: 121.84721334324755 },  
	  ];
	  citys.forEach(({ label, name, lat, lng }) => {
	    const marker = new google.maps.Marker({
	      position: { lat, lng },
	      label,
	      map,
	     
	    });
	  },); 
	  
	  
}
</script>
</html>