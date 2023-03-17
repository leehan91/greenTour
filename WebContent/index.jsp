<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ page import="vo.*" %>
<%@ include file="../_inc/inc_head.jsp" %>
<%
ArrayList<PackageInfo> piList = (ArrayList<PackageInfo>)request.getAttribute("piList");
ArrayList<PackageInfo> piList2 = (ArrayList<PackageInfo>)request.getAttribute("piList2");
%>
<!-- 메인 페이지 (index) -->

<!-- 달력  -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script> 
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> 
<script>
$(function() {
	$.datepicker.regional['ko'] = {
		closeText: '닫기',
		prevText: '이전달',
		nextText: '다음달',
		currentText: '오늘',
		monthNames: ['1월','2월','3월','4월','5월','6월',
		'7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월',
		'7월','8월','9월','10월','11월','12월'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		//buttonImage: "/images/kr/create/btn_calendar.gif",
		buttonImageOnly: true,
		// showOn :"both",
		weekHeader: 'Wk',
		dateFormat: 'yy-mm-dd',
		firstDay: 0,
		isRTL: false,
		duration:200,
		showAnim:'show',
		showMonthAfterYear: false
		// yearSuffix: '년'
	};
	$.datepicker.setDefaults($.datepicker.regional['ko']);

	$( "#date" ).datepicker({
		//defaultDate: "+1w",
		changeMonth: true,
		//numberOfMonths: 3,
		dateFormat:"yy-mm-dd",
		onClose: function( selectedDate ) {
			//$( "#eday" ).datepicker( "option", "minDate", selectedDate );
		}
	});
	$( "#eduedate" ).datepicker({
		//defaultDate: "+1w",
		changeMonth: true,
		//numberOfMonths: 3,
		dateFormat:"yy-mm-dd",
		onClose: function( selectedDate ) {
			//$( "#sday" ).datepicker( "option", "maxDate", selectedDate );
		}
	});
});
// 달력 끝 ==========================================================================

// 도시 셀렉트 ======================================================================
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
	// x : 대분류에서 선택한 값 / target : 선택한 대분류에 따라 보여줄 소분류 콤보박스 객체
		// 1. 원래 소분류 콤보박스에 있던 데이터(option 태그)들을 모두 삭제
		for (var i = target.options.length - 1 ; i > 0 ; i--) {
			target.options[i] = null;
		}

		// 2. 선택한 대분류에 속하는 소분류 데이터를 소분류 콤보박스에 넣음
		if (x != "") {	// 특정 대분류를 선택했으면
			var arr = eval("arr" + x);		// 사용할때 arr배열명만 신경쓰면 됨 
			// 대분류에서 선택한 값에 따라 사용할 배열을 지정 : 소분류 콤보박스에서 보열줄 option 태그들

			for (var i = 0 ; i < arr.length ; i++) {
				target.options[i] = new Option(arr[i].value, arr[i].text);
				// 지정한 arr배열 만큼 target에 option요소 추가
			}

			target.options[0].selected = true;
			// target의 0번 인덱스에 해당하는 option태그를 선택한 상태로 만듦
		}
	}

	function schPackage(){
		var frm = document.frm;
		 
		if (frm.city.value == null || frm.city.value == ""){			
			alert('희망도시를 선택해주세요.');
		}else if (frm.date.value == null || frm.date.value == "" || frm.date.value == '여행시작일 선택 ⇩'){
			alert('희망 날짜를 선택해주세요.');
		}else{
			document.frm.submit();
		}
	}
</script>



<style>
.maincontainer{
	width:1130px; margin:40px auto 30px auto;
	display:flex; justify-content: space-between;
}
.leftbar{ 
	width:300px; height: 500px;
	border: 1px solid lightgrey;
	
}
.leftbar > div > p{ font-size:20px; margin: 13px; margin-top:0; width: 250px; height:60px; padding : 10px;}
.where { 
	font-weight: bolder;
	border-radius:10px; text-align: center; font-size:20px; margin: 13px; width: 250px; height:30px; border: 1px solid; padding : 10px; 
	color: white; background-color:rgb(112,173,71);
}
.rightbanner{
	width:800px; height: 500px;
	border: 1px solid lightgrey;
}
.rightbanner > div { margin: 20px;}
.bottombar{ display:flex; justify-content: space-between; border:1px solid lightgrey; padding: 40px 20px 20px;}
.bottombar > div { border:1px solid lightgrey; border-radius: 20px; width: 350px; height: 200px;
 margin:0; position: relative; }
