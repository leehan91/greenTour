<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<HotelInfo> hotelList = (ArrayList<HotelInfo>)request.getAttribute("hotelList");
MyPackageMy mm = (MyPackageMy)request.getAttribute("mypackagemy");


String ccid = mm.getCc_id();
String city = mm.getMm_destination();
String ficode = mm.getFi_code();
int fridx = mm.getFr_idx();
int adult = mm.getMm_adult();
int child = mm.getMm_child();
int atotal = mm.getMm_atotal();	// atotal = 항공가격
String agrade = mm.getMm_agrade();
String sdate = (String)request.getAttribute("sdate");
String edate = (String)request.getAttribute("edate");
String air = (String)request.getAttribute("air");
 


/*
String cksdate = "", ckedate = "", ckcity = ""; 
String ckadult = "", ckchild = "", ckair = "", ckgrade =""; 
int cktotal = 0; 
String cook = request.getHeader("Cookie");
if(cook != null){	// 쿠키가 있으면
	Cookie[] cookies = request.getCookies();
	for(int i=0; i<cookies.length; i++){	// 쿠키값 받음 
		if(cookies[i].getName().equals("city"))	 ckcity = cookies[i].getValue();					
		if(cookies[i].getName().equals("sdate")) cksdate = cookies[i].getValue();
		if(cookies[i].getName().equals("edate")) ckedate = cookies[i].getValue();		
		if(cookies[i].getName().equals("adult")) ckadult = cookies[i].getValue();		
		if(cookies[i].getName().equals("child")) ckchild = cookies[i].getValue();		
		if(cookies[i].getName().equals("air"))   ckair = cookies[i].getValue();		
		if(cookies[i].getName().equals("total")) cktotal = Integer.parseInt(cookies[i].getValue());
		if(cookies[i].getName().equals("grade")) ckgrade = cookies[i].getValue(); 
	}
} */


%>
<style>
.topbar_container{
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
	font-size:20px; margin: 20px; width:220px; height:60px; line-height : 60px; 
	text-align: center; border: 1px solid lightgrey; border-radius: 10px;
}

.citys{
	display: flex; flex-wrap:nowrap; justify-content: center;
}

.citys > div {
	font-size:20px; margin: 20px; width:100px; height:60px; 
	line-height : 60px; text-align: center; border: 1px solid lightgrey; border-radius: 10px;
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
	width: 22%; height: 400px; border:1px solid lightgrey; padding: 20px; border-radius: 5px; font-size: 18px;
}

.mp_sidebar > input { margin: 10 0;}

#on { font-weight: bolder; color: rgb(112,173,71); border : 2px solid lightgrey; opacity: 1;}

.inputNum, .passenger {width:25px;}

.hotel_list{ width: 820px; border: 1px solid lightgrey; border-radius: 5px; border-radius: 5px;}
.hotel_list > div{ margin: 10px; padding:10px; display:flex; flex-wrap: nowrap; justify-content: space-between;}
.hotel_list > div > div {width:250px; border:1px solid lightgrey; border-radius: 5px; padding:10px;}
.hotel_info img {width:100%; height:100%; object-fit:cover;}
.hotel_info > div {margin: 5px; width:250px; height: 158px; overflow:hidden }
.hotel_price {text-align: right; }
</style>

<script>

var totalprice = 0;
function selhotel(val, kind){
	if(totalprice == 0){
		totalprice = document.frm.total.value;		
	}
	var arr = val.split("/");
	var hicode = arr[0];
	var hiprice = parseInt(arr[1]);
	var hiname = arr[2];
	var hgrade = kind;
	var frm = document.frm;
	
	frm.total.value = parseInt(totalprice) + parseInt(hiprice);
		
	frm.hotel.value = hiname;
	frm.hgrade.value = hgrade;
	frm.htotal.value = hiprice;
	frm.hicode.value = arr[0];
}

function gotour(){
	var frm = document.frm;
	var hotel = frm.hotel.value;
	if(hotel == ""){
		alert('호텔등급을 선택해주세요');
		return;
	}
	
	frm.submit();
}

function openPop(hicode){
	callPop(hicode);
	//location.href="mypackagehotel_pop?hicode="+hicode;
}

function callPop(val){
	awin = window.open("mypackagehotel_pop?hicode="+val,"hoteldesc","left=100,top=50,width=720,height=800","location=no");	
					// 팝업창 객체가 awin 에 들어감 ( 팝업창 주소 / 팝업창 이름 / 팝업창 크기,위치,각종옵션등 )  
}
</script>

<div style="margin:50px;"></div>
<div class="topbar_container">
	<div><span>여행지 & 날짜<br />STEP1</span></div>
	<div><span>항공편 <br />STEP2</span></div>
	<div id="on"><span>호텔 <br />STEP3</span></div>
	<div><span>관광상품 <br />STEP4</span></div>
</div>

