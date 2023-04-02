<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head_admin.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<CtgrCity> cityList = (ArrayList<CtgrCity>)request.getAttribute("cityList");
ArrayList<HotelInfo> hotelList = (ArrayList<HotelInfo>)request.getAttribute("hotelList");
ArrayList<FlightRealPrice> frpList = (ArrayList<FlightRealPrice>)request.getAttribute("frpList");

%>

<script>
var date = 0;	// ex) 3박4일 에서 4를 뽑아놓으려고 만든 변수 
var ccidtmp = "";	// 도시선택하면 변수에 박히게 해놓고 쓰려고 만든 변수(ccid) 

<%
for(int i = 0; i < cityList.size(); i++){
	CtgrCity cc = cityList.get(i);
	String arr = "arr" + cc.getCc_id();	
%>
	var <%=arr%> = new Array();	
	<%=arr%>[0] = new Option("", " 호텔 선택 ");
	
	<%
	for(int j = 0, k = 1; j < hotelList.size(); j++, k++){
		HotelInfo hi = hotelList.get(j);
		if(hi.getCc_id().equals(cityList.get(i).getCc_id())){
	%>
	<%=arr%>[<%=k%>] = new Option("<%=hi.getHi_code()%>", " <%=hi.getHi_grade() + '/' + hi.getHi_name() + '/' + hi.getHi_standard()%> ")

	<%
		} else {
			k=0;
		}
	}
	
	
}

for(int i = 0; i < cityList.size(); i++){
	CtgrCity cc = cityList.get(i);
	String farr = "farr" + cc.getCc_id();
%>
	var <%=farr%> = new Array();
	<%=farr%>[0] = new Option("", " 항공가격 선택 ");
	
	<%
	for(int a = 0, b = 1; a < frpList.size(); a++, b++){
		FlightRealPrice frp = frpList.get(a);
		if(frp.getCc_id().equals(cityList.get(i).getCc_id())){
		%>

		<%=farr%>[<%=b%>] = new Option("<%=frp.getFr_idx()%>", " <%=frp.getFr_name()+'/'+frp.getFr_grade()+'/'+frp.getFr_adult()%> ");
		
		<%
		} else {
			b=0;
		}
	}
}%>


var arr1 = new Array();	// 첫번째 대분류(대분류값 1)에 속한 소분류 메뉴(option 태그)를 저장할 배열
arr1[0] = new Option("", " 도시 선택 ");
arr1[1] = new Option("JPNOSK", " 오사카 ");	arr1[2] = new Option("JPNTYO", "  도쿄 ");
arr1[3] = new Option("JPNOKI", " 오키나와 ");	

var arr2 = new Array();	// 두번째 대분류(대분류값 2)에 속한 소분류 메뉴(option 태그)를 저장할 배열
arr2[0] = new Option("", " 도시 선택 ");
arr2[1] = new Option("THAHKT", " 푸켓 ");		arr2[2] = new Option("THABKK", " 방콕/파타야 ");

var arr3 = new Array();	
arr3[0] = new Option("", " 도시 선택 ");
arr3[1] = new Option("PHLMPH", " 보라카이 ");		arr3[2] = new Option("PHLCEB", " 세부 ");

var arr4 = new Array();	
arr4[0] = new Option("", " 도시 선택 ");
arr4[1] = new Option("HKGHKG", " 홍콩 ");	

var arr5 = new Array();	
arr5[0] = new Option("", " 도시 선택 ");
arr5[1] = new Option("SGPSGP", " 싱가폴 ");		

var arr6 = new Array();	
arr6[0] = new Option("", " 도시 선택 ");
arr6[1] = new Option("VNMDAD", " 다낭 ");		arr6[2] = new Option("VNMNHA", " 나트랑 ");

var arr7 = new Array();	
arr7[0] = new Option("", " 도시 선택 ");
arr7[1] = new Option("TWNTPE", " 타이페이 ");		arr7[2] = new Option("TWNKHH", " 가오슝/화련/지우펀 ");

function setCategory(x, target) {
	for (var i = target.options.length - 1 ; i > 0 ; i--) {
		target.options[i] = null;
	}	
	if (x != "") {	// 특정 대분류를 선택했으면
		var arr = eval("arr" + x);			

		for (var i = 0 ; i < arr.length ; i++) {
			target.options[i] = new Option(arr[i].value, arr[i].text);
		}

		target.options[0].selected = true;
	}
	
	if(x.length == 6){
	getPicode(document.frm.nation.value, document.frm.ccid.value);
		
	}
}

