<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head_admin.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String url = request.getParameter("url");	// 로그인 후 이동할 페이지 주소
if (url == null) url = "admin/admin_mainpage.jsp";
%>
<style>
.login {width:500px; margin:256px auto;}
#frm {border:1px solid black;}
</style>
<div class="login">
	<h2>관리자 로그인</h2>
	<form id="frm" action="/greenTour/member_info" align="center" method="post"><br/><br/>
		<input type="hidden" name="url" value="<%=url %>" />
		아이디 : <input type="text" name="uid" value="admin1" placeholder="아이디를 입력하세요" style="height:30px;" /><br/><br/>
		비밀번호 : <input type="password" name="pwd" value="1234" placeholder="비밀번호를 입력하세요" style="height:30px;" /><br/><br/>
		<p style="margin-bottom:30px;"><input type="submit" value="로그인" style="width:150px; height:30px;"/></p>
	</form>
</div>
</body>
</html>