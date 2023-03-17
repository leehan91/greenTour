<%@page import="vo.HotelInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
HotelInfo hi = (HotelInfo)request.getAttribute("hotelinfo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="./css/mypacakge_hotel_pop.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script defer src="./js/mypackage_hotel_pop.js"></script>
<script>

</script>
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

.thumbs{
    display: block;
    position: absolute;
    left: 2rem;
    top: 2rem;
}

.thumbs > div {
    width: 80px;
    height:50px;
    margin: 15px 0;
    border: 1px solid #fff;
    cursor: pointer;
    overflow:hidden
}
.thumbs img {
	width: 100%;
	height: 100%;
	object-fit:cover;
	
	
}

.right_panel{
	padding:20px;
	margin: 0 auto;
}

.right_panel > div{margin:0;}
..right_panel > div > div {height:100px;}

#star{margin:0; padding:0;}

.right_panel > div > ul > li {padding:5px;}

</style>

<section class="pur_main_container">

		<div class="gallery">

            <div class="gallery_images">
                <div class="image01"><img src="front/img/<%=hi.getHi_img1()%>"/></div>
                <div class="image02"><img src="front/img/<%=hi.getHi_img2()%>"/></div>
                <div class="image03"><img src="front/img/<%=hi.getHi_img3()%>"/></div>
                <div class="image04"><img src="front/img/<%=hi.getHi_img4()%>"/></div>
                <div class="image05"><img src="front/img/<%=hi.getHi_img5()%>"/></div>
            </div>

            <div class="thumbs">
                <div class="thumb01"><img src="front/img/<%=hi.getHi_img1()%>"/></div>
                <div class="thumb02"><img src="front/img/<%=hi.getHi_img2()%>"/></div>
                <div class="thumb03"><img src="front/img/<%=hi.getHi_img3()%>"/></div>
                <div class="thumb04"><img src="front/img/<%=hi.getHi_img4()%>"/></div>
                <div class="thumb05"><img src="front/img/<%=hi.getHi_img5()%>"/></div>
               
            </div>

        </div>

		<div class="right_panel">
            <div>
                <div>
                	
                    <h2><%=hi.getHi_name() %></h2>
                    <p id="star">
                    <%for(int i = 0; i < Integer.parseInt(hi.getHi_grade()); i++){ %>
					★
					<% } %>
					(<%=hi.getHi_grade() %>성급 호텔)</p>
                    <p><%=hi.getHi_standard() %> 원 부터 ~ </p><br>
                </div>

                <ul>
                    <li>호텔 주소 : <%=hi.getHi_addr() %></li>
                    <li>호텔 전화번호 : <%=hi.getHi_tel() %></li>
                    <li>호텔 설명 : <br /><%=hi.getHi_desc() %></li>
                    <li>호텔 유의사항 : <br /><%=hi.getHi_notice() %></li>
                </ul>

                
            </div>
		</div>
</section>

</body>
</html>