function setFrpList(x, target) {
	for (var i = target.options.length - 1 ; i > 0 ; i--) {
		target.options[i] = null;
	}

	if (x != "") {	
		var farr = eval("farr" + x);		

		for (var i = 0 ; i < farr.length ; i++) {
			target.options[i] = new Option(farr[i].value, farr[i].text);
		}

		target.options[0].selected = true;
	}
}



function getPicode(nation, city){
	if(nation != "" && city != ""){
		if(confirm('상품코드를 생성(확인)하시겠습니까?')){
			$.ajax({
				type : "POST",
				url : "/greenTour/admin_add_package_getpicode",
				data : {"nation" : nation, "city" : city },
				success : function(data){
					if(data == "" || data == null){	// 코드 생성 실패
						alert("코드 생성에 실패했습니다.\n 다시 시도해 보세요.")
						return;
					}else{
						var result = data;
						document.frm.picode.value = result;					
					}				
				}
			})
		}
	} else {
		alert('국가와 도시를 선택후 클릭해주세요.');
	}
	
	ccidtmp = document.frm.ccid.value;
}

const changeH = (target) => {
 
	  // option의 text 값
	  var text = target.options[target.selectedIndex].text;
	  var arr = text.split("/");
	  console.log(arr[2]);
	  $("#hPrice").text(arr[2]);
   
}

const changeF = (target) => {
	 
	  // option의 text 값
	  var text = target.options[target.selectedIndex].text;
	  var arr = text.split("/");
	  console.log(arr[2]);
	  $("#fPrice").text(arr[2]);
	  
}

function calPrice(){
	var period = document.getElementById('period').value;
	if(period.length != 4){
		alert('기간을 다시 입력하고 눌러주세요.')
		return;
	}
	var num = parseInt(period.substr(2,3));
	document.getElementById('sumPrice').innerText = parseInt(document.getElementById('hPrice').innerText) * num + parseInt(document.getElementById('fPrice').innerText) + "원 (" + document.getElementById('hPrice').innerText + "x" + num + "일)";
	date = num;
	console.log(ccidtmp);
	
}


function addTour(date){
	var d = date;
	const ccid = ccidtmp;
	awin = window.open("admin_TourList_Pop?ccid="+ccid+"&day="+d,"tourListPop","left=100,top=50,width=850,height=800");	
						// 팝업창 객체가 awin 에 들어감 ( 팝업창 주소 / 팝업창 이름 / 팝업창 크기,위치,각종옵션등 )  
	
}

function chkBtn(){
	console.log(document.frm.piimg1.value);
}

</script>

<style>
ul, li, a{list-style: none; padding:0; color:#000; text-decoration:none;}
span, object, h1, h2, h3, h4, h5, h6, p, pre, a, address, big, code, del, em, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, embed, figure, figcaption, footer, header, hgroup, menu, nav, output, ruby, section, summary, time, mark, audio, video {
    margin: 0;
    padding: 0;
}
body{width:1130px; margin:0 auto;}
.on { font-weight: bold;}
#main { display:flex; justify-content: space-between; margin-top:100px;}
.ctgr { width:200px; margin : 10px; padding: 10px; margin-top:100px; }
.form_container{ width:930px; margin : 10px; padding: 10px; border: 1px solid black;}


#topbar{ width : 930px; display: flex; justify-content: space-around; }
#topbar > div { border: 1px solid grey; width: 100%; padding : 10px; margin:10px 0; margin-top: 0;}

table, tr, td, th { border: 1px solid grey; padding:10px;}
table { width:100%; margin-bottom:20px; }
.daybyTour{ display: none; border: 1px solid grey; padding:10px; margin-bottom:20px;}
.daybyTour th { text-align:left; width :900px;}
.daybyTour td { width :900px;}
#day1 , #day2, #day3, #day4, #day5, #day6, #day7 { width : 500px;}

textarea{
	width:400px; 
	height:200px; 
    resize:none;
    }
    
#pointer{
    -webkit-animation:blink 1.5s ease-in-out infinite alternate;
    
  }
  
  @-webkit-keyframes blink{
    0% {opacity:0;}
    100% {opacity:1;}
  }

.caution{font-size: 13px; color: red;}
</style>


