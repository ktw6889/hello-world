<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/spring.tld" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, target-densitydpi=device-dpi">
<title>팀게시</title>
</head>
<body class="mobile" style="visibility:hidden;overflow-x:hidden;">
<input type="hidden" name="clubInfos" value="${command.clubInfos}" />
<form method="post" onsubmit="return false;">
<input type="hidden" name="totalRecord" value="0">
<input type="hidden" name="currPageNum" value="1">
<input type="hidden" name="numPerPage" value="5">
<input type="hidden" name="boardType" value="게시">

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
				<span class="block on" onclick="common.goParentContent('clubNoticeList.do');">게시</span>
				<span class="_badgeNotice"></span>
			</div>
			<div class="block5">
				<span class="block" onclick="common.goParentContent('clubTalk.do');">Talk</span>
				<span class="_badgeTalk"></span>
			</div>
			<div class="block5">
				<span class="block" onclick="common.goParentContent('clubGameSchedule.do');">경기</span>
				<span class="_badgeGame"></span>
			</div>
			<div class="block5">
				<span class="block" onclick="common.goParentContent('clubMemberList.do');">맴버</span>
				<span class="_badgeMember"></span>
			</div>
			<div class="block5">
				<span class="block" onclick="common.goParentContent('clubSupportList.do');">찬조</span>
				<span class="_badgeSupport"></span>
			</div>
		</div>
	</header>

	<div id="contents" class="team_detail">
		
		<div class="_teamBoardList">
		</div>
		<div class="_teamBoardMore more"><a class="more_btn" onclick="page.controller.goMorePage();">더보기</a></div>
	</div>

	<footer class="plus_btn fixed" onclick="common.goParentContent('clubNoticeReg.do');">
	</footer>

</div>
 
</form>
</body>
<script type="text/javascript" src="lib/header.js"></script>
<script type="text/javascript">
page.ready = function() {
	page.id = '/club/clubNoticeList.jsp';
	logger.debug('page.ready()', page.id);
	page.initFlag = true;
	
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
		pub.getClubBoardList = function(callback) {
			$.ajax({
				type: 'post',
				url: 'getClubBoardList.do',
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
		return pub;
	}());
	
	page.view = (function() {
		var pub = {};
		pub.init = function() {
			logger.info('page.view.init()', page.id);
			if(common.checkInitFrame('main.do')) return;
			$('#wrap').css("width", parent.page.width).css("height", parent.page.height);
			
			//page.view.countTeamBadge();
			
			page.controller.getClubBoardList();
		};
		pub.complete = function() {
			$('body').css('visibility', 'visible');
			if(parent.page.view.complete && page.initFlag) {
				parent.page.view.complete();
				page.initFlag = false;
			}
		};
		pub.countTeamBadge = function() {
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
			page.model.countTeamMemberBadge(function(data) {
				if(data != null && nvlString(data.totalRecord) != '' && data.totalRecord != '0') {
					$('._badgeMember').html('<em class="count">'+data.totalRecord+'</em>');
					parent.page.view.setCountTeamBadge('Member',data.totalRecord);
				} else {
					$('._badgeMember').html('');
					parent.page.view.setCountTeamBadge('Member', '');
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
		
		pub.countTeamNoticeBadge = function() {
			page.model.countTeamNoticeBadge(function(data) {
				if(data != null && nvlString(data.totalRecord) != '' && data.totalRecord != '0') {
					$('._badgeNotice').html('<em class="count">'+data.totalRecord+'</em>');
					parent.page.view.setCountTeamBadge('Notice', data.totalRecord);
				} else {
					$('._badgeNotice').html('');
					parent.page.view.setCountTeamBadge('Notice', '');
				}
			});
		};
		
		pub.getClubBoardList = function() {
			page.model.getClubBoardList(function(data) {
				for(var i=0;i<data.result.length; i++) {
					var boardType = '';
					if(data.result[i].noticeType == '공지') {
						boardType = 'post_type notice';
					} else if(data.result[i].noticeType == '신규') {
						boardType = 'post_type new';
					}
					
					var attachPicture = '';
					if(nvlString(data.result[i].attachPicture) != '') {
						attachPicture = '<img src="upload/'+data.result[i].attachPicture+'">';
					}
					
					var html = ''
						+'\n<div class="team_posting">'
						+'\n	<div class="user_index">'
						+'\n		<li class="user_photo" style="background-image:url(upload/'+data.result[i].picture+');"></li>'
						+'\n		<li class="name">'+data.result[i].memberName+' ('+data.result[i].memberAuth+')<font class="time">'+data.result[i].createDate+'</font></li>'
						+'\n		<li class="post_title"></li>'
						+'\n		<li class="'+boardType+'"></li>'
						+'\n	</div>'
						+'\n	<div class="text on">'+attachPicture
						+'\n		'+replaceEnterToBr(data.result[i].content)
						+'\n	</div>'
						+'\n</div>'
					
					$('._teamBoardList').append(html);
				}
				
				var totalRecord = data.totalRecord;
				var numPerPage = parseInt($('input[name="numPerPage"]').val());
				var currPageNum = parseInt($('input[name="currPageNum"]').val());
				if(totalRecord <= numPerPage*currPageNum) {
					$('._teamBoardMore').html("");
				}
				//page.controller.countTeamNoticeBadge();
				page.view.complete();
			});
		};
		pub.goMorePage = function() {
			$('input[name="currPageNum"]').val(parseInt($('input[name="currPageNum"]').val())+1);
			page.controller.getClubBoardList();
		};
		return pub;
	}());
}
</script>
</html>