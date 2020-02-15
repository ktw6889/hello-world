<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/spring.tld" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, target-densitydpi=device-dpi">
<title>Talk</title>
</head>
<body class="mobile" style="visibility:hidden;overflow-x:hidden;">
<form method="post" onsubmit="return false;">
<input type="hidden" name="clubInfos" value="${command.clubInfos}" />
<input type="hidden" name="totalRecord" value="0">
<input type="hidden" name="currPageNum" value="1">
<input type="hidden" name="numPerPage" value="50">
<input type="hidden" name="startMessageInfos" value="">
<input type="hidden" name="endMessageInfos" value="">

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
				<span class="block" onclick="common.goParentContent('clubNoticeList.do');">게시</span>
				<span class="_badgeNotice"></span>
			</div>
			<div class="block5">
				<span class="block on" onclick="common.goParentContent('clubTalk.do');">Talk</span>
				<span class="_badgeTalk"></span>
			</div>
			<div class="block5">
				<span class="block" onclick="common.goParentContent('teamGameSchedule.do');">경기</span>
				<span class="_badgeGame"></span>
			</div>
			<div class="block5">
				<span class="block" onclick="common.goParentContent('clubMemberList.do');">맴버</span>
				<span class="_badgeMember"></span>
			</div>
			<div class="block5">
				<span class="block" onclick="common.goParentContent('teamSupportList.do');">찬조</span>
				<span class="_badgeSupport"></span>
			</div>
		</div>
	</header>

	<div id="contents" class="messenger">
		<div class="_talkMore more" style="display:none;"><a class="more_btn" onclick="page.controller.goMorePage();">더보기</a></div>
		<div class="_teamTalkList messengerbox">
		</div>
	</div>

	<footer class="footer_type fixed">
		<div class="messenger_talk">
			<input type="text" name="message" placeholder="내용을 입력하세요"/>
			<span onclick="page.controller.saveClubTalk();" class="messenger_talk_btn"></span>
		</div>
	</footer>
	
</div>

