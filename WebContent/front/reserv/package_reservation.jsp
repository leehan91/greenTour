<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
PackageInfo pi = (PackageInfo)request.getAttribute("pi");
int adultCost =  0; // 성인가격
int childCost = 0; // 아동가격

%>
<script>
function setCnt(chk, kind) {	
	var adult_price = <%=pi.getPi_adult() %>;
	var child_price = <%=pi.getPi_child() %>;
	var total_price = adult_price + child_price;
	var frm = document.getElementById("inputInfo");
	
	if(kind == 'kid'){
		var cnt = parseInt(frm.Ccnt.value);	
		if (chk == "+" && cnt < 99)			frm.Ccnt.value = cnt + 1;
		else if (chk == "-" && cnt >= 1)	frm.Ccnt.value = cnt - 1;
		
		var obj = document.getElementById("child");
		obj.style.display = "block";
		
		child.innerHTML = "아동 : " + child_price + "원 x " + frm.Ccnt.value + " = " + (child_price * frm.Ccnt.value) + "원";
		if(frm.Ccnt.value == 0){
			obj.style.display = "none";
		}
	}else{
	
	var cnt = parseInt(frm.Acnt.value);
	if (chk == "+" && cnt < 99)			frm.Acnt.value = cnt + 1;
	else if (chk == "-" && cnt > 1)		frm.Acnt.value = cnt - 1;
	var obj = document.getElementById("adult");
	adult.innerHTML = "성인 : " + adult_price + "원 x " + frm.Acnt.value + " = " + (adult_price * frm.Acnt.value) + "원";
	}
	
	total_price = adult_price * frm.Acnt.value + child_price * frm.Ccnt.value
	var obj2 = document.getElementById("total");
	total.innerHTML = total_price + "원";
		$('input[name=total]').attr('value',total_price);
	
	
}
//여행 약관 및 개인정보 취급 방침 동의    
$(document).on('click', '.term_wrap .term_tit', function (e) {
    e.preventDefault();
    _this = $(this);        
    if (!_this.siblings('.term_con').hasClass('con_view')) {
        $('.term_con').removeClass('con_view');
        _this.siblings('.term_con').addClass('con_view');
    } else {
        _this.siblings('.term_con').removeClass('con_view');
    }
});

$(document).on('click', '.term_wrap .label_chk', function (e) {
    _this = $(this);
    if (!_this.siblings('.term_tit').hasClass('on')) { //체크시
        if (!_this.siblings('.term_tit').hasClass('on')) {
            _this.siblings('.term_tit').addClass('on'); //check				
            $('.term_con').removeClass('con_view'); //닫기

            if (_this.closest('.term_wrap').next().find('.term_tit').not('.on').length == 1
                && _this.closest('.term_wrap').next().find('.term_tit').not('.on').attr("data-required") != "false") { //.term_tit on이 없는 다음에 있다면
                _this.closest('.term_wrap').next().find('.term_con').addClass('con_view')
            } else {
                $('.term_tit[data-required!=false]').not('.on').eq(0).siblings('.term_con').addClass('con_view');
            }
        } else {
            _this.siblings('.term_tit').removeClass('on'); //uncheck
        }
    } else { //체크 해지시
        _this.siblings('.term_tit').removeClass('on');
        $('.term_con').removeClass('con_view');
        if (_this.siblings('.term_tit').attr("data-required") != "false") {
            _this.siblings('.term_tit').siblings('.term_con').addClass('con_view');
        }
    }
});

function removeMsg(_obj, _class) {
    if (typeof (_class) == "string" && $(_obj).hasClass(_class)) {
        $(_obj).removeClass(_class);
    }
    else if (typeof (_obj) != undefined) {
        $('.traveler').eq(0).find('.invalid').removeClass('invalid');   
    }
}

</script>

<style>
#packContainer {width:1130px; margin : 20px auto;}
h2 {width: 100%; border: 1px black solid; margin : 20px auto;}
.aboutPay {width: 100%; border : 1px black solid; display : flex; margin : 0 auto;}
.price {width: 65%; margin :2px;}
.totalPrice {width: 97%; height: 49%; border :1px black solid; margin :2px;}
.eachPrice {width: 97%; height: 49%; border :1px black solid; margin :2px;}
.notice{width: 37%; border :1px black solid; margin :2px; margin-left: 0px;}
.inMem{width : 100%; border : 1px black solid; margin :5px auto; display : flex;}
.memText{width:30%; border-right : 1px black solid;}
.memInput{width: 70%;}
.userInfo {width: 100%; display:flex; justify-content : space-between; }
.userInfo div:nth-of-type(1) {width : 75%; display : flex; justify-content : space-around; flex-wrap: wrap;}
.userInfo div:nth-of-type(1) input{width :30%; height : 20px; margin : 2px;}
.userInfo div:nth-of-type(2) {width : 20%; display : flex; 
	flex-direction: column;    
	flex-wrap: wrap; 
	justify-content: space-between;
    margin: 5px auto;
    
}
.userInfo div:nth-of-type(2) div {width : 100%; display : flex; justify-content: space-around; flex-wrap: wrap; flex-direction: row;}
.userInfo div:nth-of-type(2) div label{width : 45%; background-color: white;}
.reqeust input {width: 97%; height : 50px; margin-left : 10px;}
.userInfo p {margin : 0; padding : 0;}

