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
<input type="hidden" name="searchType" value=""/>
<input type="hidden" name="isFirst" value=""/>
<input type="hidden" name="totalRecord" value="0"/>
<input type="hidden" name="currPageNum" value="1"/>
<input type="hidden" name="numPerPage" value="2"/>
<div id="wrap">
	
	<header id="header" class="header_type02 fixed">
		<div class="leftbtn"></div>
		<div class="title logo">
			<img src="images/intro_ci_title.png" alt="GoAllIn">
		</div>
		<div class="btn_set rightbtn" onclick="common.goParentContent('option.do','beforePage=teamSearch');"></div>
		<div class="fbtn">
			<div class="block4">
				<span class="block" onclick="common.goParentContent('myClub.do');">My 팀</span>
			</div>
			<div class="block4">
				<span class="block on" onclick="common.goParentContent('clubSearch.do');">팀 검색</span>
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
		<div class="myteam">
			<div class="team_search btn_plus">
				<input type="text" name="searchVal" placeholder="팀명, 지역, 소개글 등 으로 검색하세요."/>
				<a class="search_btn" onclick="page.controller.goSearch();">검 색</a>
			</div>
			<div class="_searchTeamList">
				<div class="_searchAreaTeamList">
					<div class="more_team">
						<p class="more_title">내 주변 팀</p>
						<a class="more_btn">더보기</a>
					</div>
				</div>
				
				<div class="_searchNewTeamList">
					<div class="more_team">
						<p class="more_title">신규팀</p>
						<a class="more_btn">더보기</a>
					</div> 
				</div>
				
				<div class="_searchOpenTeamList">
					<div class="more_team">
						<p class="more_title">공개팀</p>
						<a class="more_btn">더보기</a>
					</div> 
				</div>
			</div>
			<div class="_searchTeamMore more" style="display: none;"><a class="more_btn" onclick="page.controller.goMorePage();">더보기</a></div>
		</div>
	</div>
	<!-- <li style="overflow: hidden;" -->
</div>

