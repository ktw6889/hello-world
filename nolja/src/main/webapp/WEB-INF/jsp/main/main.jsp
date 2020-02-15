<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/spring.tld" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, target-densitydpi=device-dpi">
<title>동아리야 놀자</title>
</head>
<body class="mobile" style="visibility:hidden;overflow-x:hidden;background-color:#2AA3A4;">
<form method="post" onsubmit="return false;">
<input type="hidden" name="rsaModulus" value="${command.rsaModulus}" />
<input type="hidden" name="rsaExponent" value="${command.rsaExponent}" />
<input type="hidden" name="memberInfos" value="${command.memberInfos}" />
<input type="hidden" name="memberName" value="${command.memberName}" />
<input type="hidden" name="memberAuth" value="${command.memberAuth}" />
<input type="hidden" name="clubInfos" value="${command.clubInfos}" />

<div id="pageLoading" style="position:absolute;z-index:100;text-align:center;display:none;">
	<img src="images/loading.gif" style="width:50px;height:50px;">
</div>

<div id="content" style="width:100%;">
	<iframe id="ifr_content1" src="" frameborder="0" style="display:none;" width="100%" height="100%"></iframe>
	<iframe id="ifr_content2" src="" frameborder="0" style="display:none;" width="100%" height="100%"></iframe>
	<iframe id="ifr_contentPop" src="" frameborder="0" style="display:none;" width="100%" height="100%"></iframe>
</div>