.inputGen input[type=radio]{
    display: none;
}
.inputGen input[type=radio]+label{
    display: inline-block;
    cursor: pointer;
    border: 1px solid #333;
    line-height: 24px;
    text-align: center;
    font-weight:bold;
    font-size:13px;
}
.inputGen input[type=radio]+label{
    background-color: #fff;
    color: #333;
}
.inputGen input[type=radio]:checked+label{
   background-color:rgb(112,173,71);
    color: #fff;
}
.rser_terms{margin:0 0 40px}.rser_terms .tit{margin:0 0 17px;font-size:24px;color:#111}
.rser_terms .terms_lst{margin:0 0 40px;border-top:2px solid #111;border-bottom:1px solid #aaa}
.rser_terms .term_wrap{position:relative;min-height:76px;border-top:1px solid #e1e1e1}
.rser_terms .term_wrap:first-child{border-top:none}
.rser_terms .term_wrap .term_tit{display:block;height:76px;line-height:76px;font-size:0;cursor:pointer}
.rser_terms .term_wrap .term_tit:after{position:absolute;right:20px;top:34px;content:'';z-index:-2;background-color:#fff;display:inline-block;width:14px;height:8px;overflow:hidden;background-image:url("//img.modetour.com/modetour/2019/reserve/sp_reserve_v20200212.png");background-position:-84px -263px}
.rser_terms .term_wrap .term_tit.on ~ .label_chk{color:#111;font-weight:bold}
.rser_terms .term_wrap .term_tit.on ~ .label_chk .ico_chk{display:inline-block;width:24px;height:24px;overflow:hidden;background-image:url("//img.modetour.com/modetour/2019/reserve/sp_reserve_v20200212.png");background-position:-106px -129px}
.rser_terms .term_wrap .chk{position:absolute;left:-99em;top:0;overflow:hidden;visibility:hidden}
.rser_terms .term_wrap .label_chk{position:absolute;left:0;top:0;display:inline-block;height:76px;font-size:20px;line-height:76px;z-index:1}
.rser_terms .term_wrap .label_chk .ico_chk{display:inline-block;width:24px;height:24px;overflow:hidden;background-image:url("//img.modetour.com/modetour/2019/reserve/sp_reserve_v20200212.png");background-position:-146px -129px;margin-right:8px;margin-top:-4px;vertical-align:middle}
.rser_terms .term_wrap .label_chk:hover{color:#111;font-weight:bold}
.rser_terms .term_wrap .label_chk.invalid .txt_invalid{display:inline-block}
.rser_terms .term_wrap .txt_invalid{display:none;padding-left:8px;line-height:initial;margin-top:-3px;color:#ed4949;font-size:12px;font-weight:normal;letter-spacing:-0.09em;vertical-align:middle}
.rser_terms .term_wrap .term_con{display:none;max-height:400px;padding:30px;box-sizing:border-box;overflow:hidden;overflow-y:auto;line-height:1.7;font-size:14px;color:#555;border-top:1px solid #e1e1e1;letter-spacing:0}
.rser_terms .term_wrap .term_con.con_view{display:block}
.rser_terms .term_wrap .term_con.con_view:before{position:absolute;right:20px;top:34px;content:'';z-index:-1;display:inline-block;width:14px;height:8px;overflow:hidden;background-image:url("//img.modetour.com/modetour/2019/reserve/sp_reserve_v20200212.png");background-position:-114px -263px;background-color:#fff}
.rser_terms .term_wrap .term_con dt,.rser_terms .term_wrap .term_con .tit{font-weight:bold}
.rser_terms .term_wrap .term_con dd,.rser_terms .term_wrap .term_con p{margin:0 0 20px}
.rser_terms .term_wrap .term_con table{table-layout:fixed;margin:0 0 15px;border:1px solid #ccc;border-top:2px solid #888;border-collapse:collapse}
.rser_terms .term_wrap .term_con table caption{font-size:0;height:0;visibility:hidden}
.rser_terms .term_wrap .term_con table th{padding:5px 5px 7px;font-weight:bold;text-align:center;border:1px solid #ccc;vertical-align:top}
.rser_terms .term_wrap .term_con table td{padding:5px 5px 7px;border:1px solid #ccc;vertical-align:top}

</style>


<div id = "packContainer">
	<h2><%=pi.getPi_name() %></h2>
<form id = "inputInfo" name ="frm" action="package_for_pay" method="post" >	
<input type = "hidden" name = "piCode" value = "<%=pi.getPi_code() %>" />
<input type = "hidden" name = "piName" value = "<%=pi.getPi_name() %>" />
<input type = "hidden" name = "ccid" value = "<%=pi.getCc_id() %>" />
<input type ="hidden" name ="fiCode" value ="<%=pi.getFi_code() %>" />
<input type = "hidden" name = "departure" value = "<%=pi.getFi_departure() %>" />
<input type = "hidden" name = "period" value = "<%=pi.getPi_period() %>" />
<input type = "hidden" name = "total" value = "<%=pi.getPi_adult() %>" />
	<div class = "aboutPay">
		<div class = "price">
			<div> 총 합계 금액
				<span id = "total"> <%=pi.getPi_adult() %>원</span> 
			</div>
			<div class = "eachPrice">인원별 금액
				<p id = "adult"> 성인 : <%=pi.getPi_adult() %>원 x 1 = <%=pi.getPi_adult() %>원</p>
				<p id = "child"></p>
				&nbsp;&nbsp;
			</div>
		</div>
		<div class = "notice">
			<article>
			<h4>예약금 및 전체 금액 결제 안내</h4>
			<p>예약 후 3일 이내에 여행경비의 10% 이상을 결제하셔야 합니다</p>
			<p>전체 금액은 반드시 예약 담당자와 상담 하신 후 결제 진행 부탁 드립니다.</p>
			<p>유가 및 환율 변동에 따라 총 상품요금은 변경될 수 있습니다</p>
			</article>
			<article>
			<h4>예약/결제 취소 관련</h4>
			<p>인터넷상에서 예약/결제 취소 및 변경은 불가능하오니, 예약/결제 취소나 여행자정보 변경을 원하시면 반드시 예약담당자에게 연락해 주시기 바랍니다.</p>
			</article>
		</div>
	</div>
	
	<div class = "inMem">
		<div class = "memText"> 총 여행인원</div>
		<div class = "memInput">
			성인 (만 12세 이상)
			<input type="button" value="-" onclick="setCnt(this.value, 'adult');" />
			<input type="text" name="adultCnt" id="Acnt" style="width:20px; text-align:right;" value="1" readonly="readonly" />
			<input type="button" value="+" onclick="setCnt(this.value, 'adult');" />
		 	아동 (만 12세 미만)
			<input type="button" value="-" onclick="setCnt(this.value, 'kid');"/>
			<input type="text" name="childCnt" id="Ccnt" style="width:20px; text-align:right;" value="0" readonly="readonly" />
			<input type="button" value="+" onclick="setCnt(this.value, 'kid');"/>
		</div>
	</div>

<div class = "aboutU">
		<p><span>여행자 정보</span><span>필수입력정보</span></p>
		<p>여행 대표자</p>
		<div class = "userInfo">	
				<div class = "reservInfo">
				<input type="text" name="korName" id="korName" value="홍길동" placeholder="한글 이름">
				<input type="text" name="engLast" id="engLast" value="Hong" placeholder="영문 성">
				<input type="text" name="engFirst" id="engFirst" value="gildong" placeholder="영문 이름">	
				<input type="text" name="birth" id="birth" value="19990919" placeholder="생년월일 8자리">
				<input type="text" name="phone" id="phone" value="01019991999" placeholder="휴대폰 번호('-'없이 숫자만)">
				<input type="text" name="email" id="email" value="gil-dong@naver.com" placeholder="이메일 주소">
				</div>
			<div class ="inputGen">
				<div>
					<input type="radio" name="nationality" id = "korean" value = "korean" checked><label for = "korean">내국인</label>
					<input type="radio" name="nationality" id = "foreigner" value = "foreigner" ><label for = "foreigner">외국인</label>
				</div>
				<div>
					<input type="radio" name="gender" id = "male" value = "male" checked><label for = "male">남자</label>
					<input type="radio" name="gender" id = "female" value = "female" ><label for = "female">여자</label>
				</div>
			</div>
		</div>
		<div class = "reqeust">
			<input type = "text" name = "request" placeholder = "문의  / 요청사항 입력">
		</div>
		<div class = "warning">
		<p>주의 영문이름, 생년월일, 여권만료일 등 여권정보가 잘못되어 있을 경우, 출국이 불가하니 다시 한번 확인 부탁드립니다.</p>
		<p>주의 만 18세 미만의 고객은 단독 예약이 불가하오니, 그린투어 고객센터(1234-1234)로 문의 바랍니다.</p>
		</div>
</div>	
		<div class="rser_terms">
    <h3 class="tit">여행 약관 및 개인정보 취급 방침 동의</h3>
    

    <!-- 국외 여행 약관 -->                            
    <div class="terms_lst">
        <div class="term_wrap">
            <a href="#" class="term_tit">자세히보기</a>
            <label for="agree_6" class="label_chk" onclick="removeMsg(this, 'invalid');">
                <span class="ico_chk"></span>
                국외여행특별약관동의
                <span class="txt_invalid">국외여행 특별약관동의에 동의해주세요.</span>
            </label>
            <input type="checkbox" class="chk" id="agree_6" name="">
            <div class="term_con con_view">                                        
                
                <div class="txt_advice2">
                    <span class="tit_g">이 상품은 <span class="stress">[특별약관]</span> 상품입니다.</span>
                    취소 시 [국외]여행표준약관 제6조 특약에 의한 자체 특별약관이 적용되며, 공정거래위원회 소비자분쟁해결기준 제2018-02호에 우선합니다.<br>
                    분쟁해결기준보다 높은 수수료가 부과될 수 있고, 별도의 동의절차를 거치니 필히 규정을 확인해주시기 바랍니다.
                </div>
                <div class="txt_advice2">본 상품은 국외여행 특별약관이 적용됩니다. 
<br>
<br>[특별약관]
<br>▶여행자의 여행계약 해제 요청 시 여행약관에 의거하여 취소료가 부과됩니다.
<br>- 여행개시 30일전까지( ～30) 취소 통보 시 – 계약금 환급
<br>- 여행개시 20일전까지(29～20) 취소 통보 시 – 여행경비의 10% 배상
<br>- 여행개시 10일전까지(19～10) 취소 통보 시 – 여행경비의 15% 배상
<br>- 여행개시 8일전까지( 9～ 8) 취소 통보 시 – 여행경비의 20% 배상
<br>- 여행개시 1일전까지( 7～ 1) 취소 통보 시 – 여행경비의 30% 배상
<br>- 여행(출발일) 당일 취소 통보 시 – 여행경비의 50% 배상
<br>
<br>본 상품은 항공권 발권 이후 취소 시 상기 취소료 외에 항공권 취소 수수료 130,000원이 추가로 발생됩니다.</div>
                
                <dl>
                    <dd><img src="http://img.modetour.com/modetour/2014/itinerary/10021_2.png" alt="공정거래위원회"></dd>
                    <dt>제1조(목적)</dt>
                    <dd>
                        이 약관은 (주)그린투어(이하 “여행사”라 합니다)와 여행자가 체결한 국외여행계약의 세부 이행 및 준수사항을 정함을 목적으로 합니다.
                    </dd>                                            
                    <dt>제2조(용어의 정의)</dt>
                    <dd>
                        여행의 종류 및 정의, 해외여행수속대행업의 정의는 다음과 같습니다.<br>
                        1. 기획여행 : 여행사가 미리 여행목적지 및 관광일정, 여행자에게 제공될 운송 및 숙식서비스 내용(이하 ‘여행서비스’라 함), 여행요금을 정하여 광고 또는 기타 방법으로 여행자를 모집하여 실시하는 여행.<br>
                        2. 희망여행 : 여행자(개인 또는 단체)가 희망하는 여행조건에 따라 여행사가 운송․숙식․관광 등 여행에 관한 전반적인 계획을 수립하여 실시하는 여행.<br>
                        3. 해외여행 수속대행(이하 ‘수속대행계약’이라 함) : 여행사가 여행자로부터 소정의 수속대행요금을 받기로 약정하고, 여행자의 위탁에 따라 다음에 열거하는 업무(이하 ‘수속대행업무’라 함)를 대행하는 것.<br>
                        1) 사증, 재입국 허가 및 각종 증명서 취득에 관한 수속<br>
                        2) 출입국 수속서류 작성 및 기타 관련업무<br>
                    </dd>

                    <dt>제3조(여행사와 여행자 의무)</dt>
                    <dd>
                        여행의 종류 및 정의, 해외여행수속대행업의 정의는 다음과 같다.&nbsp;<br>
                        ① 여행사는 여행자에게 안전하고 만족스러운 여행서비스를 제공하기 위하여 여행알선 및 안내․운송․숙박 등 여행계획의 수립 및 실행과정에서 맡은 바 임무를 충실히 수행하여야 합니다.<br>
                        ② 여행자는 안전하고 즐거운 여행을 위하여 여행자간 화합도모 및 여행사의 여행질서 유지에 적극 협조하여야 합니다.
                    </dd>

                    <dt>제4조(계약의 구성)</dt>
                    <dd>
                        ① 여행계약은 여행계약서(붙임)와 여행약관․여행일정표(또는 여행 설명서)를 계약내용으로 합니다.<br>
                        ② 여행계약서에는 여행사의 상호, 소재지 및 관광진흥법 제9조에 따른 보증보험 등의 가입(또는 영업보증금의 예치 현황) 내용이 포함되어야 합니다.<br>
                        ③ 여행일정표(또는 여행설명서)에는 여행일자별 여행지와 관광내용․교통수단․쇼핑횟수․숙박장소․식사 등 여행실시일정 및 여행사 제공 서비스 내용과 여행자 유의사항이 포함되어야 합니다.
                    </dd>

                    <dt>제5조(계약체결의 거절)</dt>
                    <dd>
                        여행사는 여행자에게 다음 각 호의 1에 해당하는 사유가 있을 경우에는 여행자와의 계약체결을 거절할 수 있습니다.<br>
                        1. 질병, 신체이상 등의 사유로 개별관리가 필요하거나, 단체여행(다른 여행자의 여행에 지장을 초래하는 등)의 원활한 실시에 지장이 있다고 인정되는 경우<br>
                        2. 계약서에 명시한 최대행사인원이 초과된 경우<br>
                    </dd>

                    <dt>제6조(특약)</dt>
                    <dd>
                        여행사와 여행자는 관련법규에 위반되지 않는 범위 내에서 서면(전자문서를 포함한다. 이하 같다)으로 특약을 맺을 수 있습니다.<br>
                        이 경우 여행사는 특약의 내용이 표준약관과 다르고 표준약관보다 우선 적용됨을 여행자에게 설명하고 별도의 확인을 받아야 합니다.
                    </dd>

                    <dt>제7조(계약서 등 교부 및 안전정보 제공)</dt>
                    <dd>
                        여행사는 여행자와 여행계약을 체결한 경우 계약서와 약관 및 여행일정표(또는 여행설명서)를 각 1부씩 여행자에게 교부하고, 여행목적지에 관한 안전정보를 제공하여야 합니다.<br>
                        또한 여행 출발 전 해당 여행지에 대한 안전정보가 변경된 경우에도 변경된 안전정보를 제공하여야 합니다. 
                    </dd>

                    <dt>제8조(계약서 및 약관 등 교부 간주)</dt>
                    <dd>
                        다음 각 호의 경우 여행계약서와 여행약관 및 여행일정표(또는 여행설명서)가 교부된 것으로 간주합니다.<br>
                        1. 여행자가 인터넷 등 전자정보망으로 제공된 여행계약서, 약관 및 여행일정표(또는 여행설명서)의 내용에 동의하고 여행계약의 체결을 신청한 데 대해 여행사가 전자정보망 내지 기계적 장치 등을 이용하여 여행자에게 승낙의 의사를 통지한 경우<br>
                        2. 여행사가 팩시밀리 등 기계적 장치를 이용하여 제공한 여행계약서, 약관 및 여행일정표(또는 여행설명서)의 내용에 대하여 여행자가 동의하고 여행계약의 체결을 신청하는 서면을 송부한 데 대해 여행사가 전자정보망 내지 기계적 장치 등을 이용하여 여행자에게 승낙의 의사를 통지한 경우
                    </dd>

                    <dt>제9조(여행사의 책임)</dt>
                    <dd>
                        여행사는 여행 출발시부터 도착시까지 여행사 본인 또는 그 고용인, 현지여행사 또는 그 고용인 등(이하 ‘사용인’이라 함)이 제3조제1항에서 규정한 여행사 임무와 관련하여 여행자에게 고의 또는 과실로 손해를 가한 경우 책임을 집니다.
                    </dd>

                    <dt>제10조(여행요금)</dt>
                    <dd>
                        ① 여행계약서의 여행요금에는 다음 각 호가 포함됩니다. 다만, 희망여행은 당사자간 합의에 따릅니다.<br>
                        1. 항공기, 선박, 철도 등 이용운송기관의 운임(보통운임기준)<br>
                        2. 공항, 역, 부두와 호텔사이 등 송영버스요금<br>
                        3. 숙박요금 및 식사요금<br>
                        4. 안내자경비<br>
                        5. 여행 중 필요한 각종세금<br>
                        6. 국내외 공항․항만세<br>
                        7. 관광진흥개발기금<br> 
                        8. 일정표내 관광지 입장료<br>
                        9. 기타 개별계약에 따른 비용<br>
                        ② 제1항에도 불구하고 반드시 현지에서 지불해야 하는 경비가 있는 경우 그 내역과 금액을 여행계약서에 별도로 구분하여 표시하고, 여행사는 그 사유를 안내하여야 합니다.<br>
                        ③ 여행자는 계약체결시 계약금(여행요금 중 10%이하 금액)을 여행사에게 지급하여야 하며, 계약금은 여행요금 또는 손해배상액의 전부 또는 일부로 취급합니다.<br>
                        ④ 여행자는 제1항의 여행요금 중 계약금을 제외한 잔금을 여행출발 7일전까지 여행사에게 지급하여야 합니다.<br>
                        ⑤ 여행자는 제1항의 여행요금을 당사자가 약정한 바에 따라 카드, 계좌이체 또는 무통장입금 등의 방법으로 지급하여야 합니다.<br>
                        ⑥ 희망여행요금에 여행자 보험료가 포함되는 경우 여행사는 보험회사명, 보상내용 등을 여행자에게 설명하여야 합니다.<br>
                    </dd>

                    <dt>제11조(여행요금의 변경)</dt>
                    <dd>
                        ① 국외여행을 실시함에 있어서 이용운송․숙박기관에 지급하여야 할 요금이 계약체결시보다 5%이상 증감하거나 여행요금에 적용된 외화환율이 계약체결시보다 2% 이상 증감한 경우 여행사 또는 여행자는 그 증감된 금액 범위 내에서 여행요금의 증감을 상대방에게 청구할 수 있습니다.<br>
                        ② 여행사는 제1항의 규정에 따라 여행요금을 증액하였을 때에는 여행 출발일 15일전에 여행자에게 통지하여야 합니다.<br>
                    </dd>

                    <dt>제12조(여행조건의 변경요건 및 요금 등의 정산)</dt>
                    <dd>
                        ① 계약서 등에 명시된 여행조건은 다음 각 호의 1의 경우에 한하여 변경될 수 있습니다.<br>
                        1. 여행자의 안전과 보호를 위하여 여행자의 요청 또는 현지사정에 의하여 부득이하다고 쌍방이 합의한 경우<br>
                        2. 천재지변, 전란, 정부의 명령, 운송‧숙박기관 등의 파업‧휴업 등으로 여행의 목적을 달성할 수 없는 경우 <br>
                        ② 여행사가 계약서 등에 명시된 여행일정을 변경하는 경우에는 해당 날짜의 일정이 시작되기 전에 여행자의 서면 동의를 받아야 합니다. 이때 서면동의서에는 변경일시, 변경내용, 변경으로 발생하는 비용이 포함되어야 합니다.<br>
                        ③ 천재지변, 사고, 납치 등 긴급한 사유가 발생하여 여행자로부터 여행일정 변경 동의를 받기 어렵다고 인정되는 경우에는 제2항에 따른 일정변경 동의서를 받지 아니할 수 있습니다. 다만, 여행사는 사후에 서면으로 그 변경 사유 및 비용 등을 설명하여야 합니다.<br>
                        ④ 제1항의 여행조건 변경 및 제11조의 여행요금 변경으로 인하여 제10조 제1항의 여행요금에 증감이 생기는 경우에는 여행출발 전 변경 분은 여행출발 이전에, 여행 중 변경 분은 여행종료 후 10일 이내에 각각 정산(환급)하여야 합니다. <br>
                        ⑤ 제1항의 규정에 의하지 아니하고 여행조건이 변경되거나 제16조 내지 제18조의 규정에 의한 계약의 해제․해지로 인하여 손해배상액이 발생한 경우에는 여행출발 전 발생 분은 여행 출발 이전에, 여행 중 발생 분은 여행종료 후 10일 이내에 각각 정산(환급)하여야 합니다.<br>
                        ⑥ 여행자는 여행출발 후 자기의 사정으로 숙박, 식사, 관광 등 여행요금에 포함된 서비스를 제공받지 못한 경우 여행사에게 그에 상응하는 요금의 환급을 청구할 수 없습니다. 다만, 여행이 중도에 종료된 경우에는 제18조에 준하여 처리합니다.
                    </dd>

                    <dt>제13조(여행자 지위의 양도)</dt>
                    <dd>
                        ① 여행자가 개인사정 등으로 여행자의 지위를 양도하기 위해서는 여행사의 승낙을 받아야 합니다. 이때 여행사는 여행자 또는 여행자의 지위를 양도받으려는 자가 양도로 발생하는 비용을 지급할 것을 조건으로 양도를 승낙할 수 있습니다.<br>
                        ② 전항의 양도로 발생하는 비용이 있을 경우 여행사는 기한을 정하여 그 비용의 지급을 청구하여야 합니다.<br>
                        ③ 여행사는 계약조건 또는 양도하기 어려운 불가피한 사정 등을 이유로 제1항의 양도를 승낙하지 않을 수 있습니다.<br>
                        ④ 제1항의 양도는 여행사가 승낙한 때 효력이 발생합니다. 다만, 여행사가 양도로 인해 발생한 비용의 지급을 조건으로 승낙한 경우에는 정해진 기한 내에 비용이 지급되는 즉시 효력이 발생합니다.<br>
                        ⑤ 여행자의 지위가 양도되면, 여행계약과 관련한 여행자의 모든 권리 및 의무도 그 지위를 양도 받는 자에게 승계됩니다.<br>
                    </dd>

                    <dt>제14조(여행사의 하자담보 책임)</dt>
                    <dd>
                        ① 여행자는 여행에 하자가 있는 경우에 여행사에게 하자의 시정 또는 대금의 감액을 청구할 수 있습니다. 다만, 그 시정에 지나치게 많은 비용이 들거나 그 밖에 시정을 합리적으로 기대할 수 없는 경우에는 시정을 청구할 수 없습니다.<br>
                        ② 여행자는 시정 청구, 감액 청구를 갈음하여 손해배상을 청구하거나 시정 청구, 감액 청구와 함께 손해배상을 청구 할 수 있습니다.<br>
                        ③ 제1항 및 제2항의 권리는 여행기간 중에도 행사할 수 있으며, 여행종료일부터 6개월 내에 행사하여야 합니다.<br>
                    </dd>

                    <dt>제15조(손해배상)</dt>
                    <dd>
                        ① 여행사는 현지여행사 등의 고의 또는 과실로 여행자에게 손해를 가한 경우 여행사는 여행자에게 손해를 배상하여야 합니다.<br>
                        ② 여행사의 귀책사유로 여행자의 국외여행에 필요한 사증, 재입국 허가 또는 각종 증명서 등을 취득하지 못하여 여행자의 여행일정에 차질이 생긴 경우 여행사는 여행자로부터 절차대행을 위하여 받은 금액 전부 및 그 금액의 100%상당액을 여행자에게 배상하여야 합니다.<br>
                        ③ 여행사는 항공기, 기차, 선박 등 교통기관의 연발착 또는 교통체증 등으로 인하여 여행자가 입은 손해를 배상하여야 합니다. 다만, 여행사가 고의 또는 과실이 없음을 입증한 때에는 그러하지 아니합니다.<br>
                        ④ 여행사는 자기나 그 사용인이 여행자의 수하물 수령, 인도, 보관 등에 관하여 주의를 해태(懈怠)하지 아니하였음을 증명하지 아니하면 여행자의 수하물 멸실, 훼손 또는 연착으로 인한 손해를 배상할 책임을 면하지 못합니다.
                    </dd>

                    <dt>제16조(여행출발 전 계약해제)</dt>
                    <dd>
                        ① 여행사 또는 여행자는 여행 출발 전 이 여행계약을 해제할 수 있습니다. 이 경우 발생하는 손해액은 ‘소비자분쟁해결기준’(공정거래위원회 고시)에 따라 배상합니다.<br>                                                
                        
                        ② 여행사 또는 여행자는 여행출발 전에 다음 각 호의 1에 해당하는 사유가 있는 경우 상대방에게 제1항의 손해배상액을 지급하지 아니하고 이 여행계약을 해제할 수 있습니다.<br>
                        1. 여행사가 해제할 수 있는 경우<br>
                        가. 제12조 제1항 제1호 및 제2호 사유의 경우<br>
                        나. 여행자가 다른 여행자에게 폐를 끼치거나 여행의 원활한 실시에 현저한 지장이 있다고 인정될 때<br>
                        다. 질병 등 여행자의 신체에 이상이 발생하여 여행에의 참가가 불가능한 경우<br>
                        라. 여행자가 계약서에 기재된 기일까지 여행요금을 납입하지 아니한 경우<br>
                        2. 여행자가 해제할 수 있는 경우<br>
                        가. 제12조 제1항 제1호 및 제2호의 사유가 있는 경우<br>
                        나. 여행사가 제21조에 따른 공제 또는 보증보험에 가입하지 아니 하였거나 영업보증금을 예치하지 않은 경우<br>
                        다. 여행자의 3촌 이내 친족이 사망한 경우<br>
                        *당사제출용 증빙서류<br>
                        - 친족을 확인 할 수 있는 서류(가족관계증명서 등…)<br>
                        - 진단서 또는 사체검안서(사망진단서)<br>
                        - 그 밖의 필요서류<br>
                        라. 질병 등 여행자의 신체에 이상이 발생하여 여행에의 참가가 불가능한 경우<br>
                        *당사제출용 증빙서류<br>
                        - 진단서<br>
                        - 그 밖의 필요 서류<br>
                        마. 배우자 또는 직계존비속이 신체이상으로 3일 이상 병원(의원)에 입원하여 여행 출발 전까지 퇴원이 곤란한 경우 그 배우자 또는 보호자 1인<br>
                        *당사제출용 증빙서류<br>
                        - 친족을 확인할 수 있는 서류(가족관계증명서 등…)<br>
                        - 진단서<br>
                        - 그 밖의 필요서류<br>
                        바. 여행사의 귀책사유로 계약서 또는 여행일정표(여행설명서)에 기재된 여행일정대로의 여행실시가 불가능해진 경우<br>
                        사. 제10조제1항의 규정에 의한 여행요금의 증액으로 인하여 여행 계속이 어렵다고 인정될 경우
                    </dd>

                    <dt>제17조(최저행사인원 미 충족시 계약해제)</dt>
                    <dd>
                        ① 여행사는 최저행사인원이 충족되지 아니하여 여행계약을 해제하는 경우 여행출발 7일전까지 여행자에게 통지하여야 합니다.<br>
                        ② 여행사가 여행참가자 수 미달로 전항의 기일내 통지를 하지 아니하고 계약을 해제하는 경우 이미 지급받은 계약금 환급 외에 다음 각 목의 1의 금액을 여행자에게 배상하여야 합니다.<br>
                        가. 여행출발 1일전까지 통지시 : 여행요금의 30%<br>
                        나. 여행출발 당일 통지시 : 여행요금의 50%<br>
                    </dd>

                    <dt>제18조(여행출발 후 계약해지)</dt>
                    <dd>
                        ① 여행사 또는 여행자는 여행출발 후 부득이한 사유가 있는 경우 각 당사자는 여행계약을 해지할 수 있습니다. 다만, 그 사유가 당사자 한쪽의 과실로 인하여 생긴 경우에는 상대방에게 손해를 배상하여야 합니다.<br>
                        ② 제1항에 따라 여행계약이 해지된 경우 귀환운송 의무가 있는 여행사는 여행자를 귀환운송 할 의무가 있습니다.<br>
                        ③ 제1항의 계약해지로 인하여 발생하는 추가 비용은 그 해지사유가 어느 당사자의 사정에 속하는 경우에는 그 당사자가 부담하고, 양 당사자 누구의 사정에도 속하지 아니하는 경우에는 각 당사자가 추가 비용의 50%씩을 부담합니다.<br>
                        ④ 여행자는 여행에 중대한 하자가 있는 경우에 그 시정이 이루어지지 아니하거나 계약의 내용에 따른 이행을 기대할 수 없는 경우에는 계약을 해지할 수 있습니다.<br>
                        ⑤ 제4항에 따라 계약이 해지된 경우 여행사는 대금청구권을 상실합니다. 다만, 여행자가 실행된 여행으로 이익을 얻은 경우에는 그 이익을 여행사에게 상환하여야 합니다.<br>
                        ⑥ 제4항에 따라 계약이 해지된 경우 여행사는 계약의 해지로 인하여 필요하게 된 조치를 할 의무를 지며, 계약상 귀환운송 의무가 있으면 여행자를 귀환 운송하여야 합니다. 이 경우 귀환운송비용은 원칙적으로 여행사가 부담하여야 하나, 상당한 이유가 있는 때에는 여행사는 여행자에게 그 비용의 일부를 청구할 수 있습니다.
                    </dd>

                    <dt>제19조(여행의 시작과 종료)</dt>
                    <dd>
                        여행의 시작은 탑승수속(선박인 경우 승선수속)을 마친 시점으로 하며, 여행의 종료는 여행자가 입국장 보세구역을 벗어나는 시점으로 합니다. 다만, 계약내용상 국내이동이 있을 경우에는 최초 출발지에서 이용하는 운송수단의 출발시각과 도착시각으로 합니다.
                    </dd>

                    <dt>제20조(설명의무)</dt>
                    <dd>
                        여행사는 계약서에 정하여져 있는 중요한 내용 및 그 변경사항을 여행자가 이해할 수 있도록 설명하여야 합니다.
                    </dd>

                    <dt>제21조(보험가입 등)</dt>
                    <dd>
                        여행사는 이 여행과 관련하여 여행자에게 손해가 발생한 경우 여행자에게 보험금을 지급하기 위한 보험 또는 공제에 가입하거나 영업보증금을 예치하여야 합니다.
                    </dd>

                    <dt>제22조(기타사항)</dt>
                    <dd>
                        ① 이 계약에 명시되지 아니한 사항 또는 이 계약의 해석에 관하여 다툼이 있는 경우에는 여행사 또는 여행자가 합의하여 결정하되, 합의가 이루어지지 아니한 경우에는 관계법령 및 일반관례에 따릅니다.<br>
                        ② 특수지역에의 여행으로서 정당한 사유가 있는 경우에는 이 표준약관의 내용과 달리 정할 수 있습니다.
                    </dd>
                </dl>
            </div>
        </div>
        <div class="term_wrap">
            <a href="#" class="term_tit">자세히보기</a>
            <label for="agree_7" class="label_chk" onclick="removeMsg(this, 'invalid');">
                <span class="ico_chk"></span>
                해외여행 보험
                <span class="txt_invalid">해외여행보험 약관에 동의해주세요.</span>
            </label>
            <input type="checkbox" class="chk" id="agree_7">
            <div class="term_con">                                        
                <dl>
                    <dt>Ⅰ. 보통약관</dt>
                    <dt>제1조(보험계약의 성립)</dt>
                    <dd>① 보험계약은 보험계약자의 청약과 보험회사의 승낙으로 이루어집니다.(이하 “보험계약”은 “계약”, “보험계약자”는 “계약자”, “보험회사”는 “회사”라 합니다)<br>
                        ② 회사는 계약의 청약을 받고 보험료 전액 또는 제1회 보험료(일정기간 단위의 나눠내는 보험료)를 받은 경우에는 청약일(진단계약의 경우에는 진단일)로부터 30일 이내에 승낙 또는 거절의 통지를 하며 통지가 없으면 승낙한 것으로 봅니다.
                    <br>
                        ③ 회사가 청약을 승낙한 때에는 지체없이 보험가입증서(보험증권)를 계약자에게 교부하여 드리며, 청약을 거절할 경우에는 거절통지와 함께 받은 금액을 계약자에게 돌려드립니다.<br>
                        ④ 이미 성립한 계약을 연장하거나 변경하는 경우에는 회사는 보험가입증서(보험증권)에 그 사실을 기재하거나 서면으로 알림으로써 보험가입증서(보험증권)의 교부에 대신할 수 있습니다. ④ 이미 성립한 계약을 연장하거나 변경하는 경우에는 회사는 보험가입증서(보험증권)에 그 사실을 기재하거나 서면으로 알림으로써 보험가입증서(보험증권)의 교부에 대신할 수 있습니다.
                    </dd>

                    <dt>제2조(약관교부 및 설명의무 등)</dt>
                    <dd>① 회사는 계약을 체결할 때 계약자에게 보험약관을 드리고 그 약관의 중요한 내용을 설명하여 드립니다.<br>
                        ② 회사가 제1항에 의해 제공될 약관을 계약자에게 전달하지 아니하거나 약관의 중요한 내용을 설명하지 아니한 때 또는 계약을 체결할 때 계약자가 청약서에 자필서명(날인(도장을 찍음)을 포함합니다)을 하지 아니한 때에는 계약자는 계약일로부터 1개월 이내에 계약을 취소할 수 있습니다.
                    <br>
                        ③ 제2항에 따라 계약이 취소된 경우에는 회사는 이미 납입한 보험료를 계약자에게 돌려 드리며, 보험료를 받은 기간에 대하여 보험개발원이 공시하는 정기예금이율로 계산한 금액을 더하여 지급합니다.
                    </dd>

                    <dt>제3조(보험료)</dt>
                    <dd>① 보험료는 다른 약정이 없으면 보험기간이 시작되기 전에 내어야 합니다.<br>
                        ② 다른 약정이 없으면 보험기간이 시작된 후라도 보험료를 받기 전에 생긴 손해는 보상하여 드리지 아니합니다.
                    </dd>

                    <dt>제4조(회사의 보장의 시기 및 종기)</dt>
                    <dd>① 회사의 보장은 보험기간의 첫날 오후 4시에 시작하여 마지막날 오후 4시에 끝납니다. 그러나 보험가입증서(보험증권)에 이와 다른 시각이 기재되어 있을 때에는 그 시각으로 하며, 시각은 보험가입증서(보험증권) 발행지의 표준시를 따릅니다.
                    <br>
                        ② 회사가 계약자로부터 계약의 청약과 함께 보험료 상당액의 전부 또는 일부를 받은 경우에 그 청약을 승낙하기 전에 계약에서 정한 보험사고가 생긴 때에는 회사는 계약상의 보장을 합니다.
                    <br>
                        ③ 제2항의 규정에도 불구하고 회사는 다음 중 한 가지에 해당되는 경우에는 보장을 하지 아니합니다.
                    <br>
                        1. 제1항에서 정한 보장의 시기가 개시되지 아니한 경우
                    <br>
                        2. 제13조(계약전 알릴의무)의 규정에 의하여 계약자 또는 피보험자가 회사에 알린 내용 또는 건강진단 내용이 보험금 지급사유의 발생에 영향을 미쳤음을 회사가 증명하는 경우
                    <br>
                        3. 제15조(계약의 해지)의 규정을 준용하여 회사가 보장을 하지 아니할 수 있는 경우
                    <br>
                        ④ 제1항의 규정에도 불구하고 회사는 피보험자가 주거지를 출발하기 전과 주거지에 도착한 이후에 발생한 사고에 대하여는 보상하여 드리지 아니합니다.<br>
                        ⑤ 피보험자가 승객으로 탑승하는 항공기, 선박 등의 교통승용구가 보험기간 마지막날의 오후 4시까지 여행의 최종목적지에 도착하도록 예정되어 있음에도 불구하고 도착이 지연되었을 경우에는 제1항의 규정에도 불구하고 회사의 보장의 종기는 24시간을 한도로 자동적으로 연장됩니다.
                    <br>
                        ⑥ 제5항의 경우 중 피보험자가 승객으로 탑승하는 항공기가 제3자에 의한 불법적인 지배를 받았을 경우 또는 공권력에 의해 구속을 받았을 경우에는 그때부터 피보험자가 정상적인 여행 상태로 돌아올 때까지의 필요한 시간 또는 회사가 타당하다고 인정되는 시간을 한도로 하여 회사의 보장의 종기는 연장됩니다.							
                    </dd>

                    <dt>제5조(청약의 철회)</dt>
                    <dd>① 가계성보험(개인의 일상생활과 관련된 보험으로 보험료를 단체 또는 법인이 부담하지 않는 개인보험계약과 단체요율(피보험자가 단체인 계약에 적용되는 요율)이 적용되지 않는 계약을 말합니다)에 한하여 계약자는 청약을 한 날 또는 보험료를 납입한 날부터 15일 이내에 그 청약을 철회할 수 있습니다. 다만, 보험기간이 90일 이내인 경우에는 그러하지 아니합니다.<br>
                        ② 회사는 청약의 철회를 접수한 경우에는 지체없이 보험료를 돌려드리며, 보험료 반환이 지체된 기간에 대하여는 보험개발원이 공시하는 정기예금 이율로 계산한 금액을 더하여 지급합니다.							
                    </dd>

                    <dt>제6조(보상하는 손해)</dt>
                    <dd>① 회사는 피보험자가 보험가입증서(보험증권)에 기재된 여행을 목적으로 주거지를 출발하여 여행을 마치고 주거지에 도착할 때까지의 여행도중에 급격하고도 우연한 외래의 사고(이하 “사고”라 합니다)로 신체(의수, 의족, 의안, 의치 등 신체보조장구는 제외합니다)에 상해를 입었을 때에는 그 상해로 인하여 생긴 손해(이하 “손해”라 합니다)를 이 약관에 따라 보상하여 드립니다.<br>
                        ② 제1항의 상해에는 유독가스 또는 유독물질을 우연하게도 일시에 흡입, 흡수 또는 섭취하였을 때에 생긴 중독증상을 포함합니다. 그러나 세균성 음식물중독과 상습적으로 흡입, 흡수 또는 섭취한 결과로 생긴 중독증상은 이에 포함되지 아니합니다.							
                    </dd>

                    <dt>제7조 (보상하지 아니하는 손해)</dt>
                    <dd>① 회사는 아래의 사유를 원인으로 하여 생긴 손해는 보상하여 드리지 아니합니다.<br>
                        1. 계약자나 피보험자의 고의
                    <br>
                        2. 보험수익자(이하 "수익자"라 합니다)의 고의. 그러나 그 수익자가 보험금의 일부 수익자인 경우에는 그 수익자에 해당하는 보험금을 제외한 나머지 보험금을 다른 수익자에게 지급합니다.
                    <br>
                        3. 피보험자의 자해, 자살, 자살미수, 형법상의 범죄행위 또는 폭력행위(다만, 형법상 정당방위, 긴급피난 및 정당행위로 인정되는 경우에는 보상하여 드립니다)
                    <br>
                        4. 피보험자의 질병
                    <br>
                        5. 피보험자의 심신상실 또는 정신질환
                    <br>
                        6. 피보험자의 임신, 출산(제왕절개 포함), 유산, 외과적 수술 또는 그 밖의 의료처치
                    <br>
                        7. 피보험자의 사형
                    <br>
                        8. 지진, 분화, 해일 또는 이와 비슷한 천재지변
                    <br>
                        9. 전쟁, 외국의 무력행사, 혁명, 내란, 사변, 폭동, 소요, 기타 이들과 유사한 사태
                    <br>
                        10. 핵연료 물질(사용이 끝난 연료를 포함합니다. 이하 같습니다) 또는 핵연료 물질에 의하여 오염된 물질(원자핵분열 생성물을 포함합니다)의 방사성, 폭발성 또는 그밖의 유해한 특성에 의한 사고
                    <br>
                        11. 제10호 이외의 방사선을 쬐는 것 또는 방사능 오염
                    <br>
                        ② 회사는 다른 약정이 없으면 피보험자가 직업, 직무 또는 동호회 활동목적으로 아래에 열거된 행위를 하는 동안에 생긴 손해에 대하여는 보상하여 드리지 아니합니다.
                    <br>
                        1. 전문등반(전문적인 등산용구를 사용하여 암벽 또는 빙벽을 오르내리거나 특수한 기술, 경험, 사전훈련을 필요로 하는 등반을 말합니다), 글라이더조종, 스카이다이빙, 스쿠버다이빙, 행글라이딩 또는 이와 비슷한 위험한 활동
                    <br>
                        2. 모터보트, 자동차 또는 오토바이에 의한 경기, 시범, 흥행(이를 위한 연습을 포함 합니다) 또는 시운전(다만, 공용도로상에서 시운전을 하는 동안 발생한 상해는 보상하여 드립니다)
                    <br>
                        3. 선박승무원, 어부, 사공, 양식업자, 그 밖에 선박에 탑승하는 것을 직무로 하는 사람이 직무상 선박에 탑승하고 있는 동안							
                    </dd>

                    <dt>제8조(사망보험금)</dt>
                    <dd>① 회사는 피보험자가 제6조(보상하는 손해)에서 정한 사고로 상해를 입고 그 직접결과로써 사고일부터 1년 이내에 사망하였을 경우에는 보험가입금액 전액을 사망보험금으로 수익자(수익자의 지정이 없을 때에는 피보험자의 상속인)에게 지급합니다.
                    <br>
                        ② 피보험자가 탑승한 항공기 또는 선박이 조난 또는 행방불명되어 피보험자의 생사가 분명하지 아니한 상태에서 정부기관이 피보험자의 사망을 인정하여 관공서의 사망보고에 따라 가족관계등록부에 사망이 기재된 경우에는 그 사고가 발생한 때에 피보험자가 사망한 것으로 봅니다. 그러나 사망보험금을 지급한 후에 피보험자의 생존이 확인되었을 때에는 지급한 보험금을 회수합니다.
                    </dd>

                    <dt>제9조(후유장해보험금)</dt>
                    <dd>① 회사는 피보험자가 제6조(보상하는 손해)에서 정한 사고로 상해를 입고 그 상해가 치유된 후 직접결과로써 사고일부터 1년 이내에 신체의 일부를 잃었거나 또는 그 기능이 영구히 상실(이하 “후유장해”라 합니다)된 경우에는 장해분류표Ⅰ(【별표1】참조. 이하 같습니다)에서 정한 지급률을 보험가입금액에 곱하여 산출한 금액을 후유장해보험금으로 피보험자에게 지급합니다. 다만, 영구히 고정된 증상은 아니지만 치료종결 후 한시적으로 나타나는 장해에 대하여는 그 기간이 5년 이상인 때에는 해당 장해 지급률의 20%를 보험가입금액에 곱하여 산출한 금액을 지급합니다.
                    <br>
                        ② 제1항의 후유장해보험금 지급을 위한 후유장해지급률이 사고일부터 180일이 지나도록 확정되지 아니하는 경우에는 사고일부터 180일이 되는 날의 의사 진단에 기초하여 고정될 것으로 인정되는 상태를 후유장해의 지급률로 결정합니다. 다만, 그 이후 보장을 받을 수 있는 기간 중에 장해상태가 더 악화되는 경우에는 그 악화된 장해상태를 기준으로 후유장해 지급률을 결정하되 장해분류표에 장해판정 시기가 별도로 정해진 경우에는 그에 따릅니다.
                    <br>
                        ③ 장해분류표에 해당되지 아니하는 후유장해는 피보험자의 직업, 연령, 신분 또는 성별 등에 관계없이 신체의 장해정도에 따라 장해분류표의 구분에 준하여 지급액을 결정합니다. 다만, 장해분류표의 각 장해분류별 최저지급률 장해정도에 이르지 않는 후유장해에 대하여는 후유장해보험금을 지급하지 아니합니다. ④ 같은 사고로 두 가지 이상의 후유장해가 생긴 경우에는 후유장해 지급률을 합산하여 지급합니다. 다만, 장해분류표의 각 신체부위별 판정기준에서 별도로 정한 경우에는 그 기준에 따릅니다.
                    <br>
                        ⑤ 제4항에도 불구하고 동일한 신체부위에 장해분류표상의 2가지 이상의 장해가 발생한 경우에는 합산하지 않고 그 중 높은 지급률을 적용합니다. 다만, 장해분류표의 각 신체부위별 판정기준에서 별도로 정한 경우에는 그 기준에 따릅니다.
                    <br>
                        ⑥ 다른 상해로 인하여 후유장해가 2회이상 발생하였을 경우에는 그 때마다 이에 해당하는 후유장해지급률을 결정합니다. 그러나, 그 후유장해가 이미 후유장해보험금을 지급받은 동일 부위에 가중된 때에는 최종 장해상태에 해당하는 후유장해보험금에서 이미 지급받은 후유장해보험금을 차감하여 지급합니다. 다만, 장해분류표의 각 신체부위별 판정기준에서 별도로 정한 경우에는 그 기준을 따릅니다.
                    <br>
                        ⑦ 이미 다음 중 한가지의 경우에 해당되는 후유장해가 있었던 피보험자에게 그 신체의 동일 부위에 또다시 제6항에 규정하는 후유장해상태가 발생하였을 경우에는 다음 중 한가지의 경우에 해당되는 후유장해에 대한 후유장해보험금이 지급된 것으로 보고 최종 후유장해상태에 해당하는 후유장해보험금에서 이미 지급받은 것으로 간주한 후유장해보험금을 차감하여 지급합니다.
                    <br>
                        1. 이 약관의 보장개시전의 원인에 의하거나 또는 그 이전에 발생한 후유장해로 장해보험금의 지급사유가 되지 않았던 후유장해
                    <br>
                        2. 위1호 이외에 이 약관의 규정에 의하여 후유장해보험금의 지급사유가 되지 않았던 후유장해 또는 후유장해보험금이 지급되지 않았던 후유장해
                    </dd>

                    <dt>제10조(의료비보험금)</dt>
                    <dd>① 회사는 피보험자가 제6조(보상하는 손해)에서 정한 상해를 입고 그 직접결과로써 의사의 치료를 받은 때에는 1사고당 의료비가입금액을 한도로 피보험자가 실제로 부담한 의료비 전액을 지급합니다. 그러나 어떠한 경우에도 사고일부터 180일을 한도로 합니다.
                    <br>
                        ② 제1항에도 불구하고 아래의 각호에 해당하는 비용은 보험금을 지급하지 아니합니다.
                    <br>
                        1. 한약재 등의 보신용 투약비용
                    <br>
                        2. 진료와 무관한 제비용(TV시청료, 전화료, 제증명료 등), 상당한 사유가 없는 고단위 영양제 투여비용, 의사의 임상적 소견과 관련 없는 검사비용
                    <br>
                        ③ 제1항에도 불구하고 척추지압술(Chiropractic, 추나요법 등)이나 침술(부항, 뜸 포함)치료로 인한 의료비는 치료받는 국가의 법에서 정한 병원 및 의사의 자격을 가진 자에 의하여 치료를 받은 경우에 한하며, 하나의 상해에 대하여 US $700.00 한도로 보상하여 드립니다.
                    <br>
                        ④ 제1항의 비용에 대하여 보험금을 지급할 다수계약이 체결되어 있는 경우에는 각각의 계약에 대하여 다른 계약이 없는 것으로 하여 산출한 보상책임액의 합계액이 제1항의 비용을 초과했을 때 회사는 이 계약에 따른 보상책임액의 위의 합계액에 대한 비율에 따라 의료비 보험금을 지급합니다.
                    <br>
                        &lt;용어풀이&gt;<br>
                        다수계약에 해당하는 보험종목은 제3보험의 상해․질병․간병보험 및 손해보험의 종합․장기손해․개인 연금․<br>
                        퇴직보험으로 합니다.<br>
                        ⑤ 제1항에도 불구하고 피보험자가 보장개시일 이후 제1항에서 정한 사고로 치료를 받던 중 보험기간이 만료되었을 경우에도 보험기간 만료전 사고일로부터 계속중인 치료에 대한 상해의료비를 180일을 한도로 보상하여 드립니다.
                    </dd>

                    <dt>제11조(다른 신체상해 또는 질병의 영향)</dt>
                    <dd>① 피보험자가 제6조(보상하는 손해)에서 정한 상해를 입은 경우 이미 존재한 신체장해 또는 질병의 영향으로 또는 제6조(보상하는 손해)에서 정한 상해를 입은 후에 그 원인이 된 사고와 관계없이 새로이 발생한 상해나 질병의 영향으로 제6조(보상하는 손해)에서 정한 상해가 중하게 된 때에는 회사는 그 영향이 없었던 때에 상당하는 금액을 결정하여 지급합니다.
                    <br>
                        ② 정당한 이유없이 피보험자가 치료를 게을리하거나 또는 계약자나 수익자가 치료를 하여 주지 않으므로 인하여 제6조(보상하는 손해)에서 정한 상해가 중하게 된 경우에는 제1항과 같은 방법으로 합니다.							
                    </dd>

                    <dt>제12조(보험금의 지급한도)</dt>
                    <dd>① 회사가 지급하여야 할 사망 또는 후유장해보험금은 보험기간을 통하여 보험가입증서(보험증권)에 기재된 사망 또는 후유장해 보험가입금액 각각을 한도로 합니다.
                    <br>
                        ② 회사가 지급하여야 할 의료비보험금은 1사고마다 보험가입증서(보험증권)에 기재된 의료비보험가입금액을 한도로 합니다.							
                    </dd>

                    <dt>제13조(계약전 알릴 의무)</dt>
                    <dd>계약자, 피보험자 또는 이들의 대리인은 청약시(건강진단을 받는 경우에는 건강진단서 포함) 청약서(질문서를 포함합니다)에서 질문한 사항에 대하여 알고 있는 사실을 반드시 사실대로 알려야 합니다. 특히 피보험자에 대하여 상해에 의한 손해를 보상하는 다른 계약을 맺은 경우에는 반드시 그 사실을 회사에 알려야 합니다.
                    </dd>

                    <dt>제14조(계약후 알릴 의무)</dt>
                    <dd>① 계약을 맺은 후 사망보험금수익자를 지정 또는 변경할 때에는 계약자 또는 피보험자는 지체없이 서면으로 회사에 알려야 합니다. 다만, 이 경우에는 피보험자의 동의서를 첨부하여야 합니다.
                    <br>
                        ② 계약자는 주소 또는 연락처가 변경된 경우에는 지체없이 이를 회사에 알려야 합니다. 다만, 계약자가 알리지 않은 경우 회사가 알고 있는 최종의 주소 또는 연락처로 알린 사항은 일반적으로 도달에 필요한 시일이 지난 때에는 계약자에게 도달한 것으로 봅니다.							
                    </dd>

                    <dt>제15조(계약의 해지)</dt>
                    <dd>① 계약자는 손해가 발생하기 전에는 언제든지 계약을 해지할 수 있습니다. 다만 타인을 위한 계약의 경우에는 계약자는 그 타인의 동의를 얻거나 보험가입증서(보험증권)를 소지한 경우에 한하여 계약을 해지할 수 있습니다.
                    <br>
                        ② 회사는 계약자, 피보험자 또는 수익자의 고의로 손해가 발생한 경우 이 계약을 해지할 수 있습니다.
                    <br>
                        ③ 회사는 계약자, 피보험자 또는 이들의 대리인이 제13조(계약전 알릴의무)에도 불구하고 고의 또는 중대한 과실로 중요한 사항에 대하여 사실과 다르게 알린 경우에는 손해의 발생여부에 관계없이 이 계약을 해지할 수 있습니다.
                    <br>
                        ④ 제3항의 경우에도 불구하고 다음중 하나에 해당하는 경우에는 회사는 계약을 해지할 없습니다.
                    <br>
                        1. 회사가 계약당시에 그 사실을 알았거나 중대한 과실로 인하여 알지 못하였을 때
                    <br>
                        2. 회사가 그 사실을 안날로부터 1개월 이상 지났을 때
                    <br>
                        3. 보험을 모집한 자(이하 “보험설계사 등”이라 합니다)가 계약자 또는 피보험자의 계약전 알릴 의무사항을 임의로 기재한 경우
                    <br>
                        ⑤ 제3항에 의한 계약의 해지가 손해발생 후에 이루어진 경우 회사는 그 손해를 보상하여 드리지 아니하며, 계약전 알릴의무 위반사실 뿐만 아니라 계약전 알릴의무사항이 중요한 사항에 해당되는 사유를 “반대증거가 있는 경우 이의를 제기할 수 있습니다”라는 문구와 함께 계약자에게 서면으로 알려드립니다.
                    <br>
                        ⑥ 손해가 제3항에 해당되는 사실로 생긴 것이 아닌 것으로 증명된 때에는 제5항에 관계없이 보상하여 드립니다.
                    </dd>

                    <dt>제16조(피보험자의 변경)</dt>
                    <dd>① 계약자가 피보험자를 변경할 수 있는 경우는 다음과 같습니다.
                    <br>
                        1. 피보험자가 이 보험에서 보장하지 아니하는 사유로 사망하거나 파산, 이민 또는 이혼 등 불가피한 사유로 계약을 계속 유지시킬 수 없는 경우
                    <br>
                        2. 계약자가 그와 고용관계에 있는 피보험자를 해고 또는 교체한 경우
                    <br>
                        &lt;용어풀이&gt;<br>
                        고용관계라 함은 피고용인이 고용인에게 노무를 제공하고, 고용인은 그에 대한 보수를 지급하기로 약정한 관계를 말합니다.
                    </dd>

                    <dt>제17조(계약의 무효)</dt>
                    <dd>타인의 사망을 보험사고로 하는 계약에서 계약을 체결할 때까지 피보험자의 서면에 의한 동의를 얻지 아니한 경우에는 계약을 무효로 합니다. 다만, 단체가 규약에 따라 구성원의 전부 또는 일부를 피보험자로 하는 계약을 체결하는 경우에는 이를 적용하지 아니합니다.							
                    </dd>

                    <dt>제18조(보험료의 환급)</dt>
                    <dd>① 이 계약이 무효, 효력상실 또는 해지된 때에는 다음과 같이 보험료를 돌려 드립니다. 다만, 보험기간중 보험사고가 발생하여 보험금이 지급된 사실이 있으면 어떠한 경우에도 당해 보험년도(초년도(첫째년도)는 보험기간의 초일(첫째날)부터 1년간, 차년도(둘째년도) 이후는 각각 보험기간의 초일(첫째날) 해당일로부터 1년간을 말합니다)의 보험료는 돌려드리지 아니합니다.
                    <br>
                        1. 계약자, 피보험자 또는 수익자의 책임없는 사유에 의하는 경우 : 무효의 경우에는 회사에 납입한 보험료의 전액, 효력상실 또는 해지의 경우에는 경과하지 아니한 기간에 대하여 일단위로 계산한 보험료
                    <br>
                        2. 계약자, 피보험자 또는 수익자의 책임있는 사유에 의하는 경우 : 이미 경과한 기간에 대하여 단기요율(1년미만의 기간에 적용되는 요율)로 계산한 보험료를 뺀 잔액. 다만, 계약자, 피보험자 또는 수익자의 고의 또는 중대한 과실로 무효가 된 때에는 보험료를 돌려드리지 아니합니다.
                    <br>
                        ② 보험기간이 1년을 초과하는 계약이 무효 또는 효력상실인 경우에는 무효 또는 효력상실의 원인이 생긴 날 또는 해지일이 속하는 보험년도의 보험료는 제1항의 규정을 적용하고 그 이후의 보험년도에 속하는 보험료는 전액을 돌려드립니다.
                    </dd>

                    <dt>제19조 (손해의 통지)</dt>
                    <dd>① 계약자, 피보험자 또는 수익자는 사고가 생긴 것을 안 때에는 지체없이 그 사실을 회사에 알려야 합니다.<br>
                        ② 보험계약자 또는 보험수익자는 피보험자가 탑승한 항공기나 선박이 행방불명 또는 조난되었음을 알았을 때도 지체없이 그 상황을 회사에 알려야 합니다.
                    <br>
                        ③ 계약자, 피보험자 또는 수익자가 제1항 및 제2항의 통지를 게을리하여 손해가 증가된 때에는 회사는 그 증가된 손해는 보상하여 드리지 아니합니다.
                    </dd>

                    <dt>제20조 (보험금 청구시 구비서류)</dt>
                    <dd>① 계약자, 피보험자(또는 수익자)는 다음의 서류를 제출하고 보험금을 청구하여야 합니다.
                    <br>
                        1. 청구서(회사양식)
                    <br>
                        2. 사고증명서(사망진단서, 장해진단서, 입원치료확인서 등)
                    <br>
                        3. 신분증(주민등록증 또는 운전면허증 등 사진이 부착된 정부기관발행 신분증, 본인이 아닌 경우에는 본인의 인감증명서 포함)
                    <br>
                        4. 기타 보험금 등의 수령에 필요하여 제출하는 서류
                    <br>
                        ② 병원 또는 의원에서 제1항 제2호의 사고증명서를 발급받을 경우, 그 병원 또는 의원은 의료법 제3조(의료기관)에서 정하는 국내의 병원이나 의원 또는 이와 동등하다고 인정되는 국외의 의료기관이어야 합니다.							
                    </dd>

                    <dt>제21조 (보험금의 지급)</dt>
                    <dd>① 회사는 제20조(보험금 청구시 구비서류)에서 정한 청구서류를 접수한 때에는 접수증을 교부하고 그 서류를 접수한 날로부터 신체손해에 관한 보험금은 3영업일, 배상책임손해에 대한 보험금은 10영업일, 재산손해에 대한 보험금은 20영업일 이내에 지급합니다.
                    <br>
                        ② 회사가 보험금 지급사유의 조사 및 확인을 위하여 제1항의 지급기일초과가 명백히 예상되는 경우에는 구체적 사유, 지급예정일 및 가지급보험금 청구절차를 피보험자 또는 수익자에게 서면 통지하여 드립니다.
                    <br>
                        ③ 제2항에 의하여 추가적인 조사가 이루어지는 경우에는 회사는 피보험자 또는 수익자의 청구에 따라 회사가 추정하는 보험금의 50%상당액을 가지급보험금으로 지급합니다.
                    <br>
                        ④ 회사가 제1항의 규정에 정한 지급기일내에 보험금을 지급하지 아니하였을 때에는 그 다음날부터 지급일까지의 기간에 대하여 보험개발원이 공시하는 정기예금 이율로 계산한 금액을 보험금에 더하여 지급합니다. 그러나 계약자, 피보험자 또는 수익자의 책임있는 사유로 지급이 지연된 때에는 그 해당기간에 대한 이자는 더하여 드리지 아니합니다.
                    <br>
                        ⑤ 계약자, 피보험자 또는 수익자는 제15조(계약의 해지)와 관련하여 의료기관 또는 국민건강보험공단, 경찰서 등 관공서에 대한 회사의 조사에 동의하여야 합니다. 다만 정당한 사유 없이 이에 동의하지 않을 경우 사실확인이 끝날 때까지 회사는 보험금지급 지연에 따른 이자를 지급하지 아니합니다.
                    </dd>

                    <dt>제22조 (보험금 청구권의 상실)</dt>
                    <dd>계약자, 피보험자 또는 수익자는 아래와 같은 경우에는 손해에 대한 보험금의 청구권을 잃게 됩니다.
                    <br>
                        1. 계약자, 피보험자 또는 수익자가 손해의 통지 또는 보험금 청구에 관한 서류에 고의 로 사실과 다른 것을 기재하였거나 그 서류 또는 증거를 위조 또는 변조한 경우
                    <br>
                        2. 계약자, 피보험자 또는 수익자가 상당한 이유없이 손해의 조사를 방해 또는 회피한 때에는 그 해당손해
                    </dd>

                    <dt>제23조 (소멸시효)</dt>
                    <dd>보험금 청구권, 보험료 또는 환급금 반환청구권은 2년간 행사하지 아니하면 소멸시효가 완성됩니다.
                    </dd>

                    <dt>제24조 (계약내용의 교환)</dt>
                    <dd>회사는 보험계약의 체결 및 관리 등을 위한 판단자료로서 활용하기 위하여 다음 각 호의 사항을 계약자 및 피보험자의 동의를 받아 다른 보험회사(보험관련 업무를 위탁받은 자를 포함) 및 보험관련 단체 등에게 제공할 수 있으며 이 경우 회사는 신용정보의이용및보호에관한법률 제23조(개인신용정보의 제공․활용에 대한 동의) 및 동법 시행령 제12조(개인신용정보의 제공․활용에 대한 동의 등)의 규정을 따릅니다.
                    <br>
                        1. 계약자, 피보험자의 성명, 주민등록번호 및 주소
                    <br>
                        2. 계약일, 보험종목, 보험료, 보험가입금액 등 계약내용<br>
                        3. 보험금과 각종 급부금액 및 지급사유 등 지급내용
                    <br>
                        4. 피보험자의 상해 및 질병에 관한 정보
                    </dd>

                    <dt>제25조 (분쟁의 조정)</dt>
                    <dd>계약에 관하여 분쟁이 있는 경우에는 분쟁당사자 또는 기타 이해관계인과 회사는 금융감독원장에게 조정을 신청할 수 있습니다.
                    </dd>

                    <dt>제26조 (관할법원)</dt>
                    <dd>이 계약에 관한 소송은 계약자, 피보험자(또는 수익자)가 선택하는 대한민국 법원을 합의에 따른 관할법원으로 합니다.
                    </dd>

                    <dt>제27조 (약관의 해석)</dt>
                    <dd>① 회사는 신의성실의 원칙에 따라 공정하게 약관을 해석하여야 하며 계약자에 따라 다르게 해석하지 아니합니다.
                    <br>
                        ② 회사는 약관의 뜻이 명백하지 아니한 경우에는 계약자에게 유리하게 해석합니다.
                    </dd>

                    <dt>제28조 (회사가 제작한 보험안내장의 효력)</dt>
                    <dd>보험설계사 등이 모집과정에서 사용한 회사(각종 점포 및 대리점 포함) 제작의 보험안내장(계약의 청약을 권유하기 위해 만든 서류 등을 말합니다)의 내용이 이 약관의 규정과 다른 경우에는 계약자에게 유리한 내용으로 계약이 성립된 것으로 봅니다.
                    </dd>

                    <dt>제29조 (회사의 손해배상책임)</dt>
                    <dd>회사는 계약과 관련하여 임직원, 보험설계사 및 대리점의 책임있는 사유로 인하여 발생된 손해에 대하여는 관계법규 및 사업방법서에서 정한 바에 따라 손해배상의 책임을 집니다.
                    </dd>

                    <dt>제30조 (예금보험기금에 의한 지급보장)</dt>
                    <dd>회사가 파산 등으로 인하여 보험금 등을 지급하지 못할 경우에는 예금자보호법에서 정하는 바에 따라 그 지급을 보장합니다.
                    </dd>

                    <dt>제31조 (준거법)</dt>
                    <dd>이 약관에서 정하지 아니한 사항은 대한민국 법령을 따릅니다.
                    </dd>

                    <dt>Ⅱ. 특별약관</dt>
                    <dt>1. 질병사망 특별약관</dt>
                    <dt>제1조 (보상하는 손해)</dt>
                    <dd>① 회사는 피보험자가 보통약관 제6조(보상하는 손해)의 여행도중에 질병으로 사망하거나 또는 신체의 일부를 잃었거나 그 기능이 영구히 상실(이하 “후유장해”라 합니다)되어 장해분류표Ⅰ(【별표1】참조. 이하 같습니다)에서 정한 지급률이 80%이상에 해당하는 후유장해가 남았을 경우에는 이 특별약관의 사망보험가입금액 전액을 피보험자 사망시 질병사망보험금으로 수익자(수익자의 지정이 없을 때에는 피보험자의 상속인)에게 지급하며, 80% 이상 후유장해가 남았을 경우 후유장해보험금으로 피보험자에게 지급합니다. 다만, 여행도중에 발생한 질병을 직접원인으로 하여 보험기간 마지막날로부터 30일 이내에 사망하거나 또는 80% 이상 후유장해가 남았을 경우에도 동일하게 보상하여 드립니다.
                    <br>
                        ② 제1항에도 불구하고 영구히 고정된 증상은 아니지만 치료 종결 후 한시적으로 나타나는 장해이나 그 기간이 5년 이상인 때에는 후유장해로 인정하고 해당 장해지급률의 20%를 후유장해지급률로 하여 제1항을 적용합니다.
                    <br>
                        ③ 제1항 및 제2항의 질병사망보험금 지급을 위한 후유장해지급률이 사고일로부터 180일이 지나도록 확정되지 아니하는 경우에는 사고일로부터 180일이 되는 날의 의사 진단에 기초하여 고정될 것으로 인정되는 상태를 후유장해의 지급률로 결정합니다. 다만, 그 이후 보장을 받을 수 있는 기간 중에 장해상태가 더 악화되는 경우에는 그 악화된 장해상태를 기준으로 후유장해지급률을 결정하되 장해분류표에 장해판정 시기가 별도로 정해진 경우에는 그에 따릅니다.
                    <br>
                        ④ 장해분류표에 해당되지 아니하는 후유장해는 피보험자의 직업, 연령, 신분 또는 성별 등에 관계없이 신체의 장해정도에 따라 장해분류표의 구분에 준하여 지급액을 결정합니다. 다만, 장해분류표의 각 장해분류별 최저지급률 장해정도에 이르지 않는 후유장해에 대하여는 후유장해보험금을 지급하지 아니합니다.
                    <br>
                        ⑤ 같은 사고로 두 가지 이상의 후유장해가 생긴 경우에는 후유장해 지급률을 합산하여 지급합니다. 다만, 장해분류표의 각 신체부위별 판정기준에서 별도로 정한 경우에는 그 기준에 따릅니다.
                    <br>
                        ⑥ 제5항에도 불구하고 동일한 신체부위에 장해분류표상의 2가지 이상의 장해가 발생한 경우에는 합산하지 않고 그 중 높은 지급률을 적용합니다. 다만, 장해분류표의 각 신체부위별 판정기준에서 별도로 정한 경우에는 그 기준에 따릅니다.
                    </dd>

                    <dt>제2조 (보험계약의 무효)</dt>
                    <dd>보통약관 제17조(계약의 무효)에서 정한 및 계약을 체결할 때 15세 미만자, 심신상실자 또는 심신박약자를 피보험자로 한 경우에는 이 특별약관은 무효로 합니다.
                    </dd>

                    <dt>제3조 (계약연령의 계산)</dt>
                    <dd>① 피보험자의 계약연령은 계약일 현재 만 연령으로 계산하고 1년미만의 단수가 있을 때에는 6개월 미만은 버리고 6개월 이상은 1년으로 계산합니다.
                    <br>
                        ② 제1항에 따라 계산된 계약연령이 계산착오로 피보험자의 실제 연령과 차이가 있는 경우에 실제연령이 이 보험의 가입연령 범위내일 경우에는 실제연령에 의하여 계산된 것으로 보고 이로 인하여 보험료의 변경이 있을 때에는 변경에 따른 정해진 보험료를 받거나 돌려 드립니다.
                    </dd>

                    <dt>제4조(준용규정)</dt>
                    <dd>이 특별약관에 정하지 아니한 사항은 보통약관을 따릅니다.</dd>

                    <dt>2. 질병의료비</dt>
                    <dt>2-1. 질병의료비 특별약관</dt>
                    <dt>제1조 (보상하는 손해)</dt>
                    <dd>① 회사는 피보험자가 보통약관 제6조(보상하는 손해)의 여행도중에 질병(다만, 보험계약 청약일로부터 과거 5년이내에 그 질병으로 인하여 진단 또는 치료를 받은 경우에는 제외합니다.)으로 인하여 의사의 치료를 받기 시작했을 때 이 특별약관에 따라 피보험자가 부담하는 의료실비를 보상하여 드립니다. 다만, 의사의 치료를 받기 시작한 날로부터 180일을 한도로 하며, 여행도중에 발생한 질병을 직접원인으로 하여 보험기간 만료후 30일 이내에 의사의 치료를 받기 시작했을 때에도 동일하게 보상하여 드립니다.
                    <br>
                        ② 제1항의 비용은 1질병에 대하여 질병의료비 보험가입금액을 한도로 합니다. 단, 척추지압술(Chiropractic, 추나요법 등)이나 침술(부항, 뜸 포함)치료로 인한 의료비는 치료받는 국가의 법에서 정한 병원 및 의사의 자격을 가진 자에 의하여 치료를 받은 경우에 한하며, 하나의 질병에 대하여 US $700.00 한도로 보상하여 드립니다.
                    <br>
                        ③ 제1항의 비용에 대하여 보험금을 지급할 다수의 계약이 체결되어 있는 경우에는 각각의 계약에 대하여 다른 계약이 없는 것으로 하여 산출한 보상책임액의 합계액이 제1항의 비용을 초과했을 때 회사는 이 계약에 따른 보상책임액의 위의 합계액에 대한 비율에 따라 질병의료비 보험금을 지급합니다.
                    </dd>

                    <dt>제2조 (보상하지 아니하는 손해)</dt>
                    <dd>회사는 그 원인의 직접 간접을 묻지 아니하고 보통약관 제7조(보상하지 아니하는 손해)의 제1항의 제1호~제3호, 제7호~제11호 및 아래의 사유를 원인으로 하여 생긴 손해는 보상하여 드리지 아니합니다.
                    <br>
                        1. 회사가 보통약관에 따라 보험금을 지급할 상해에 기인하는 질병
                    <br>
                        2. 임신, 출산, 유산. 그러나 질병에 기인하는 경우에는 보상하여 드립니다.
                    <br>
                        3. 치아보철 등의 치과치료 비용. 그러나 질병은 보상하여 드립니다.
                    </dd>

                    <dt>제3조 (준용규정)</dt>
                    <dd>이 특별약관에 정하지 아니한 사항은 보통약관을 따릅니다.
                    </dd>

                    <dt>2-2. 자기부담금설정 추가특별약관</dt>
                    <dt>제1조 (보험금의 지급)</dt>
                    <dd>회사는 특별약관 제1조(보상하는 손해) 제1항의 규정에도 불구하고 회사가 지급하는 보험금은 1사고마다 피보험자가 실제로 지급한 비용 중 ( )만원을 초과하는 금액으로 합니다.
                    </dd>

                    <dt>제2조 (준용규정)</dt>
                    <dd>이 추가특별약관에 정하지 아니한 사항은 보통약관 및 특별약관을 따릅니다.
                    </dd>

                    <dt>3. 배상책임 특별약관</dt>
                    <dt>제1조 (보상하는 손해)</dt>
                    <dd>회사는 피보험자가 보통약관 제6조(보상하는 손해)의 여행도중에 생긴 우연한 사고(이하「사고」라 합니다)로 타인의 신체의 장해(이 특별약관에 있어서는 상해, 질병, 사망, 후유장해를 말합니다) 또는 재물의 손해(재물의 없어짐, 손상 및 망가짐을 포함합니다)에 대한 법률적인 배상책임을 부담함으로써 입은 아래의 손해를 이 특별약관에 따라 보상하여 드립니다.
                    <br>
                        ① 피보험자가 피해자에게 지급한 법률상 손해배상금
                    <br>
                        ② 피보험자가 지출한 아래의 비용
                    <br>
                        1. 피보험자가 제6조(손해방지의무) 제1항 제1호의 방법을 조사하여 구하기 위하여 지급한 필요 또는 유익하였던 비용. 그러나 피보험자가 그 방법을 조사하여 구한 후에 배상책임이 없음이 판명된 때에는 그 비용 중 응급처치, 긴급호송 또는 그 밖의 긴급조치를 위하여 지급한 비용과 지급에 관하여 미리 회사의 동의를 받은 비용만 보상합니다.
                    <br>
                        2. 피보험자가 제6조(손해방지의무) 제1항 제2호의 절차를 취하는데 지급한 필요 또는 유익하였던 비용
                    <br>
                        3. 피보험자가 미리 회사의 동의를 받아 지급한 소송비용, 변호사보수, 중재, 화해 또는 조정에 관한 비용
                    <br>
                        4. 증권상 보상한도액내의 금액에 대한 공탁보증보험료. 그러나 그러한 보증을 제공할 책임은 부담하지 아니합니다.
                    <br>
                        5. 피보험자가 제7조(손해배상청구에 대한 회사의 해결) 제2항 및 제3항의 회사의 요구에 따르기 위하여 지급한 비용
                    <br>
                    </dd>

                    <dt>제2조 (보상하지 아니하는 손해)</dt>
                    <dd>회사는 보통약관 제7조(보상하지 아니하는 손해) 제1항 제1호, 제8호~제11호 및 아래의 사유로 손해배상책임을 부담하게 됨으로써 입은 손해는 보상하여 드리지 아니합니다.
                    <br>
                        1. 피보험자의 직무수행에 직접 기인하는 배상책임
                    <br>
                        2. 피보험자의 직무용으로만 사용되는 동산의 소유, 사용 또는 관리에 기인하는 배상책임
                    <br>
                        3. 피보험자가 소유, 사용 또는 관리하는 부동산에 기인하는 배상책임
                    <br>
                        4. 피보험자의 근로자가 피보험자의 업무에 종사 중에 입은 신체의 장해에 기인하는 배상책임. 단, 피보험자의 가사사용인에 대하여는 이와 같지 아니합니다.
                    <br>
                        5. 피보험자와 타인간에 손해배상에 관한 약정이 있는 경우, 그 약정에 의하여 가중된 배상책임
                    <br>
                        6. 피보험자와 세대를 같이하는 친족(민법 제777조규정의 범위와 같습니다) 및 여행과정을 같이 하는 친족에 대한 배상책임
                    <br>
                        7. 피보험자가 소유, 사용 또는 관리하는 재물이 손해를 입었을 경우에 그 재물에 대하여 정당한 권리를 가진 사람에게 부담하는 손해에 대한 배상책임. 단, 호텔의 객실이나 객실내의 동산에 끼치는 손해에 대하여는 이와 같지 아니합니다.
                    <br>
                        8. 피보험자의 심신상실에 기인하는 배상책임
                    <br>
                        9. 피보험자 또는 피보험자의 지시에 따른 폭행 또는 구타에 기인하는 배상책임
                    <br>
                        10. 항공기, 선박, 차량(원동력이 인력에 의한 것을 제외합니다), 총기(공기총은 제외합니다)의 소유, 사용 또는 관리에 기인하는 배상책임
                    </dd>

                    <dt>제3조 (보험금 등의 지급한도)</dt>
                    <dd>① 회사가 보상하는 손해배상금은 보험가입증서(보험증권)에 기재된 보상한도액을 한도로 합니다.
                    <br>
                        ② 회사는 1회의 사고에 대하여 손해배상금이 보험가입증서(보험증권)에 기재된 자기부담금을 초과하는 경우에 한하여 그 초과분을 보상합니다. 그러나 보험기간중 발생하는 사고에 대한 회사의 보상총액은 보험가입증서(보험증권)에 기재된 총보상한도액을 한도로 합니다.
                    <br>
                        ③ 회사는 위 제2항의 손해배상금과 제1조(보상하는 손해) 제2항 제1호 내지 제5호의 비용 전액을 보상합니다. 그러나 손해배상청구금액이 보험가입증서(보험증권)에 기재된 보상한도액을 초과하는 경우 제1조(보상하는 손해) 제2항의 제2호 및 제3호의 비용중 소송비용의 인지대 및 변호사 비용 및 제4호의 비용은 보험가입증서(보험증권)에 기재된 보상한도액에 해당하는 금액에 대한 비용만 보상합니다.
                    </dd>

                    <dt>제4조 (타인을 위한 계약)</dt>
                    <dd>① 계약자는 타인을 위한 계약을 체결하는 경우에 그 타인의 위임이 없는 때에는 반드시 이를 회사에 알려야 하며, 이를 알리지 않았을 때에는 그 타인은 이 계약이 체결된 사실을 알지 못하였다는 사유로 회사에 이의를 제기할 수 없습니다.
                    <br>
                        ② 타인을 위한 계약에서 보험사고가 발생한 경우에 계약자가 그 타인에게 보험사고의 발생으로 생긴 손해를 배상한 때에는 계약자는 그 타인의 권리를 해하지 아니하는 범위 안에서 회사에 보험금의 지급을 청구할 수 있습니다.
                    </dd>

                    <dt>제5조 (손해의 발생과 통지)</dt>
                    <dd>① 계약자 또는 피보험자는 아래와 같은 사실이 있는 경우에는 지체없이 그 내용을 서면으로 회사에 알려야 합니다.
                    <br>
                        1. 사고가 발생하였을 경우 사고가 발생한 때와 곳, 피해자의 주소와 성명, 사고상황 및 이들 사항의 증인이 있을 경우 그 주소와 성명
                    <br>
                        2. 제3자로부터 손해배상청구를 받았을 경우
                    <br>
                        3. 손해배상책임에 관한 소송을 제기받았을 경우
                    <br>
                        ② 계약자 또는 피보험자가 제1항 제1호 및 제2호의 통지를 게을리하여 손해가 증가된 때에는 회사는 그 증가된 손해를 보상하여 드리지 아니하며, 제1항 제3호의 통지를 게을리 한 때에는 소송비용과 회사가 손해배상책임이 없다고 인정되는 부분은 보상하여 드리지 아니합니다.
                    </dd>

                    <dt>제6조 (손해방지의무)</dt>
                    <dd>① 보험사고가 생긴 때에는 계약자 또는 피보험자는 아래의 사항을 이행하여야 합니다.
                    <br>
                        1. 손해의 방지 또는 경감을 위한 일체의 방법을 조사하여 구하는 일
                    <br>
                        2. 제3자로부터 손해의 배상을 받을 수 있는 경우에는 그 권리를 지키거나 행사하기 위한 필요한 절차를 취할 일
                    <br>
                        3. 손해배상책임의 전부 또는 일부를 승인하고자 할 때에는 미리 회사의 동의를 받을 일. 그러나 피해자에 대한 응급처치, 긴급호송 또는 그밖의 긴급조치는 그러하지 아니합니다.
                    <br>
                        4. 손해배상책임에 관하여 피보험자가 소송을 제기하려고 할 때에는 미리 회사의 동의를 받을 일
                    <br>
                        ② 계약자 또는 피보험자가 정당한 이유 없이 제1항의 의무를 이행하지 아니하였을 때에는 그 손해액을 아래에 따라 결정합니다.
                    <br>
                        1. 제1항 제1호 및 제2호의 경우에는 손해를 방지 또는 경감할 수 있었다고 인정되는 부분을 뺍니다.
                    <br>
                        2. 제1항 제3호의 경우에는 회사가 손해배상책임이 없다고 인정되는 부분을 뺍니다.
                    <br>
                        3. 제1항 제4호의 경우에는 소송비용 및 변호사비용과 회사가 손해배상책임이 없다고 인정되는 부분을 뺍니다.
                    </dd>

                    <dt>제7조 (손해배상청구에 대한 회사의 해결)</dt>
                    <dd>① 피보험자가 피해자에게 손해배상책임을 지는 사고가 생긴 때에는 피해자는 이 특별약관에 의하여 회사가 피보험자에게 지급책임을 지는 금액한도내에서 회사에 대하여 보험금의 지급을 직접 청구할 수 있습니다. 그러나 회사는 피보험자가 그 사고에 관하여 가지는 항변으로써 피해자에게 대항할 수 있습니다.
                    <br>
                        ② 회사가 제1항의 청구를 받았을 때에는 지체없이 피보험자에게 통지하여야 하며, 회사의 요구가 있으면 계약자 또는 피보험자는 필요한 서류증거의 제출, 증언 또는 증인출석에 협조하여야 합니다.
                    <br>
                        ③ 피보험자가 피해자로부터 손해배상의 청구를 받았을 경우에 회사가 필요하다고 인정할 때에는 피보험자를 대신하여 회사의 비용으로 이를 해결할 수 있습니다. 이 경우에 회사의 요구가 있으면 계약자 및 피보험자는 이에 협력하여야 합니다.
                    <br>
                        ④ 계약자 및 피보험자가 정당한 이유없이 제2항, 제3항의 요구에 협조하지 아니할 때에는 회사는 그로 인하여 늘어난 손해는 보상하여 드리지 아니합니다.
                    </dd>

                    <dt>제8조 (보험금의 지급)</dt>
                    <dd>① 피보험자가 보험금을 청구할 때에는 다음의 서류를 회사에 제출하여야 합니다.
                    <br>
                        1. 보험금 청구서
                    <br>
                        2. 신분증(주민등록증 또는 운전면허증 등 사진이 부착된 정부기관발행 신분증, 본인이 아닌 경우에는 본인의 인감증명서 포함)
                    <br>
                        3. 손해배상금 및 그 밖의 비용을 지급하였음을 증명하는 서류
                    <br>
                        4. 회사가 요구하는 그 밖의 서류
                    <br>
                        ② 회사는 제1항에 따른 보험금 청구를 받은 후 지체없이 지급할 보험금을 결정하고 지급할 보험금이 결정되면 10영업일 이내에 이를 지급하여 드립니다. 그러나 보험금 지급에 필요한 조사를 이 기간내에 마칠 수 없고 피보험자의 청구가 있을 때에는 회사가 추정한 보험금의 50% 상당액을 가지급보험금으로 지급합니다.
                    <br>
                        ③ 회사는 제2항의 지급보험금이 결정된 후 10영업일이 지나도록 보험금을 지급하지 아니하였을 때에는 지체된 날로부터 지급일까지 보험개발원이 매월 공시하는 1년만기 정기예금 이율에 의한 지연배상금을 지급합니다. 그러나 피보험자의 책임있는 사유로 지체된 경우에는 그러하지 아니합니다.
                    <br>
                        ④ 회사는 피보험자가 제1항의 서류중 기재사항에 관하여 거짓으로 기재하거나 어떠한 사실을 숨겼을 경우에는 일체의 보험금을 지급하지 아니합니다. 그러나 계약자 또는 피보험자의 책임있는 사유로 지급이 지연된 때에는 그 해당기간에 대한 이자를 더하여 드리지 아니합니다.
                    </dd>

                    <dt>제9조 (보험금의 분담)</dt>
                    <dd>① 이 계약에서 보장하는 위험과 같은 위험을 보장하는 다른 계약(공제계약(각종 공제회에 가입되어 있는 계약)을 포함합니다)이 있을 경우 각 계약에 대하여 다른 계약이 없는 것으로 하여 각각 산출한 보상책임액의 합계액이 손해액을 초과할 때에는 회사는 이 계약에 의한 보상책임액의 전기합계액(각각 산출한 보상책임액의 합계액)에 대한 비율에 따라 손해를 보상합니다. 이 계약과 다른 계약이 모두 의무보험인 경우에도 같습니다.
                    <br>
                        ② 의무보험이 아닌 보험계약에 대하여는 의무보험에서 보상되는 금액(피보험자가 가입을 하지 않은 경우에는 보상될 것으로 추정되는 금액)을 차감한 금액을 손해액으로 간주하여 제1항에 의한 보상할 금액을 결정합니다.
                    <br>
                        ③ 피보험자가 다른 계약에 대하여 보험금 청구를 포기한 경우에도 회사의 제1항에 의한 지급보험금 결정에는 영향을 미치지 아니합니다.
                    </dd>

                    <dt>제10조 (대위권)</dt>
                    <dd>① 회사가 보험금을 지급한 때에는 회사는 지급한 보험금의 한도내에서 아래의 권리를 가집니다. 다만, 회사가 보상한 금액이 피보험자가 입은 손해의 일부인 경우에는 피보험자의 권리를 침해하지 아니하는 범위내에서 그 권리를 가집니다.
                    <br>
                        1. 피보험자가 제3자로부터 손해배상을 받을 수 있는 경우에는 그 손해배상청구권
                    <br>
                        2. 피보험자가 손해배상을 함으로써 대위 취득하는 것이 있을 경우에는 그 대위권
                    <br>
                        ② 계약자 또는 피보험자는 제1항에 의하여 회사가 취득한 권리를 행사하거나 지키는 것에 관하여 필요한 조치를 하여야 하며, 또한 회사가 요구하는 증거 및 서류를 제출하여야 합니다.
                    <br>
                        ③ 회사는 제1항, 제2항에도 불구하고 타인을 위한 보험계약의 경우에는 계약자에 대한 대위권을 포기합니다.
                    </dd>

                    <dt>제11조 (준용규정)</dt>
                    <dd>이 특별약관에 정하지 아니한 사항은 보통약관을 따릅니다.
                    </dd>

                    <dt>4. 휴대품손해 특별약관</dt>
                    <dt>제1조 (보험목적의 범위)</dt>
                    <dd>① 이 보험의 목적은 피보험자가 여행도중에 휴대하는 피보험자 소유∙사용∙관리의 휴대품에 한합니다.
                    <br>
                        ② 아래의 물건은 보험의 목적에 포함되지 아니합니다.
                    <br>
                        1. 통화, 유가증권, 인지, 우표, 신용카드, 쿠폰, 항공권, 여권 등 이와 비슷한 것
                    <br>
                        2. 원고, 설계서, 도안, 장부 기타 이들에 준하는 것
                    <br>
                        3. 선박 또는 자동차(자동3륜차, 자동2륜차 포함)
                    <br>
                        4. 산악 등반이나 탐험등에 필요한 용구
                    <br>
                        5. 동물, 식물
                    <br>
                        6. 의치, 의수족, 콘택트렌즈
                    <br>
                        7. 기타(보험가입증서(보험증권)에 특별히 기재된 것)
                    </dd>

                    <dt>제2조 (보상하는 손해)</dt>
                    <dd>회사는 피보험자가 보통약관 제6조(보상하는 손해)의 여행도중에 생긴 우연한 사고에 의하여 보험의 목적에 입은 손해를 이 특별약관에 따라 보상해 드립니다.
                    </dd>

                    <dt>제3조 (보상하지 아니하는 손해)</dt>
                    <dd>회사는 보통약관 제7조(보상하지 아니하는 손해) 제1항 제8호~제11호 및 아래의 사유로 인하여 생긴 손해는 보상하여 드리지 아니합니다.
                    <br>
                        1. 계약자 또는 피보험자의 고의 또는 중대한 과실
                    <br>
                        2. 피보험자에게 보험금이 지급되도록 하기 위하여 피보험자와 여행을 같이 하는 친족 또는 고용인이 고의로 일으킨 손해
                    <br>
                        3. 압류, 징발, 몰수, 파괴 등 국가 또는 공공기관의 공권력행사. 단, 화재, 소방, 피난에 필요한 처리로 된 경우를 제외합니다.
                    <br>
                        4. 보험의 목적의 흠으로 생긴 손해. 그러나 보험계약자, 피보험자 또는 이들을 대신하여 보험의 목적을 관리하는 자가 상당한 주의를 하였음에도 불구하고 발견하지 못한 흠으로 인한 손해는 보상하여 드립니다.
                    <br>
                        5. 보험의 목적의 자연소모, 녹, 곰팡이, 변질, 변색등과 쥐나 벌레로 인한 손해
                    <br>
                        6. 단순한 외관상의 손해로 기능에는 지장이 없는 손해
                    <br>
                        7. 보험의 목적인 액체의 유출. 단, 그 결과로 다른 보험의 목적에 생긴 손해는 보상하여 드립니다.
                    <br>
                        8. 보험의 목적의 방치 또는 분실
                    </dd>

                    <dt>제4조 (손해방지의무)</dt>
                    <dd>① 보험사고가 생긴 때에는 계약자 또는 피보험자는 손해의 방지와 경감에 힘써야 합니다. 만약 고의 또는 중대한 과실로 이를 게을리한 때에는 방지 또는 경감할 수 있었을 것으로 밝혀진 부분을 손해액에서 뺍니다.
                    <br>
                        ② 회사는 제1항의 손해방지 또는 경감에 소요된 필요 또는 유익한 비용(이하「손해방지비용」이라 합니다) 제6조(지급보험금의 계산)의 지급보험금 계산 방법에 준하여 이를 보상하여 드립니다.
                    <br>
                        ③ 회사는 제6조(지급보험금의 계산)의 지급보험금에 제2항의 손해방지비용을 합한 금액이 보험가입금액을 초과하더라도 이를 지급합니다.
                    </dd>

                    <dt>제5조 (손해액의 조사결정)</dt>
                    <dd>회사가 보상할 손해액은 그 손해가 생긴 때와 곳에서의 보험의 목적의 가액(이하「보험가액」이라 합니다)에 따라 계산합니다.
                    </dd>

                    <dt>제6조 (지급보험금의 계산)</dt>
                    <dd>① 회사가 지급할 보험금은 손해액에서 1회의 사고에 대하여 보험가입증서(보험증권)에 기재된 자기부담금을 공제한 금액으로 합니다.
                    <br>
                        ② 보험의 목적의 손상을 수선할 경우에는 보험의 목적을 손해발생 직전의 상태로 복원하는데 필요한 비용을 제1항의 손해액으로 합니다.
                    <br>
                        ③ 보험의 목적이 1조 또는 1쌍으로 된 경우에 있어, 그 일부에 손해가 생겼을 때 그 손해가 당해 보험목적 전체의 가치에 미치는 영향을 고려하여 손해액을 결정합니다. 이 경우에 당해 부분의 수선비가 보험가액을 초과하는 경우를 제외하고는 어떠한 경우에도 전부 손해로 볼 수 없습니다.
                    <br>
                        ④ 보험의 목적의 1개 또는 1조, 1쌍에 대한 제1항의 지급할 보험금은 200,000원을 한도로 합니다.
                    <br>
                        ⑤ 보험의 목적에 대하여 이 계약에서 보상하는 위험과 같은 위험을 보상하는 다른 계약이 있을 경우에는 각각의 계약에 대하여 다른 계약이 없는 것으로 하여 산출한 보상책임액의 합계액이 손해액을 초과했을 때, 회사는 이 계약에 따른 보상책임액의 전기합계액에 대한 비율에 따라 보험금을 지급합니다.
                    </dd>

                    <dt>제7조 (잔존물 및 도난품의 귀속)</dt>
                    <dd>① 회사가 보험금을 지급하였을 때는 보험의 목적의 잔존물은 회사가 그것을 취득할 의사를 표시하지 않은 경우에 한하여 피보험자에게 귀속되는 것으로 합니다.
                    <br>
                        ② 도난당한 보험의 목적이 발견된 때에는 아래에 따라 처리합니다.
                    <br>
                        1. 회사가 손해보상을 하기 전에 보험의 목적을 회수하였을 때에는 그 회수물에 대해 도난손해가 발생하지 않았던 것으로 합니다.
                    <br>
                        2. 회사가 손해배상을 한 후에 보험의 목적이 회수된 경우에 그 소유권이 회사에 귀속되는 것으로 합니다. 이 경우 회사는 이를 타당한 값으로 매각하고, 그 대금이 보험의 목적에 대하여 보상한 금액과 회수 또는 매각에 소요된 필요비용을 합한 금액을 넘을 때에는 그 초과액을 피보험자에게 돌려 드립니다. 그러나 피보험자는 보험의 목적의 매각전에 지급받은 보험금은 회사에 반환하고 그 물건을 찾아갈 수 있습니다.
                    <br>
                        ③ 제2항과 관련하여 보험의 목적에 도난, 강탈 이외의 원인으로 생긴 손해 및 계약자나 피보험자가 보험의 목적을 회수하는데 소요된 비용이 있는 경우 회사는 제6조(지급보험금의 계산)의 계산방법에 따라 산출한 금액을 보상하여 드립니다.
                    <br>
                    </dd>

                    <dt>제8조 (대위권)</dt>
                    <dd>① 회사가 보험금을 지급한 때에는 회사는 지급한 보험금 한도내에서 계약자 또는 피보험자가 제3자에 대하여 가지는 손해배상 청구권을 취득합니다. 다만, 회사가 보상한 금액이 피보험자가 입은 손해의 일부인 경우에는 피보험자의 권리를 침해하지 아니하는 범위내에서 그 권리를 취득합니다.
                    <br>
                        ② 계약자 또는 피보험자는 제1항에 의하여 회사가 취득한 권리를 행사하거나 지키는 것에 관하여 필요한 조치를 하여야 하며 또한 회사가 요구하는 증거 및 서류를 제출하여야 합니다. 이에 필요한 비용은 회사가 드립니다.
                    <br>
                        ③ 회사는 제1항, 제2항에도 불구하고 타인을 위한 계약의 경우에는 계약자에 대한 대위권을 포기합니다.
                    <br>
                    </dd>

                    <dt>제9조 (용어의 대체)</dt>
                    <dd>보통약관 제19조(손해의 통지)에서의 사고는 손해로 대체됩니다.
                    </dd>

                    <dt>제10조 (준용규정)</dt>
                    <dd>이 특별약관에 정하지 아니한 사항은 보통약관을 따릅니다.
                    </dd>

                    <dt>5. 특별비용 특별약관</dt>
                    <dt>제1조 (보상하는 손해)</dt>
                    <dd>① 회사는 아래의 사유로 계약자, 피보험자 또는 피보험자의 법정상속인이 부담하는 비용을 이 특별약관에 따라 보상하여 드립니다.
                    <br>
                        1. 보통약관 제6조(보상하는 손해)의 여행도중(이하「여행도중」이라 합니다)에 피보험자가 탑승한 항공기 또는 선박이 행방불명 또는 조난된 경우 또는 산악등반 중에 조난된 경우 2. 여행도중에 급격하고도 우연한 외래의 사고에 따라 긴급수색구조 등이 필요한 상태로 된 것이 경찰등의 공공기관에 의하여 확인된 경우
                    <br>
                        3. 보통약관 제6조(보상하는 손해)의 상해를 직접 원인으로 하여 사고일로부터 1년이내에 사망한 경우 또는 14일이상 계속 입원한 경우(다른 의료기관으로 이전한 경우에는 이전에 소요된 기간을 입원중으로 봅니다. 다만, 그 이전에 대하여는 치료를 위하여 의사가 필요하다고 인정한 경우에 한합니다. 이하 같습니다.)
                    <br>
                        4. 질병을 직접 원인으로 하여 여행도중에 사망한 경우 또는 질병을 직접 원인으로 하여 14일이상 계속 입원한 경우. 다만, 입원에 대하여는 여행도중에 의사가 치료를 개시한 질병으로 인한 입원에 한합니다.
                    <br>
                        ② 제1항 제1호의 산악등반 중 피보험자의 조난이 확실치 않은 경우에는 피보험자의 하산 예정일이후 계약자 또는 피보험자의 법정상속인이나 이들을 대신한 사람이 경찰서 등의 공공기관, 조난구조대, 해난구조회사 또는 항공회사에 수색을 의뢰한 것을 조난이 발생한 것으로 봅니다.
                    </dd>

                    <dt>제2조 (비용의 범위)</dt>
                    <dd>① 회사가 보상하는 비용의 범위는 아래와 같습니다.
                    <br>
                        1. 수색구조비용
                    <br>
                        조난당한 피보험자를 수색, 구조 또는 이송(이하「수색」이라 합니다)하는 활동에 필요한 비용중 이들의 활동에 종사한 사람으로부터의 청구에 의하여 지급한 비용을 말합니다.
                    <br>
                        2. 항공운임 등 교통비
                    <br>
                        피보험자의 수색, 간호 또는 사고처리를 위하여 사고발생지 또는 피보험자의 법정상속인(그 대리인을 포함합니다. 이하「구원자」라 합니다)의 현지 왕복교통비를 말하며 2명분을 한도로 합니다.
                    <br>
                        3. 숙박비
                    <br>
                        현지에서의 구원자의 숙박비를 말하며 구원자 2명분을 한도로 하여 1명당 14일분을 한도로 합니다.
                    <br>
                        4. 이송비용
                    <br>
                        피보험자가 사망한 경우 그 유해를 현지로부터 보험가입증서(보험증권)에 기재된 피보험자의 주소지에 이송하는데 필요한 비용 및 치료를 계속중인 피보험자를 보험가입증서(보험증권)에 기재된 피보험자의 주소지에 이송하는데 드는 비용으로서 통상액을 넘는 피보험자의 운임 및 수행하는 의사, 간호사의 호송비를 말합니다.
                    <br>
                        5. 제잡비
                    <br>
                        구원자의 출입국 절차에 필요한 비용(여권인지대, 사증료, 예방접종료 등) 및 구원자 또는 피보험자가 현지에서 지출한 교통비, 통신비, 피보험자 유해처리비 등을 말하고 10만원을 한도로 합니다.
                    </dd>

                    <dt>제3조 (보상하지 아니하는 손해)</dt>
                    <dd>회사는 보통약관 제7조(보상하지 아니하는 손해) 제1항 제1호~제3호, 제7호~제11호의 사유로 인하여 생긴 손해는 보상하여 드리지 아니합니다.
                    </dd>

                    <dt>제4조 (보험금의 지급)</dt>
                    <dd>회사는 제2조(비용의 범위)의 비용 중 정당하다고 인정된 부분에 대해서만 보상하여 드리며, 계약자, 피보험자 또는 보험수익자가 타인으로부터 손해배상을 받을 수 있는 경우에는 그 금액을 지급하지 아니합니다.
                    </dd>

                    <dt>제5조 (보험금의 분담)</dt>
                    <dd>제1조(보상하는 손해)의 비용에 대하여 보험금을 지급할 다수의 계약이 체결되어 있는 경우에는 각각의 계약에 대하여 다른 계약이 없는 것으로 하여 산출한 보상책임액의 합계액이 그 비용을 초과했을 때 회사는 이 계약에 따른 보상책임액의 위의 합계액에 대한 비율에 따라 보험금을 지급하여 드립니다.
                    </dd>

                    <dt>제6조 (보상한도액)</dt>
                    <dd>회사가 이 특별약관에 관하여 지급할 보험금은 보험기간을 통하여 이 특별약관의 보험가입금액을 한도로 합니다.
                    </dd>

                    <dt>제7조 (준용규정)</dt>
                    <dd>이 특별약관에 정하지 아니한 사항은 보통약관을 따릅니다.
                    </dd>

                    <dt>6. 천재 상해위험 특별약관</dt>
                    <dt>제1조 (보상하는 손해)</dt>
                    <dd>회사는 피보험자가 보통약관 제7조(보상하지 아니하는 손해) 제1항 제8호에도 불구하고 지진, 분화 또는 해일로 보통약관 제6조(보상하는 손해)에 정한 상해를 입었을 때에는 그 상해로 인하여 생긴 손해를 이 특별약관에 따라 보상하여 드립니다.
                    </dd>

                    <dt>제2조 (준용규정)</dt>
                    <dd>이 특별약관에 정하지 아니한 사항은 보통약관을 따릅니다.
                    </dd>

                    <dt>7. 사망․후유장해보험금만의 지급특별약관</dt>
                    <dt>제1조 (보상하는 손해)</dt>
                    <dd>① 회사는 이 특별약관에 따라 보통약관에 규정한 사망․후유장해 보험금만을 지급하여 드립니다. 이 경우 회사는 이 특별약관에 따라 의료비보험금은 지급하지 아니합니다. ② 이 특별약관은 질병의료비 특별약관과 동시에 붙일 수 없습니다.
                    </dd>

                    <dt>제2조 (준용규정)</dt>
                    <dd>이 특별약관에 정하지 아니한 사항은 보통약관을 따릅니다.
                    </dd>

                    <dt>8. 외교관 특별약관</dt>
                    <dt>제1조 (피보험자의 범위)</dt>
                    <dd>이 특별약관은 보통약관의 피보험자로 하는 경우에 적용합니다.
                    <br>
                        1. 대한민국 외교관 신분으로 외국에 파견 또는 주재하는 자
                    <br>
                        2. 제1호의 배우자
                    <br>
                        3. 제1호의 직계 자녀로서 만19세까지의 자녀
                    </dd>

                    <dt>제2조 (보험가입금액)</dt>
                    <dd>각 피보험자에 대한 보험가입금액은 다음과 같습니다.
                    <br>
                        피보험자 사망․후유장해($) 의료비($)
                    <br>
                        본 인 300,000 1,000
                    <br>
                        배 우 자 200,000 1,000
                    <br>
                        자녀1인당 10,000 1,000
                    </dd>

                    <dt>제3조 (보상하는 손해)</dt>
                    <dd>① 회사는 제1조(피보험자의 범위)의 피보험자가 보험가입증서(보험증권)에 기재된 외국에 파견 또는 주재할 목적으로 현지로 출발하기 위하여 국내의 공항이나 부두에서 비행기 또는 선박에 탑승한 때로부터 귀국하여 비행기나 선박에서 내릴 때까지의 기간동안에 급격하고도 우연한 외래의 사고(이하「사고」라 합니다)로 신체에 상해를 입었을 때에는 그 상해로 인하여 생긴 손해를 이 특별약관에 따라 보상하여 드립니다.
                    <br>
                        ② 회사는 보통약관 제7조(보상하지 아니하는 손해) 제1항 제9호에도 불구하고 전쟁, 외국의 무력행사, 혁명, 내란, 폭동, 소요 기타 이들과 유사한 사태로 인하여 피보험자가 상해를 입었을 경우에도 이 특별약관에 따라 제1항의 손해를 보상하여 드립니다. 그러나 그 위험이 뚜렷하게 증가했다고 인정될 때에는 남은기간에 대한 추가보험료 납입통지를 계약자에게 서면으로 발송하며, 계약자는 15일 이내에 추가보험료 수락여부를 회사에 통보하여야 합니다. 만약 계약자가 수락을 거부하거나 통지를 하지 아니할 경우는 15일째 되는 날의 오후 4시에 해당 피보험자에 대한 계약은 그 효력을 상실합니다.
                    </dd>

                    <dt>제4조 (회사의 보장의 시기 및 종기)</dt>
                    <dd>보통약관 제4조(회사의 보장의 시기 및 종기) 제3항에서의 주거지를 출발하기 전과 주거지에 도착한 이후의 발생한 사고는 이 특별약관에서 국내의 공항이나 부두에서 비행기나 선박에 탑승하기 이전과 귀국(일시 귀국인 경우를 포함합니다)하여 비행기나 선박에서 내린 이후의 국내에 있는 기간 동안에 발생한 사고로 변경됩니다.
                    </dd>

                    <dt>제5조 (피보험자의 변경)</dt>
                    <dd>① 다음과 같은 사실이 발생한 경우 해당 피보험자는 그 사실발생과 동시에 이 계약의 피보험자로부터 제외됩니다.
                    <br>
                        1. 피보험자 본인이 무단으로 외교관의 직무를 이탈한 때
                    <br>
                        2. 피보험자가 외국에 망명한 때
                    <br>
                        3. 피보험자 본인이 국내근무발령을 받고 귀국한 때
                    <br>
                        ② 이 계약의 보험기간중에 새로운 피보험자를 추가 또는 주재국을 변경할 경우에 계약자는 회사에 서면으로 그 통지를 발송하여야 합니다.
                    </dd>

                    <dt>제6조 (보험료의 추징․환급)</dt>
                    <dd>① 제3조(보상하는 손해) 제2항 및 제5조(피보험자의 변경) 제1항의 경우에 회사는 해당 피보험자의 경과하지 아니한 기간에 대한 보험료를 일단위로 계산하여 계약자에게 돌려 드립니다.
                    <br>
                        ② 제5조(피보험자의 변경) 제2항의 경우에 보험계약자는 해당 피보험자의 남은 보험기간에 대한 보험료를 납입하여야 합니다.
                    </dd>

                    <dt>제7조 (준용규정)</dt>
                    <dd>이 특별약관에 정하지 아니한 사항은 보통약관을 따릅니다.
                    </dd>

                    <dt>9. 전쟁위험 특별약관</dt>
                    <dt>제1조 (보상하는 손해)</dt>
                    <dd>① 회사는 보통약관 제7조(보상하지 아니하는 손해) 제1항 제10호의 규정에도 불구하고 전쟁, 외국의 무력행사, 혁명, 내란, 폭동, 소요, 기타 이들과 유사한 사태로 인하여 피보험자가 상해를 입었을 때는 보통약관의 규정에 의한 사망․후유장해보험금을 이 특별약관에 따라 지급하여 드립니다.
                    <br>
                        ② 회사는 보험기간이 만료되기 전이라도 제1항의 위험이 뚜렷이 증가했다고 인정될 때에는 24시간 이전에 서면으로 추가보험료를 청구하거나 이 특별약관을 해지할 수 있습니다.
                    </dd>

                    <dt>제2조 (계약 후 알릴 의무의 특례)</dt>
                    <dd>① 피보험자가 여행경로를 변경하는 경우에는 계약자 또는 피보험자는 미리 그 내용을 서면으로 회사에 제출하여야 합니다.
                    <br>
                        ② 회사는 제1항의 통지를 받은 경우에는 회사가 정한 바에 의하여 추가보험료를 청구하거나 이 특별약관을 해지할 수 있습니다.
                    <br>
                        ③ 계약자 또는 피보험자가 제1항의 계약후 알릴 의무를 이행하지 아니한 경우에는 회사는 피보험자가 여행경로를 변경한 이후의 사고로 인한 상해에 대해서는 보상하여 드리지 아니합니다.
                    </dd>

                    <dt>제3조 (보험계약해지의 효력)</dt>
                    <dd>제1조(보상하는 손해) 제2항 및 제2조(계약 후 알릴 의무의 특례) 제2항의 해지는 장래에 대해서만 그 효력이 있습니다.
                    </dd>

                    <dt>제4조 (준용규정)</dt>
                    <dd>이 특별약관에 정하지 아니한 사항은 보통약관을 따릅니다.<br>
                    </dd>

                    <dt>10. 해외연수생 질병의료비 특별약관</dt>
                    <dt>제1조 (피보험자의 범위)</dt>
                    <dd>이 특별약관은 피보험자가 다음과 같은 경우 적용합니다.
                    <br>
                        1. 대학(교) 및 연구소 등에 유학, 연수 및 이와 유사한 연구를 목적으로 하는 자
                    <br>
                        2. 제1호의 배우자
                    <br>
                        3. 제1호의 직계자녀로서 만 19세까지의 자녀
                    </dd>

                    <dt>제2조 (보상하는 손해)</dt>
                    <dd>① 회사는 보통약관 제6조(보상하는 손해)의 여행도중에 질병(다만, 보험계약 청약일로부터 과거 5년이내에 그 질병으로 인하여 진단 또는 치료를 받은 경우에는 제외합니다.)으로 인하여 의사의 치료를 받기 시작했을 때 이 특별약관에 따라 피보험자가 부담하는 의료실비를 보상하여 드립니다. 다만, 의사의 치료를 받기 시작한 날로부터 180일이내의 치료에 소요된 비용을 한도로 하며, 여행도중에 발생한 질병을 직접원인으로 하여 보험기간 만료후 30일 이내에 의사의 치료를 받기 시작했을 때에도 동일하게 보상하여 드립니다.
                    <br>
                        ② 제1항의 비용은 1 질병에 대하여 이 특별약관의 보험가입금액을 한도로 합니다. 단, 척추지압술(Chiropractic, 추나요법 등)이나 침술(부항, 뜸 포함)치료로 인한 의료비는 치료받는 국가의 법에서 정한 병원 및 의사의 자격을 가진 자에 의하여 치료를 받은 경우에 한하며, 하나의 질병에 대하여 US $700.00 한도로 보상하여 드립니다.
                    <br>
                        ③ 제1항의 비용에 대하여 보험금을 지급할 다른 동종의 계약이 있을 경우에는 각각의 계약에 대하여 다른 계약이 없는 것으로 하여 산출한 보상책임액의 합계액이 제1항의 비용을 초과했을 때 회사는 이 계약에 따른 보상책임의 위의 합계액에 대한 비율에 따라 질병치료 보험금을 지급합니다.
                    </dd>

                    <dt>제3조 (보상하지 아니하는 손해)</dt>
                    <dd>회사는 그 원인의 직접 간접을 묻지 아니하고 보통약관 제7조(보상하지 아니하는 손해) 제1항 제1호~제3호, 제7호~제11호 및 아래의 사유를 원인으로 하여 생긴 손해는 보상하여 드리지 아니합니다.
                    <br>
                        1. 회사가 보통약관에 따라 보험금을 지급할 상해에 기인하는 질병
                    <br>
                        2. 임신, 출산, 유산 그러나 질병에 기인하는 경우에는 보상하여 드립니다.
                    <br>
                        3. 치아보철 등의 치과치료비용. 그러나 질병은 보상하여 드립니다.
                    </dd>

                    <dt>제4조 (보상한도)</dt>
                    <dd>회사는 이 특별약관 제2조(보상하는 손해) 제1항의 규정에도 불구하고 회사가 지급하는 보험금은 1사고마다 피보험자가 실제로 지급한 비용중 보험가입증서(보험증권)에 기재된 자기부담금 ( )만원을 공제한 금액으로 합니다.
                    </dd>

                    <dt>제5조 (준용규정)</dt>
                    <dd>이 특별약관에 정하지 아니한 사항은 보통약관을 따릅니다.
                    </dd>


                </dl>
            </div>
        </div>
        <div class="term_wrap">
            <a href="#" class="term_tit">자세히보기</a>
            <label for="agree_8" class="label_chk" onclick="removeMsg(this, 'invalid');">
                <span class="ico_chk"></span>
                개인정보 수집, 이용동의
                <span class="txt_invalid">개인정보 수집, 이용에 동의해주세요.</span>
            </label>
            <input type="checkbox" class="chk" id="agree_8" name="cc">
            <div class="term_con">                                        
                <p>
                    당사는 여행상품의 예약 및 여행관련 서비스 제공 등의 업무처리를 위하여 고객으로부터 최소한의 필수정보를 수집하며, 제공한 모든 개인정보는 별도의 동의가 없는 한 해당목적 이외의 다른 목적으로 사용하지 않습니다.		
                </p>
                <dl>
                    <dt>1. 개인정보의 수집 항목</dt>
                    <dd>: 성명(영문포함), 휴대전화번호, 이메일, 생년월일, 성별, 결제기록, 여권정보, 비자정보 등
                    </dd>
                    <dt>2. 개인정보 수집 및 이용 목적</dt>
                    <dd>가. 콘텐츠 제공, 구매 및 요금결제, 물품 등을 배송(발송), 금융거래 본인인증 및 금융서비스 등의 서비스 제공에 관한 계약 이행 및 요금정산
                    <br>
                        나. 인구통계학적 분석자료<br>
                        다. 불만처리 등의 민원처리 및 고지사항 전달 등을 위한 고객관리
                    </dd>
                    <dt class="agreemet_txt_bold">3. 개인정보 보유 및 이용기간</dt>
                    <dd class="agreemet_txt_bold">아래와 같은 관계법령의 규정에 의하여 정한 기간 동안 보존할 필요가 있는 경우를 제외하고는 개인정보 수집 및 이용목적이 달성된 후 파기합니다.<br>
                        가. 계약 또는 청약철회 등에 관한 기록 : 5년(전자상거래 등에서의 소비자보호에 관한 법률)<br>
                        나. 대금결제 및 재화 등의 공급에 관한 기록 : 5년(전자상거래 등에서의 소비자보호에 관한 법률)<br>
                        다. 소비자의 불만 또는 분쟁처리에 관한 기록: 3년(전자상거래 등에서의 소비자보호에 관한 법률)<br>
                        라. 표시•광고에 관한 기록: 6개월
                    </dd>
                    <dt>4. 동의거부권</dt>
                    <dd>: 개인정보 수집 및 이용 동의를 거부할 권리가 있으며, 미동의 시 여행서비스의 제공이 제한됩니다.
                    </dd>
                </dl>
            </div>
        </div>
        <div class="term_wrap">
            <a href="#" class="term_tit">자세히보기</a>
            <label for="agree_9" class="label_chk" onclick="removeMsg(this, 'invalid');">
                <span class="ico_chk"></span>
                고유식별정보 수집, 이용동의
                <span class="txt_invalid">고유식별정보 수집, 이용에 동의해주세요.</span>
            </label>
            <input type="checkbox" class="chk" id="agree_9">
            <div class="term_con">                                        
                <p>
                    당사는 개인정보보호법을 준수하며 서비스 수행의 목적에 한하여 최소한의 고유식별정보를 수집 및 이용하고 있습니다.		
                </p>
                <dl>
                    <dt>1. 수집 및 이용하는 고유식별 정보 </dt>
                    <dd class="agreemet_txt_bold">: 여권번호
                    </dd>
                    <dt>2. 고유식별 정보 수집 및 이용목적</dt>
                    <dd>가. 보험회사에 여행자 보험 가입<br>
                        나. 해외여행 출국가능 여부파악 및 여행자 본인 식별
                    </dd>
                    <dt>3. 고유식별 정보 보유 및 이용기간</dt>
                    <dd class="agreemet_txt_bold">: 수집이용 목적 또는 제공받은 목적의 달성시까지
                    </dd>
                    <dt>4. 동의거부권</dt>
                    <dd>: 고유식별 정보 수집 및 이용 동의를 거부할 권리가 있으며, 미동의 시 여행서비스의 제공이 제한됩니다.
                    </dd>
                </dl>
            </div>
        </div>
        <div class="term_wrap">
            <a href="#" class="term_tit" data-required="false">자세히보기</a>
            <label for="agree_10" class="label_chk invalid">
                <span class="ico_chk"></span>
                개인정보 제3자 제공동의(선택)
                <span class="txt_invalid">개인정보 제3자 제공에 동의하지 않을 권리가 있으며, 미동의시 여행서비스의 제공이 제한됩니다.</span>
            </label>
            <input type="checkbox" class="chk" id="agree_10">
            <div class="term_con">                                        
                <p>1. 당사는 고객님의 동의가 있거나 관련 법령의 규정에 의한 경우를 제외하고 어떠한 경우에도 ‘개인정보의 수집 및 이용목적’ 에서 고지한 범위를 넘어 서비스와 무관한 타 기업/기관에 제공하거나 이용하지 않습니다. 단, 고객님의 개인정보를 제공 및 공유하는 경우는 다음과 같습니다.</p>
                <table>
                    <caption>수집하는 개인정보의 제3자 제공 표</caption>
                    <colgroup>
                        <col style="width: 33.3%">
                        <col style="width: 33.3%">
                        <col style="width: 33.3%">
                    </colgroup>
                    <tbody><tr>
                        <th scope="col">제공대상</th>
                        <th scope="col">제공하는 항목</th>
                        <th scope="col">제공받는 자의 이용목적</th>
                    </tr>
                    <tr>
                        <td class="agreemet_txt_bold">대한항공, 아시아나항공 외 기타 항공사, 크루즈 및 기타 해운업체, 호텔 및 기타 숙박업체, 기타 현지 랜드업체<br>
                            <a href="http://www.modetour.com/w3c/UsedPlace/AirLand.aspx" target="_blank" title="새창으로열기">[전체보기]</a></td>
                        <td>성명(영문이름포함), 생년월일, 성별, 여권/비자 유무 및 관련 정보(여권만료일, 여권번호 등), 핸드폰번호, 투어마일리지정보, 회원종류</td>
                        <td rowspan="3" class="agreemet_txt_bold">항공권 및 기타운송업체 탑승예약, 숙박예약, 현지 행사 진행 및 고객관리 목적, 서비스 제공, 구매 및 요금 결제, 개인 식별, 불만처리 등 민원처리, 고지사항 전달,마일리지적립/전환,사용확인, 회원할인등</td>
                    </tr>
                    <tr>
                        <td class="agreemet_txt_bold">Rail Europe 외 기타 철도업체<br>
                            <a href="http://www.modetour.com/w3c/UsedPlace/Rail.aspx" target="_blank" title="새창으로열기">[전체보기]</a></td>
                        <td>성명(영문이름포함), 여권/비자 유무 및 관련 정보(여권만료일, 여권번호 등)</td>
                    </tr>
                    <tr>
                        <td class="agreemet_txt_bold">기타 현지 렌터카 업체<br>
                            <a href="http://www.modetour.com/w3c/UsedPlace/RentCar.aspx" target="_blank" title="새창으로열기">[전체보기]</a></td>
                        <td>성명, 자택전화번호, 휴대전화번호, 생년월일, 성별</td>
                    </tr>
                    <tr>
                        <td class="agreemet_txt_bold">그린투어 대리점,자회사 및 제휴사<br>
                            <a href="http://www.modetour.com/w3c/UsedPlace/Agency.aspx" target="_blank" title="새창으로열기">[전체보기]</a></td>
                        <td>성명(영문이름포함), 생년월일,성별, 여권/비자 유무 및 관련 정보(여권만료일, 여권번호 등), 연락처, 이메일, 마일리지정보, 회원종류</td>
                        <td class="agreemet_txt_bold">여행상담 및 예약확인, 일반 및 제휴 서비스 제공, 구매 및 요금 결제,마일리지적립/전환,사용확인,제휴서비스이용안내,이벤트 안내등</td>
                    </tr>
                    <tr>
                        <td class="agreemet_txt_bold">동부화재, 한화손해보험, KB손해보험, 메리츠화재, 에이스보험</td>
                        <td>성명(영문이름포함), 생년월일, 여권번호, 연락처</td>
                        <td class="agreemet_txt_bold">서비스 제공, 구매 및 요금 결제, 개인 식별, 가입 의사 확인, 불만처리 등 민원처리, 고지사항 전달</td>
                    </tr>
                    <tr>
                        <td class="agreemet_txt_bold">서울 신용평가정보</td>
                        <td>성명, 생년월일, 성별</td>
                        <td class="agreemet_txt_bold">실명인증목적 아이핀 서비스</td>
                    </tr>
                    <tr>
                        <td class="agreemet_txt_bold">한국모바일인증</td>
                        <td>이름, 생년월일, 휴대전화번호</td>
                        <td class="agreemet_txt_bold">실명 및 본인인증 목적 휴대폰인증서비스</td>
                    </tr>
                    <tr>
                        <td class="agreemet_txt_bold">이니시스</td>
                        <td>이름, 가상계좌번호, 금액</td>
                        <td class="agreemet_txt_bold">은행자동납부 인출업무 중계, 은행계좌인증</td>
                    </tr>
                    <tr>
                        <td class="agreemet_txt_bold">삼성카드, 롯데카드, 외환카드 외 제휴신용카드사, 제휴은행 및 기타 송신 관련 업체<br>
                            <a href="http://www.modetour.com/w3c/UsedPlace/Finance.aspx" target="_blank" title="새창으로열기">[전체보기]</a></td>
                        <td>이름, 생년월일, 성별, 연락처(전화번호,휴대전화번호), 이메일, 카드번호</td>
                        <td class="agreemet_txt_bold">요금납부/정산, 제휴서비스 이용안내/권유, 마일리지 적립, 전환, 사용, 확인, 회원할인 및 기타 연계서비스 제공</td>
                    </tr>
                    <tr>
                        <td class="agreemet_txt_bold">㈜홈플러스,하나카드</td>
                        <td>성명, 생년월일, 성별, 연락처, 마일리지 정보, 회원종류, 이메일주소</td>
                        <td class="agreemet_txt_bold">홈플러스 FMC포인트등 기타 포인트 적립, 전환, 사용, 확인, 회원할인 및 기타 포인트관련 서비스 제공</td>
                    </tr>
                    <tr>
                        <td class="agreemet_txt_bold">SK플래닛, ㈜엠콤, ㈜얍컴퍼니</td>
                        <td>성명, 생년월일, 성별, 핸드폰번호, 멤버십 회원번호, 마일리지 정보</td>
                        <td class="agreemet_txt_bold">모바일 멤버십관련 서비스</td>
                    </tr>
                    <tr>
                        <td class="agreemet_txt_bold">㈜인터내셔날에스오에스코리아</td>
                        <td>영문이름,성별,항공사 예약번호, 티켓번호, 여정</td>
                        <td class="agreemet_txt_bold">고객의 체류정보 확인 및 응급상항 대처</td>
                    </tr>
                    <tr>
                        <td colspan="3" class="agreemet_txt_bold">● 정보 보유 및 이용 기간 : 이용목적에 따른 개인정보 제공시, 이용목적 달성시 및    관계법령에 따른 보관기간까지 (제휴업체에는 제휴계약 종료시 까지)</td>
                    </tr>
                </tbody></table>
                <p>2. 개인정보 3자제공에 대한 동의를 거부할 권리가 있으며, 미동의 시 여행서비스의 제공이 제한됩니다.</p>
                <p>* 제3자 제공에 대한 동의를 거부할 권리가 있으며, 미동의 시 티켓 및 바우쳐, 일정표 전송 등 여행서비스의 제공이 제한될 수 있습니다.</p>
            </div>
        </div>
        <div class="term_wrap">
            <a href="#" class="term_tit">자세히보기</a>
            <label for="agree_11" class="label_chk" onclick="removeMsg(this, 'invalid');">
                <span class="ico_chk"></span>
                증빙제공 및 환급규정 동의
                <span class="txt_invalid">증빙제공 및 환급규정에 동의해주세요.</span>
            </label>
            <input type="checkbox" class="chk" id="agree_11">
            <div class="term_con">
                <dl>
                    <dt>[증빙제공 및 환급규정] </dt>
                    <dd>고객은 계약 취소와 관련하여 취소수수료(여행사 인건비 포함) 부가 내역에 대한 구체적인 증빙과 설명을 여행사에 요구할 수 있으며, 여행사는 관련 설명과 증빙을 제시하고, 취소수수료 규정과 차액이 있는 경우 이를 환급합니다.
                    </dd>
                </dl>
            </div>
        </div>
    </div>                            
    <!-- //국외 여행 약관 -->

    
</div>
		
		
		<input type ="submit" value = "예약하기" />
</form>

</div>

</div>

</body>

</html>