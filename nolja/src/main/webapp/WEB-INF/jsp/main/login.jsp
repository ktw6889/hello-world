<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/spring.tld" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, target-densitydpi=device-dpi">
<title>로그인</title>
</head>
<body class="mobile" style="visibility:hidden;overflow-x:hidden;">
<form method="post" onsubmit="return false;">

<div id="wrap">
	<div id="contents" class="intro loginblock">
		<div class="intro_logo">
			<img src="images/intro_ci.png" alt="GoAllIn">
		</div>
		<div class="intro_text">
			모임을 사랑하는 동호인들을 위한<br/>
			<p>놀자 동아리 APP</p>
		</div>
		<div class="login_box">
		
			<input type="text" name="email" tabindex="1" class="input_text" onkeydown="page.controller.changeText();" placeholder="아이디 예)abc@naver.com">
			<input type="password" name="password" title="2" class="input_text" onkeydown="page.controller.changeText();" placeholder="비밀번호" tabindex="2">

			<p class="_signFail" style="display:none;">일치하는 정보가 없습니다.<br/>
			   아이디 또는 비밀번호를 다시 확인해 주세요.</p>
			
			<p class="auto _autoLogin" style="display:none;"><input type="checkbox" name="autoLogin" tabindex="3" class="sign_checkbox"/>자동로그인</p>
		
		</div>
		<div class="login"><a onclick="page.controller.checkLogin();" tabindex="4">로그인</a></div>

		<div class="login_btn">
			<a onclick="common.goParentContent('signup.do');" tabindex="5">회원가입&nbsp;&nbsp;&nbsp;|</a>
			<a onclick="common.goParentContent('findId.do');" tabindex="6">아이디 찾기&nbsp;&nbsp;&nbsp;|</a>
			<a onclick="common.goParentContent('findPassword.do');" tabindex="7">비밀번호 찾기</a>
		</div>

		<div class="intro_bg">
			<img src="images/intro_bg_02.png">
		</div>
	</div>
</div>

</form>
</body>
<script type="text/javascript" src="lib/header.js"></script>
<script type="text/javascript">
page.ready = function() {
	page.id = '/main/login.jsp';
	logger.debug('page.ready()', page.id);
	page.initFlag = true;
	
	page.model = (function() {
		var pub = {};
		pub.init = function() {
			logger.info('page.model.init()', page.id);
		};
		pub.checkLogin = function(callback) {
			if($('input[name="email"]').val() == '') {
				alert('아이디를 입력하세요.');	
				return false;
			}
			if($('input[name="password"]').val() == '') {
				alert('비밀번호을 입력하세요.');	
				return false;
			}
			$.ajax({
				type: 'post',
				url: 'checkLogin.do',
				//data: {email:parent.rsa.encrypt($('input[name="email"]').val()), password:parent.rsa.encrypt($('input[name="password"]').val())},
				data: {email:$('input[name="email"]').val(), password:$('input[name="password"]').val()},
				dataType: 'json',
				success: function(data) {
					$('input[name="email"]').val('');
					$('input[name="password"]').val('');
					if(data.status == '200') {
						callback(data);	
					} else {
						parent.page.toast.show('error','오류가 발생하였습니다.<br/>관리자에게 문의하세요.');
					}
				}
			});
		};
		return pub;
	}());
	
	page.view = (function() {
		var pub = {};
		pub.init = function() {
			logger.info('page.view.init()', page.id);
			if(common.checkInitFrame('main.do')) return;
			$('#wrap').css("width", parent.page.width).css("height", parent.page.height);
			
			if(common.isMobile()) {
				$('._autoLogin').show();
			} 
			
			page.view.complete();
		};
		pub.complete = function() {
			$('body').css('visibility', 'visible');
			if(parent.page.view.complete && page.initFlag) {
				parent.page.view.complete();
				page.initFlag = false;
			}
		};
		return pub;
	}());
	
	page.controller = (function() {
		var pub = {};
		pub.init = function() {
			logger.info('page.controller.init()', page.id);
			page.model.init();
			page.view.init();
		};
		pub.goPageBack = function() {
			common.goParentContent('logo.do');
		};
		pub.checkLogin = function() {
			page.model.checkLogin(function(data) {
				if(data.resultObj != null) {
					if($('input[name=autoLogin]').is(":checked")) {
						if(window.android && window.android.setMessage) {
							window.android.setMessage('plugin:autologin:'+data.resultObj.infos);
						} else if(parent.page.ios || parent.page.apple) {
							location.href = 'plugin:autologin:'+data.resultObj.infos;
						}
					}
					parent.page.view.setMemberInfo(data.resultObj.infos, data.resultObj.memberName, nvlString(data.resultObj.memberAuth), nvlString(data.resultObj.teamInfos), nvlString(data.resultObj.gcmId), true);
				} else {
					$('._signFail').css('display','');
				}
			});
		};
		pub.changeText = function() {
			$('._signFail').css('display','none');
		};
		return pub;
	}());
}
</script>
</html>