<div class="mp_all">
	<div class="change">
		<div class="hotel_list">
			<%for(int i = 0; i < hotelList.size(); i++){ 
				HotelInfo hi = new HotelInfo();
				hi = hotelList.get(i);
			%>
			<div class="hotel_info" >
			
				<div onclick="openPop(document.getElementById('hicode_pop<%=i%>').value)" style="cursor:pointer;">
					
					<img alt="호텔이미지" src="front/img/<%=hi.getHi_img1()%>">
					
				</div>
				<div onclick="openPop(document.getElementById('hicode_pop<%=i%>').value)" style="cursor:pointer;">
					<input type="hidden" id="hicode_pop<%=i%>" value="<%=hi.getHi_code() %>" >
					<p><%=hi.getHi_name() %></p>
					<p id="star">
                    <%for(int j = 0; j < Integer.parseInt(hi.getHi_grade()); j++){ %>
					★
					<% } %>
					(<%=hi.getHi_grade() %>성급 호텔)</p>
					<p>남은 방 개수 : <%=hi.getHi_stock() %> 개</p>
					
				</div>
			
				<div class="hotel_price">
				
					<p>스탠다드 : <%=hi.getHi_standard() %>원 
					<input id="standard<%=i %>" type="hidden" value="<%=hi.getHi_code()+'/'+hi.getHi_standard()+'/'+hi.getHi_name()%>">
					<input type="button" value="선택" onclick="selhotel(document.getElementById('standard<%=i%>').value,'standard');"> </p> 
					
					<p> 디럭스 : <%=hi.getHi_deluxe() %>원 
					<input id="deluxe<%=i %>" type="hidden" value="<%=hi.getHi_code()+'/'+hi.getHi_deluxe()+'/'+hi.getHi_name()%>">
					<input type="button" value="선택" onclick="selhotel(document.getElementById('deluxe<%=i%>').value,'deluxe');"></p>
					
					<p> 스위트 : <%=hi.getHi_suite() %>원	
					<input id="suite<%=i %>" type="hidden" value="<%=hi.getHi_code()+'/'+hi.getHi_suite()+'/'+hi.getHi_name()%>">
					<input type="button" value="선택" onclick="selhotel(document.getElementById('suite<%=i%>').value,'suite');"></p>					
					
				</div>
			</div>
			
			<% } %>
		</div>
		
	
	</div> <!-- change div end -->

	<div class="mp_sidebar">
		<form name="frm" action="mypackage_main_tour" method="post">
			
			여행지 : <input name="city" type="text" value="<%=city %>" readonly="readonly"  ><hr />
			여행시작 날짜 : <input name="sdate" type="date" value="<%=sdate %>" readonly="readonly" ><br />
			여행종료 날짜 : <input name="edate" type="date" value="<%=edate %>" readonly="readonly" ><hr />
			
			<!-- 성인 : <input name="adult" type="number" value="0" placeholder="성인 0" style="text-align: right;" min="1" max="5" onchange="chgAdult(this.value);" disabled="disabled">명<br />
			아동 : <input name="child" type="number" value="0" placeholder="아동 0" style="text-align: right;" min="0" max="5" onchange="chgChild(this.value);" disabled="disabled">명<hr /> -->
			
			<!-- 남은좌석 : <input class="passenger" name="passenger" type="text" value="" disabled="disabled"><br /> -->
			
			성인 :
			<input name="adult" class="inputNum" type="text"  id="cnt" value="<%=adult %>" readonly="readonly" >
			<br />
			
			아동 : 
			<input name="child" class="inputNum" type="text"  id="cnt" value="<%=child %>" readonly="readonly" >
			<hr />
						
			항공 : <input name="air" type="text" value="<%=air %>" placeholder="항공편" readonly="readonly" ><br />
			     					
			등급 : <input name="agrade" type="text" value="<%=agrade %>" placeholder="좌석등급" readonly="readonly" ><hr />
			
			호텔 : <input name="hotel" type="text" value="" placeholder="호텔" readonly="readonly"><br />
				 
				
			등급 : <input name="hgrade" type="text" value="" placeholder="호텔방 등급" readonly="readonly"><hr />
			
			가격 : <input name="total" type="text" value="<%=atotal%>" placeholder="가격" readonly="readonly" text-align="right"><hr />
					
				 <input name="ccid" type="hidden" value="<%=ccid %>">
				 <input name="ficode" type="hidden" value="<%=ficode %>">
				 <input name="fridx" type="hidden" value="<%=fridx%>">
				 <input name="atotal" type="hidden" value="<%=atotal %>">			 
				 <input name="hicode" type="hidden" value="">
				 <input name="htotal" type="hidden" value="">	
				 
			<input type="button" name="prev" value="이전" onclick="history.back();" >
			<input type="button" name="next" value="다음" onclick="gotour();">		
		</form>				
	</div>
</div>

<div style="margin:50px;"></div>


</body>
</html>