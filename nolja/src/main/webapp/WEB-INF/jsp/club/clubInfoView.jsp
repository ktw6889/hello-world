<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/spring.tld" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, target-densitydpi=device-dpi">
<title>팀정보</title>
</head>
<body class="mobile" style="visibility:hidden;overflow-x:hidden;">
<form method="post" onsubmit="return false;">
<input type="hidden" name="clubInfos" value="${command.clubInfos}" />
<input type="hidden" name="memberAuth" value="${command.memberAuth}" />

<div id="wrap">
	
	<header id="header" class="header_type02 fixed">
		<div class="btn_goback leftbtn" onclick="page.controller.goPageBack();"></div>
		<div class="leftbtn"></div>
		<div class="title team tL">
			<li class="team_logo" style="background-image:url(upload/${command.symbol});"></li>
			<li>${command.clubName}</li>
		</div>
		<div class="rightbtn">
			<div class="btn_teamSign inTxt mr7" style="display:none;" onclick="page.controller.joinClubInfo();">회원가입</div>
		</div>
		<div class="fbtn">
			<div class="block5">
				<span class="block" onclick="parent.page.toast.show('warning','팀가입후 이용 가능합니다.');">게시</span>
				<span class="_badgeNotice"></span>
			</div>
			<div class="block5">
				<span class="block" onclick="parent.page.toast.show('warning','팀가입후 이용 가능합니다.');">Talk</span>
				<span class="_badgeTalk"></span>
			</div>
			<div class="block5">
				<span class="block" onclick="parent.page.toast.show('warning','팀가입후 이용 가능합니다.');">경기</span>
				<span class="_badgeGame"></span>
			</div>
			<div class="block5">
				<span class="block" onclick="parent.page.toast.show('warning','팀가입후 이용 가능합니다.');">맴버</span>
				<span class="_badgeMember"></span>
			</div>
			<div class="block5">
				<span class="block" onclick="parent.page.toast.show('warning','팀가입후 이용 가능합니다.');">찬조</span>
				<span class="_badgeSupport"></span>
			</div>
		</div>
	</header>

	<div id="contents" class="team_detail">
		
		<div class="team_photo">
			<img src="upload/${command.introImage}" alt="GoAllIn">
			<!-- <p>팀을 대표하는 이미지를 등록해 주세요!!</p> -->
		</div>
		<div class="team_index">
			<li class="fL">
				<p>지역 : 수 원</p>
				<!-- <p>구장 : 삼성전기 소 운동장</p> -->
			</li>
			<li class="fR">
				<p class="win"><font class="text_blue bold">승 : </font>${command.gameWin}</p>
				<p class="manner"><font class="text_red bold">매너 : </font>${command.gameManner}</p>
			</li>
		</div>
		
		<div class="team_greet">
			<div class="user_index">
				<li class="user_photo" style="background-image:url(upload/${command.teamManagerPicture});"></li>
				<li>${command.teamManagerName} (회장)</li>
			</div>
			<div class="text">
				${command.intro}
			</div>
		</div>

		<div class="team_info">
			<div class="info_title relative">회원 분포도</div>
			<div class="_memberAge info_age">
			<!-- 
			<div class="info_age">
				<li class="age"></li>
				<li class="age10" style="width:20%;"><em>10대<em></li>
				<li class="age20" style="width:30%;"><em>20대<em></li>
				<li class="age30" style="width:60%;"><em>30대<em></li>
				<li class="age40" style="width:80%;"><em>40대<em></li>
				<li class="age50" style="width:90%;"><em>50대<em></li>
				<li class="age00" style="width:100%;"><em>기타<em></li>
			</div>
			 -->
		
		</div>
		
	</div>
	
</div>

<div id="waitJoinMember" class="alert_meseage" style="display:none;">
	<div class="meseage">
		<div class="team_alert">
			회원가입 <font>신청 중</font>입니다.
			<p>요청하신 팀의 승인을 기다리고 있습니다.<br>잠시만 기다려 주십시오.</p>
		</div>
	</div>
</div>

