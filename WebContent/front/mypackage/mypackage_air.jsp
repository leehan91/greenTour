<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String city = request.getParameter("city");
String sdate = request.getParameter("sdate");
String edate = request.getParameter("edate");
String ccid = (String)request.getAttribute("ccid");


ArrayList<FlightInfo> airList = (ArrayList<FlightInfo>)request.getAttribute("airList");
FlightInfo fi = null;

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
	width: 22%; height: 333px; border:1px solid lightgrey; padding: 20px; border-radius: 5px; font-size: 18px;
}

.mp_sidebar > input { margin: 10 0;}

#on { font-weight: bolder; color: rgb(112,173,71); border : 2px solid lightgrey; opacity: 1;}

.inputNum, .passenger {width:25px;}

.air_list{ width: 820px; border: 1px solid lightgrey; border-radius: 5px; border-radius: 5px;}
.air_list > div{border:1px solid lightgrey; border-radius: 5px; margin: 10px; padding:5px; display: flex; justify-content: space-evenly; align-items: center;}
.air_price  p { margin-left:20px; width:130px; padding:5px; cursor: pointer; border: 1px solid lightgrey; border-radius: 5px;}
.air_price {cursor: pointer;}
.air_img { text-align:  center;}
</style>
<script>
var adult_price = 0;
var child_price = 0;
var atmp = 1;
var ctmp = 0;
var arr = [];
function selAir(val){
	var frmair = document.frm.air;
	var frm = document.frm;
	arr = val.split('/');
	
	var brand = arr[0];
		if(brand == 'KO') company = '대한항공';
		else company = '아시아나';
		
	var ficode = arr[1];
	var fipassenger = arr[2];	
	var fridx = arr[3];
	adult_price = arr[4];	var adult = arr[4];
	child_price = arr[5];	var child = arr[5];
	var grade = arr[6];
	frmair.value = company+'/'+brand+ficode;
	frm.passenger.value = fipassenger;
	frm.grade.value = grade;
	frm.fridx.value = fridx;
	frm.total.value = adult;
	frm.adult.disabled = false;
	frm.child.disabled = false;
	frm.adult.value = 1;
	frm.child.value = 0;
	document.getElementsByClassName('button').disabled = false;
	atmp = 1;
	ctmp = 0;
	
}
function chgAdult(num){
	
	if (atmp < num){
		document.frm.total.value = parseInt(document.frm.total.value) + parseInt(adult_price);		
	} else if (atmp > num){
		document.frm.total.value = parseInt(document.frm.total.value) - parseInt(adult_price);
	}
	atmp = num;
}

function chgChild(num2){	// 문제있음 > 문제해결!!!!............................................................................................
	if (ctmp < num2){
		document.frm.total.value = parseInt(document.frm.total.value) + parseInt(child_price);
	}else if (ctmp > num2){
		document.frm.total.value = parseInt(document.frm.total.value) - parseInt(child_price);
	}
	ctmp = num2;
}

function setCnt(chk, kind){
	/* var cnt = eval("document.frm." + kind + ".value"); */
	if(document.frm.total.value == ""){
		alert('먼저 항공정보를 선택하신 후 인원을 설정할 수 있습니다.');
		return;
	}
	
	if(kind == 'Adult') var frm = document.frm.adult;
	else 				var frm = document.frm.child;
	
	
	if(chk == "+" && frm.value < 10) {
		frm.value = parseInt(frm.value) + 1;
		
	}else if (chk == "-" && frm.value > 1){ 
		frm.value = parseInt(frm.value) - 1;	
	}else if (chk == "-" && frm.value > 0 && kind == 'Child'){
		frm.value = parseInt(frm.value) - 1;
	}
		
	if(kind == 'Adult') {
		frm.onchange = chgAdult(frm.value);
		
	}else{
		frm.onchange = chgChild(frm.value);
	}
	
}

function gohotel(){
	if(document.frm.total.value == ""){
		alert('먼저 항공정보와 인원을 선택하신 후 다음단계로 갈 수 있습니다.');
		return;
	}
	
	var frm = document.frm;
	var city = frm.city.value;
	var sdate = frm.sdate.value;
	var edate = frm.edate.value;
	var adult = frm.adult.value;
	var child = frm.child.value;
	
	var frmair = document.frm.air;
	arr = frm.air.value.split('/');
	var company = arr[0];
	

	var grade = frm.grade.value;
	
	
	
	if(confirm (company + ' / ' + grade + ' / 성인 : ' + adult + '명 / 아동 : ' + child + '명 \n 확인을 누르시면 호텔선택 페이지로 넘어갑니다.')){
		frm.submit();
	}
}

</script>

<div style="margin:50px;"></div>
<div class="topbar_container">
	<div ><span>여행지 & 날짜<br />STEP1</span></div>
	<div id="on"><span>항공편 <br />STEP2</span></div>
	<div><span>호텔 <br />STEP3</span></div>
	<div><span>관광상품 <br />STEP4</span></div>
</div>

