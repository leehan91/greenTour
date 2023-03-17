<%@page import="vo.PackageTour"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
PackageTour pt = (PackageTour)request.getAttribute("tourinfo");
String name = pt.getPt_name();
String addr = pt.getPt_addr();
String desc = pt.getPt_desc();
String summary = pt.getPt_summary();
String ptimg = pt.getPt_image();
String hpage = pt.getPt_page();
if(hpage.equals(""))hpage="무료";
int price = pt.getPt_price();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<style>
body{
margin:0px;
   	padding:0px;
}
.pur_main_container{
   	width:700px;
   	margin:0px;
   	padding:0px;
}

.gallery{
    display: block;    
    /* height: 800px; */
    min-height: 450px;
    position: relative;
    overflow: hidden;
}

.gallery_images{
    width: 100%;
    height: 100%;
    position: relative;
    top:0;
    object-fit:cover;
}

.gallery_images > div{
    width: 700px;
    height: 450px;
    position: absolute;
    top: 0;
    left: 0;
    overflow:hidden    
}

.gallery_images img {
    width: 100%;
    height:100%;
    object-fit:cover;  
}


.right_panel{
	padding:20px;
	margin: 0 auto;
}

.right_panel > div{margin:0;}
.right_panel > div > div {height:100px;}

.right_panel > div > ul > li {padding:5px;}

</style>

<section class="pur_main_container">

		<div class="gallery">

            <div class="gallery_images">
                <div class="image01"><img src="front/img/<%=ptimg%>"/></div>
            </div>
        </div>

		<div class="right_panel">
            <div>
                <div>
                	
                    <h2><%=name %></h2>             
                    <p>가격 : <%if(price==0){%> 무료 <% }else { %><%=price%>원(1인당)<% } %> </p><br>
                </div>

                <ul>
                    <li>주소 : <%=addr%></li>
                    <li>홈페이지 : <%=hpage %></li>
                    <li>투어 설명 : <br /><%=summary %></li>
                    <li>투어 상세 : <br /><%=desc %></li>
                </ul>               
            </div>
		</div>
</section>





</body>
</html>