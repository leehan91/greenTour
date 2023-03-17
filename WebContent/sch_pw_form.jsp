<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String url = request.getParameter("url");	// 로그인 후 이동할 페이지 주소
if (url == null) url = "login_form";
MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
%>
<style>
.login {
	border:1px solid black;
	width:500px; margin:0 auto; margin-top:300px;
}
input[type=text] {width:250px;}
#num {width:100px;}
input[type=password] {width:100px;}
input[type=submit] {width:200px; height:30px;}
input[type=button] {width:100px; height:30px; margin:0 auto;}
#p {width:200px; margin:0 auto;}

</style>
<div class="login" align="center">
	<h2 align="center">아이디 / 비밀번호 찾기</h2>
	<form name="frmSch" action="schPw" method="post">
		<input type="hidden" name="url" value="<%=url %>" />
		<input type="button" value="아이디 찾기" onclick="location.href='sch_id_form';"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="비밀번호 찾기" onclick="location.href='sch_pw_form';"/><br /><br />
		아이디 : <input type="text" name="uid" size="6"/><br /><br />
		이름 : <input type="text" name="name" /><br /><br />
		주민등록번호 : <input type="text" name="regist1" id="num" size="6" maxlength="6" onkeyup="onlyNum(this);"/> - 
		<input type="password" name="regist2" size="7" maxlength="7" onkeyup="onlyNum(this);" /><br /><br /><br />
		<p id="p"><input type="submit" value="확인" /></p><br />
	</form>
</div>
</body>
</html>