<main id="main">

   <div class="bar">
		<ul class="ctgr">
	      <li><a href="">회원 관리</a></li><hr />
	      <li><a href="">도시 관리</a></li><hr />
	      <li><a href="">게시판 관리</a></li><hr />
	      <li>
	         <a href="">상품 관리</a><br />
	         <span>&nbsp;&nbsp;&nbsp;<a href="/greenTour/admin_package_list"> - 패키지 관리</a></span><br />
	         <span>&nbsp;&nbsp;&nbsp;<a href="/greenTour/hotel_list"> - 호텔 관리</a></span><br />
	         <span>&nbsp;&nbsp;&nbsp;<a href="/greenTour/tour_list"> - 관광 상품 관리</a></strong><br />
	      </li><hr />
	      <li><a href="">고객센터</a></li><hr />
	      <li><a href="../admin_stat">통계</a></li>
	   </ul>
	</div>
   
   
   
   
   	<form name="frm" action="admin_add_package_insert" method="post" enctype="multipart/form-data">
   	<p class="caution" >*상품코드는 도시 선택시 자동생성됩니다.</p>
   	<div id="topbar">
    		<div>
    		<p>상품코드 : <input type="text" name="picode" value="" readonly="readonly" style="font-size:20px; font-weight:bold; border:none" onfocus="this.blur();" ></p>
    		<p>패키지명 : <input type="text" name="piname"></p><br />
    			
    		</div>
    		<div>
    		키워드 입력란<br />
    		<input type="text" name="keyword">
    		
    		</div>
    		
   	</div>
   추천상품 등록여부 : <select name="pisuggest">
			    	<option value="n" selected="selected">추천상품 등록여부 </option> 
			    	<option value="n" >N</option>
			    	<option value="y" >Y</option>
    			</select>
   	<br />
   	<br />
    	
  	<p class="caution" onclick="chkBtn();">*이미지는 총 5장이며 모두 등록해 주셔야 정상 등록됩니다.</p>
    <div class="all_container" >
    	<div id="img_container" style="height:100px; padding:10px; margin-bottom: 10px;border: 1px solid grey;" >
    	
    	이미지1 : <input type="file" name="piimg1" />
    	이미지2 : <input type="file" name="piimg2" /><br />
   		이미지3 : <input type="file" name="piimg3" />
    	이미지4 : <input type="file" name="piimg4" /><br />
    	이미지5 : <input type="file" name="piimg5" />	    
    	
    	</div>
     
    <table >
    	<tr align="center">
	    	<td width="10%">국가</td>
	    		<td width="20%">
	    			<select name="nation" onchange="setCategory(this.value, this.form.ccid)" style="cursor:pointer; text-align:center; width:150px;" >
					<option value=""> 나라 선택 </option>
					<option value="1"> 일본 </option>
					<option value="2"> 태국 </option>
					<option value="3"> 필리핀 </option>
					<option value="4"> 홍콩 </option>
					<option value="5"> 싱가폴 </option>
					<option value="6"> 베트남 </option>
					<option value="7"> 대만 </option>
				</select>
	    		</td>
    		<td width="10%">도시</td>
    		<td width="20%">
    			<select name="ccid" style="cursor:pointer; text-align:center; width:150px; " onchange="javascript:setCategory(this.value, this.form.hicode); setFrpList(this.value, this.form.fridx);">
					<option value=""> 도시 선택  </option>
					
				</select>
    		</td>
    		<td  width="10%">기간</td>
    		<td  width="*"><input type="text" id="period" name="period" value="3박4일" placeholder="패키지 기간 ex)3박4일"></td>
    	
    	</tr>
    	
    	
    	<tr align="center" >
    			<td  >호텔</td>
    		<td width="*">
    			<select name="hicode" style="cursor:pointer; text-align:center; width:150px; " onchange="changeH(this)" > 
    				<option value="">호텔 선택</option>
    				
    			</select>
    		</td>
    		<td >항공편</td>
    		<td >
    			<select name="fridx" style="cursor:pointer; text-align:center; width:150px;" onchange="changeF(this)" >
    				<option value=""> 항공가격 선택</option>
    			</select> 
    		</td>
    		<td >수량</td>
    		<td ><input type="text" value="100" name="pistock"></td>
    	</tr>
    </table>
    <br />
    <p class="caution">*반드시 예상가격 측정후 패키지 가격을 책정해주세요.</p>
    <input type="button" name="picodeBtn" value="상품코드 재확인" onclick="getPicode(document.frm.nation.value, document.frm.ccid.value)">
    <input type="button" name="sumBtn" value="예상가격 계산" onclick="calPrice()">
    <span id="pointer">◀</span>
    <br />
    <table>
    	<tr>
    		<td width="20%" >항공가격 (왕복 성인)</td>
    		<td width="*" id="fPrice">0</td>
    	</tr>
    	<tr>
    		<td>호텔가격 </td>
    		<td id="hPrice">0</td>
    	</tr>
    	<tr>
    		<td>최소 가격 (예상)</td>
    		<td id="sumPrice">0</td>
    	</tr>
    </table>
    <br />
    <p class="caution">*출국일 , 입국일은 관광상품을 등록할 수 없습니다.</p>
    <input type="button" value="일정표 열기" onclick="block()">
    <input type="button" value="일정표 초기화" onclick="init()">
    
    <div id ="tour_container">
    	
    	<table class="daybyTour" width="100%;">
    		<tr>
    			<th colspan="2">1일차 일정표</th>
    		<tr>
    		<tr>
    			<td><input type="text" id="day1" name ="day1" placeholder="출국일과 입국일은 선택할수 없습니다." value="자유여행" readonly="readonly"></td>
    			<td>
    			<input type="button" value="추가" onclick="addTour('1')">
    			<input type="button" value="삭제" onclick="document.getElementById('day1').value='자유여행'">
    			</td>
    		</tr>
    		
    	</table>
 		<table class="daybyTour">
    		<tr>
    			<th colspan="2">2일차 일정표</th>
    		<tr>
    		<tr>
    			<td><input type="text" id="day2" name ="day2" placeholder="" value="자유여행"  readonly="readonly" onclick=""></td>
    			<td>
    			<input type="button" value="추가" onclick="addTour('2')">
    			<input type="button" value="삭제" onclick="document.getElementById('day2').value='자유여행'">
    			</td>
    		</tr>
    		
    	</table>
    	<table class="daybyTour">
    		<tr>
    			<th colspan="2">3일차 일정표</th>
    		<tr>
    		<tr>
    			<td><input type="text" id="day3" name ="day3" placeholder="" value="자유여행"  readonly="readonly" onclick=""></td>
    			<td>
    			<input type="button" value="추가" onclick="addTour('3')">
    			<input type="button" value="삭제" onclick="document.getElementById('day3').value='자유여행'">
    			</td>
    		</tr>
    		
    	</table>
    	<table class="daybyTour">
    		<tr>
    			<th colspan="2">4일차 일정표</th>
    		<tr>
    		<tr>
    			<td><input type="text" id="day4" name ="day4" placeholder="" value="자유여행"  readonly="readonly" onclick=""></td>
    			<td>
    			<input type="button" value="추가" onclick="addTour('4')">
    			<input type="button" value="삭제" onclick="document.getElementById('day4').value='자유여행'">
    			</td>
    		</tr>
    		
    	</table>
    	<table class="daybyTour">
    		<tr>
    			<th colspan="2">5일차 일정표</th>
    		<tr>
    		<tr>
    			<td><input type="text" id="day5" name ="day5" placeholder="" value="자유여행" readonly="readonly" onclick=""></td>
    			<td>
    			<input type="button" value="추가" onclick="addTour('5')">
    			<input type="button" value="삭제" onclick="document.getElementById('day5').value='자유여행'">
    			</td>
    		</tr>
    		
    	</table >
    	<table class="daybyTour">
    		<tr>
    			<th colspan="2">6일차 일정표</th>
    		<tr>
    		<tr>
    			<td><input type="text" id="day6" name ="day6" placeholder="" value="자유여행" readonly="readonly" onclick=""></td>
    			<td>
    			<input type="button" value="추가" onclick="addTour('6')">
    			<input type="button" value="삭제" onclick="document.getElementById('day6').value='자유여행'">
    			</td>
    		</tr>
    		
    	</table>
    	<table class="daybyTour">
    		<tr>
    			<th colspan="2">7일차 일정표</th>
    		<tr>
    		<tr>
    			<td><input type="text" id="day7" name ="day7" placeholder="" value="자유여행" readonly="readonly" onclick=""></td>
    			<td>
    			<input type="button" value="추가" onclick="addTour('7')">
    			<input type="button" value="삭제" onclick="document.getElementById('day7').value='자유여행'">
    			</td>
    		</tr>
    		
    	</table>
    	
    <script>
	const showDay = document.querySelectorAll('.daybyTour');
	//const dayInput = document.querySelectorAll('.daybyTour input');
	
	function block(){
		for(var i =0; i<7; i++){
			var day = showDay[i];
			
			day.style.display = "none";
			day.style.opacity = "1";
			//day.input.disabled = true;
		}
		
		for(var j =0; j<date; j++){
			var day = showDay[j];
			
			day.style.display = "block";
			//input.disabled = false;
			
			if(j==0){
				day.style.opacity ="0.3";
				day.style.display = "none";
				//day.input.disabled = true;
			}else if(j==date-1){
				day.style.opacity ="0.3"; 
				day.style.display = "none";
				
				//day.input.disabled = true;
				// = "입국은 추가할 수 없습니다."; // <==============================이거 처리안됨... 마지막날 placeholder 주거나 아예 막아버리기
				//day.placeholder ='입국일은 추가 할 수 없습니다.'
			}
		}
	
	}
	
	function init(){
		for(var i =0; i<date; i++){
			var day = showDay[i];
			
			day.style.display = "none";
			day.style.opacity = "1";
			document.getElementById('day1').value="자유여행";
			document.getElementById('day2').value="자유여행";
			document.getElementById('day3').value="자유여행";
			document.getElementById('day4').value="자유여행";
			document.getElementById('day5').value="자유여행";
			document.getElementById('day6').value="자유여행";
			document.getElementById('day7').value="자유여행";
		
		}
	}
	
	function onlyNum(obj){
		if(isNaN(obj.value)){	// 숫자가 아니면 참인 함수 isNan()
			obj.value = "";
		}
	}
	
	
	
	</script>	
    	
    	
    	
    	
    	
    	
    </div>
    
    <br />
    
    <table>
    	<tr><td>성인가격 : </td><td><input type="text" name= "piadult" onkeyup="onlyNum(this)"></td>
    	<td>아동가격 : </td><td><input type="text" name= "pichild" onkeyup="onlyNum(this)"></td></tr>
    </table>
   
    
    <table>
    	<tr>
    	<td width="15%">상품 설명 : </td>
    	<td width="*"><input type="text" name= "summary" value="summary"  placeholder="summary" style="width : 750px;"></td>
    	</tr>    	
    </table>
    
    <table>
    <tr>
	    <td onclick="test123()">스페셜혜택</td>
	    <td><input type="text" name= "pispecial" placeholder="EX)기사,가이드포함" value="기사,가이드포함" style="width : 750px;"></td>
    </tr>
    <tr>
	    <td>식사</td>
	    <td><input type="text" name= "pifood" placeholder="EX)호텔조식,씨푸드" value="호텔조식,씨푸드" style="width : 750px;"></td>
    </tr>
     
    </table>
    