<div class="mp_all">
	<div class="change">
		<div class="air_list">
			<%
				String[] grade = {"이코노미", "비즈니스", "퍼스트", "이코노미", "비즈니스", "퍼스트"};
			
				for(int i = 0; i < airList.size(); i++){ 
				fi = airList.get(i);
				ArrayList<FlightRealPrice> priceList = fi.getFlightRealPriceList();
				
				%>
				<div style="display: flex; padding:10px;">
				<div class="air_img"><img width="100" src="/greenTourSite/front/mypackage/image/korean.jpg"></div>
				인천 > <%= fi.getCc_name()%> &nbsp; 출발 : <%=fi.getFi_departure() %> &nbsp; 도착 : <%=fi.getFi_cityarrive() %><br /><br />
				<%= fi.getCc_name()%> > 인천 &nbsp; 출발 : <%=fi.getFi_cityleave() %> &nbsp; 도착 : <%=fi.getFi_entry() %>
			
				
					<div class="air_price">
					<%for(int j = 0; j < 3; j++) {%>	<!-- 가격은 fi 하나당 6개 (대한3개 아시아나3개) 대한한공 가격은 0,1,2 에 들어있기에 3까지만  -->
						<label for="airprice<%=j%><%=i%>" onclick="selAir(document.getElementById('airprice<%=j%><%=i%>').value);">
							<input id="airprice<%=j%><%=i%>" type="hidden" 
							value="KO/<%=fi.getFi_code()%>/<%=fi.getFi_passenger() %>/<%=priceList.get(j).getFr_idx()%>/<%=priceList.get(j).getFr_adult()%>/<%=priceList.get(j).getFr_child()%>/<%=grade[j]%>">
							<p><%=grade[j] %><br />성인 : <%=priceList.get(j).getFr_adult()%>원 <br /> 아동 : <%=priceList.get(j).getFr_child() %>원</p>
						</label>
					<% } %>
						
					</div>
				
			</div>
			
			<div style="display: flex;" padding:10px;>
			<div><img width="105" src="/greenTourSite/front/mypackage/image/asiana.jpg"></div>
			인천 > <%= fi.getCc_name()%> &nbsp; 출발 : <%=fi.getFi_departure() %> &nbsp; 도착 : <%=fi.getFi_cityarrive() %><br /><br />
			<%= fi.getCc_name()%> > 인천 &nbsp; 출발 : <%=fi.getFi_cityleave() %> &nbsp; 도착 : <%=fi.getFi_entry() %>
			
				<div class="air_price">
				<%for(int j = 3; j < 6; j++) {%> <!-- 아시아나 가격은 3,4,5 에 있기에 3~6까지 루프 -->
					<label for="airprice<%=j%><%=i%>" onclick="selAir(document.getElementById('airprice<%=j%><%=i%>').value);">
						<input id="airprice<%=j%><%=i%>" type="hidden" 
						value="AS/<%=fi.getFi_code()%>/<%=fi.getFi_passenger() %>/<%=priceList.get(j).getFr_idx()%>/<%=priceList.get(j).getFr_adult()%>/<%=priceList.get(j).getFr_child()%>/<%=grade[j]%>"  >
						<p><%=grade[j] %><br />성인 : <%=priceList.get(j).getFr_adult()%>원 <br /> 아동 : <%=priceList.get(j).getFr_child() %>원</p>
					</label>										
				<% } %>				
				</div>
			</div>
			
			<% } %>
		</div>
		
	
	</div> <!-- change div end -->

	<div class="mp_sidebar">
		<form name="frm" action="mypackage_main_hotel" method="post">
			
			여행지 : <input name="city" type="text" value="<%=city %>" readonly="readonly" ><hr />
			<input name="ccid" type="hidden" value="<%=ccid %>">
			여행시작 날짜 : <input name="sdate" type="date" value="<%=sdate %>" readonly="readonly" ><br />
			여행종료 날짜 : <input name="edate" type="date" value="<%=edate %>" readonly="readonly" ><hr />
			
			<!-- 성인 : <input name="adult" type="number" value="0" placeholder="성인 0" style="text-align: right;" min="1" max="5" onchange="chgAdult(this.value);" disabled="disabled">명<br />
			아동 : <input name="child" type="number" value="0" placeholder="아동 0" style="text-align: right;" min="0" max="5" onchange="chgChild(this.value);" disabled="disabled">명<hr /> -->
			
			남은좌석 : <input class="passenger" name="passenger" type="text" value="" ><br />
			
			성인 : <input class="button" type="button" value="-" onclick="setCnt(this.value, 'Adult');" />
			<input class="inputNum" type="text" name="adult" id="cnt" value="0" readonly="readonly" />
			<input class="button" type="button" value="+" onclick="setCnt(this.value, 'Adult');" /><br />
			
			아동 : <input class="button" type="button" value="-" onclick="setCnt(this.value, 'Child');" />
			<input class="inputNum" type="text" name="child" id="cnt" value="0" readonly="readonly" />
			<input class="button" type="button" value="+" onclick="setCnt(this.value, 'Child');" /><hr />
						
			항공 : <input name="air" type="text" value="" placeholder="항공편" readonly="readonly"><br />
			
			등급 : <input name="grade" type="text" value="" placeholder="좌석등급" readonly="readonly"><br />
			<input name="fridx" type="hidden" value="">
			<!--  호텔 : <input name="hotel" type="text" value="" placeholder="호텔" disabled="disabled"><hr />-->
			
			가격 : <input name="total" type="text" value="" placeholder="가격" readonly="readonly" text-align="right"><hr />
			
			<input type="button" name="prev" value="이전" onclick="history.back();" >
			<input type="button" name="next" value="다음" onclick="gohotel();">		
		</form>				
	</div>
</div>
<div style="margin:50px;"></div>

</body>
</html>