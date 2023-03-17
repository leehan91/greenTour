<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head_admin.jsp" %>
<style>
ul, li, a{list-style: none; padding:0; color:#000; text-decoration:none;}

.main {display:flex; justify-content:space-between; margin-top:100px;}
.bar {width:200px;}
.welcome {width:830px; margin:0 auto;}
</style>
<div class="main">
	<div class="bar">
		<ul class="ctgr">
	      <li><a href="/greenTourSite/member_list">회원 관리</a></li><hr />
	      <li><a href="">도시 관리</a></li><hr />
	      <li><a href="">게시판 관리</a></li><hr />
	      <li>
	         <a href="/greenTourSite/admin_package_list">상품 관리</a><br />
	         <span>&nbsp;&nbsp;&nbsp;<a href="/greenTourSite/admin_package_list"> - 패키지 관리</a></span><br />
	         <span>&nbsp;&nbsp;&nbsp;<a href="/greenTourSite/hotel_list"> - 호텔 관리</a></span><br />
	         <strong>&nbsp;&nbsp;&nbsp;<a href="/greenTourSite/tour_list"> - 관광 상품 관리</a></strong><br />
	      </li><hr />
	      <li><a href="">고객센터</a></li><hr />
	      <li><a href="/greenTourSite/admin_amount">통계</a></li>
	   </ul>
	</div>
	<div class="welcome">
		<h2 align="center">환영합니다.</h2>
		<form action="/greenTourSite/member_list" align="center">
			<input type="submit" value="관리하기" style="width:300px; height:150px; margin:0 auto;"/>
		</form>
	</div>
</div>
</body>
</html>