</form>
</body>
<script type="text/javascript" src="lib/header.js"></script>
<script type="text/javascript">
page.ready = function() {
	page.id = '/club/clubInfoView.jsp';
	logger.debug('page.ready()', page.id);
	page.initFlag = true;
	
	page.model = (function() {
		var pub = {};
		pub.init = function() {
			logger.info('page.model.init()', page.id);
		};
		pub.joinClubInfo = function(callback) {
			$.ajax({
				type: 'post',
				url: 'joinClubInfo.do',
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
		return pub;
	}());
	
	page.view = (function() {
		var pub = {};
		pub.init = function() {
			logger.info('page.view.init()', page.id);
			if(common.checkInitFrame('main.do')) return;
			$('#wrap').css("width", parent.page.width).css("height", parent.page.height);
			
			if($('input[name="memberAuth"]').val() == '요청') {
				$('#waitJoinMember').show();
			} else {
				$('.btn_teamSign').show();
			}
			
			page.view.setMemberAge('${command.memberAge}');
			
			page.view.complete();
		};
		pub.complete = function() {
			$('body').css('visibility', 'visible');
			if(parent.page.view.complete && page.initFlag) {
				parent.page.view.complete();
				page.initFlag = false;
			}
		};
		pub.setMemberAge = function(memberAge) {
			var totalCnt = 0;
			if(memberAge != null && memberAge != '') {
				var age1 = parseInt(memberAge.split(':')[0]);
				totalCnt += age1;
				var age2 = parseInt(memberAge.split(':')[1]);
				totalCnt += age2;
				var age3 = parseInt(memberAge.split(':')[2]);
				totalCnt += age3;
				var age4 = parseInt(memberAge.split(':')[3]);
				totalCnt += age4;
				var age5 = parseInt(memberAge.split(':')[4]);
				totalCnt += age5;
				var age6 = parseInt(memberAge.split(':')[5]);
				totalCnt += age6;
			}
			
			var html = '\n<li class="age"></li>';
			if(age1 != 0) {
				html +='\n<li class="age10" style="width:'+(age1/totalCnt*100)+'%;"><em>10대<em></li>';
			}
			if((age1+age2) != 0 && age1 != (age1+age2)) {
				html +='\n<li class="age20" style="width:'+((age1+age2)/totalCnt*100)+'%;"><em>20대<em></li>';
			}
			if((age1+age2+age3) != 0 && (age1+age2) != (age1+age2+age3)) {
				html +='\n<li class="age30" style="width:'+((age1+age2+age3)/totalCnt*100)+'%;"><em>30대<em></li>';
			}
			if((age1+age2+age3+age4) != 0 && (age1+age2+age3) != (age1+age2+age3+age4)) {
				html +='\n<li class="age40" style="width:'+((age1+age2+age3+age4)/totalCnt*100)+'%;"><em>40대<em></li>';
			}
			if((age1+age2+age3+age4+age5) != 0 && (age1+age2+age3+age4) != (age1+age2+age3+age4+age5)) {
				html +='\n<li class="age50" style="width:'+((age1+age2+age3+age4+age5)/totalCnt*100)+'%;"><em>50대<em></li>';
			}
			if((age1+age2+age3+age4+age5+age6) != 0 && (age1+age2+age3+age4+age5) != (age1+age2+age3+age4+age5+age6)) {
				html +='\n<li class="age00" style="width:'+((age1+age2+age3+age4+age5+age6)/totalCnt*100)+'%;"><em>기타<em></li>';
			}
			$('._memberAge').html(html);
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
			common.goBack();
		};
		pub.joinClubInfo = function() {
			if($('input[name="memberAuth"]').val() == '') {
				if(confirm('회원가입 하시겠습니까?')) {
					common.loading(true);
					page.model.joinClubInfo(function(data) {
						common.loading(false);
						if(nvlString(data.infos) == 'duplication') {
							parent.page.toast.show('warning','중복된 요청입니다.');
						} else if(nvlString(data.infos) != '') {
							parent.page.toast.show('success','회원가입 요청하였습니다.');
							common.goReload();
						} else {
							parent.page.toast.show('warning','회원가입에 실패하였습니다.');
						}
					});
				}
			}
		};
		return pub;
	}());
}
</script>
</html>