<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<PackageTour> tourList = (ArrayList<PackageTour>)request.getAttribute("tourList");
MyPackageMy mm = (MyPackageMy)request.getAttribute("mypackagemy");

String ccid = mm.getCc_id();
String city = mm.getMm_destination();
String ficode = mm.getFi_code();
int fridx = mm.getFr_idx();
int adult = mm.getMm_adult();
int child = mm.getMm_child();
int atotal = mm.getMm_atotal();	// atotal = 항공가격
String hicode = mm.getHi_code();
int htotal = mm.getMm_htotal();
String hotel = (String)request.getAttribute("hotel");
String hgrade = mm.getMm_hgrade();
String agrade = mm.getMm_agrade();
String sdate = (String)request.getAttribute("sdate");
String edate = (String)request.getAttribute("edate");
int total = Integer.parseInt((String)request.getAttribute("total"));
String air = (String)request.getAttribute("air");

%>
<style>
.topbar_container{
	display: flex; justify-content: center; 
}
.topbar_container > div {
	margin: 50px; width:150px; height:60px; 
	line-height : 30px; text-align: center; border: 1px solid lightgrey; border-radius: 10px; opacity :0.5;
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
	width: 22%; border:1px solid lightgrey; padding: 20px; border-radius: 5px; font-size: 18px;
}

.mp_sidebar > input { margin: 10 0;}

#on { font-weight: bolder; color: rgb(112,173,71); border : 2px solid lightgrey; opacity:1;}

.inputNum, .passenger {width:25px;}

.tourlist{ width: 820px; border-radius: 5px; border-radius: 5px;}
th, tr, td { border: 1px solid lightgrey; padding: 10px;}

.tourinfo img {width:100%;}

</style>

<script>
const arr = [];
const ptarr = [];
const total = <%=total%>;
function seltour(val, chk){	
	var tmp = val.split('/');
	var ptname = tmp[0];
	var ptcode = ", " + tmp[1];
	var ptprice = parseInt(tmp[2]);
	var tourlist = document.frm.tourlist;
	var tour = ", " + ptname;
	var tourlist = document.getElementById('tourList');
	//배열을 만들어보자 
	
	if(chk){ // 선택 일때
		if(arr.length == 0)	tour = tour.substring(2);	// 투어 이름 
		if(ptarr.length == 0) ptcode = ptcode.substring(2); // ptcode
		
		arr[arr.length] = tour;	// 투어이름을 배열에 넣음
		ptarr[ptarr.length] = ptcode;
		
		var result="";
		var ptresult ="";
		for(var i = 0; i<arr.length; i++){
			result += arr[i];
		}
		for(var j = 0; j<ptarr.length; j++){
			ptresult += ptarr[j];
		}
		
		tourList.innerText = result;
		document.frm.ptcode.value = ptresult;	// ptcode
		
		document.frm.total.value = parseInt(document.frm.total.value) + parseInt(ptprice);
		
	}else{
		//선택 해제 일 경우 
		if(arr.length > 0  ) tour = tour.substring(2);
		if(ptarr.length > 0) ptcode = ptcode.substring(2);
		
		var result=""; var ptresult=""; var tmp = 7; var tmp2 = 7;
		
		for(var i = 0; i<arr.length; i++){
			if( arr[i] == tour || arr[i] == ", " + tour){
				arr.splice(i,1);
				tmp = i;
			}
		}
		
		for(var i = 0; i<arr.length; i++){
			if(tmp==0 && i == 0)arr[i] = arr[i].substring(2);	// 0번 인덱스가 지워졌을 때 
			result += arr[i];
		}
		
		
		/* 아래는 잘못된 코드  */
		/* 	for(var i = 0; i<arr.length; i++){
			if( arr[i] == tour || arr[i] == ", " + tour){
				arr.splice(i,1);
				tmp = i;
			}
		}
		
		for(var i = 0; i<arr.length; i++){
			if(i==0)arr[i].substring(2);	// 0번 인덱스가 지워졌을 때 
			result += arr[i];
		} */
				
		
		for(var j = 0; j<ptarr.length; j++){
			if( ptarr[j] == ptcode || ptarr[j] == ", " + ptcode){
				ptarr.splice(j,1);
				tmp2 = j;
			}
		}
		for(var j = 0; j<ptarr.length; j++){
			if(tmp2 == 0 && j==0)ptarr[j].substring(2);	// 0번 인덱스가 지워졌을 때 
			ptresult += ptarr[j];
		}
		
		
		tourList.innerText = result;
		document.frm.ptcode.value = ptresult;	// ptcode 
		
		document.frm.total.value = parseInt(document.frm.total.value) - parseInt(ptprice);
		
		
	}
	// alert(document.frm.ptcode.value); // ptcode 정상작동 확인
	document.frm.frmtourlist.value = tourlist.value; // frm 안의 frmtourlist 에 동일한 값 넣어주기 (hidden 으로 보내기위해)
	document.frm.ttotal.value = parseInt(document.frm.total.value) - total;
	adjustHeight();
}
// textarea 높이 자동조절 
function adjustHeight() {
	  var textEle = $('textarea');
	  textEle[0].style.height = 'auto';
	  var textEleHeight = textEle.prop('scrollHeight');
	  textEle.css('height', textEleHeight);	  
}

