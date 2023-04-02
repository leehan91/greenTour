<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head_admin.jsp" %>
<script src="/greenTour/js/utils.js"></script>
<script src="/greenTour/js/Chart.min.js"></script>
<%
request.setCharacterEncoding("utf-8");

CalendarInfo ci = (CalendarInfo)request.getAttribute("ci");
// 달력 출력을 위한 정보(현재 연월일, 검색 연월) 들을 저장하고 있는 인스턴스
StatInfo pa = (StatInfo)request.getAttribute("pa");
StatInfo mp = (StatInfo)request.getAttribute("mp");

StatInfo si1 = (StatInfo)request.getAttribute("si1");	StatInfo si2 = (StatInfo)request.getAttribute("si2");

StatInfo sp1 = (StatInfo)request.getAttribute("sp1");	StatInfo sp2 = (StatInfo)request.getAttribute("sp2");
StatInfo sp3 = (StatInfo)request.getAttribute("sp3");	StatInfo sp4 = (StatInfo)request.getAttribute("sp4");
StatInfo sp5 = (StatInfo)request.getAttribute("sp5");	StatInfo sp6 = (StatInfo)request.getAttribute("sp6");
StatInfo sp7 = (StatInfo)request.getAttribute("sp7");	StatInfo sp8 = (StatInfo)request.getAttribute("sp8");
StatInfo sp9 = (StatInfo)request.getAttribute("sp9");	StatInfo sp10 = (StatInfo)request.getAttribute("sp10");
StatInfo sp11 = (StatInfo)request.getAttribute("sp11");	StatInfo sp12 = (StatInfo)request.getAttribute("sp12");

StatInfo sm1 = (StatInfo)request.getAttribute("sm1");	StatInfo sm2 = (StatInfo)request.getAttribute("sm2");
StatInfo sm3 = (StatInfo)request.getAttribute("sp3");	StatInfo sm4 = (StatInfo)request.getAttribute("sm4");
StatInfo sm5 = (StatInfo)request.getAttribute("sp5");	StatInfo sm6 = (StatInfo)request.getAttribute("sm6");
StatInfo sm7 = (StatInfo)request.getAttribute("sp7");	StatInfo sm8 = (StatInfo)request.getAttribute("sm8");
StatInfo sm9 = (StatInfo)request.getAttribute("sp9");	StatInfo sm10 = (StatInfo)request.getAttribute("sm10");
StatInfo sm11 = (StatInfo)request.getAttribute("sp11");	StatInfo sm12 = (StatInfo)request.getAttribute("sm12");

StatInfo pak = (StatInfo)request.getAttribute("statP");StatInfo mpk = (StatInfo)request.getAttribute("statM");
StatInfo rq = (StatInfo)request.getAttribute("rq");StatInfo rqYes = (StatInfo)request.getAttribute("rqYes");StatInfo rqNo = (StatInfo)request.getAttribute("rqNo");
StatInfo member = (StatInfo)request.getAttribute("member");StatInfo memberA = (StatInfo)request.getAttribute("memberA");
StatInfo memberB = (StatInfo)request.getAttribute("memberB");StatInfo memberD = (StatInfo)request.getAttribute("memberD");
StatInfo pRate = (StatInfo)request.getAttribute("pRate");StatInfo mRate = (StatInfo)request.getAttribute("mRate");


ArrayList<StatInfo> palist = (ArrayList<StatInfo>)request.getAttribute("palist");
ArrayList<StatInfo> mplist = (ArrayList<StatInfo>)request.getAttribute("mplist");


String[] arr = {"'1월'", "'2월'", "'3월'", "'4월'", "'5월'", "'6월'", "'7월'", "'8월'", "'9월'", "'10월'", "'11월'", "'12월'"};
%>
<%
/* int sy = ci.getsYear(), sm = ci.getsMonth();
String month = "";
StatInfo spa = new StatInfo(); 
StatInfo smp = new StatInfo();
StatInfo paT = new StatInfo();
if (sm <= 6){
	for (int i = 0; i < 6; i++){
		month = arr[i];
		spa = palist.get(i);
		smp = mplist.get(i);
	}	
}else if(sm > 6){
	for (int i = 6; i < 11; i++){
		month = arr[i];
		spa = palist.get(i);
		smp = mplist.get(i);
	}	
} */

%>
<style>
.side_menu ul, li {list-style : none; margin: 0; padding: 0;}

.ctg {border : 1px solid black; margin: 5px; background-color : greenyellow;}
.ctg a{width: 100%; cursor:pointer; text-decoration: none; }
.ctg ul {background-color : white;}
.ctg .hide{display:none;}