</form>
</body>
<script type="text/javascript" src="lib/header.js"></script>
<script type="text/javascript">
page.ready = function() {
	page.id = '/menu/teamSearch.jsp';
	logger.debug('page.ready()', page.id);
	page.initFlag = true;
	
	page.model = (function() {
		var pub = {};
		pub.init = function() {
			logger.info('page.model.init()', page.id);
		};
		pub.joinClubInfo = function(clubInfos, callback) {
			$.ajax({
				type: 'post',
				url: 'joinClubInfo.do',
				data: {clubInfos:clubInfos},
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
		pub.searchTeamInfoList = function(callback) {
			$.ajax({
				type: 'post',
				url: 'searchClubInfoList.do',
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
			
			page.controller.searchMainTeamList("AREA");
			page.controller.searchMainTeamList("NEW");
			page.controller.searchMainTeamList("OPEN");
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
		pub.searchTeamInfoList = function() {
			page.model.searchTeamInfoList(function(data) {
				if($('input[name="currPageNum"]').val() == '1'){
					$('._searchTeamList').html("");	
				}
				var html = '';
				if(data.result != null && data.result.length > 0) {
					for(var i=0;i<data.result.length; i++) {
						var myTeamHtml = '';
						if(data.result[i].myTeamFlag == 'Y') {
							myTeamHtml = 'style="clear:both; margin-top:35%; width:40px; height:40px;"';
						} else {
							myTeamHtml = 'class="teambtn_sign" onclick="page.controller.joinClubInfo(\''+nvlString(data.result[i].infos)+'\');"';
						}
						
						html += '\n<div class="teambox">';
						html += '\n	<div class="teamlogo" style="background-image:url(upload/'+nvlString(data.result[i].symbol)+');"></div>';
						html += '\n	<div class="teaminfo" onclick="common.goParentContent(\'clubInfo.do\', \'clubInfos='+nvlString(data.result[i].infos)+'\');">';
						html += '\n		<li class="team_title">'+nvlString(data.result[i].clubName)+'</li>';
						html += '\n		<li class="team_sub">('+nvlString(data.result[i].area1)+' '+nvlString(data.result[i].area2)+', '+nvlString(data.result[i].memberCnt)+'명)</li>';
						html += '\n		<li class="team_info txt_post">'+replaceEnterToBr(data.result[i].intro)+'</li>';
						html += '\n		<li class="team_rank">Ranking No.'+nvlString(data.result[i].rank)+'</li>';
						html += '\n	</div>';
						html += '\n	<div class="teambtn">';
						html += '\n		<li '+myTeamHtml+'></li>';
						html += '\n		<li class="teambtn_phone" onclick="common.callPhone(\''+nvlString(data.result[i].managerPhone)+'\')"></li>';
						html += '\n	</div>';
						html += '\n</div>';
					}
				}
				$('._searchTeamList').append(html);
				
				var totalRecord = data.totalRecord;
				var numPerPage = parseInt($('input[name="numPerPage"]').val());
				var currPageNum = parseInt($('input[name="currPageNum"]').val());
				if(totalRecord <= numPerPage*currPageNum) {
					$('._searchTeamMore').css('display','none');
				}else{
					$('._searchTeamMore').css('display','');
				}
				page.view.complete();
			});
		};
		
		pub.searchMainTeamList = function(searchType) {
			$('input[name="searchType"]').val(searchType);
			$('input[name="isFirst"]').val("ture");
			page.model.searchTeamInfoList(function(data) {
				if(searchType == 'AREA'){
					$('._searchAreaTeamList').html("");
				}else if(searchType == 'NEW'){
					$('._searchNewTeamList').html("");
				}else if(searchType == 'OPEN'){
					$('._searchOpenTeamList').html("");
				}
				
				var html = '';
				if(data.result != null && data.result.length > 0) {
					html += '\n<div class="more_team">';
					
					if(searchType == 'AREA'){
						html += '\n<p class="more_title">내 주변 팀</p>';
						html += '\n<a class="more_btn" onclick="page.controller.goMainMorePage(\'AREA\');">더보기</a>';
					}else if(searchType == 'NEW'){
						html += '\n<p class="more_title">신규팀</p>';
						html += '\n<a class="more_btn" onclick="page.controller.goMainMorePage(\'NEW\');">더보기</a>';
					}else if(searchType == 'OPEN'){
						html += '\n<p class="more_title">공개팀</p>';
						html += '\n<a class="more_btn" onclick="page.controller.goMainMorePage(\'OPEN\');">더보기</a>';
					}
					html += '\n</div>';
					for(var i=0;i<data.result.length; i++) {
						var myTeamHtml = '';
						if(data.result[i].myTeamFlag == 'Y') {
							myTeamHtml = 'style="clear:both; margin-top:35%; width:40px; height:40px;"';
						} else {
							myTeamHtml = 'class="teambtn_sign" onclick="page.controller.joinClubInfo(\''+nvlString(data.result[i].infos)+'\');"';
						}
						
						html += '\n<div class="teambox">';
						html += '\n	<div class="teamlogo" style="background-image:url(upload/'+nvlString(data.result[i].symbol)+');"></div>';
						html += '\n	<div class="teaminfo" onclick="common.goParentContent(\'clubInfo.do\', \'clubInfos='+nvlString(data.result[i].infos)+'\');">';
						html += '\n		<li class="team_title">'+nvlString(data.result[i].clubName)+'</li>';
						html +='\n		<li class="team_sub">(평균'+nvlString(data.result[i].avgAge)+'세,'+nvlString(data.result[i].area1)+'/'+nvlString(data.result[i].area2)+')</li>'
						html += '\n		<li class="team_info txt_post">'+replaceEnterToBr(data.result[i].intro)+'</li>';
						html += '\n		<li class="team_rank">Ranking No.'+nvlString(data.result[i].rank)+'</li>';
						html += '\n	</div>';
						html += '\n	<div class="teambtn">';
						html += '\n		<li '+myTeamHtml+'></li>';
						html += '\n		<li class="teambtn_phone" onclick="common.callPhone(\''+nvlString(data.result[i].managerPhone)+'\')"></li>';
						html += '\n	</div>';
						html += '\n</div>';
					}
				}
				if(searchType == 'AREA'){
					$('._searchAreaTeamList').append(html);
				}else if(searchType == 'NEW'){
					$('._searchNewTeamList').append(html);
				}else if(searchType == 'OPEN'){
					$('._searchOpenTeamList').append(html);
				}
				
				$('input[name="searchType"]').val("");
				$('input[name="isFirst"]').val("");
				page.view.complete();
			});
		};
		
		pub.goSearch = function() {
			$('input[name="searchType"]').val("");
			$('input[name="numPerPage"]').val("5");
			$('input[name="currPageNum"]').val("1");
			page.controller.searchTeamInfoList();
		};
		
		pub.goMainMorePage = function(searchType) {
			$('input[name="searchType"]').val(searchType);
			$('input[name="numPerPage"]').val("5");
			page.controller.searchTeamInfoList();
		};
		
		pub.goMorePage = function() {
			$('input[name="currPageNum"]').val(parseInt($('input[name="currPageNum"]').val())+1);
			page.controller.searchTeamInfoList();
		};
		
		pub.joinClubInfo = function(clubInfos) {
			if(confirm('회원가입 하시겠습니까?')) {
				common.loading(true);
				page.model.joinClubInfo(clubInfos, function(data) {
					common.loading(false);
					if(nvlString(data.infos) == 'duplication') {
						parent.page.toast.show('warning','중복된 요청입니다.');
					} else if(nvlString(data.infos) != '') {
						parent.page.toast.show('success','회원가입 요청하였습니다.');
						common.goParentContent('clubInfo.do', 'clubInfos='+clubInfos);
					} else {
						parent.page.toast.show('warning','회원가입에 실패하였습니다.');
					}
				});
			}
		};
		
		return pub;
	}());
}
</script>
</html>