<script>
function test123(){
	console.log($("textarea[name=pnsafe]").val());
}

function makePnidx(){
	if(ccidtmp==""){
		alert('도시를 먼저 선택해주세요');
		return;
	}
	var pninsur = $("textarea[name=pninsur]").val();
	var pnguide = $("textarea[name=pnguide]").val(); 
	var pninclude = $("textarea[name=pninclude]").val(); 
	var pndeclude = $("textarea[name=pndeclude]").val(); 
	var pnwarning = $("textarea[name=pnwarning]").val(); 
	var pnsafe = $("textarea[name=pnsafe]").val(); 
	
	var ccid = ccidtmp;
	
	if(confirm('유의사항을 생성하시겠습니까?')){
		$.ajax({
			type : "POST",
			url : "/greenTour/admin_add_package_notice",
			data : {"pninsur" : pninsur, "pnguide" : pnguide, 
					"pninclude" : pninclude, "pndeclude" : pndeclude, 
					"pnwarning" : pnwarning, "pnsafe" : pnsafe,
					"ccid" : ccid},
					success : function(data){
						console.log(data);
					
						var val = data;
						var arr = val.split('/');
						var idx = arr[0]+"";
						console.log(idx);
						var chk = arr[1];
						
						
						if(chk != 1){	// 장바구니에서 삭제실패
							alert("유의사항 생성에 실패했습니다. \n 다시 시도해 보세요.")
							return;
						}else{
							alert("유의사항 생성 성공!");
							document.frm.newpnidx.value=idx;
							var pnidx = document.getElementsByName('pnidx');
							
				}				
			}
		})
	}	
}