canvas {
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
}

#body_container {text-align : center; width: 830px;}
#num_box {border : 1px solid grey; margin : 30px auto; display : flex; justify-content: space-around;}

.statBox {display : flex; justify-content: space-around; text-align: left; margin : 10px auto; border : 1px solid black; width:830px; }
.statBox div {padding : 10px 20px;}
.statBox ul {padding : 0;}
.statBox li {list-style: none; padding : 0 5px;}

</style>

<script>
$(document).ready(function(){
    $(".side_menu> .ctg > a").click(function(){
        var submenu = $(this).next("ul");
        if( submenu.is(":visible") ){
            submenu.slideUp();
	  }else{
            submenu.slideDown();
        }
    });
});
</script>
<script>
var color = Chart.helpers.color;
var barChartData = {
	labels: [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	datasets: [{
		label: '패키지',
		backgroundColor: color(window.chartColors.red).alpha(0.7).rgbString(),
		borderColor: window.chartColors.red,
		borderWidth: 1,
		data: [<%=sp1.getSi_paAmount() %>, <%=sp2.getSi_paAmount() %>, <%=sp3.getSi_paAmount() %>, <%=sp4.getSi_paAmount() %>
		, <%=sp5.getSi_paAmount() %>, <%=sp6.getSi_paAmount() %>, <%=sp7.getSi_paAmount() %>, <%=sp8.getSi_paAmount() %>
		, <%=sp9.getSi_paAmount() %>, <%=sp10.getSi_paAmount() %>, <%=sp11.getSi_paAmount() %>, <%=sp12.getSi_paAmount() %>]
	}, {
		label: '나만의',
		backgroundColor: color(window.chartColors.blue).alpha(0.7).rgbString(),
		borderColor: window.chartColors.blue,
		borderWidth: 1,
		data: [<%=sm1.getSi_mpAmount() %>, <%=sm2.getSi_mpAmount() %>, <%=sm3.getSi_mpAmount() %>, <%=sm4.getSi_mpAmount() %>
		, <%=sm5.getSi_mpAmount() %>, <%=sm6.getSi_mpAmount() %>, <%=sm7.getSi_mpAmount() %>, <%=sm8.getSi_mpAmount() %>
		, <%=sm9.getSi_mpAmount() %>, <%=sm10.getSi_mpAmount() %>, <%=sm11.getSi_mpAmount() %>, <%=sm12.getSi_mpAmount() %>]
	}, {
		label: '총 판매',
		backgroundColor: color(window.chartColors.green).alpha(0.7).rgbString(),
		borderColor: window.chartColors.green,
		borderWidth: 1,
		data: [<%=sp1.getSi_paAmount() +  sm1.getSi_mpAmount()%>, <%=sp2.getSi_paAmount() +  sm2.getSi_mpAmount()%>, 
			<%=sp3.getSi_paAmount() +  sm3.getSi_mpAmount()%>, <%=sp4.getSi_paAmount() +  sm4.getSi_mpAmount() %>,
		 	<%=sp5.getSi_paAmount() +  sm5.getSi_mpAmount()%>, <%=sp6.getSi_paAmount() +  sm6.getSi_mpAmount()%>, 
			<%=sp7.getSi_paAmount() +  sm7.getSi_mpAmount()%>, <%=sp8.getSi_paAmount() +  sm8.getSi_mpAmount()%>,
		 	<%=sp9.getSi_paAmount() +  sm9.getSi_mpAmount()%>, <%=sp10.getSi_paAmount() +  sm10.getSi_mpAmount()%>, 
			<%=sp11.getSi_paAmount() +  sm11.getSi_mpAmount()%>, <%=sp12.getSi_paAmount() +  sm12.getSi_mpAmount()%>]
	}
	]
};


window.onload = function() {
	var ctx = document.getElementById('canvas').getContext('2d');
	window.myBar = new Chart(ctx, {
		type: 'bar',
		data: barChartData,
		options: {
			responsive: true,
			legend:{ position:'top' }
		}
	});
};
</script>


<main class="side_menu">
	<ul class="ctgr">
		<li><a href="member_list">회원 관리</a></li><hr />
		<li><a href="">도시 관리</a></li><hr />
		<li><a href="">게시판 관리</a></li><hr />
		<li><a href="/greenTour/admin_package_list">상품 관리</a></li><hr />
		<li><a href="">고객센터</a></li><hr />
		<li>
			<a>통계</a><br/>
			<span><strong>&nbsp;&nbsp;&nbsp;<a href="/greenTour/admin_amount"> - 통계 홈</a><br/></strong></span>
			<span>&nbsp;&nbsp;&nbsp;<a href="/greenTour/admin_city"> - 도시별 판매액</a></span>
		</li>
	</ul>

	<div id = "body_container">
		<h2>  <%=ci.getsYear()  %> 그린투어 </h2>
		<div id="container">
			<canvas id="canvas">
			</canvas>
		</div>
		
		<div id = "num_box">
			<div>
			<h3>이번 달 </h3>
				<p> 패키지  판매액 :<%=si1.getSi_paAmount() %> 원</p>
				<p> 나만의  판매액 :<%=si2.getSi_mpAmount()%>  원</p>
				<p> 총 판매액  판매액 :<%=si1.getSi_paAmount() + si2.getSi_mpAmount() %> 원</p>
			</div>
			<div>
			<h3><%=ci.getsYear()  %> 판매 누적액 </h3>
				<p> 패키지  판매액 :<%=sp1.getSi_paAmount() + sp2.getSi_paAmount() + sp3.getSi_paAmount() + sp4.getSi_paAmount() + sp5.getSi_paAmount() + sp6.getSi_paAmount()
				+ sp7.getSi_paAmount() + sp8.getSi_paAmount() + sp9.getSi_paAmount() + sp10.getSi_paAmount() + sp11.getSi_paAmount() +  sp12.getSi_paAmount() %> 원</p>
				<p> 나만의  판매액 :<%=sm1.getSi_mpAmount() + sm2.getSi_mpAmount() + sm3.getSi_mpAmount() + sm4.getSi_mpAmount() + sm5.getSi_mpAmount() + sm6.getSi_mpAmount() 
				+ sm7.getSi_mpAmount() + sm8.getSi_mpAmount() + sm9.getSi_mpAmount() + sm10.getSi_mpAmount() + sm11.getSi_mpAmount() + sm12.getSi_mpAmount() %> 원</p>
				<p> 총 판매액  판매액 :<%=sp1.getSi_paAmount() + sp2.getSi_paAmount() + sp3.getSi_paAmount() + sp4.getSi_paAmount() + sp5.getSi_paAmount() + sp6.getSi_paAmount()
				+ sp7.getSi_paAmount() + sp8.getSi_paAmount() + sp9.getSi_paAmount() + sp10.getSi_paAmount() + sp11.getSi_paAmount() +  sp12.getSi_paAmount() +  
				sm1.getSi_mpAmount() + sm2.getSi_mpAmount() + sm3.getSi_mpAmount() + sm4.getSi_mpAmount() + sm5.getSi_mpAmount() + sm6.getSi_mpAmount() 
				+ sm7.getSi_mpAmount() + sm8.getSi_mpAmount() + sm9.getSi_mpAmount() + sm10.getSi_mpAmount() + sm11.getSi_mpAmount() + sm12.getSi_mpAmount()%> 원</p>
			</div>
		</div>
	
	<div class = "statBox">
		<div name = "rateStat" style = "width :30%" >
			<h3>판매량 통계</h3>
			<ul>
				<li>패키지 판매량 :<%=pak.getSi_pNum() %> </li>
				<li>나만의 패키지 판매량 :<%=mpk.getSi_mNum() %> </li>
				<li>총 판매량 : <%=pak.getSi_pNum() +  mpk.getSi_mNum()%></li>
			</ul>
		</div>
		<div name = "amountStat" style = "width :35%">
			<h3>판매액 통계</h3>
			<ul>
				<li>패키지 판매액 :<%=pak.getSi_paAmount() %> 원</li>
				<li>나만의 패키지 판매액 :<%=mpk.getSi_mpAmount() %> 원</li>
				<li>총 판매액 :<%=pak.getSi_paAmount() + mpk.getSi_mpAmount() %> 원</li>
			</ul>
		</div>	
		<div name = "memberStat" style = "width :15%">
			<h3>회원 수</h3>
			<ul>
				<li>전체 : <%=member.getSi_member() %></li>
				<li>정상 회원:<%=memberA.getSi_memberA() %> </li>
				<li>휴면 회원:<%=memberB.getSi_memberB() %> </li>
				<li>탈퇴 회원:<%=memberD.getSi_memberD() %> </li>
			</ul>
		</div>	
		<div name = "rqStat" style = "width :20%">
			<h3>문의 글</h3>
			<ul>
				<li>전체 :<%=rq.getSi_TotalReq() %> </li>
				<li><a href="">답변 미완료:<%=rqNo.getSi_NoReq() %> </a></li>
				<li>답변 완료:<%=rqYes.getSi_YesReq() %> </li>
			</ul>
		</div>		
		
	</div>

</div>


</body>
</html>