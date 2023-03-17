<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
//만나이 계산
function setAge(_jumin1) {
    var result = -1;

    if (_jumin1.length > 7 && isDate2(_jumin1) && isDate2($Item.sdate)) {
        var birthday = new Date(_jumin1.substr(0, 4) + "-" + _jumin1.substr(0, 4) + "-" + _jumin1.substr(4, 2));
        var sdate = new Date($Item.sdate);

        result = sdate.getFullYear() - birthday.getFullYear();
    }
    return result;
}

//만나이 계산 - YYYYMMDD
function getWesternAge(birthday) {
    var returnAge = 0;

    if (birthday != null && birthday.length > 7) {
        var myBirthYMD = birthday.substr(0, 4) + "-" + birthday.substr(4, 2) + "-" + birthday.substr(6, 2);
        var birthday = new Date(myBirthYMD + 'T00:00:00.000Z');

        var now = new Date();
        var dd = String(now.getDate()).padStart(2, '0');
        var mm = String(now.getMonth() + 1).padStart(2, '0');
        var yyyy = now.getFullYear();
        var nowYMD = yyyy + '-' + mm + '-' + dd + 'T00:00:00.000Z';
        var today = new Date(nowYMD);

        var returnAge = today.getFullYear() - birthday.getFullYear();
        birthday.setFullYear(today.getFullYear());

        if (today < birthday) {
            returnAge--;
        }
    }

    return returnAge;
}

//주민번호앞자리 + 성별(총7자리)
function setJumin(_birth, _gender, _foreign) {
    var result = "";
    var gender_text = 0;

    if (!isBlank(_birth) && isDate2(_birth) && _gender != undefined) {
        if (Number(_birth.substr(0, 4)) < 2000) {
            if (_gender == "M") gender_text = 1; else gender_text = 2;
        } else {
            if (_gender == "M") gender_text = 3; else gender_text = 4;
        }

        if (_foreign != undefined && _foreign == "T") gender_text += 4;
        result = _birth.substr(2, 6) + gender_text.toString();
    }

    return result != 0 && result.length > 6 ? result : "";
}

//휴대폰번호형식 세팅
function setPhone(_phone, _spec) {
    var phone_txt = "";
    var spec_txt = _spec == null || _spec == undefined ? "-" : _spec;

    if (_phone.length > 10) {
        phone_txt = _phone.substr(0, 3) + spec_txt + _phone.substr(3, 4) + spec_txt + _phone.substr(7, 4);
    }
    else if (_phone.length > 0) {
        phone_txt = _phone.substr(0, 3) + spec_txt + _phone.substr(3, 3) + spec_txt + _phone.substr(6, 4);
    }
    return phone_txt;
}

//숫자로만 입력
function onlyNumber(_obj) {
    //if ((((event.keyCode >= 48) && (event.keyCode <= 57)) || (event.keyCode == 13))) {
    //    event.returnValue = true;
    //} else {
    //    event.returnValue = false;
    //}
    var val = (_obj != null && _obj != undefined) ? $(_obj).val() : "";
    if (_obj != null && _obj != undefined) {
        $(_obj).val(val.replace(/[^0-9]/gi, ''));
    }
}

//영문으로만 입력
function onlyEnglish(_obj) {
    var val = (_obj != null && _obj != undefined) ? $(_obj).val() : "";
    if (_obj != null && _obj != undefined) {
        $(_obj).val(val.replace(/[^a-zA-Z-\s]/gi, ''));    //영문, 공백, '-'    
        //^[',\-\.]*[a-zA-Z\u00C0-\u00FF]+[a-zA-Z\u00C0-\u00FF',\-\.]
    }
}

