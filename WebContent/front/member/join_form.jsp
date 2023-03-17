<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head.jsp" %>
<%
String[] arrDomain = {"naver.com", "nate.com", "gmail.com"};
%>
<style>
#frm {border:1px solid black;}
#agreement { width: 1125px; height: 200px; overflow: auto; border:1px solid black;}
#joinform {align:center;}
#idMsg { font-size: 0.8em; }
#fontBlue { font-weight: bold; color: blue; }
#fontRed { font-weight: bold; color: red; }
input[type=submit] {width:200px; height:30px; align:center;}
</style>
<script>
	$(document).ready(function() {
		$("#e2").change(function() {
			if ($(this).val() == "") {
				$("#e3").val("");
			} else if ($(this).val() == "direct") {
				$("#e3").val("");
				$("#e3").focus();	
			} else {
				$("#e3").val($(this).val());
			}
		});
	});
/*
	function chkDupId() {
	// 팝업창을 이용한 아이디 중복 체크를 위한 함수
		awin = window.open("member/dup_id_form.jsp", "aa", "width=300, height=200, left=50, top=50");
		// parameter : 팝업창에서 보여줄 파일, 윈도우 이름, 크기 및 위치 지정 
		// 파일 위치 기준점 정확히 체크, 포워딩 등 들어가면 경로 차이 남 //
	}
*/
	
	function chkDupId(uid) {
	// ajax를 이용한 아이디 중복체크를 위한 함수	
		if (uid.length >= 4) {		// 사용자가 입력한 아이디가 4자 이상이면
			$.ajax({	// 데이터 주고 받을 때 사용 //
				type : "POST", 		// 데이터 전송 방법
				url : "/greenTourSite/dupId", 	// 전송한 데이터를 받을 서버의 url(컨트롤러로 서블릿 클래스를 의미)
				data : {"uid" : uid}, 		// 지정한 url로 보낼 데이터의 이름과 값
				success : function(chkRs) {		// 데이터를 보내 실행한 결과를 chkRs로 받아 옴
					if (chkRs == 0) {		// uid와 동일한 기존 회원의 아이디가 없으면
						$("#idMsg").html("<span id='fontBlue'>사용할 수 있는 아이디 입니다.</span>");
						$("#idChk").val("y");		// 아이디 중복 체크를 성공한 상태로 변경
					} else {		// uid와 동일한 기존 회원의 아이디가 있으면
						$("#idMsg").html("<span id='fontRed'>이미 사용중인 아이디 입니다.</span>");
						$("#idChk").val("n");
					}
				}
			});
		} else {		// 사용자가 입력한 아이디가 4자 미만이면 - 성공/실패 상태에서 지우고 다시 입력할 경우 돌아갈 초기 값
			$("#idMsg").text("아이디는 4 ~ 20자로 입력하세요.");
			$("#idChk").val("n");
			// 아이디 중복 체크를 하지 않거나 실패한 상태로 변경
		}
	}
</script>
<br /><br />
<h2>회원 가입</h2>
<form name="frmJoin" id="frm" action="member_proc_in" method="post">
	<input type="hidden" name="idChk" value="n" />		<!-- 아이디 중복 체크를 통해 사용 가능한 아이디를 입력했는지 여부를 가질 컨트롤 -->
	<div id="agreement">
	약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용
	약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용
	약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용
	약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용
	약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용
	약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용
	약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용
	약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용
	약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용
	약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용
	약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용
	약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용
	약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용
	약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 약관 내용
	</div>
	<br /><input type="radio" name="agree" value="y" id="agreeY" />
	<label for="agreeY">동의</label>&nbsp;&nbsp;
	<input type="radio" name="agree" value="n" id="agreeN" />
	<label for="agreeN">미동의</label>
	<br /><br /><hr />
	<div id="joinForm">
		<label id="mi_id">아이디 : </label>
<!--
		<input type="text" name="mi_id" maxlength="20" readonly="readonly" />
		<input type="button" value="중복 검사" onclick="chkDupId();" />
 -->
		<input type="text" name="mi_id" id="mi_id" maxlength="20" onkeyup="chkDupId(this.value);" />
		<span id="idMsg">아이디는 4 ~ 20자로 입력하세요.</span>
		<br /><br />
		<label id="mi_pw1">비밀번호 : </label>
		<input type="password" name="mi_pw1" id="mi_pw1" maxlength="20" />
		<br /><br />
		<label id="mi_pw2">비밀번호 확인: </label>
		<input type="password" name="mi_pw2" id="mi_pw2" maxlength="20" />
		<br /><br />
		<label id="mi_name">이름 : </label>
		<input type="text" name="mi_name" id="mi_name" maxlength="20" />
		<br /><br />성별 : 
		<input type="radio" name="mi_gender" value="남" id="genderM" checked="checked" />
		<label for="genderM">남자</label>
		<input type="radio" name="mi_gender" value="여" id="genderF" />
		<label for="genderF">여자</label>
		<br /><br />
		주민등록번호 : <input type="text" name="mi_registration1" id="num" size="6" maxlength="6" onkeyup="onlyNum(this);"/> - 
		<input type="password" name="mi_registration2" size="7" maxlength="7" onkeyup="onlyNum(this);" /><br /><br />
		휴대폰 : 
		<select name="p1">
			<option>010</option>
			<option>011</option>
			<option>016</option>
			<option>019</option>
		</select> - 
		<input type="text" name="p2" size="4" maxlength="4" onkeyup="onlyNum(this);" /> - 
		<input type="text" name="p3" size="4" maxlength="4" onkeyup="onlyNum(this);" />
		<br /><br />
		이메일 : 
		<input type="text" name="e1" size="10" /> @ 
		<select name="e2" id="e2">
			<option value="">이메일 선택</option>
<% for (int i = 0; i < arrDomain.length; i++) { %>
			<option value="<%=arrDomain[i] %>"><%=arrDomain[i] %></option>
<% } %>
			<option value="direct">직접 입력</option>
		</select>
		<input type="text" name="e3" id="e3" size="10" />
		<br /><br /><hr />
		<input type="submit" value="회원 가입 " />
	</div>
</form>
</body>
</html>