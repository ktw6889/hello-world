<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/spring.tld" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, target-densitydpi=device-dpi">
<title>맴버관리</title>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>
<body class="mobile" style="visibility:hidden;overflow-x:hidden;">
<form method="post" onsubmit="return false;">
<input type="hidden" name="clubInfos" value="${command.clubInfos}" />
<input type="hidden" name="memberInfos" value="${command.memberInfos}" />
<input type="hidden" name="memberAuth" value="${command.memberAuth}" />

<div id="wrap">
	
	<header id="header" class="header_type02 fixed">
		<div class="btn_goback leftbtn" onclick="page.controller.goPageBack();"></div>
		<div class="title team tL">
			<li class="team_logo" style="background-image:url(upload/${command.symbol});"></li>
			<li>${command.clubName}</li>
		</div>
		<div class="rightbtn">
			<!--
			<div class="btn_home mr20"></div>
			<div class="btn_set"></div>
			-->
		</div>
		<div class="fbtn">
			<div class="block5">
				<span class="block" onclick="common.goParentContent('teamNoticeList.do');">게시</span>
				<span class="_badgeNotice"></span>
			</div>
			<div class="block5">
				<span class="block" onclick="common.goParentContent('teamTalk.do');">Talk</span>
				<span class="_badgeTalk"></span>
			</div>
			<div class="block5">
				<span class="block" onclick="common.goParentContent('teamGameSchedule.do');">경기</span>
				<span class="_badgeGame"></span>
			</div>
			<div class="block5">
				<span class="block on" onclick="common.goParentContent('teamMemberList.do');">맴버</span>
				<span class="_badgeMember"></span>
			</div>
			<div class="block5">
				<span class="block" onclick="common.goParentContent('teamSupportList.do');">찬조</span>
				<span class="_badgeSupport"></span>
			</div>
		</div>
	</header>

	<div id="contents" class="team_detail">
		<div class="_teamMemberList"></div>
	</div>
	
	<div style="height:120px;">
	</div>
	
	
	<footer class="plus_human fixed" id="kakao-link-btn">
	</footer>
	
</div>

<div id="divMemberAuth" style="position:absolute;display:none;top:0px;left:0px;width:100px;float:right;border:1px solid #888888;background-color:#ffffff;z-index:10000;">
	<div style="padding:10px 20px 10px 20px;border:1px solid #dddddd;text-align:center;">
		<font style="font-size:20px;font-weight:bold;" onclick="page.controller.changeMemberAuth('회장');">회장</font>
	</div>
	<div style="padding:10px 20px 10px 20px;border:1px solid #dddddd;text-align:center;">
		<font style="font-size:20px;font-weight:bold;" onclick="page.controller.changeMemberAuth('총무');">총무</font>
	</div>
	<div style="padding:10px 20px 10px 20px;border:1px solid #dddddd;text-align:center;">
		<font style="font-size:20px;font-weight:bold;" onclick="page.controller.changeMemberAuth('감독');">감독</font>
	</div>
	<div style="padding:10px 20px 10px 20px;border:1px solid #dddddd;text-align:center;">
		<font style="font-size:20px;font-weight:bold;" onclick="page.controller.changeMemberAuth('회원');">회원</font>
	</div>
</div>

</form>
</body>
<script type="text/javascript" src="lib/header.js"></script>
<script type="text/javascript">

//<![CDATA[
// // 사용할 앱의 JavaScript 키를 설정해 주세요.
Kakao.init('ecc252dcf7cfda4c838a117cabc8c196');
// // 카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.

Kakao.Link.createTalkLinkButton({
  container: '#kakao-link-btn',
  label: 'GoAllIn 에 오신것을 환영 합니다.',
  image: {
    src: 'http://1.239.149.10:7080/images/intro_ci.png',
    //'http://dn.api1.kage.kakao.co.kr/14/dn/btqaWmFftyx/tBbQPH764Maw2R6IBhXd6K/o.jpg',
    width: '592',
    height: '582'
  },
  webButton: {
    text: 'GoAllIn',
    url: 'https://play.google.com/apps/testing/com.goallin.android.goallin'
    	// 'http://1.239.149.10:7080/soccer/main.do'  
         //'https://dev.kakao.com/docs/js' // 앱 설정의 웹 플랫폼에 등록한 도메인의 URL이어야 합니다.
  }
});

//]]>