function goReserve(){
	if(document.frm.ptcode.value == ""){
		if(confirm('관광상품을 추가하지 않으실건가요? 확인 클릭시 결제페이지로 이동합니다.')){
			// 관광상품 추가안할시 바로 submit()
			document.frm.submit();
		}else{
			
			return;// 관광상품을 추가하기 위해 취소 누를시. 아무일도 안함.
		}
		
	}else{	// 관광상품을 잘 담았을 때. 
		document.frm.submit();
	}

}
function openPop(ptcode){
	callPop(ptcode);
}

function callPop(val){
	awin = window.open("mypackagetour_pop?ptcode="+val,"tourdesc","left=100,top=50,width=720,height=800","location=no");	
					// 팝업창 객체가 awin 에 들어감 ( 팝업창 주소 / 팝업창 이름 / 팝업창 크기,위치,각종옵션등 )  
}
	


</script>
<div style="margin:50px;"></div>
<div class="topbar_container">
	<div><span>여행지 & 날짜<br />STEP1</span></div>
	<div><span>항공편 <br />STEP2</span></div>
	<div><span>호텔 <br />STEP3</span></div>
	<div id="on"><span>관광상품 <br />STEP4</span></div>
</div>

<div class="mp_all">
	<div class="change">
		<div class="tourlist">
		<form action="#" name="frmtour">
			
			<div class="tourinfo">
				<table width="830" cellpadding="0" cellspacing="0" id="list">
			         <tr>
			            <th width="15%">지역</th>
			            <th width="25%">상품명</th>
			            <th width="30%">상품설명</th>
			            <th width="20%">비용</th>
			            <th width="10%">선택</th>
			            
			         </tr>
			         
			         <%for(int i = 0; i < tourList.size(); i++){
						PackageTour pt = tourList.get(i);
						String ptname = pt.getPt_name();
				
						%>

					   <tr align="center" >
				
					      <td onclick="openPop('<%=pt.getPt_code()%>');"><%=city %></td>
					      <td onclick="openPop('<%=pt.getPt_code()%>');"><%=pt.getPt_name() %></td>
					      <td onclick="openPop('<%=pt.getPt_code()%>');"><%=pt.getPt_summary() %></td>
					      <td align="right" onclick="openPop('<%=pt.getPt_code()%>');"><%=pt.getPt_price() %>원</td>
					      
					      <td>
					      <input type="hidden" id="ptcode<%=i%>" value="<%=pt.getPt_name()+'/'+pt.getPt_code()+'/'+ pt.getPt_price()%>">
					      <input type="checkbox" name="chkBox" id="chktour<%=i%>" value="" onchange="seltour(document.getElementById('ptcode<%=i%>').value,$('#chktour<%=i%>').is(':checked'))">
					      </td>					
	
					   </tr>
					<% } %>
				</table>

			</div>
			</form>
		</div>
	
	</div> <!-- change div end -->

	<div class="mp_sidebar">
		<form name="frm" action="mypackage_main_reserve" method="post">
			
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
			
			호텔 : <input name="hotel" type="text" value="<%=hotel %>" placeholder="호텔" readonly="readonly"><br />			 
				
			등급 : <input name="hgrade" type="text" value="<%=hgrade %>" placeholder="호텔방 등급" readonly="readonly"><hr />
			
			<!-- 관광 상품 : <input name="tourlist" type="text" value="" style="overflow:auto; height:80px;"><hr /> -->
			관광 상품 : <textarea id = "tourList" font-size="3em;" row="1" cols="33" ></textarea>
			
			
				
				 
				 <input name="ccid" type="hidden" value="<%=ccid %>">
				 <input name="ficode" type="hidden" value="<%=ficode %>">
				 <input name="fridx" type="hidden" value="<%=fridx%>">
				 
				 <input name="atotal" type="hidden" value="<%=atotal %>">
				  		 
				 <input name="hicode" type="hidden" value="<%=hicode%>">
				 <input name="htotal" type="hidden" value="<%=htotal%>">
				 
				 <input name="ptcode" type="hidden" value="">
				 <input name="frmtourlist" type="hidden" value="">
				 <input name="ttotal" type="hidden" value="">	
			
			<input type="button" name="ini" value="관광상품 초기화" onclick="location.reload();" ><hr />
			가격 : <input name="total" type="text" value="<%=total%>" placeholder="가격" readonly="readonly" text-align="right"><hr />
			<input type="button" name="prev" value="이전" onclick="history.back();" >
			<input type="button" name="next" value="다음" onclick="goReserve();">		
		</form>				
	</div>
</div>

<div style="margin:50px;"></div>


</body>
</html>