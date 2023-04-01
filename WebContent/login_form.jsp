<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String url = request.getParameter("url");	// 로그인 후 이동할 페이지 주소
if (url == null) url = "index";
%>
<style>
.login {border: 1px solid lightgrey; border-radius:10px; width: 400px; padding: 30px; margin: 0 auto; margin-top: 150px;}
h2 {color:green;}
input[type=text] {width: 200px; border:none; border-bottom: 1px solid lightgrey; font-size: 1.2em;}
input[type=password] {width: 200px; border:none; border-bottom: 1px solid lightgrey; font-size: 1.2em;}
input[type=submit] {width: 100px; height: 30px;}
input[type=button] {width: 210px; height: 30px;}
input[name=join]{width:100px;}
input:focus {outline: none;}
h2{margin-top:0px;}
</style>
<div class="login" align="center">
	<h2>GREEN TOUR</h2>
	<form name="frmLogin" action="login" method="post">
		<input type="hidden" name="url" value="<%=url %>" />아이디&nbsp;&nbsp;&nbsp;&nbsp;: 
		<input type="text" name="uid" value="test1" />
		<br />
		<br /> 비밀번호 : <input type="password" name="pwd" value="1234" /><br /><br />
		<br /> <input type="submit" value="로그인" />&nbsp;
		<input name="join" type="button"
			value="회원가입" onclick="location.href='join_form'" />
			<div style="margin:20px;"></div>
		<input type="button" value="아이디/비밀번호 찾기" onclick="location.href='sch_id_form'" /> 
	</form>
</div>
</body>
</html>