.bottombar > div > span { margin:0; font-size: 2rem; position:absolute; top:-20%;}
.bottombar > div > a > b {font-size:21px; position:absolute; left:75%; top:80%;color:white; z-index:3} 
.bottombar > div > a > img{ width:100%; height: 100%; border-radius: 20px; position:absolute; left:0px; top:0px;
z-index:2;}
.monthlycontainer { display:flex; justify-content: space-between; flex-wrap:wrap; border:1px solid lightgrey; padding: 20px; }
.monthlycontainer > div { border:1px solid lightgrey; border-radius: 20px; width: 350px; height: 200px; margin-bottom: 30px; position: relative;}
.monthlycontainer > div > span {margin:0; font-size: 1.5rem; color:#fff; background : red; position:absolute; z-index:4; }
.monthlycontainer > div > a > b {font-size:21px; position:absolute; left:75%; top:80%;color:white; z-index:3} 
.monthlycontainer > div > a > img{ width:100%; height: 100%; border-radius: 20px; position:absolute; left:0px; top:0px;
z-index:2;}
</style>

<div class="maincontainer">
	<div class="leftbar" ><br /><br />
		<%if(isLogin){ %>
		<div><p><%=miname.substring(1) %>님 환영합니다! <br /><strong>어떤 여행을 꿈꾸시나요?</strong></p></div>
		<% }else{ %>
		<div><p>고객님, <br /><strong>어떤여행을 꿈꾸시나요?</strong></p></div>
		<% } %>
		<div class="where" >여행지를 선택해주세요</div>
			<form name="frm" action="sch_keyword">
				<select name="nation" onchange="setCategory(this.value, this.form.city);" style="cursor:pointer; text-align:center; font-size:20px; width:270px; height:40px; margin: 13px; margin-top: 4px;" >
					<option value=""> 나라 선택 </option>
					<option value="1"> 일본 </option>
					<option value="2"> 태국 </option>
					<option value="3"> 필리핀 </option>
					<option value="4"> 홍콩 </option>
					<option value="5"> 싱가폴 </option>
					<option value="6"> 베트남 </option>
					<option value="7"> 대만 </option>
				</select>
				
				<select name="city" style="cursor:pointer; text-align:center; font-size:20px; width:270px; height:40px; margin: 13px; margin-top: 4px; margin-bottom: 4px" >
					<option value=""> 도시 선택  </option>
					
				</select>
			    <!--  <div class="where" >인천 출발</div> -->
			
				<input readonly="readonly" style="text-align:center; cursor:pointer; font-size:20px; width:263px; height:35px; margin: 13px;" type="text" name="date" id="date" value="여행시작일 선택 ⇩" class="ipt" />
				<!-- <input align="center" style="width:105px; height:40px; margin: 13px;" type="text" name="eduedate" id="eduedate" value="  도착날짜 선택▼" class="ipt" /> -->
				
				<div class="where" style="cursor:pointer;" onclick="schPackage();"> 패키지 검색 </div>
			</form>
	</div>
	<div class="rightbanner">
		<div>
		<p style="width:100%; height:460px; overflow: hidden;"><a href="/greenTourSite/sch_keyword?keyword=일본"><img alt="여행도시 & 패키지 배너" src="https://image.hanatour.com/usr/manual/md/2023/02/PL00113647/PL00113647.jpg"></a></p>
		</div>
	</div>

</div>
<!-- ================================================= 추천 상품 시작 ============================================================= -->
<p style="background-color:rgb(112,173,71); color:white; font-weight:bolder; width: 200px; height: 33px; padding: 20px; text-align:center; border: 1px solid lightgrey; border-radius: 10px; font-size: 18px;">할인 이벤트중인 패키지</p>

<div class="bottombar" name="package_out">
<%
	for (int i = 0; i < piList.size(); i++){
		PackageInfo pi1 = piList.get(i);
%>
	<div>
		<span><%=pi1.getPi_dc() %>% 할인중</span>
		<a href="package_list?picode=<%=pi1.getPi_code() %>">
		<img alt="할인 이벤트중인 패키지" src="front/img/<%=pi1.getPi_img2()%>"/>
		<b><%=pi1.getCc_name() %></b>
		</a>
	</div>
<%
	}
%>
</div>
<p style="background-color:rgb(112,173,71); color:white; font-weight:bolder; width: 200px; height: 33px; padding: 20px; text-align:center; border: 1px solid lightgrey; border-radius: 10px; font-size: 20px;">월간 인기 패키지</p>
<div class="monthlycontainer">
<% 
	for (int i = 0; i < piList2.size(); i++){ 
		PackageInfo pi2 = piList2.get(i);
%>
	<div>
		<span>월간 인기패키지</span>
      <a href="package_list?picode=<%=pi2.getPi_code() %>"> 
      <img alt="월간 인기 패키지" src="front/img/<%=pi2.getPi_img2()%>" />
      <b><%=pi2.getCc_name() %></b>
      </a>
	</div>
<%
	}
%>	
<!-- ================================================= 추천 상품 끝 ============================================================= -->
</div>
</body>
</html>