</form>
</body>
<script type="text/javascript" src="lib/header.js"></script>
<script type="text/javascript">
page.ready = function() {
	page.id = '/club/clubTalk.jsp';
	logger.debug('page.ready()', page.id);
	page.initFlag = true;
	page.messageDate = '';
	page.messageDateEnd = '';
	page.intervalId = null;
	page.intervalTime = 5000;
	
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
		pub.saveClubTalk = function(callback) {
			$.ajax({
				type: 'post',
				url: 'saveClubTalk.do',
				data: $("form").serialize(),
				dataType: 'json',
				success: function(data) {
					if(data.status == '200') {
						callback(data);	
					} else {
						parent.page.toast.show('warning','등록에 실패하였습니다.');
					}
				}
			});
		};
		pub.getTeamTalkList = function(callback) {
			$.ajax({
				type: 'post',
				url: 'getClubTalkList.do',
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
		pub.getTeamTalkListEnd = function(callback) {
			$.ajax({
				type: 'post',
				url: 'getClubTalkListEnd.do',
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
			
			page.view.complete();
			page.controller.getTeamTalkList();
		};
		pub.complete = function() {
			$('body').css('visibility', 'visible');
			if(parent.page.view.complete && page.initFlag) {
				parent.page.view.complete();
				page.initFlag = false;
			}
		};
		pub.clearInterval = function(intervalId) {
			clearInterval(intervalId);
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
		
		pub.countTeamTalkBadge = function() {
			page.model.countTeamTalkBadge(function(data) {
				if(data != null && nvlString(data.totalRecord) != '' && data.totalRecord != '0') {
					$('._badgeTalk').html('<em class="count">'+data.totalRecord+'</em>');
					parent.page.view.setCountTeamBadge('Talk', data.totalRecord);
				} else {
					$('._badgeTalk').html('');
					parent.page.view.setCountTeamBadge('Talk', '');
				}
			});
		};
		
		pub.saveClubTalk = function() {
			if($('input[name="message"]').val() != '') {
				page.model.saveClubTalk(function(data) {
					if(nvlString(data.infos) != '') {
						parent.page.controller.goContent('clubTalk.do');
					} else {
						parent.page.toast.show('warning','등록에 실패하였습니다.');
					}
				});
			}
		};
		pub.getTeamTalkList = function() {
			page.model.getTeamTalkList(function(data) {
				if(data.result != null && data.result.length > 0) {
					for(var i=0;i<data.result.length; i++) {
						
						if(data.result[i].messageType == 'NOTICE') {
							var noticeMessage = '';
							if(data.result[i].message == '요청') {
								noticeMessage = data.result[i].memberName +'님 회원가입 요청하셨습니다.';
							} else if(data.result[i].message == '회원') {
								noticeMessage = data.result[i].memberName +'님 회원가입 되셨습니다.';
							} else {
								noticeMessage = data.result[i].message;
							}
							$('._teamTalkList').prepend('<div style="text-align:center;"><p>'+noticeMessage+'</p></div>');
							continue;
						}
						
						if(page.messageDate != data.result[i].messageDate) {
							if(page.messageDate != '') {
								$('._teamTalkList').prepend('<div class="date_line"><p>'+page.messageDate+'</p></div>');
							}
							page.messageDate = data.result[i].messageDate;
						}
						
						var readMessage = '';
						if(nvlString(data.result[i].memberReadCnt) != '' && data.result[i].memberReadCnt > 0) {
							readMessage = '읽음 '+data.result[i].memberReadCnt;
						}
						
						var html = '';
						if(data.result[i].myFlag == 'Y') {
							html += '<div class="mytext">';
							html += '	<div class="mytext_text">';
							html += '		<li style="text-align:left;">';
							html += replaceEnterToBr(data.result[i].message);
							html += '			<em></em>';
							html += '			<span class="info_read">'+readMessage+'</span>';
							html += '			<span class="info_time">'+nvlString(data.result[i].messageTime)+'</span>';
							html += '		</li>';
							html += '	</div>';
							html += '</div>';
						} else {
							html += '<div class="others">';
							html += '	<div class="others_photo">';
							html += '		<img src="upload/'+nvlString(data.result[i].memberPicture)+'">';
							//html += '		<li class="user_photo" style="background-image:url(upload/'+nvlString(data.result[i].memberPicture)+');"></li>';
							html += '	</div>';
							html += '	<div class="others_text">';
							html += '		<li class="user">'+nvlString(data.result[i].memberName)+'</li>';
							html += '		<li>';
							html += replaceEnterToBr(data.result[i].message);
							html += '			<em></em>';
							html += '			<span class="info_read">'+readMessage+'</span>';
							html += '			<span class="info_time">'+nvlString(data.result[i].messageTime)+'</span>';
							html += '		</li>';
							html += '	</div>';
							html += '</div>';
						}
						
						if(i == 0 && $('input[name="currPageNum"]').val() == 1) {
							$('input[name="startMessageInfos"]').val(data.result[i].infos);
							$('input[name="endMessageInfos"]').val(data.result[i].infos);
							page.messageDateEnd = data.result[i].messageDate;
							page.intervalId = setInterval(function() { 
								page.controller.getTeamTalkListEnd();
							}, page.intervalTime);
							parent.page.view.setIntervalId(page.intervalId);
						}
						$('._teamTalkList').prepend(html);
					}
					if(page.messageDate != '') {
						$('._teamTalkList').prepend('<div class="date_line"><p>'+page.messageDate+'</p></div>');
					}
					if($('input[name="currPageNum"]').val() == 1) {
						$('body').scrollTop($('._teamTalkList').height());
					}
				}
				
				var totalRecord = data.totalRecord;
				var numPerPage = parseInt($('input[name="numPerPage"]').val());
				var currPageNum = parseInt($('input[name="currPageNum"]').val());
				if(totalRecord <= numPerPage*currPageNum) {
					$('._talkMore').remove();
				} else {
					$('._talkMore').show();
				}
				page.controller.countTeamTalkBadge();
			});
		};
		pub.goMorePage = function() {
			$('input[name="currPageNum"]').val(parseInt($('input[name="currPageNum"]').val())+1);
			page.controller.getTeamTalkList();
		};
		
		pub.getTeamTalkListEnd = function() {
			page.model.getTeamTalkListEnd(function(data) {
				if(data.result != null && data.result.length > 0) {
					for(var i=0;i<data.result.length; i++) {
						if(page.messageDateEnd != data.result[i].messageDate) {
								$('._teamTalkList').append('<div class="date_line"><p>'+page.messageDate+'</p></div>');
							page.messageDateEnd = data.result[i].messageDate;
						}
						
						var readMessage = '';
						if(nvlString(data.result[i].memberReadCnt) != '' && data.result[i].memberReadCnt > 0) {
							readMessage = '읽음 '+data.result[i].memberReadCnt;
						}
						
						var html = '';
						if(data.result[i].myFlag == 'Y') {
							html += '<div class="mytext">';
							html += '	<div class="mytext_text">';
							html += '		<li style="text-align:left;">';
							html += replaceEnterToBr(data.result[i].message);
							html += '			<em></em>';
							html += '			<span class="info_read">'+readMessage+'</span>';
							html += '			<span class="info_time">'+nvlString(data.result[i].messageTime)+'</span>';
							html += '		</li>';
							html += '	</div>';
							html += '</div>';
						} else {
							html += '<div class="others">';
							html += '	<div class="others_photo">';
							//html += '		<img src="upload/'+nvlString(data.result[i].memberPicture)+'">';
							html += '		<li class="user_photo" style="background-image:url(upload/'+data.result[i].memberPicture+');"></li>';
							html += '	</div>';
							html += '	<div class="others_text">';
							html += '		<li class="user">'+nvlString(data.result[i].memberName)+'</li>';
							html += '		<li>';
							html += replaceEnterToBr(data.result[i].message);
							html += '			<em></em>';
							html += '			<span class="info_read">'+readMessage+'</span>';
							html += '			<span class="info_time">'+nvlString(data.result[i].messageTime)+'</span>';
							html += '		</li>';
							html += '	</div>';
							html += '</div>';
						}
						$('input[name="endMessageInfos"]').val(data.result[i].infos);
						$('._teamTalkList').append(html);
					}
					$('body').scrollTop($('._teamTalkList').height());
				}
			});
		};
		return pub;
	}());
}

/*
page.beforeunload = function() {
    if(page.webSocket) {
    	page.webSocket.close();
    }
}
*/
</script>
</html>