page.ready = function() {
	page.id = '/club/clubMemberList.jsp';
	logger.debug('page.ready()', page.id);
	page.initFlag = true;
	page.authInfos = '';
	
	page.model = (function() {
		var pub = {};
		pub.init = function() {
			logger.info('page.model.init()', page.id);
		};
		pub.countTeamNoticeBadge = function(callback) {
			$.ajax({
				type: 'post',
				url: 'countTeamNoticeBadge.do',
				data: $("form").serialize(),
				dataType: 'json',
				success: function(data) {
					if(data.status == '200') {
						callback(data);	
					} else {
						parent.page.toast.show('warning','가져오기에 실패하였습니다.');
					}
				}
			});
		};
		pub.countTeamTalkBadge = function(callback) {
			$.ajax({
				type: 'post',
				url: 'countTeamTalkBadge.do',
				data: $("form").serialize(),
				dataType: 'json',
				success: function(data) {
					if(data.status == '200') {
						callback(data);	
					} else {
						parent.page.toast.show('warning','가져오기에 실패하였습니다.');
					}
				}
			});
		};
		pub.countTeamGameBadge = function(callback) {
			$.ajax({
				type: 'post',
				url: 'countTeamGameBadge.do',
				data: $("form").serialize(),
				dataType: 'json',
				success: function(data) {
					if(data.status == '200') {
						callback(data);	
					} else {
						parent.page.toast.show('warning','가져오기에 실패하였습니다.');
					}
				}
			});
		};
		pub.countTeamMemberBadge = function(callback) {
			$.ajax({
				type: 'post',
				url: 'countTeamMemberBadge.do',
				data: $("form").serialize(),
				dataType: 'json',
				success: function(data) {
					if(data.status == '200') {
						callback(data);	
					} else {
						parent.page.toast.show('warning','가져오기에 실패하였습니다.');
					}
				}
			});
		};
		pub.countTeamSupportBadge = function(callback) {
			$.ajax({
				type: 'post',
				url: 'countTeamSupportBadge.do',
				data: $("form").serialize(),
				dataType: 'json',
				success: function(data) {
					if(data.status == '200') {
						callback(data);	
					} else {
						parent.page.toast.show('warning','가져오기에 실패하였습니다.');
					}
				}
			});
		};
		pub.getClubMemberList = function(callback) {
			$.ajax({
				type: 'post',
				url: 'getClubMemberList.do',
				data: $("form").serialize(),
				dataType: 'json',
				success: function(data) {
					if(data.status == '200') {
						callback(data);	
					} else {
						parent.page.toast.show('warning','가져오기 실패하였습니다.');
					}
				}
			});
		};
		pub.acceptMemberClub = function(memberInfos, memberName, callback) {
			$.ajax({
				type: 'post',
				url: 'acceptMemberClub.do',
				data: {infos:memberInfos, memberName:memberName},
				dataType: 'json',
				success: function(data) {
					if(data.status == '200') {
						callback(data);	
					} else {
						parent.page.toast.show('warning','승인에 실패하였습니다.');
					}
				}
			});
		};
		
		pub.changeMemberAuth = function(authInfos, memberAuth, callback) {
			$.ajax({
				type: 'post',
				url: 'changeMemberAuth.do',
				data: {infos:authInfos, memberAuth:memberAuth},
				dataType: 'json',
				success: function(data) {
					if(data.status == '200') {
						callback(data);	
					} else {
						parent.page.toast.show('warning','변경에 실패하였습니다.');
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
			
			//page.view.countTeamBadge();
			
			page.controller.getClubMemberList();
		};
		pub.complete = function() {
			$('body').css('visibility', 'visible');
			if(parent.page.view.complete && page.initFlag) {
				parent.page.view.complete();
				page.initFlag = false;
			}
		};
		pub.countTeamBadge = function() {
			page.model.countTeamNoticeBadge(function(data) {
				if(data != null && nvlString(data.totalRecord) != '' && data.totalRecord != '0') {
					$('._badgeNotice').html('<em class="count">'+data.totalRecord+'</em>');
					parent.page.view.setCountTeamBadge('Notice', data.totalRecord);
				} else {
					$('._badgeNotice').html('');
					parent.page.view.setCountTeamBadge('Notice', '');
				}
			});
			page.model.countTeamTalkBadge(function(data) {
				if(data != null && nvlString(data.totalRecord) != '' && data.totalRecord != '0') {
					$('._badgeTalk').html('<em class="count">'+data.totalRecord+'</em>');
					parent.page.view.setCountTeamBadge('Talk', data.totalRecord);
				} else {
					$('._badgeTalk').html('');
					parent.page.view.setCountTeamBadge('Talk', '');
				}
			});
			page.model.countTeamGameBadge(function(data) {
				if(data != null && nvlString(data.totalRecord) != '' && data.totalRecord != '0') {
					$('._badgeGame').html('<em class="count">'+data.totalRecord+'</em>');
					parent.page.view.setCountTeamBadge('Game', data.totalRecord);
				} else {
					$('._badgeGame').html('');
					parent.page.view.setCountTeamBadge('Game', '');
				}
			});
			page.model.countTeamSupportBadge(function(data) {
				if(data != null && nvlString(data.totalRecord) != '' && data.totalRecord != '0') {
					$('._badgeSupport').html('<em class="count">'+data.totalRecord+'</em>');
					parent.page.view.setCountTeamBadge('Support',data.totalRecord);
				} else {
					$('._badgeSupport').html('');
					parent.page.view.setCountTeamBadge('Support', '');
				}
			});
		};
		pub.changeAuthView = function(obj, infos, auth) {
            $('#divMemberAuth').css('top', $(obj).offset().top).css('left', $(obj).offset().left-120);
            if(page.authInfos == infos && $('#divMemberAuth').css('display') != 'none') {
            	$('#divMemberAuth').hide();
            } else {
            	$('#divMemberAuth').show();
            }
            page.authInfos = infos;
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
			common.goParentContent('clubInfo.do');
		};
		
		pub.countTeamMemberBadge = function() {
			page.model.countTeamMemberBadge(function(data) {
				if(data != null && nvlString(data.totalRecord) != '' && data.totalRecord != '0') {
					$('._badgeMember').html('<em class="count">'+data.totalRecord+'</em>');
					parent.page.view.setCountTeamBadge('Member', data.totalRecord);
				} else {
					$('._badgeMember').html('');
					parent.page.view.setCountTeamBadge('Member', '');
				}
			});
		};
		
		pub.getClubMemberList = function() {
			page.model.getClubMemberList(function(data) {
				$('._teamMemberList').html("");
				for(var i=0;i<data.result.length; i++) {
					var postType = '';
					if($('input[name="memberAuth"]').val() != '회원' && $('input[name="memberInfos"]').val() != data.result[i].infos) {
						if(data.result[i].memberAuth == '요청') {
							postType = '<li class="post_type com" onclick="page.controller.acceptMemberClub(\''+data.result[i].infos+'\', \''+data.result[i].memberName+'\');"></li>';
						} else {
							postType = '<li class="post_type setting" onclick="page.view.changeAuthView(this,\''+data.result[i].infos+'\',\''+data.result[i].memberAuth+'\');"></li>';
						}
					} else {
						postType = '<li></li>';
					}
					
					var goodPoint = '<li></li>';
					if(data.result[i].goodPoint != null && data.result[i].goodPoint != '') {
						goodPoint = '<li class="good_play"><em class="count">'+data.result[i].goodPoint+'</em></li>';
					}
					
					var newHtml ='';
					if(data.result[i].newFlag == '1') {
						newHtml = '<em class="new"></em>';
					}
					
					var point = '';
					if(data.result[i].point != null && data.result[i].point != '') {
						point = '<font class="time">Point '+data.result[i].point+'</font>';
					}
					
					var html = ''
						+'\n<div class="team_posting">'
						+'\n	<div class="user_index">'
						+'\n		<li class="user_photo" style="background-image:url(upload/'+data.result[i].picture+');">'+newHtml+'</li>'
						+'\n		<li class="name">'+data.result[i].memberName+' ('+data.result[i].memberAuth+', '+data.result[i].age+')'+point+'</li>'
						+'\n		<li class="post_phone" onclick="common.callPhone(\''+data.result[i].phone+'\');">'+data.result[i].phone+'</li>'
						+'\n		'+goodPoint
						+'\n		'+postType
						+'\n	</div>'
						+'\n</div>';
					$('._teamMemberList').append(html);
				}
			//	page.controller.countTeamMemberBadge();
				page.view.complete();
			});
		};
		pub.acceptMemberClub = function(memberInfos, memberName) {
			if(confirm('승인 하시겠습니까?')) {
				common.loading(true);
				page.model.acceptMemberClub(memberInfos, memberName, function(data) {
					common.loading(false);
					if(nvlString(data.infos) != '') {
						parent.page.toast.show('success','승인하였습니다.');
						common.goReload();
					} else {
						parent.page.toast.show('warning','승인에 실패하였습니다.');
					}
				});
			}
		};
		pub.changeMemberAuth = function(memberAuth) {
			if(page.authInfos != '') {
				common.loading(true);
				page.model.changeMemberAuth(page.authInfos, memberAuth, function(data) {
					common.loading(false);
					if(nvlString(data.infos) != '') {
						parent.page.toast.show('success','변경하였습니다.');
						common.goReload();
					}
				});
			}
		};
		return pub;
	}());
}
</script>
</html>