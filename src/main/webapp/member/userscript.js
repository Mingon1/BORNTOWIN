/**
 * 
 */
 
 
 var isCheck = false;
 var use;
 var pwuse;
var pwsame;

 $(function(){
	//alert("안녕");
	$("input[name=id]").keydown(function(){
		$('#idmsg').html('');
		isCheck = false;
		use = "";
	});
	
	$("input[name=passwd]").keydown(function(){
		$('#pwmsg').html('');
		use = "";
	});
	
	$("input[name=repasswd]").keydown(function(){
		$('#repwmsg').html('');
		use = "";
	});
	
	$("input[name=name]").keydown(function(){
		$('#namemsg').html('');
		use = "";
	});
	
	$("input[name=email]").keydown(function(){
		$('#emailmsg').html('');
		use = "";
	});
	
});

function duplicate(){
	
	isCheck = true;
	
	$.ajax({
		url : "id_check.jsp",
		data : ({
			userid: $('input[name=id]').val()
		}),
		success : function(data){
			if($('input[name=id').val()==""){
				$('#idmsg').html("<font color=red>아이디를 입력하세요</font>");
				use = "missing";
			}else if($.trim(data) == "Yes"){
				$('#idmsg').html("<font color=blue>사용 가능한 아이디입니다.</font>");
				use = "possible";
			}else{
				$('#idmsg').html("<font color=red>사용중인 아이디입니다.</font>");
				use = "impossible";
			}
		}
	});// ajax
	
}//duplicate

function Check(){
	if($('input[name=id').val==""){
		$('#idmsg').html("<font color=red>아이디를 입력하세요</font>");
		$('input[name = id]').focus();
		return false;
	}else if(use=="impossible"){
		$('#idmsg').html("<font color=red>이미 사용중인 아이디입니다</font>");
		return false;
	}else if(isCheck == false){
		$('#idmsg').html("<font color=red>중복체크 먼저 하세요</font>");
		return false;
	}else if($('input[name = passwd]').val()==""){
		$('#pwmsg').html("<font color=red>비밀번호를 입력하세요</font>");
		return false;
	}else if($('input[name = name]').val()==""){
		$('#namemsg').html("<font color=red>이름을 입력하세요</font>");
		return false;
		
	}else if($('input[name = email]').val()==""){
		$('#emailmsg').html("<font color=red>이메일을 입력하세요</font>");
		return false;
		
	}else if($('input[name = gender]:checked').length==0){
		alert("성별체크해주세요");
		return false;
		
	}else if($('input[name = detailaddr]').val()==""){
		$('input[name = postaddr]').focus();
		return false;
	}
}//check

function pwcheck(){
	var pw = $('input[name=passwd]').val();
	var rgpw = /.{8,15}/;
	if(pw.search(rgpw)==-1){
		$('#pwmsg').html("<font color=red>비밀번호는 8자~15자 사이입니다</font>");
		pwuse = "formaterror"; 
		return false;
	}
	var pw_num = pw.search(/[0-9]/);
	var pw_eng = pw.search(/[a-zA-Z!@$^*()._%+-]/);
	
	if(pw_num<0 || pw_eng<0){
		$('#pwmsg').html("<font color=red>영문 대소문자/숫자/특수문자 중 2가지 이상 조합</font>");
		pwuse = "formaterror";
		return false;
	}
	pwuse = "";
}//pw

function repwcheck(){
	var passwd = $('input[name=passwd]').val();
    var repasswd = $('input[name=repasswd]').val(); 
    
     if ($('input[name=repasswd]').val()=="") {
        $('#repwmsg').html("<font color=red>비밀번호를 입력하세요.</font>");
    } else if(passwd == repasswd){
        $('#repwmsg').html("<font color=blue>일치합니다.</font>");
    	pwsame = "same";
    } else {
        $('#repwmsg').html("<font color=red>일치하지 않습니다.</font>");
    	pwsame = "nosame";

    }
}//repw

function emcheck(){
    var regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$/;
    var email = $('input[name=email]').val();
    if(email.search(regex)==-1){
        $('#emailmsg').html("<font color=red>@포함 도메인주소가 들어가야합니다</font>");
        return false;
    }
}//em

