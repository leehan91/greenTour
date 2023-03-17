<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<style>
.daybyTour{ display: none;}
</style>

<div id ="tour_container">
		<input type="button" onclick="block()">
    	<table class="daybyTour">
    		<tr>
    			<th>1일차 일정표</th>
    		<tr>
    		<tr>
    			<td><input type="text" placeholder="출국일은 관광상품을 추가할 수 없습니다." readonly="readonly"></td>
    		</tr>
    		
    	</table>
 		<table class="daybyTour">
    		<tr>
    			<th>2일차 일정표</th>
    		<tr>
    		<tr>
    			<td><input type="text" placeholder="출국일은 관광상품을 추가할 수 없습니다." readonly="readonly"></td>
    		</tr>
    		
    	</table>
    	<table class="daybyTour">
    		<tr>
    			<th>3일차 일정표</th>
    		<tr>
    		<tr>
    			<td><input type="text" placeholder="출국일은 관광상품을 추가할 수 없습니다." readonly="readonly"></td>
    		</tr>
    		
    	</table>
    	<table class="daybyTour">
    		<tr>
    			<th>4일차 일정표</th>
    		<tr>
    		<tr>
    			<td><input type="text" placeholder="출국일은 관광상품을 추가할 수 없습니다." readonly="readonly"></td>
    		</tr>
    		
    	</table>
    	<table class="daybyTour">
    		<tr>
    			<th>5일차 일정표</th>
    		<tr>
    		<tr>
    			<td><input type="text" placeholder="출국일은 관광상품을 추가할 수 없습니다." readonly="readonly"></td>
    		</tr>
    		
    	</table >
    	<table class="daybyTour">
    		<tr>
    			<th>6일차 일정표</th>
    		<tr>
    		<tr>
    			<td><input type="text" placeholder="출국일은 관광상품을 추가할 수 없습니다." readonly="readonly"></td>
    		</tr>
    		
    	</table>
    	<table class="daybyTour">
    		<tr>
    			<th>7일차 일정표</th>
    		<tr>
    		<tr>
    			<td><input type="text" placeholder="출국일은 관광상품을 추가할 수 없습니다." readonly="readonly"></td>
    		</tr>
    		
    	</table>
 
</div>
<script>
var showDay = document.querySelectorAll('.daybyTour');
var date = 4;

function block(){
	for(var i =0; i<date; i++){
		var day = showDay[i];
		day.style.display = "block";

	}
}

function init(){
	for(var i =0; i<date; i++){
		var day = showDay[i];
		day.style.display = "none";
	}
}
</script>
</body>
</html>