</form>
</body>
<script type="text/javascript" src="lib/header.js"></script>
<script type="text/javascript">
page.ready = function() {
	page.id = '/main/main.jsp';
	logger.debug('page.ready()', page.id);
	page.width = $(window).width();
	page.height = $(window).height();
	page.currentPage = 2;
	page.currentPagePop = 1;
	page.initFlag = true;
	page.reloadFlag = false;
	page.isMobile = false;
	page.intervalId = null;
	
	page.badgeNotice = '';
	page.badgeTalk = '';
	page.badgeGame = '';
	page.badgeMember = '';
	page.badgeSupport = '';
	
	page.prevPageUrl = '';
	page.thisPageUrl = '';
	page.direct = '';
	
	page.android = (/android/i).test(navigator.userAgent); 
	page.apple = (/firefox/i).test(navigator.userAgent);
	page.ios = (/ipod|iphone|ipad/i).test(navigator.userAgent);
	
	page.model = (function() {
		var pub = {};
		pub.init = function() {
			logger.info('page.model.init()', page.id);
		};
		pub.saveToken = function(token, callback) {
			$.ajax({
				type: 'post',
				url: 'saveToken.do',
				data: {token:token},
				dataType: 'json',
				success: function(data) {
					if(data.status == '200') {
						callback(data);	
					} else {
						parent.page.toast.show('warning','저장에 실패하였습니다.');
					}
				}
			});
		};
		pub.autoLoginPhone = function(infos, callback) {
			$.ajax({
				type: 'post',
				url: 'autoLoginPhone.do',
				data: {infos:infos},
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
		pub.logoutPhone = function(callback) {
			$.ajax({
				type: 'post',
				url: 'logoutPhone.do',
				data: {},
				dataType: 'json',
				success: function(data) {
					if(data.status == '200') {
						callback(data);	
					} else {
						parent.page.toast.show('warning','종료에 실패하였습니다.');
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
			page.setPublic($('input[name="rsaModulus"]').val(), $('input[name="rsaExponent"]').val());
			$('#pageLoading').css("width", page.width).css("height", page.height);
			$('#pageLoading').find("img").css("padding-top", (page.height/2)-50);
			
			$('#content').css("width", page.width).css("height", page.height);
			
			if(self != top) {
				top.location.href= 'main.do';
				return;
			}
			
			//$('#ifr_content1').attr('src', 'logo.do');
			$('#ifr_content2').attr('src', 'logo.do');
			page.controller.goAutoLoginCheck();
		};
		pub.complete = function() {
			//console.log(history.length+":"+page.currentPage);
			$('body').css('visibility', 'visible');
			if(!page.reloadFlag) {
				$('#ifr_content1').css('display', 'none');
				$('#ifr_content2').css('display', 'none');
				$('#ifr_content'+page.currentPage).css('display', '');
			
				if(page.currentPage == 1) {
					page.currentPage = 2;
				} else {
					page.currentPage = 1;
					if(page.initFlag) {
						page.controller.goMenu();
						page.initFlag = false;
					}
				}
			} else {
				page.reloadFlag = false;
			}
			page.loading(false);
		};
		pub.completePop = function() {
			$('body').css('visibility', 'visible');
			if(page.currentPage == 1) {
				page.currentPagePop = 2;
			} else {
				page.currentPagePop = 1;
			}
			$('#ifr_content1').css('display', 'none');
			$('#ifr_content2').css('display', 'none');
			$('#ifr_contentPop').css('display', '');
			page.loading(false);
		};
		pub.getWidth = function() {
			return page.width;
		};
		pub.getHeight = function() {
			return page.height;
		};
		pub.setIntervalId = function(intervalId) {
			page.intervalId = intervalId;
		};
		pub.setMemberInfo = function(memberInfos, memberName, memberAuth, clubInfos, gcmId, goFlag) {
			$('input[name="memberInfos"]').val(memberInfos);
			$('input[name="memberName"]').val(memberName);
			$('input[name="memberAuth"]').val(memberAuth);
			$('input[name="clubInfos"]').val(clubInfos);
			
			if(gcmId == '') {
				page.plugin.getToken();
			}
			
			if(goFlag) {
				page.controller.goMenu();
			}
		};
		pub.setCountTeamBadge = function(badgeType, count) {
			if(badgeType == 'Notice') {
				page.badgeNotice = count;
			} else if(badgeType == 'Talk') {
				page.badgeTalk = count;
			} else if(badgeType == 'Game') {
				page.badgeGame = count;
			} else if(badgeType == 'Member') {
				page.badgeMember = count;
			} else if(badgeType == 'Support') {
				page.badgeSupport = count;
			}
		};
		pub.getCountTeamBadge = function(badgeType) {
			var result = '';
			if(badgeType == 'Notice') {
				result = page.badgeNotice;
			} else if(badgeType == 'Talk') {
				result = page.badgeTalk;
			} else if(badgeType == 'Game') {
				result = page.badgeGame;
			} else if(badgeType == 'Member') {
				result = page.badgeMember;
			} else if(badgeType == 'Support') {
				result = page.badgeSupport;
			}
			return result;
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
		pub.goMain = function() {
			$(location).attr('href','main.do');
		};
		pub.goLogout = function() {
			$(location).attr('href','logout.do');
		};
		pub.goWithdraw = function() {
			$(location).attr('href','withdraw.do');
		};
		pub.goMenu = function() {
			if($('input[name="memberInfos"]').val() != '') {
				if($('input[name="clubInfos"]').val() != '') {
					page.controller.goContent('clubInfo.do?clubInfos='+$('input[name="clubInfos"]').val()+'&direct='+page.direct);
				} else {
					page.controller.goContent('myClub.do');
				}
			}
		};
		pub.goBack = function() {
			page.controller.goContent(page.prevPageUrl);
		};
		pub.goReload = function() {
			page.loading(true);
			$('#ifr_content'+page.currentPage).attr('src', page.thisPageUrl);
			/*
			page.reloadFlag = true;
			if(page.currentPage == 1) {
				document.getElementById('ifr_content2').contentDocument.location.reload(true);
			} else {
				document.getElementById('ifr_content1').contentDocument.location.reload(true);
			}
			*/
		};
		pub.goContent = function(contentSrc) {
			console.log("goContent : "+contentSrc+" / "+page.currentPage+" / "+page.thisPageUrl+" / "+page.prevPageUrl);
			page.loading(true);
			if(page.intervalId != null) {
				$('iframe').each(function(i) {
					if(document.getElementById($(this).attr('id')).contentWindow.page) {
					if(document.getElementById($(this).attr('id')).contentWindow.page.view) {
						if(document.getElementById($(this).attr('id')).contentWindow.page.view.clearInterval) {
							document.getElementById($(this).attr('id')).contentWindow.page.view.clearInterval(page.intervalId);
						}
					}
					}
				});
				page.intervalId = null;
			}
			page.prevPageUrl = page.thisPageUrl;
			page.thisPageUrl = contentSrc;
			$('#ifr_content'+page.currentPage).attr('src', contentSrc);
		};
		pub.goContentPop = function(contentSrc) {
			console.log("goContentPop : "+contentSrc+" / "+page.currentPage);
			page.loading(true);
			$('#ifr_contentPop').attr('src', contentSrc);
		};
		pub.goClosePop = function(targetPage, param1, param2) {
			$('body').css('visibility', 'visible');
			$('#ifr_contentPop').hide();
			$('#ifr_content'+page.currentPagePop).show();
			$('#ifr_content'+page.currentPagePop)[0].contentWindow.resultCallBack(param1, param2);
		};
		pub.goMapClosePop = function(targetPage, param1, param2) {
			$('body').css('visibility', 'visible');
			$('#ifr_contentPop').hide();
			$('#ifr_content'+page.currentPagePop).show();
			$('#ifr_content'+page.currentPagePop)[0].contentWindow.mapResultCallBack(param1, param2);
		};
		
		pub.goAutoLoginCheck = function() {
			if(window.android && window.android.setMessage) {
				window.android.setMessage('plugin:setrsa:'+$('input[name="rsaModulus"]').val()+":"+$('input[name="rsaExponent"]').val());
			} else if(page.ios || page.apple) {
				location.href = 'plugin:setrsa:'+$('input[name="rsaModulus"]').val()+":"+$('input[name="rsaExponent"]').val();
			}
		};
		return pub;
	}());
	
	page.plugin = (function() {
		var pub = {};
		pub.setMessage = function(url) {
			if(window.android && window.android.setMessage) {
				window.android.setMessage(url);
			}
		};
		pub.goPageBack = function() {
			$('iframe').each(function(i) {
				if($(this).css('display') != 'none') {
					if(document.getElementById($(this).attr('id')).contentWindow.page.controller.goPageBack) {
						document.getElementById($(this).attr('id')).contentWindow.page.controller.goPageBack();
					}
				}
			});
		};
		pub.saveMobileSuccess = function() {
			$('iframe').each(function(i) {
				if($(this).css('display') != 'none') {
					if(document.getElementById($(this).attr('id')).contentWindow.page.controller.saveMobileSuccess) {
						document.getElementById($(this).attr('id')).contentWindow.page.controller.saveMobileSuccess();
					}
				}
			});
		};
		pub.saveMobileFail = function() {
			$('iframe').each(function(i) {
				if($(this).css('display') != 'none') {
					if(document.getElementById($(this).attr('id')).contentWindow.page.controller.saveMobileFail) {
						document.getElementById($(this).attr('id')).contentWindow.page.controller.saveMobileFail();
					}
				}
			});
		};
		pub.exit = function() {
			page.model.logoutPhone(function(data) {
				if(window.android && window.android.setMessage) {
					window.android.setMessage('plugin:exit');
				} else if(page.ios || page.apple) {
					location.href = 'plugin:exit';
				}
			});
		};
		pub.getToken = function(token) {
			if(window.android && window.android.setMessage) {
				window.android.setMessage('plugin:gettoken');
			} else if(page.ios || page.apple) {
				location.href = 'plugin:gettoken';
			}
		};
		pub.setToken = function(token) {
			if(nvlString(token) != '') {
				page.model.saveToken(token, function(data) {
					parent.page.toast.show('success','Push 정보 등록되었습니다.');
				});
			}
		};
		pub.autoLogin = function(infos, direct) {
			page.isMobile = true;
			page.direct = direct;
			if(nvlString(infos) != '') {
				page.model.autoLoginPhone(infos, function(data) {
					if(data.resultObj != null) {
						page.view.setMemberInfo(data.resultObj.infos, data.resultObj.memberName, nvlString(data.resultObj.memberAuth), nvlString(data.resultObj.clubInfos), nvlString(data.resultObj.gcmId), true);
					}
				});
			}
		};
		pub.setPhoneInfo = function(autoLoginFlag) {
			$('iframe').each(function(i) {
				if($(this).css('display') != 'none') {
					if(document.getElementById($(this).attr('id')).contentWindow.page.plugin.setPhoneInfo) {
						document.getElementById($(this).attr('id')).contentWindow.page.plugin.setPhoneInfo(autoLoginFlag);
					}
				}
			});
		};
		pub.setPhone = function(phone) {
			$('iframe').each(function(i) {
				if($(this).css('display') != 'none') {
					if(document.getElementById($(this).attr('id')).contentWindow.page.plugin.setPhone) {
						document.getElementById($(this).attr('id')).contentWindow.page.plugin.setPhone(phone);
					}
				}
			});
		};
		pub.setImageUploadStr = function(uploadType, imgStr) {
			$('iframe').each(function(i) {
				if($(this).css('display') != 'none') {
					if(document.getElementById($(this).attr('id')).contentWindow.page.plugin.setImageUploadStr) {
						document.getElementById($(this).attr('id')).contentWindow.page.plugin.setImageUploadStr(uploadType, imgStr);
					}
				}
			});
		};
		
		pub.setGameDate = function(gameDate) {
			$('iframe').each(function(i) {
				if($(this).css('display') != 'none') {
					if(document.getElementById($(this).attr('id')).contentWindow.page.plugin.setGameDate) {
						document.getElementById($(this).attr('id')).contentWindow.page.plugin.setGameDate(gameDate);
					}
				}
			});
		};
		pub.setGameStime = function(gameStime) {
			$('iframe').each(function(i) {
				if($(this).css('display') != 'none') {
					if(document.getElementById($(this).attr('id')).contentWindow.page.plugin.setGameStime) {
						document.getElementById($(this).attr('id')).contentWindow.page.plugin.setGameStime(gameStime);
					}
				}
			});
		};
		pub.setGameEtime = function(gameEtime) {
			$('iframe').each(function(i) {
				if($(this).css('display') != 'none') {
					if(document.getElementById($(this).attr('id')).contentWindow.page.plugin.setGameEtime) {
						document.getElementById($(this).attr('id')).contentWindow.page.plugin.setGameEtime(gameEtime);
					}
				}
			});
		};
		pub.callPhone = function(phoneNumber) {
			console.log('call:'+phoneNumber);
			if(window.android && window.android.setMessage) {
				window.android.setMessage('plugin:call:'+phoneNumber);
			} else if(parent.page.ios || parent.page.apple) {
				location.href = 'plugin:call:'+phoneNumber;
			}
		};
		pub.iosTest = function(message) {
			alert(message);
		};
		return pub;
	}());
	
	
	page.toast = (function() {
		var pub = {};
		pub.show = function(type, text) {
			
			if(window.android && window.android.setMessage) {
				window.android.setMessage('plugin:toast:'+type+":"+text);
			} else if(page.ios || page.apple) {
				location.href = 'plugin:toast:'+type+":"+text;
			} else {
				$().toastmessage('showToast', {
				    text : text,
				    type : type
				});
			}
		};
		return pub;
	}());
	
	page.loading = function(flag) {
		if(flag) {
			$('#pageLoading').css('display','');
		} else {
			$('#pageLoading').css('display','none');
		}
	};
	
}
</script>
</html>