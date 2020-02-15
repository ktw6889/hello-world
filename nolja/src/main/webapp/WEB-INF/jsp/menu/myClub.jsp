<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/spring.tld" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, target-densitydpi=device-dpi">
<title>메뉴</title>
<style>
	.txt_post { display: -webkit-box; display: -ms-flexbox; display: box; margin-top:1px; max-height:120px; overflow:hidden; vertical-align:top; text-overflow: ellipsis; word-break:break-all; -webkit-box-orient:vertical; -webkit-line-clamp:3 }
</style>
</head>
<body class="mobile" style="visibility:hidden;overflow-x:hidden;">
<form method="post" onsubmit="return false;">

<div id="wrap">
	
	<header id="header" class="header_type02 fixed">
		<div class="leftbtn"></div>
		<div class="title logo">
			<img src="images/intro_ci_title.png" alt="GoAllIn">
		</div>
		<div class="btn_set rightbtn" onclick="common.goParentContent('option.do','beforePage=myTeam');"></div>
		<div class="fbtn">
			<div class="block4">
				<span class="block on" onclick="common.goParentContent('myClub.do');">My 팀</span>
			</div>
			<div class="block4">
				<span class="block" onclick="common.goParentContent('clubSearch.do');">팀 검색</span>
			</div>
			<div class="block4">
				<span class="block" onclick="common.goParentContent('gameSchedule.do');">경기 일정</span>
			</div>
			<div class="block4">
				<span class="block" onclick="common.goParentContent('ranking.do');">랭킹</span>
			</div>
		</div>
	</header>

	<div id="contents">
		<div class="_selectView1 myteam notTeam" style="display:none;">
			<div class="notTeam_info">
				운영 중 이거나 가입된 팀이 없으십니다.<br/>
				팀검색을 통하여 가입하시거나 팀만들기를 통해 <br/>새로운 팀을 만들고 팀을 운영해 보세요.
			</div>
			<div class="make_team mt10p"><a onclick="common.goParentContent('clubReg.do','infos=NEW');">팀만들기</a></div>
			<div class="search_team"><a onclick="common.goParentContent('clubSearch.do');">팀검색</a></div>
			<div class="intro_fs"><a onclick="common.goParentContent('appIntro.do');">놀자동아리 소개</a></div>
		</div>
		<div class="_selectView2 myteam" style="display:none;">
		</div>
	</div>		
	
	<footer class="_btnPlus plus_btn fixed" style="display:none;" onclick="common.goParentContent('clubReg.do','infos=NEW');">
	</footer>
</div>

</form>
</body>
<script type="text/javascript" src="lib/header.js"></script>
<script type="text/javascript">
page.ready = function() {
	page.id = '/menu/myClub.jsp';
	logger.debug('page.ready()', page.id);
	page.initFlag = true;
	
	page.model = (function() {
		var pub = {};
		pub.init = function() {
			logger.info('page.model.init()', page.id);
		};
		
		pub.getMyClubInfoList = function(callback) {
			$.ajax({
				type: 'post',
				url: 'getMyClubInfoList.do',
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
		
		pub.searchClubInfoList = function(callback) {
			$.ajax({
				type: 'post',
				url: 'searchClubInfoList.do',
				data: {searchType:'Team',searchVal:$('input[name="searchValTeam"]').val()},
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
			
			page.controller.getMyClubInfoList();
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
			if(window.android && window.android.setMessage) {
				window.android.setMessage('plugin:back');
			} else if(parent.page.ios || parent.page.apple) {
				location.href = 'plugin:back';
			}
		};
		pub.getMyClubInfoList = function() {
			page.model.getMyClubInfoList(function(data) {
				if(data.result != null && data.result.length > 0) {
					$('._selectView1').css('display','none');
					$('._selectView2').css('display','');
					
					$('._selectView2').html("");
					var html = '';
					for(var i=0;i<data.result.length; i++) {
						html += '\n<div class="teambox">';
						html += '\n	<div class="teamlogo"style="background-image:url(upload/'+nvlString(data.result[i].symbol)+');"></div>';
						html += '\n	<div class="teaminfo" onclick="common.goParentContent(\'clubInfo.do\', \'clubInfos='+nvlString(data.result[i].infos)+'\');">';
						html += '\n		<li class="team_title">'+nvlString(data.result[i].clubName)+'</li>';
						html += '\n		<li class="team_sub">('+nvlString(data.result[i].area1)+' '+nvlString(data.result[i].area2)+', '+nvlString(data.result[i].memberCnt)+'명)</li>';
						html += '\n		<li class="team_info txt_post">'+replaceEnterToBr(data.result[i].intro)+'</li>';
						html += '\n		<li class="team_rank">Ranking No.'+nvlString(data.result[i].rank)+'</li>';
						html += '\n	</div>';
						html += '\n	<div class="teambtn">';
						html += '\n		<li style="clear:both; margin-top:35%; width:40px; height:40px;"></li>';
						html += '\n		<li class="teambtn_phone" onclick="common.callPhone(\''+nvlString(data.result[i].managerPhone)+'\')"></li>';
						html += '\n	</div>';
						html += '\n</div>';
					}
					$('._selectView2').append(html);
					$('._btnPlus').css('display','');
				} else {
					$('._selectView1').css('display','');
					$('._selectView2').css('display','none');
					$('._btnPlus').css('display','none');
				}
				page.view.complete();
			});
		};
		
		return pub;
	}());
}
</script>
</html>