//한글로만 입력
function onlyHangul(_obj) {
    var val = (_obj != null && _obj != undefined) ? $(_obj).val() : "";
    if (_obj != null && _obj != undefined) {
        $(_obj).val(val.replace(/[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"\\]/g, ''));
    }
}

//이메일형식으로만 입력(영어, 숫자, 특수문자[-@._])
function onlyEmail(_obj) {
    var val = (_obj != null && _obj != undefined) ? $(_obj).val() : "";
    if (_obj != null && _obj != undefined) {
        $(_obj).val(val.replace(/[^a-zA-Z0-9-@._]/gi, ''));    //영어, 숫자, 특수문자[-@._]
    }
}

//메세지 삭제
function removeMsg(_obj, _class) {
    if (typeof (_class) == "string" && $(_obj).hasClass(_class)) {
        $(_obj).removeClass(_class);
    }
    else if (typeof (_obj) != undefined) {
        $('.traveler').eq(0).find('.invalid').removeClass('invalid');   //대표여행자만 remove
    }
}

//휴대폰번호 확인[형식:01012345678]
function isMobile(_phone) {
    var regExp = /(01[016789])([1-9]{1}[0-9]{2,3})([0-9]{4})$/;
    var myArray; if (regExp.test(_phone)) {
        myArray = regExp.exec(_phone);
        return true;
    } else {
        return false;
    }
}

//콤마 찍기
function setComma(num) {

    num = new String(num)
    num = num.replace(/,/gi, "")
    var fl = ""

    if (isNaN(num)) { alert("문자는 사용할 수 없습니다."); return 0 }

    if (num == 0) return num

    if (num < 0) {
        num = num * (-1);
        fl = "-";
    }
    else {
        num = num * 1 //처음 입력값이 0부터 시작할때 이것을 제거한다.
    }

    num = new String(num)
    var temp = ""
    var co = 3
    var num_len = num.length

    while (num_len > 0) {
        num_len = num_len - co;
        if (num_len < 0) { co = num_len + co; num_len = 0 }
        temp = "," + num.substr(num_len, co) + temp;
    }
    return fl + temp.substr(1)
}

//input 값 유효성 체크
function checkValue(obj) {
    var required = $(obj).attr("data-required") == "required";  //필수요소여부
    var chk_id = $(obj).prop("id");

    if (chk_id.indexOf("traveler_name_") > -1) {    //한글성명
        if (isBlank($(obj).val())) {
            if (required) {
                $(obj).addClass("invalid");
            }
        }
    }
    else if (chk_id.indexOf("traveler_eng_family_name_") > -1) {   //영문성        
        if (isBlank($(obj).val())) {
            if (required) {
                $(obj).next('.txt_invalid').text('영문성을 입력하세요.');
                $(obj).addClass("invalid");
            }
        }
        else if (/[^a-zA-Z-\s]/.test($(obj).val())) {
            $(obj).next('.txt_invalid').text('영문성을 올바르게 입력하세요.');
            $(obj).addClass("invalid");
        }
    }
    else if (chk_id.indexOf("traveler_eng_given_name_") > -1) {   //영문이름
        if (isBlank($(obj).val())) {
            if (required) {
                $(obj).next('.txt_invalid').text('영문이름을 입력하세요.');
                $(obj).addClass("invalid");
            }
        }
        else if (/[^a-zA-Z-\s]/.test($(obj).val())) {
            $(obj).next('.txt_invalid').text('영문이름을 올바르게 입력하세요.');
            $(obj).addClass("invalid");
        }
    }
    else if (chk_id.indexOf("traveler_jumin1_") > -1) {    //주민번호 앞자리
        if (isBlank($(obj).val())) {
            if (required) {
                $(obj).next('.txt_invalid').text('생년월일을 입력하세요.');
                $(obj).addClass("invalid");
            }
        }
        else if (isNaN($(obj).val()) || $(obj).val().trim().length < 8
            || !isDate2($(obj).val().substr(0, 4) + "-" + $(obj).val().substr(4, 2) + "-" + $(obj).val().substr(6, 2))) {
            $(obj).next('.txt_invalid').text('생년월일을 올바르게 입력하세요.');
            $(obj).addClass("invalid");
        }
    }
    else if (chk_id.indexOf("traveler_hp_") > -1) {   //휴대폰번호 
        if (isBlank($(obj).val())) {
            if (required) {
                $(obj).next('.txt_invalid').text('휴대폰번호를 입력하세요.');
                $(obj).addClass("invalid");
            }
        }
        else if (isNaN($(obj).val()) || $(obj).val().trim().length < 10 || !isMobile($(obj).val().trim())) {
            $(obj).next('.txt_invalid').text('휴대폰번호를 올바르게 입력하세요.');
            $(obj).addClass("invalid");
        }
    }
    else if (chk_id.indexOf("traveler_email_") > -1) {   //이메일
        if (isBlank($(obj).val())) {
            if (required) {
                $(obj).next('.txt_invalid').text('이메일주소를 입력하세요.');
                $(obj).addClass("invalid");
            }
        }
        else if (!isBlank($(obj).val()) && !isEmail($(obj).val().trim())) {
            $(obj).next('.txt_invalid').text('이메일주소를 올바르게 입력하세요.');
            $(obj).addClass("invalid");
        }
    }
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


</script>










</body>
</html>