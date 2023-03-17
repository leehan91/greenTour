<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head_admin.jsp"%>
<%
request.setCharacterEncoding("utf-8");
PackageTour pt = (PackageTour)request.getAttribute("pt");

String ptcode = pt.getPt_code();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
ul, li, a{list-style: none; padding:0; color:#000; text-decoration:none;}
body{width:1130px; margin:0 auto;}
textarea{margin-top:10px; }
#main {display:flex; justify-content: space-evenly; margin-top:100px;}
.ctgr {width:200px;}
#title {border:1px solid black;width:100%; margin-bottom:15px; }
#frm {width:830px; position:relative; margin-bottom:100px;}
#frm #title {text-align:center;}
#frm #title input {width:80%;}
#title tr, #title td {padding:5px; border:1px solid #ddd;}
#submit {padding:10px 20px; position:absolute; right:0; top:100%;}
</style>
<script src="/greenTourSite/js/jquery-3.6.1.js"></script>
<script>
function frmVal(frm){
	if(frm.code.value == "" ){
		alert("필수입력사항입니다. 패키지 코드를 입력하세요");
		frm.code.focus();
		return false;
	} else if(frm.code.value.length != 11){
		alert("잘못된 정보를 입력하셨습니다. 패키지 코드를 다시 입력하세요");
		frm.code.focus();
		return false;
	} else if(frm.country.value == ""){
		alert("필수입력사항입니다. 국가코드를 입력하세요");
		frm.country.focus();
		return false;
	} else if(frm.city.value == ""){
		frm.city.focus();
		alert("필수입력사항입니다. 도시코드를 입력하세요");
		return false;
	} else if(frm.name.value == ""){
		frm.name.focus();
		alert("필수입력사항입니다. 패키지 이름을 입력하세요");
		return false;
	} else if(frm.summary.value == ""){
		frm.summary.focus();
		alert("필수입력사항입니다. 패키지 개요을 입력하세요");
		return false;
	} else if(frm.desc.value == ""){
		frm.desc.focus();
		alert("필수입력사항입니다. 패키지 소개를 입력하세요");
		return false;
	} else if(frm.img.value == ""){
		frm.img.focus();
		alert("필수입력사항입니다. 이미지를 등록하세요");
		return false;
	} 

	return true;
}
/*
var fileInput = document.getElementById("fileUpload");
alert(fileInput);

var handleFiles = function(e) {
  var selectedFile = [...fileInput.files];
  console.log(selectedFile);
  var fileReader = new FileReader();

  fileReader.readAsDataURL(selectedFile[0]);

  fileReader.onload = function () {
    document.getElementById("previewImg").src = fileReader.result;
  };
};
fileInput.addEventListener("change", handleFiles);
*/
</script>
</head>
<body>
<main id="main">
	<ul class="ctgr">
		<li><a href="">회원 관리</a></li><hr />
		<li><a href="">도시 관리</a></li><hr />
		<li><a href="">게시판 관리</a></li><hr />
		<li>
			<a href="">상품 관리</a><br />
        	 <span>&nbsp;&nbsp;&nbsp;<a href="admin_package_list"> - 패키지 관리</a></span><br />
	         <span>&nbsp;&nbsp;&nbsp;<a href="hotel_list"> - 호텔 관리</a></span><br />
	         <strong>&nbsp;&nbsp;&nbsp;<a href="tour_list"> - 관광 상품 관리</a></strong><br />
		</li><hr />
		<li><a href="">고객센터</a></li><hr />
		<li><a href="/greenTourSite/admin_amount">통계</a></li>
	</ul>
<form id="frm" action="tour_proc_up" method="post" onsubmit="return frmVal(this);" enctype="multipart/form-data">
	패키지 코드 : PT + 국가코드 + 도시코드 + 일련번호
	<p>패키지 코드 : <input type="text" name="code" value="<%=ptcode %>"/>
	&nbsp;&nbsp; 등록일 : <%=pt.getPt_date() %></p>
	
	<table id="title">
	<tr>
		<td width="10%">국가</td>
		<td width="10%">도시</td>
		<td width="20%">관광상품</td>
		<td width="*">주소</td>
		<td width="10%">가격</td>
		<td width="25%">홈페이지</td>
	</tr>
	<tr>
		<td><input type="text" name="country" value="<%=pt.getCc_id().substring(0,3) %>"/></td>
		<td><input type="text" name="city" value="<%=pt.getCc_id().substring(3) %>" /></td>
		<td><input type="text" name="name" value="<%=pt.getPt_name() %>"></td>
		<td><input type="text" name="addr" value="<%=pt.getPt_addr() %>"></td>
		<td><input type="number" name="price" value="<%=pt.getPt_price() %>" min="0"></td>
		<td><input type="text" name="page" value="<%=pt.getPt_page() %>"></td>
	</tr>
	</table>
	<div style ="width:500; height:400; object-fit:cover; overflow: hidden;" >
    <img style ="object-fit:cover; "id="previewImg" width="100%;" height="100%" alt="이미지 영역" src="/greenTourSite/front/img/<%=pt.getPt_image() %>" />
	</div>
	<input type="file" id="fileUpload" name="ptimg" accept='image/*' value="" ><br />

	<textarea name="summary" cols="115" rows="30" placeholder="개요(관광상품 소개)- 최대 50자 까지 입력가능합니다."><%=pt.getPt_summary() %></textarea>
	<textarea name="desc" cols="115" rows="30" placeholder="소개, 안내사항, 유의 사항 등 -최대 500자 까지 입력가능합니다. "><%=pt.getPt_desc() %></textarea>
	
	<input type="submit" id="submit"/>
</form>

</main>
</body>
</html>