function goBack(){
	if(confirm('저장되지 않은 모든 정보가 사라집니다.')){
		history.back();
	}else{
		return;
	}
}

function insertPackage(){
	var frm = document.frm;
	if(frm.picode.value != "" && frm.ccid.value != "" && frm.nation.value != "" && frm.hicode.value != "" && frm.newpnidx.value != ""&& frm.piname.value != "" && frm.period.value != "" && frm.keyword.value != "" &&
			/* frm.piimg1.value != "" && frm.piimg2.value != "" && frm.piimg3.value != "" && frm.piimg4.value != "" && frm.piimg5.value != "" && */ frm.summary.value != "" && frm.pispecial.value != "" && frm.pifood.value != "" 
			&& frm.pistock.value != "" && frm.piadult.value != "" && frm.pichild.value != "" && document.frm.piimg1.value != "" && document.frm.piimg2.value != "" 
			&& document.frm.piimg3.value != "" && document.frm.piimg4.value != "" && document.frm.piimg5.value != "" ){
		alert(frm.picode.value+'패키지를 생성합니다');
		document.frm.submit();
	} else {
		alert('정상 실행되지 않았습니다. 옵션을 확인하세요.');
		return;
	}
}

</script>
    
    <table>
    	<tr>
    		<td width="20%;"> 패키지 유의사항 선택 </td>
    		<td><select name="pnidx">
    			<option value="" selected="selected">1</option>
    			</select>
    		</td>
    		
    		<td>유의사항 생성</td>
    		<td>
	    		<input type="button" value ="생성" onclick="makePnidx();">
	    		<input type="hidden" name="newpnidx" value = "">
    		</td>
  		</tr>
  	</table>	
  	
  	<table>
  		<tr>
  			<td>보험</td>
  			<td>가이드</td>
  				
  		</tr>
  		
    	<tr>
    		<td><textarea name="pninsur">[여행자보험] 가입</textarea></td>
    		<td><textarea name="pnguide">[가이드] 인솔자는 동반하지 않습니다.</textarea></td>
    		
    	</tr>
    	<tr>
    		<td>포함사항</td>	
    		<td>불포함사항</td>
  			
    	</tr>
    	
    	<tr>
    		<td><textarea name="pninclude">
