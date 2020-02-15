<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/spring.tld" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, target-densitydpi=device-dpi">
<title>설정</title>
</head>
<body class="mobile" style="visibility:hidden;overflow-x:hidden;">
<form method="post" onsubmit="return false;">
<input type="hidden" name="infos" value="${command.infos}" />
<input type="hidden" name="beforePage" value="${command.beforePage}" />

<div id="wrap">
	
	<div class="set_menu" style="width:100%;">
		<div class="header">
			<div class="btn_set leftbtn" onclick="common.goParentContent('myClub.do');"></div>
			<div class="title">
				설정
			</div>
		</div>
		
		<div class="set_content">
			<div class="menu">
				<div class="set_title" onclick="common.goParentContent('signup.do');">내 정보 수정</div>
				<div class="set_go">
			</div>
		</div>

		<div class="menu">
			<div class="set_title">Push 메세지 알람</div>
			<div class="_pushFlag onoffswitch">
			</div>
		</div>
		<div class="menu">
			<div class="set_title" onclick="page.plugin.getToken();">Push 정보 새로고침</div>
			<div class="set_go" onclick="page.plugin.getToken();"></div>
		</div>
		
		<div class="menu">
			<div class="set_title">자동 로그인</div>
			<div class="_autoLoginFlag onoffswitch">
			</div>
		</div>
		<%--
		<div class="menu">
			<div class="set_title">추가</div>
			<div class="set_go"></div>
		</div>
		--%>
		<div class="menu">
			<div class="set_title" onclick="common.goParentLogout();">로그아웃</div>
			<div class="set_go" onclick="common.goParentLogout();"></div>
		</div>
		
		<div class="menu">
			<div class="set_title" onclick="common.goParentContent('appIntro.do');">GoAllIn 소개</div>
			<div class="set_go" onclick="common.goParentContent('appIntro.do');"></div>
		</div>
		<div class="menu">
			<div class="set_title">프로그램 정보</div>
			<div class="sub_text">Ver. ${command.versionNo} (${command.versionDate})</div>
		</div>
		<div class="menu">
			<div class="set_title" onclick="page.controller.goWithdraw();">'GoAllIn' 서비스 탈퇴</div>
			<div class="set_go" onclick="page.controller.goWithdraw();"></div>
		</div>
	</div>

</div>

</form>
</body>
<script type="text/javascript" src="lib/header.js"></script>
<script type="text/javascript">
page.ready = function() {
	page.id = '/menu/option.jsp';
	logger.debug('page.ready()', page.id);
	page.initFlag = true;
	
	page.model = (function() {
		var pub = {};
		pub.init = function() {
			logger.info('page.model.init()', page.id);
		};
		pub.savePushFlag = function(pushFlag,callback) {
			$.ajax({
				type: 'post',
				url: 'savePushFlag.do',
				data: {pushFlag:pushFlag},
				dataType: 'json',
				success: function(data) {
					if(data.status == '200') {
						callback(data);	
					} else {
						parent.page.toast.show('warning','저장하기 실패하였습니다.');
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
			
			page.controller.setPushFlag('${command.pushFlag}');
			
			page.view.complete();
			page.plugin.getPhoneInfo();
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
			var beforePage = $('input[name="beforePage"]').val();
			if(beforePage != '') {
				common.goParentContent(beforePage+'.do');
			} else {
				common.goParentContent('clubSearch.do');
			}
		};
		pub.changeAutoLoginFlag = function() {
			if($('input[name=autoLoginFlag]').is(":checked")) {
				if(window.android && window.android.setMessage) {
					window.android.setMessage('plugin:autologin:'+$('input[name="infos"]').val());
				} else if(parent.page.ios || parent.page.apple) {
					location.href = 'plugin:autologin:'+$('input[name="infos"]').val();
				}
			} else {
				if(window.android && window.android.setMessage) {
					window.android.setMessage('plugin:option:delautologin');
				} else if(parent.page.ios || parent.page.apple) {
					location.href = 'plugin:option:delautologin';
				}
			}
		};
		pub.setPushFlag = function(pushFlag) {
			var checked = '';
			if(pushFlag == 'Y') {
				checked = 'checked';
			}
			var html = '<input type="checkbox" name="pushFlag" onchange="page.controller.changePushFlag();" class="onoffswitch-checkbox" id="pushSwitch" '+checked+'>'
			+'<label class="onoffswitch-label" for="pushSwitch">'
			+'	<span class="onoffswitch-inner"></span>'
			+'	<span class="onoffswitch-switch"></span>'
			+'</label>';
			$('._pushFlag').html(html);
		};
		pub.changePushFlag = function() {
			if($('input[name="pushFlag"]').is(":checked")) {
				page.model.savePushFlag('Y',function(data) {
					if(data.resultObj != null) {
						parent.page.toast.show('success','Push On'); 
					}
				});
			} else {
				page.model.savePushFlag('N',function(data) {
					if(data.resultObj != null) {
						parent.page.toast.show('success','Push Off'); 
					}
				});
			}
		};
		pub.goWithdraw = function() {
			if(confirm('정말로 탈퇴하시겠습니까?')) {
				parent.page.controller.goWithdraw();
			}
		};
		return pub;
	}());
	
	page.plugin = (function() {
		var pub = {};
		pub.getPhoneInfo = function() {
			if(window.android && window.android.setMessage) {
				window.android.setMessage('plugin:option:getphoneinfo');
			} else if(parent.page.ios || parent.page.apple) {
				location.href = 'plugin:option:getphoneinfo';
			}
		};
		pub.setPhoneInfo = function(autoLoginFlag) {
			var checked = '';
			if(autoLoginFlag == 'Y') {
				checked = 'checked';
			}
			var html = '<input type="checkbox" name="autoLoginFlag" onchange="page.controller.changeAutoLoginFlag();" class="onoffswitch-checkbox" id="autoLoginSwitch" '+checked+'>'
			+'<label class="onoffswitch-label" for="autoLoginSwitch">'
			+'	<span class="onoffswitch-inner"></span>'
			+'	<span class="onoffswitch-switch"></span>'
			+'</label>';
			$('._autoLoginFlag').html(html);
		};
		pub.getToken = function() {
			if(window.android && window.android.setMessage) {
				window.android.setMessage('plugin:gettoken');
			} else if(parent.page.ios || parent.page.apple) {
				location.href = 'plugin:gettoken';
			}
		};
		return pub;
	}());
}
</script>
</html>