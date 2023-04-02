<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head_admin.jsp" %>
<style>

.welcome {width:830px;}
</style>
<main class="side_menu">
	<ul class="ctgr">
		<li><a href="/greenTour/member_list">회원 관리</a></li><hr />
		<li><a href="">도시 관리</a></li><hr />
		<li><a href="">게시판 관리</a></li><hr />
		<li><a href="/greenTour/admin_package_list">상품 관리</a></li><hr />
		<li><a href="/greenTour/admin_pareview_list">고객센터</a></li><hr />
		<li><a href="/greenTour/admin_amount">통계</a></li>
	</ul>	
	<div class="welcome">
		<h2 align="center">환영합니다.</h2>
		<form action="member_list" align="center">
			<input type="submit" value="관리하기" style="width:300px; height:150px; margin:0 auto;"/>
		</form>
	</div>
</main>
</body>
</html>