①왕복항공권②인천공항세,관광진흥개발기금,현지공항세,전쟁보험료③숙박비, 식사비(일정표참고), 차량비④여행자보험 포함⑤한국인 가이드와 함께 미팅/센딩 서비스</textarea></td>
    		<td><textarea name="pndeclude">
① 기타개인경비*매너팁은 소비자의 자율적 선택사항으로 지불여부에 따른 불이익은 없습니다.(매너팁 : 식당, 객실 청소원 등 서비스에 대한 단순 감사의 표시로, 소비자(여행자)의 의사에 따라 자율적으로 지불하는 비용)</textarea></td>

		</tr>
		
		<tr>
			<td>유의사항</td>
  			<td>안전정보</td>
  		</tr>
  		
  		
  		<tr>
    		<td><textarea name="pnwarning">예약시 유의사항
■ 선발권 관련 규정안내① 선발권 특가로 진행되는 요금입니다.② 선발권 후 항공요금 상승에 따라 상품가격이 인상될 수 있습니다.③ 항공사 규정상 발권 후에는 이름 변경, 여정 변경 시 별도비용이 추가됩니다.</textarea></td>
    		<td><textarea name="pnsafe">여행 금지국가 지정 현황
- 우크라이나(전 지역(2022년 2월 13일 ~ 2023년 1월 31일까지))
- 러시아 일부지역 : 러시아 로스토프·벨고로드·보로네시·쿠르스크·브랸스크 지역 내 우크라이나 국경에서 30km (2022년 3월 8일 ~ 2023년 1월 31일까지)
- 벨라루스 일부지역 : 벨라루스 브레스트·고멜 지역 내 우크라이나 국경에서 30km (2022년 3월 8일 ~ 2023년 1월 31일까지)</textarea></td>
    	</tr>
    </table>
      
    
    
   
    <div style="display: flex; justify-content: flex-end; margin-bottom: 50px;">
    	
    	
    	<div style="display: inline-block; padding:20px; width: 110px; margin-right:20px; border:1px solid black; text-align:center; font-size: 20px;" class="insertBtn" onclick="goBack();">뒤로가기</div>
    	<div style="display: inline-block; padding:20px; width: 110px; border:1px solid black; font-size: 20px; text-align:center;"  class="insertBtn" onclick="insertPackage();">패키지 생성</div>  	
    </div>
    </form>
</main>

</body>
</html>