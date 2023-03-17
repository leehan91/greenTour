<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String url = request.getParameter("url");	// 로그인 후 이동할 페이지 주소
if (url == null) url = "index.jsp";
%>
<style>
.login {
	border:1px solid black;
	width:500px; margin:0 auto; margin-top:300px; }
h2 {color:green;}
input[type=text] {width:200px;}
input[type=password] {width:200px;}
input[type=submit] {width:200px; height:30px;}
input[type=button] {width:200px; height:30px;}
</style>
<div class="login" align="center">
	<h2>그린 투어</h2>
	<form name="frmLogin" action="login" method="post">
		<input type="hidden" name="url" value="<%=url %>" />
		&nbsp;&nbsp;아이디 : <input type="text" name="uid" value="test1"/><br /><br />
		비밀번호 : <input type="password"  name="pwd" value="1234"/><br /><br />
		<input type="submit" value="로그인" /><br /><br />
		<input type="button" value="아이디/비밀번호 찾기" onclick="location.href='sch_id_form'" />
		<input type="button" value="회원가입" onclick="location.href='join_form'" />
	</form>
</div>
</body>
</html>