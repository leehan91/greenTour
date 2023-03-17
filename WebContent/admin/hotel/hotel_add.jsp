<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head_admin.jsp"%>
<script>

$(function(){
	itemChange();
});

function itemChange() {
	
	var JPN = [ "오사카", "도쿄", "오키나와" ];
	var engJPN = [ "OSK", "TYO", "OKI" ];
	var THA = [ "푸캣", "방콕/파타야" ];
	var engTHA = [ "HKT", "BKK" ];
	var PHL = [ "보라카이", "세부" ];
	var engPHL = [ "MPH", "CEB" ];
	var HKG = [ "홍콩" ];
	var engHKG = [ "HKG" ];
	var SGP = [ "싱가포르" ];
	var engSGP = [ "SGP" ];
	var VNM = [ "다낭", "나트랑" ];
	var engVNM = [ "DAD", "NHA" ];
	var TWN = [ "타이페이", "가오슝/화련/지우편" ];
	var engTWN = [ "TPE", "KHH" ];

	var selectItem = $("#select1").val();
	
	var changeItem;
	var changeItem2;

	if (selectItem == "JPN") {
		changeItem = JPN;
		changeItem2 = engJPN;
	} else if (selectItem == "THA") {
		changeItem = THA;
		changeItem2 = engTHA;
	} else if (selectItem == "PHL") {
		changeItem = PHL;
		changeItem2 = engPHL;
	} else if (selectItem == "HKG") {
		changeItem = HKG;
		changeItem2 = engHKG;
	} else if (selectItem == "SGP") {
		changeItem = SGP;
		changeItem2 = engSGP;
	} else if (selectItem == "VNM") {
		changeItem = VNM;
		changeItem2 = engVNM;
	} else if (selectItem == "TWN") {
		changeItem = TWN;
		changeItem2 = engTWN;
	}
	
	
	$('#select2').empty();
	for (var count = 0; count < changeItem.length; count++) {
		var option = $("<option value='"+changeItem2[count]+"'>" + changeItem[count] + "</option>");
		$('#select2').append(option);
	}
	selectCity();
}

function onlyNumber(obj) {
	obj.value = obj.value.replace(/[^0-9]/g, "");
}
	
function selectCity(e) {
	var data = new Object();
	var city;
	if(e == null) {
		city = $("#select2").val();
	} else {
		city = e.value;
	}
	
	data.ccid=$("#select1").val()+city;
	// console.log(data.ccid)
	
	$.ajax({
		type : "POST",
		url : "/greenTourSite/hotel_code", 
		data : data,
		success : function(hotelId) {
			$("#newId").text(hotelId.new_id);
			$("input[name=code]").val(hotelId.new_id);
		}
	});
}
</script>
<style type="text/css">

#newId{
	color:red;
}

.tg {
	border-collapse: collapse;
	border-spacing: 0;
	margin: 30px 0;
}

.tg td {
	border-color: black;
	border-style: solid;
	border-width: 1px;
	font-family: Arial, sans-serif;
	font-size: 14px;
	overflow: hidden;
	padding: 10px 5px;
	word-break: normal;
	    height: 68px;
}

.tg th {
	border-color: black;
	border-style: solid;
	border-width: 1px;
	font-family: Arial, sans-serif;
	font-size: 14px;
	font-weight: normal;
	overflow: hidden;
	padding: 10px 5px;
	word-break: normal;
}

.tg .tg-0pky {
	border-color: inherit;
	text-align: left;
	vertical-align: top
}

.tg .tg-0lax {
	text-align: left;
	vertical-align: top
}

.desc {
	margin-bottom: 50px;
}

.notice{
	margin-bottom: 20px;
}

.sb {
    float: right;
    font-size: 22px;
}

.content {
	margin : 100px 0;
}

.sel1 {
    width: 60px;
}

.sel2 {
    width: 69px;
}

.hcode {
    font-size: 30px;
}

#sdp{width: 88px;}
#dlp{width: 88px;}
#sup{width: 88px;}
#htel{width: 118px;}
</style>
<div>
	<div class="content">
		<span class="hcode">호텔코드 : <span id="newId"></span></span>
		<form method="get" id="hotelAddForm" action="/greenTourSite/hotel_code">
			<table class="tg" style="table-layout: fixed; width: 1130px">
				<colgroup>
					<col style="width: 77px">
					<col style="width: 77px">
					<col style="width: 50px">
					<col style="width: 171px">
					<col style="width: 313px">
					<col style="width: 131px">
					<col style="width: 100px">
					<col style="width: 100px">
					<col style="width: 100px">
				</colgroup>
				<thead>
					<tr>
						<th class="tg-0pky">국가</th>
						<th class="tg-0lax">도시</th>
						<th class="tg-0lax">성급</th>
						<th class="tg-0lax">호텔명</th>
						<th class="tg-0lax">주소</th>
						<th class="tg-0lax">연락처</th>
						<th class="tg-0lax">스탠다드 가격</th>
						<th class="tg-0lax">디럭스 가격</th>
						<th class="tg-0lax">스위트 가격</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="tg-0lax"><select class="sel1" name="nation" id="select1" onchange="itemChange()">
								<option value="JPN">일본</option>
								<option value="THA">태국</option>
								<option value="PHL">필리핀</option>
								<option value="HKG">홍콩</option>
								<option value="SGP">싱가포르</option>
								<option value="VNM">베트남</option>
								<option value="TWN">대만</option>
						</select></td>
						<td class="tg-0lax"><select class="sel2" name="city" id="select2" onchange="selectCity(this)"></select></td>
						<td class="tg-0lax"><select name="grade">
						<option>1</option>
						<option>2</option>
						<option>3</option>
						<option>4</option>
						<option>5</option>
						</select></td>
						<td class="tg-0lax"><textarea name="name" rows="2" cols="25" style="width:160px; height:50px; resize: none;"></textarea></td>
						<td class="tg-0lax"><textarea name="addr" rows="2" cols="25" style="width:305px; height:50px; resize: none;"></textarea></td>
						<td class="tg-0lax"><input id="htel" name="tel" type="text" /></td>
						<td class="tg-0lax"><input id="sdp" name="standard" type="text" onKeyup="onlyNumber(this)" /></td>
						<td class="tg-0lax"><input id="dlp" name="deluxe" type="text" onKeyup="onlyNumber(this)" /></td>
						<td class="tg-0lax"><input id="sup" name="suite" type="text" onKeyup="onlyNumber(this)" /></td>
					</tr>
				</tbody>
			</table>
			<div>
				<textarea class="desc" name="desc" rows="5" cols="25" placeholder="호텔 소개" style="width:1130px; height:150px; resize: none;"></textarea>
				<textarea class="notice" name="notice" rows="5" cols="25" placeholder="안내 사항" style="width:1130px; height:150px; resize: none;"></textarea>
			</div>
				<input type="hidden" name="code" value="" >
				<button class="sb" type="submit">완료</button>
		</form>
	</div>
</div>
</body>
</html>