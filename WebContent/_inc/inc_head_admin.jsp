<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ page import="vo.*" %>
<%
AdminInfo adminLoginInfo = (AdminInfo)session.getAttribute("adminLoginInfo");
boolean isLogin = false;
String aiid = "", ainame = "";
if (adminLoginInfo != null) { 
	isLogin = true;
	aiid = adminLoginInfo.getAi_id();
}

// 로그인 여부를 판단할 변수 isLogin 생성
%>
<style>
body{ max-width: 1130px; margin: 0 auto; }
a{color:black; text-decoration: none;}
li{list-style: none;}
header{width: 1130px; 
    margin: 0 auto;
}
</style>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="/greenTour/js/jquery-3.6.1.js"></script>
<script src = "/greenTour/js/utils.js"></script>
<script src = "/greenTour/js/Chart.min.js"></script>
<style>
.m_menu { width:1130px; 
    display: flex;
    flex-wrap: wrap;
    justify-content: flex-end;
    
}

.m_menu p {
	border:1px solid lightgrey; line-height: 40px;
    width:90px; height: 40px; border-radius: 10px;
    display:inline-block; text-align: center;
}

.m_menu a {
    margin:5px 5px;   
    text-decoration-line: none;
}
</style>
<body>
	<header>
		<div class="m_menu">
				<%if(!isLogin){ %>
                <p><a href="/greenTourSite/admin/admin_index.jsp"><span class="my_menu">로그인</span></a></p>
                <%} else { %>
                <p><a href="/greenTourSite/admin/admin_logout.jsp"><span class="my_menu">로그아웃</span></a></p>
                <%} %>
		</div>
	</header>