<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head_admin.jsp" %>
<%
request.setCharacterEncoding("utf-8");
PackageInfo pi = (PackageInfo)request.getAttribute("pi");
ArrayList<PackageTour> tl = pi.getTourList();

%>
<!-- 스크립트 시작 -->
<script>

</script>
<!-- 스타일 시작 -->
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
</style>


<main id="main">
<div>
   <ul class="ctgr">
      <li><a href="">회원 관리</a></li>
      <li><a href="">도시 관리</a></li><hr />
      <li><a href="">게시판 관리</a></li><hr />
      <li>
         <a href="">상품 관리</a><br />
         <span class="on">&nbsp;&nbsp;&nbsp;<a href="admin_add_package_form"> - 패키지 관리</a></span><br />
         <span>&nbsp;&nbsp;&nbsp;<a href=""> - 호텔 관리</a></span><br />
         <span>&nbsp;&nbsp;&nbsp;<a href=""> - 관광 상품 관리</a></span><br />
      </li><hr />
      <li><a href="">고객센터</a></li><hr />
      <li><a href="">통계</a></li>
   </ul>
   </div>
   
   
   
   
   	<form name="frm" action="package_real_up" method="post">
   	<p style="font-size: 13px; color: red;">*상품코드는 도시 선택시 자동생성됩니다.</p>
   	<div id="topbar">
    		<div>
    		<p>상품코드 : <input type="text" name="picode" value="<%=pi.getPi_code() %>" readonly="readonly" style="font-size:20px; font-weight:bold; border:none" onfocus="this.blur();" ></p>
    		<p>패키지명 : <input type="text" name="piname" value="<%=pi.getPi_name() %>"></p>
    		</div>
    		<div>
    		키워드 입력란<br />
    		<input type="text" name="keyword" value="<%=pi.getPi_keyword() %>">
    		</div>
    		
   	</div>
   	<br />
    	
  	
    <div class="all_container" >
    	<div id="img_container" style="height:100px; padding:10px; margin-bottom: 10px;border: 1px solid grey;" >
    	이미지
    	<input type="image">
    	<input type="button" name="addImg" value="추가">
    	<input type="button" name="delImg" value="삭제">
    	
    	</div>
     
    <table >
    	<tr align="center">
	    	<td width="10%">국가</td>
	    		<td width="20%">
	    			<%=pi.getPi_country() %>
	    		</td>
    		<td width="10%">도시</td>
    		<td width="20%">
    			<%=pi.getCc_name() %>
    		</td>
    		<td  width="10%">기간</td>
    		<td  width="*"><input type="text" id="period" name="period" value="<%=pi.getPi_period() %>"></td>
    	
    	</tr>
    	
    	<br /><p style="font-size: 13px; color: red;">*항공편 a:이코노미 b:비지니스 c:퍼스트</p>
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
    		<td ><input type="text" name="quantity" value="<%=pi.getPi_stock() %>"></td>
    	</tr>
    </table>
    <br />
    <table>
    	<tr>
    		<td>패키지 가격</td>
    		<td id="sumPrice"><%=pi.getPi_price() %></td>
    	</tr>
    </table>
    <br />
    <p style="font-size: 13px; color: red;">*출국일 , 입국일은 관광상품을 등록할 수 없습니다.</p>
    <input type="button" value="일정표 열기" onclick="block()">
    <input type="button" value="일정표 초기화" onclick="init()">
    
    <div id ="tour_container">
    	
    	<table class="daybyTour" width="100%;">
    		<tr>
    			<th colspan="2">1일차 일정표</th>
    		<tr>
    		<tr>
    			<td><input type="text" id="day1" name ="day1" placeholder="출국일과 입국일은 선택할수 없습니다." value="출국일" readonly="readonly"></td>
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
			document.getElementById('day1').value="출국일은 선택할 수 없습니다.";
			document.getElementById('day2').value="자유여행";
			document.getElementById('day3').value="자유여행";
			document.getElementById('day4').value="자유여행";
			document.getElementById('day5').value="자유여행";
			document.getElementById('day6').value="자유여행";
			document.getElementById('day7').value="자유여행";
		
		}
	}
	</script>	
    	
    	
    	
    	
    	
    	
    </div>
    
    <br />
    
    <table>
    	<tr><td>성인가격 : </td><td><input type="text" name= "piadult" value="<%=pi.getPi_adult() %>"></td>
    	<td>아동가격 : </td><td><input type="text" name= "pichild" value="<%=pi.getPi_child() %>"></td></tr>
    </table>
   
    
    <table>
    	<tr>
    	<td width="15%">상품 설명 : </td>
    	<td width="*"><input type="text" name= "summary" value="" placeholder="summary" style="width : 750px;"></td>
    	</tr>    	
    </table>
    
    <table>
    <tr>
	    <td>스페셜혜택</td>
	    <td><input type="text" name= "pispecial" placeholder="EX)기사,가이드포함" value="<%=pi.getPi_special() %>" style="width : 750px;"></td>
    </tr>
    <tr>
	    <td>식사</td>
	    <td><input type="text" name= "pifood" placeholder="EX)호텔조식,씨푸드" value="<%=pi.getPi_food() %>" style="width : 750px;"></td>
    </tr>
     
    </table>
    
<script>
function makePnidx(){
	if(ccidtmp==""){
		alert('도시를 먼저 선택해주세요');
		return;
	}
	var pninsur = document.getElementsByName("pninsur").innerText;
	var pnguide = document.getElementsByName("pnguide").innerText;
	var pninclude = document.getElementsByName("pninclude").innerText;
	var pndeclude = document.getElementsByName("pndeclude").innerText;
	var pnwarning = document.getElementsByName("pnwarning").innerText;
	var pnsafe = document.getElementsByName("pnsafe").innerText;
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
						
						
						if(chk != 1){	// 생성 실패했을 경우 
							alert("유의사항 생성에 실패했습니다. \n 다시 시도해 보세요.")
							return;
						}else{
							alert("유의사항 생성 성공!");
							document.frm.newpnidx.value=idx;
										
						}				
					}
			})
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
	    		<input type="button" value ="생성" onclick="makePnidx()">
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
    </form>
</main>

</body>
</html>