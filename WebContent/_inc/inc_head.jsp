<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ page import="vo.*" %>
<%
MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
boolean isLogin = false;
String miid = "", miname = "", miphone = "", miemail = ""; int mileage = 0;
if (loginInfo != null) { 
	isLogin = true;
	miid = loginInfo.getMi_id();
	miname = loginInfo.getMi_name();
	miphone = loginInfo.getMi_phone();
	mileage = loginInfo.getMi_mileage();
	miemail = loginInfo.getMi_email();
}

// 로그인 여부를 판단할 변수 isLogin 생성
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GreenTour</title>
</head>
<script src="/greenTour/js/jquery-3.6.1.js"></script>

<script>
function onlyNum(obj){
	if(isNaN(obj.value)){	// 숫자가 아니면 참인 함수 isNan()
		obj.value = "";
	}
}

/* 로딩창 */
function loadingProcess(){
  openLoading();
  // 타이머를 이용해 로딩창 종료
  setTimeout(closeLoading, 1200);
}

// 로딩창 키는 함수
function openLoading() {
    //화면 높이와 너비를 구합니다.
    let maskHeight = $(document).height();
    let maskWidth = window.innerWidth;
    //출력할 마스크를 설정해준다.
    let mask ="<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";
    // 로딩 이미지 주소 및 옵션
    let loadingImg ='';
    loadingImg += "<div id='loadingImg' style='position:absolute; top: calc(50% - (50px / 2)); width:50%; z-index:99999999;'>";
    loadingImg += " <img src='front/mypackage/image/loading3.gif' style='position: relative; display: block; margin: 0px auto;'/>";
    loadingImg += "</div>"; 
    //레이어 추가
    $('body')
        .append(mask)
        .append(loadingImg)
    //마스크의 높이와 너비로 전체 화면을 채운다.
    $('#mask').css({
            'width' : maskWidth,
            'height': maskHeight,
            'opacity' :'0.2'
    });
    //마스크 표시
    $('#mask').show();  
    //로딩 이미지 표시
    $('#loadingImg').show();
}

// 로딩창 끄는 함수
function closeLoading() {
    $('#mask, #loadingImg').hide();
    $('#mask, #loadingImg').empty(); 
}
</script>
<style>
body{ max-width: 1130px; margin: 0 auto; }
a{color:black}
header{width: 1130px; 
    margin: 0 auto;
}
#title {
	width:100%;
    display: flex; height: 130px;
    justify-content: space-between;
    align-items: center;
}
h1 {font-size:45px; color:rgb(112,173,71);}
.frmSch {background-color:white; width:700px; text-align:center; }
.sch {height:32px;}
.frmSch .text {width:60%; height:25px; padding:2px; 
    border-radius: 5px; border: 1px solid grey; }

#m_menu { width:230px; 
    display: flex;
    flex-wrap: wrap;
    justify-content: flex-end;
    
}
#m_menu a {
    margin:5px 5px;    
}
.my_menu{
    border:1px solid lightgrey; border-radius: 5px;
	line-height: 40px;
	width: 90px;
	height: 40px;
	border-radius: 10px;
	display: inline-block;
	text-align: center;
}
#menu {display: flex;
    justify-content: space-between;
}
#menu a {}
#menu .main_menu {
    border: 1px solid lightgrey;
	color : #555;
	border-radius:10px;
	line-height: 60px;
	font-weight:bolder;
	width: 150px;
	height: 60px;
	display: inline-block;
	text-align: center;
	font-size: 21px;
	margin-top:20px;
}
.main_menu:hover {color : rgb(112, 173, 71);}
#title > a {text-decoration:none;}
</style>
<body>
    <header>
        <div id="title">
            <a href="index"><h1>그린투어</h1></a>
            <form action="sch_keyword" class="frmSch" name="frmSch" method="get">
                <input class="text" type="text" name="keyword" placeholder="&nbsp;여행지를 검색해보세요."/>
                <input class="sch" type="submit" value="검색" />
            </form>
            <div id="m_menu">
            	<%if(!isLogin){ %>
                <a href="login_form"><span class="my_menu">로그인</span></a>
                <a href="join_form"><span class="my_menu">회원가입</span></a>
                <a href="mypage_reserve"><span class="my_menu">마이페이지</span></a>
                <a href="#"><span class="my_menu">예약확인</span></a>
                <% } else { %>
                <a href="#"><span class="my_menu"><%=miid %>님</span></a>
                <a href="/greenTour/logout.jsp"><span class="my_menu">로그아웃</span></a>
                <a href="mypage_reserve"><span class="my_menu">마이페이지</span></a>
                <a href="#"><span class="my_menu">예약확인</span></a>
                <% } %>
            </div>
        </div>
        
        <nav id="menu">
            <a href="package_main?ccid=JPN"><span class="main_menu">패키지</span></a>
            <a href="mypackage_main"><span class="main_menu">나만의 패키지</span></a>
            <a href="pareview_list"><span class="main_menu">패키지 후기</span></a>
            <a href="#"><span class="main_menu">여행도시</span></a>
            <a href="#"><span class="main_menu">고객센터</span></a>
        </nav>
    </header>