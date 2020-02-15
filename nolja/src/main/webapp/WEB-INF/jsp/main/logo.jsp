<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/spring.tld" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, target-densitydpi=device-dpi">
<title>Logo</title>
</head>
<body class="mobile" style="visibility:hidden;overflow-x:hidden;">
<form method="post" onsubmit="return false;">

<div id="wrap">
	<div id="contents" class="intro">
		<div class="intro_logo">
			<img src="images/logo_2.jpg" alt="GoAllIn">
		</div>
		<div class="intro_text">
			사람들을 사랑하는 동호인들을 위한<br/>
			<p>동아리 APP</p>
		</div>
		<<div class="signup"><a onclick="common.goParentContent('signup.do');">회원가입</a></div>
		<div class="login"><a onclick="common.goParentContent('login.do');">로그인</a></div>
		<div class="intro_bg">
			<img src="images/intro_bg.png">
		</div>
	</div>
</div>

<!--  
<div class="container">
	<div class="header">
		<div class="center">
			Logo
		</div>
	</div>
	<div class="content center">
		<button onclick="common.goParentContent('signup.do');">회원가입</button>
		<button onclick="common.goParentContent('login.do');">로그인</button>
		<button onclick="page.controller.autoLogin('1611092110340009','123');">자동로그인</button>
	</div>
</div> 
-->

</form>
</body>
<script type="text/javascript" src="lib/header.js"></script>
<script type="text/javascript">
 
page.ready = function() { 
	page.id = '/main/logo.jsp';
	logger.debug('page.ready()', page.id);
	page.initFlag = true;
	
	page.model = (function() {
		var pub = {};
		pub.init = function() {
			logger.info('page.model.init()', page.id);
		};
		/*
		pub.autoLogin = function(infos, phone, callback) {
			$.ajax({
				type: 'post',
				url: 'autoLogin.do',
				data: {infos:parent.rsa.encrypt(infos), phone:parent.rsa.encrypt(phone)},
				dataType: 'json',
				success: function(data) {
					if(data.status == '200') {
						callback(data);	
					} else {
						parent.page.toast.show('warning','자동로그인에 실패하였습니다.');
					}
				}
			});
		};
		*/
		return pub;
	}());
	
	page.view = (function() {
		var pub = {};
		pub.init = function() {
			logger.info('page.view.init()', page.id);
			if(common.checkInitFrame('main.do')) return;
			$('#wrap').css("width", parent.page.width).css("height", parent.page.height);
			
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
		/*
		pub.goPageBack = function() {
			if(window.android && window.android.setMessage) {
				window.android.setMessage('plugin:back');
			} else if(parent.page.ios || parent.page.apple) {
				location.href = 'plugin:back';
			}
		};
		pub.autoLogin = function(infos, phone) {
			page.model.autoLogin(infos, phone, function(data) {
				if(data.resultObj != null) {
					parent.page.view.setMemberInfo(data.resultObj.infos, data.resultObj.memberName, nvlString(data.resultObj.memberAuth), nvlString(data.resultObj.teamInfos), nvlString(data.resultObj.gcmId), true);
				} else {
					parent.page.toast.show('warning','로그인 실패하였습니다.');
				}
			});
		};
		*/
		return pub;
	}());
}

</script>
</html>