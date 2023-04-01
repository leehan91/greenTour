<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head_admin.jsp" %>
<%
CalendarInfo ci = (CalendarInfo)request.getAttribute("ci");

StatInfo hkgp = (StatInfo)request.getAttribute("hkgp");
StatInfo jpnp = (StatInfo)request.getAttribute("jpnp");
StatInfo phlp = (StatInfo)request.getAttribute("phlp");
StatInfo sgpp = (StatInfo)request.getAttribute("sgpp");
StatInfo thap = (StatInfo)request.getAttribute("thap");
StatInfo twnp = (StatInfo)request.getAttribute("twnp");
StatInfo vnmp = (StatInfo)request.getAttribute("vnmp");

StatInfo hkgm = (StatInfo)request.getAttribute("hkgm");
StatInfo jpnm = (StatInfo)request.getAttribute("jpnm");
StatInfo phlm = (StatInfo)request.getAttribute("phlm");
StatInfo sgpm = (StatInfo)request.getAttribute("sgpm");
StatInfo tham = (StatInfo)request.getAttribute("tham");
StatInfo twnm = (StatInfo)request.getAttribute("twnm");
StatInfo vnmm = (StatInfo)request.getAttribute("vnmm");

String[] ccArr = {"HKG", "JPN", "PHL", "SGP", "THA", "TWN", "VNM"};

StatInfo si = new StatInfo(); 
%>
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
	labels: ['홍콩', '일본', '필리핀', '싱가포르', '태국', '대만', '베트남'],
	datasets: [{
		label: '패키지',
		backgroundColor: color(window.chartColors.red).alpha(0.8).rgbString(),
		borderColor: window.chartColors.red,
		borderWidth: 1,
		data: [<%=hkgp.getSi_ccPaAmount() %>, <%=jpnp.getSi_ccPaAmount() %>, <%=phlp.getSi_ccPaAmount() %>,
				<%=sgpp.getSi_ccPaAmount() %>, <%=thap.getSi_ccPaAmount() %>, <%=twnp.getSi_ccPaAmount() %>, <%=vnmp.getSi_ccPaAmount() %>
		]
	}, {
		label: '나만의',
		backgroundColor: color(window.chartColors.blue).alpha(0.8).rgbString(),
		borderColor: window.chartColors.blue,
		borderWidth: 1,
		data: [
			<%=hkgm.getSi_ccMpAmount() %>, <%=jpnm.getSi_ccMpAmount() %>, <%=phlm.getSi_ccMpAmount() %>,
			<%=sgpm.getSi_ccMpAmount() %>, <%=tham.getSi_ccMpAmount() %>, <%=twnm.getSi_ccMpAmount() %>, <%=vnmm.getSi_ccMpAmount() %>
				]
	}, {
		label: '총 판매',
		backgroundColor: color(window.chartColors.green).alpha(0.8).rgbString(),
		borderColor: window.chartColors.blue,
		borderWidth: 1,
		data: [<%=hkgp.getSi_ccPaAmount() + hkgm.getSi_ccMpAmount()%>, <%=jpnp.getSi_ccPaAmount() + jpnm.getSi_ccMpAmount()%>, 
				<%=phlp.getSi_ccPaAmount() + phlm.getSi_ccMpAmount() %>, <%=sgpp.getSi_ccPaAmount() + sgpm.getSi_ccMpAmount() %>, 
				<%=thap.getSi_ccPaAmount() +  tham.getSi_ccMpAmount()%>, <%=twnp.getSi_ccPaAmount() + twnm.getSi_ccMpAmount()%>, 
				<%=vnmp.getSi_ccPaAmount() + vnmm.getSi_ccMpAmount() %>]
	}
	]
};
var config = {
		   type: 'pie',
		   data: {
		      datasets: [{
		         data: [<%=hkgp.getSi_ccPaAmount() + hkgm.getSi_ccMpAmount()%>, <%=(jpnp.getSi_ccPaAmount() + jpnm.getSi_ccMpAmount()) / 10 %>, 
		            <%=phlp.getSi_ccPaAmount() + phlm.getSi_ccMpAmount() %>, <%=sgpp.getSi_ccPaAmount() + sgpm.getSi_ccMpAmount() %>, 
		            <%=thap.getSi_ccPaAmount() +  tham.getSi_ccMpAmount()%>, <%=twnp.getSi_ccPaAmount() + twnm.getSi_ccMpAmount()%>,
		            <%=vnmp.getSi_ccPaAmount() + vnmm.getSi_ccMpAmount() %>], 
		         backgroundColor: [
		            window.chartColors.grey,
		            window.chartColors.red,
		            window.chartColors.orange,
		            window.chartColors.blue,
		            window.chartColors.green,
		            window.chartColors.yellow,
		            window.chartColors.purple

		         ],
		         label: '점유율'
		      }],
		      labels: ["홍콩", "일본", "필리핀", "싱가포르", "태국", "대만", "베트남"]
		   },
		   options: { responsive:true, title:{ display:true, text:'도시별 점유율' } }
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
	var ctx2 = document.getElementById('chart-area').getContext('2d');
	window.myPie = new Chart(ctx2, config);
};
</script>

<style>
.side_menu ul, li {list-style : none; margin: 0; padding: 0;}


#body_container {width : 830px; text-align : center;}
#canvas-holder {margin: 30px auto; }
</style>

<main class="side_menu">
	<ul class="ctgr">
		<li><a href="member_list">회원 관리</a></li><hr />
		<li><a href="">도시 관리</a></li><hr />
		<li><a href="">게시판 관리</a></li><hr />
		<li><a href="/greenTourSite/admin_package_list">상품 관리</a></li><hr />
		<li><a href="">고객센터</a></li><hr />
		<li>
			<a>통계</a><br/>
			<span>&nbsp;&nbsp;&nbsp;<a href="/greenTourSite/admin_amount"> - 통계 홈</a><br/></span>
			<span><strong>&nbsp;&nbsp;&nbsp;<a href="/greenTourSite/admin_city"> - 도시별 판매액</a></strong></span>			
		</li>
	</ul>


	<div id = "body_container">
		<h2> <%=ci.getsYear() %>년  <%=ci.getcMonth() %>월 도시 별 매출</h2>
		
		<div id="container">
			<canvas id="canvas"></canvas>
		</div>
	
		<div id="canvas-holder" style = "width : 830px;">
			<canvas id="chart-area"></canvas>
		</div>	
	</div>
</main>
</body>
</html>
