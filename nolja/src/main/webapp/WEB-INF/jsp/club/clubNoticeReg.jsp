<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/spring.tld" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, target-densitydpi=device-dpi">
<title>게시 글쓰기</title>
</head>
<body class="mobile" style="visibility:hidden;overflow-x:hidden;">
<form name="soccerForm" method="post" enctype="multipart/form-data" onsubmit="return false;">
<input type="hidden" name="infos" value="${command.infos}" />
<input type="hidden" name="clubInfos" value="${command.clubInfos}" />

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

	<div id="contents" class="team_detail btn_plus">

		<div class="">
			<table class="basic_table">	
				<colgroup>
					<col width="180"><col width="">
				</colgroup>
				<tbody>
				<tr class="selectTr">
					<td class="bold tR">구&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;분 :</td>
					<td class="selectTd">
						<select name="noticeType">
							<option value="공지">공지사항</option>
							<option value="일반">일반</option>
						</select>	
					</td>
				</tr>
				
				<tr>
					<td colspan="2" class="textareaTd">
						<textarea name="content" class="input_message" style="height:400px;"></textarea>
					</td>
				</tr>
				
			</tbody></table>
		</div>
		<input type="file" name="attachPicture" onchange="page.view.changeAttachPicture(this);" style="display:none;">
		<input type="hidden" name="attachPictureStr">
		<div class="plus_box">
			<!-- <li class="file_plus"></li>-->
			<li class="photo_plus" onclick="page.view.clickAttachPicture();">
			</li>
		</div>
	</div>

	<footer class="footer_type fixed">
		<div class="block1" onclick="page.controller.saveTeamNotice();">
			글 등록하기
		</div>
	</footer>
	
</div>
 
</form>
<iframe name="hiddenFrame" style="display:none;"></iframe>
</body>
<script type="text/javascript" src="lib/header.js"></script>
<script type="text/javascript">
page.ready = function() {
	page.id = '/club/clubNoticeReg.jsp';
	logger.debug('page.ready()', page.id);
	page.initFlag = true;
	page.clickFlag = true;
	page.mobileFlag = false;
	
	page.model = (function() {
		var pub = {};
		pub.init = function() {
			logger.info('page.model.init()', page.id);
		};
		/*
		pub.saveTeamNotice = function(callback) {
			$.ajax({
				type: 'post',
				url: 'saveTeamNotice.do',
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
		*/
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
		};
		pub.complete = function() {
			$('body').css('visibility', 'visible');
			if(parent.page.view.complete && page.initFlag) {
				parent.page.view.complete();
				page.initFlag = false;
			}
		};
		pub.countTeamBadge = function() {
			var badge = parent.page.view.getCountTeamBadge('Notice');
			if(nvlString(badge) != '' && badge != '0') {
				$('._badgeNotice').html('<em class="count">'+badge+'</em>');
			} else {
				$('._badgeNotice').html('');
			}
			badge = parent.page.view.getCountTeamBadge('Talk');
			if(nvlString(badge) != '' && badge != '0') {
				$('._badgeTalk').html('<em class="count">'+badge+'</em>');
			} else {
				$('._badgeTalk').html('');
			}
			badge = parent.page.view.getCountTeamBadge('Game');
			if(nvlString(badge) != '' && badge != '0') {
				$('._badgeGame').html('<em class="count">'+badge+'</em>');
			} else {
				$('._badgeGame').html('');
			}
			badge = parent.page.view.getCountTeamBadge('Member');
			if(nvlString(badge) != '' && badge != '0') {
				$('._badgeMember').html('<em class="count">'+badge+'</em>');
			} else {
				$('._badgeMember').html('');
			}
			badge = parent.page.view.getCountTeamBadge('Support');
			if(nvlString(badge) != '' && badge != '0') {
				$('._badgeSupport').html('<em class="count">'+badge+'</em>');
			} else {
				$('._badgeSupport').html('');
			}
		};
		pub.clickAttachPicture = function() {
			$('input[name="attachPicture"]').click();
			page.plugin.getImageUpload();
		};
		pub.changeAttachPicture = function(obj) {
			$('input[name="attachPictureStr"]').val(obj.value);
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
			common.goParentContent('clubNoticeList.do');
		};
		pub.saveTeamNotice = function() {
			if(page.clickFlag) {
				page.clickFlag = false;
				if(confirm('등록하겠습니까?')) {
					common.loading(true);
					var form = document.soccerForm;
					form.action = 'saveClubNotice.do';
					form.target = 'hiddenFrame';
					form.submit();
				} else {
					page.clickFlag = true;
				}
			}
		};
		
		pub.saveSuccess = function(infos) {
			if(page.mobileFlag) {
				page.plugin.saveMobile(infos);
			} else {
				common.loading(false);
				parent.page.toast.show('success','저장에 성공하였습니다.');
				common.goParentContent('clubNoticeList.do');
				page.clickFlag = true;
			}
		};
		pub.saveFail = function() {
			common.loading(false);
			parent.page.toast.show('warning','저장에 실패하였습니다.');
			page.clickFlag = true;
		};
		pub.saveMobileSuccess = function() {
			common.loading(false);
			parent.page.toast.show('success','저장에 성공하였습니다.');
			common.goParentContent('clubNoticeList.do');
			page.clickFlag = true;
		};
		pub.saveMobileFail = function() {
			common.loading(false);
			parent.page.toast.show('warning','저장에 실패하였습니다.');
			page.clickFlag = true;
		};
		return pub;
	}());
	
	page.plugin = (function() {
		var pub = {};
		pub.getImageUpload = function() {
			if(window.android && window.android.setMessage) {
				window.android.setMessage('plugin:image:notice');
			} else if(parent.page.ios || parent.page.apple) {
				location.href = 'plugin:image:notice';
			}
			$('input[name="attachPictureStr"]').val("");
		};
		pub.setImageUploadStr = function(uploadType, imgStr) {
			$('input[name="attachPictureStr"]').val(imgStr);
			page.mobileFlag = true;
		};
		pub.saveMobile = function(infos) {
			if($('input[name="attachPictureStr"]').val() != null) {
				if(window.android && window.android.setMessage) {
					window.android.setMessage('plugin:saveimage:notice:'+infos);
				} else if(parent.page.ios || parent.page.apple) {
					location.href = 'plugin:saveimage:notice:'+infos;
				}
			} else {
				page.controller.saveMobileSuccess();
			}
		};
		return pub;
	}());
}
</script>
</html>