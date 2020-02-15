<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/spring.tld" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, target-densitydpi=device-dpi">
<title>메뉴</title>
</head>
<body class="mobile" style="visibility:hidden;overflow-x:hidden;">
<form method="post" onsubmit="return false;">

<div id="wrap">
	
	<header id="header" class="header_type02 fixed">
		<div class="leftbtn"></div>
		<div class="title logo">
			<img src="images/intro_ci_title.png" alt="GoAllIn">
		</div>
		<div class="btn_set rightbtn" onclick="common.goParentContent('option.do');"></div>
		<div class="fbtn">
			<div class="block4">
				<span class="_selectTab1 block" onclick="page.view.selectTab(1);">My 팀</span>
			</div>
			<div class="block4">
				<span class="_selectTab2 block" onclick="page.view.selectTab(2);">팀 검색</span>
			</div>
			<div class="block4">
				<span class="_selectTab3 block" onclick="page.view.selectTab(3);">경기 일정</span>
			</div>
			<div class="block4">
				<span class="_selectTab4 block" onclick="page.view.selectTab(4);">랭킹</span>
			</div>
		</div>	
	</header>

	<div id="contents">
		<div class="_selectView1">
			<div class="_selectView11 myteam notTeam" style="display:none;">
				<div class="notTeam_info">
					운영 중 이거나 가입된 팀이 없으십니다.<br/>
					팀검색을 통하여 가입하시거나 팀만들기를 통해 <br/>새로운 팀을 만들고 팀을 운영해 보세요.
				</div>
				<div class="make_team mt10p"><a onclick="common.goParentContent('clubReg.do');">팀만들기</a></div>
				<div class="search_team"><a onclick="page.view.selectTab(2);">팀검색</a></div>
				<div class="intro_fs"><a onclick="common.goParentContent('appIntro.do');">GoAllIn 소개</a></div>
			</div>
			<div class="_selectView12 myteam" style="display:none;">
			</div>
		</div>
			
		<div class="_selectView2 myteam" style="display:none;">
			<div class="team_search btn_plus">
				<input type="text" name="searchValTeam" placeholder="팀명, 지역, 소개글 등 으로 검색하세요."/>
				<a class="search_btn" onclick="page.controller.searchClubInfoList();">검 색</a>
			</div>
			<div class="_searchTeamList">
				<div class="more_team">
					<p class="more_title">내 주변 팀</p>
					<a class="more_btn">더보기</a>
				</div> 
	
				<div class="teambox">
					<div class="teamlogo" style="background-image:url(images/bg_logo01.png);"></div>
					<div class="teaminfo">
						<li class="team_title">SNUBH</li>
						<li class="team_sub">(종로구 , 46명)</li>
						<li class="team_info">SNUBH는 서울대학병원에 근무하며 축구를 
						사랑하는 중증환자들이 모여 치료를 거부하
						며 축구중독에 빠진 모임</li>
						<li class="team_rank">Ranking No. 109</li>
					</div>
					<div class="teambtn">
						<li class="teambtn_sign" onclick=""></li>
						<li class="teambtn_phone" onclick=""></li>
					</div>
				</div>
	
				<div class="more_team">
					<p class="more_title">신규팀</p>
					<a class="more_btn">더보기</a>
				</div> 
	
				<div class="teambox">
					<div class="teamlogo" style="background-image:url(images/bg_logo02.png);"></div>
					<div class="teaminfo">
						<li class="team_title">SEJONG FIRES</li>
						<li class="team_sub">(세종시 , 76명)</li>
						<li class="team_info">세종시에서 축구를 사랑하는 열정의 불길이
						치솟는 사람들의 모임.
						불꺼주실 사랑의 여성 단원 대환영~!!</li>
						<li class="team_rank">Ranking No. 69</li>
					</div>
					<div class="teambtn">
						<li class="teambtn_sign" onclick=""></li>
						<li class="teambtn_phone" onclick=""></li>
					</div>
				</div>
	
				<div class="teambox">
					<div class="teamlogo" style="background-image:url(images/bg_logo03.png);"></div>
					<div class="teaminfo">
						<li class="team_title">수원썬더스</li>
						<li class="team_sub">(수원 , 94명)</li>
						<li class="team_info">수원에서 활동 가능한 누구나 모여 축구도 
						하고 친목도모도 하는 모임 입니다.<br/>
						개발이라도 말술 회원 우대~!!</li>
						<li class="team_rank">Ranking No. 23</li>
					</div>
					<div class="teambtn">
						<li class="teambtn_sign" onclick=""></li>
						<li class="teambtn_phone" onclick=""></li>
					</div>
				</div>
	
				<div class="more_team">
					<p class="more_title">공개팀</p>
					<a class="more_btn">더보기</a>
				</div> 
	
				<div class="teambox">
					<div class="teamlogo" style="background-image:url(images/bg_logo04.png);"></div>
					<div class="teaminfo">
						<li class="team_title">드라곤 슛돌이</li>
						<li class="team_sub">(화성시 , 46명)</li>
						<li class="team_info">76년 용띠들이 주축을 이루어 만든 축구 동
						호회로 2005년 부터 활동중입니다.<br/>
						띠동갑, 여성회원 우대, 대환영!!!</li>
						<li class="team_rank">Ranking No. 109</li>
					</div>
					<div class="teambtn">
						<li class="teambtn_sign" onclick=""></li>
						<li class="teambtn_phone" onclick=""></li>
					</div>
				</div>
	
				<div class="teambox">
					<div class="teamlogo" style="background-image:url(images/bg_logo01.png);"></div>
					<div class="teaminfo">
						<li class="team_title">SNUBH</li>
						<li class="team_sub">(종로구 , 46명)</li>
						<li class="team_info">SNUBH는 서울대학병원에 근무하며 축구를 
						사랑하는 중증환자들이 모여 치료를 거부하
						며 축구중독에 빠진 모임</li>
						<li class="team_rank">Ranking No. 109</li>
					</div>
					<div class="teambtn">
						<li class="teambtn_sign" onclick=""></li>
						<li class="teambtn_phone" onclick=""></li>
					</div>
				</div>
			</div>
		</div>
		
		<div class="_selectView3 myteam" style="display:none;">
			<div class="team_search btn_plus">
				<input type="text" placeholder="팀명, 지역, 소개글 등 으로 검색하세요."/>
				<a class="search_btn">검 색</a>
			</div>

			<div class="team_tab">
				<div class="block2">
					<span class="_selectTab31 block on" onclick="page.view.selectTab3(1);">일 정</span>
				</div>
				<div class="block2">
					<span class="_selectTab32 block" onclick="page.view.selectTab3(2);">기 록</span>
				</div>
			</div> 
			<div class="_selectView31">
				<div class="team_game">
					<div class="game_info">
						<p>2016.12.10(토) 14:00 ~ 16:00</p>
						<p>수원 삼성전기 소 운동장</p>
					</div>
					<div class="game_block">
						<div class="game_team">
							<div class="img" style="background-image:url(images/bg_logo01.png)" ></div>
							<li class="team_title">SNUBH</li>
							<li class="team_sub">4전 <font class="text_blue">2승</font> <font class="text_red">2패</font></li>
						</div>
		
						<div class="game_team">
							<div class="img" style="background-image:url(images/bg_logo02.png)" ></div>
							<li class="team_title">SEJONG FIRES</li>
							<li class="team_sub">14전 <font class="text_blue">11승</font> <font class="text_red">3패</font></li>
						</div>
					</div>
				</div>
			</div>
			<div class="_selectView32" style="display:none;">
				<div class="team_game result">
					<div class="game_info">
						<p>2016.12.10(토) 14:00 ~ 16:00</p>
						<p>수원 삼성전기 소 운동장</p>
					</div>
					<div class="game_block">
						<div class="game_team">
							<div class="img" style="background-image:url(images/bg_logo01.png)" ></div>
							<li class="result_win left">승</li>
							<li class="team_title">SNUBH</li>
							<li class="result_count win">3</li>
						</div>
	
						<div class="game_team">
							<div class="img" style="background-image:url(images/bg_logo02.png)" ></div>
							<li class="result_lose right">패</li>
							<li class="team_title">SEJONG FIRES</li>
							<li class="result_count lose">1</li>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="_selectView4 myteam" style="display:none;">
			<div class="team_search btn_plus">
				<input type="text" placeholder="팀명, 지역, 소개글 등 으로 검색하세요."/>
				<a class="search_btn">검 색</a>
			</div>

			<div class="team_tab">
				<div class="block2">
					<span class="_selectTab41 block on" onclick="page.view.selectTab4(1);">전 체</span>
				</div>
				<div class="block2">
					<span class="_selectTab42 block" onclick="page.view.selectTab4(2);">지 역 (수원시)</span>
				</div>
			</div> 
			<div class="_selectView41">
				<div class="teambox Rank">
					<div class="team_rank">
						1
						<img src="images/rank_01.png" alt="SNUBH">
					</div>
					<div class="teamlogo" style="background-image:url(images/bg_logo01.png);"></div>
					<div class="teaminfo">
						<li class="team_title">SNUBH</li>
						<li class="team_sub">(종로구 , 46명)</li>
						<li class="team_info">SNUBH는 서울대학병원에 근무하며 축구를 
						사랑하는 중증환자들이 모여 치료를 거부하
						며 축구중독에 빠진 모임</li>
						<li class="team_rank">Ranking No. 109</li>
					</div>
					<div class="teambtn">
						<li class="teambtn_sign" onclick=""></li>
						<li class="teambtn_phone" onclick=""></li>
					</div>
				</div>
	
				<div class="teambox Rank">
					<div class="team_rank">
						2
						<img src="images/rank_02.png" alt="SNUBH">
					</div>
					<div class="teamlogo" style="background-image:url(images/bg_logo02.png);"></div>
					<div class="teaminfo">
						<li class="team_title">SEJONG FIRES</li>
						<li class="team_sub">(세종시 , 76명)</li>
						<li class="team_info">세종시에서 축구를 사랑하는 열정의 불길이
						치솟는 사람들의 모임.
						불꺼주실 사랑의 여성 단원 대환영~!!</li>
						<li class="team_rank">Ranking No. 69</li>
					</div>
					<div class="teambtn">
						<li class="teambtn_sign" onclick=""></li>
						<li class="teambtn_phone" onclick=""></li>
					</div>
				</div>
	
				<div class="teambox Rank">
					<div class="team_rank">
						3
						<img src="images/rank_03.png" alt="SNUBH">
					</div>
					<div class="teamlogo" style="background-image:url(images/bg_logo03.png);"></div>
					<div class="teaminfo">
						<li class="team_title">수원썬더스</li>
						<li class="team_sub">(수원 , 94명)</li>
						<li class="team_info">수원에서 활동 가능한 누구나 모여 축구도 
						하고 친목도모도 하는 모임 입니다.<br/>
						개발이라도 말술 회원 우대~!!</li>
						<li class="team_rank">Ranking No. 23</li>
					</div>
					<div class="teambtn">
						<li class="teambtn_sign" onclick=""></li>
						<li class="teambtn_phone" onclick=""></li>
					</div>
				</div>
	
				<div class="teambox Rank">
					<div class="team_rank">
						4
					</div>
					<div class="teamlogo" style="background-image:url(images/bg_logo04.png);"></div>
					<div class="teaminfo">
						<li class="team_title">드라곤 슛돌이</li>
						<li class="team_sub">(화성시 , 46명)</li>
						<li class="team_info">76년 용띠들이 주축을 이루어 만든 축구 동
						호회로 2005년 부터 활동중입니다.<br/>
						띠동갑, 여성회원 우대, 대환영!!!</li>
						<li class="team_rank">Ranking No. 109</li>
					</div>
					<div class="teambtn">
						<li class="teambtn_sign" onclick=""></li>
						<li class="teambtn_phone" onclick=""></li>
					</div>
				</div>
	
				<div class="teambox Rank">
					<div class="team_rank">
						99
					</div>
					<div class="teamlogo" style="background-image:url(images/bg_logo01.png);"></div>
					<div class="teaminfo">
						<li class="team_title">SNUBH</li>
						<li class="team_sub">(종로구 , 46명)</li>
						<li class="team_info">SNUBH는 서울대학병원에 근무하며 축구를 
						사랑하는 중증환자들이 모여 치료를 거부하
						며 축구중독에 빠진 모임</li>
						<li class="team_rank">Ranking No. 109</li>
					</div>
					<div class="teambtn">
						<li class="teambtn_sign" onclick=""></li>
						<li class="teambtn_phone" onclick=""></li>
					</div>
				</div>
			</div>
			<div class="_selectView42" style="display:none;">
				<div class="teambox Rank">
					<div class="team_rank">
						1
						<img src="images/rank_01.png" alt="SNUBH">
					</div>
					<div class="teamlogo" style="background-image:url(images/bg_logo01.png);"></div>
					<div class="teaminfo">
						<li class="team_title">SNUBH</li>
						<li class="team_sub">(종로구 , 46명)</li>
						<li class="team_info">SNUBH는 서울대학병원에 근무하며 축구를 
						사랑하는 중증환자들이 모여 치료를 거부하
						며 축구중독에 빠진 모임</li>
						<li class="team_rank">Ranking No. 109</li>
					</div>
					<div class="teambtn">
						<li class="teambtn_sign" onclick=""></li>
						<li class="teambtn_phone" onclick=""></li>
					</div>
				</div>
	
				<div class="teambox Rank">
					<div class="team_rank">
						2
						<img src="images/rank_02.png" alt="SNUBH">
					</div>
					<div class="teamlogo" style="background-image:url(images/bg_logo02.png);"></div>
					<div class="teaminfo">
						<li class="team_title">SEJONG FIRES</li>
						<li class="team_sub">(세종시 , 76명)</li>
						<li class="team_info">세종시에서 축구를 사랑하는 열정의 불길이
						치솟는 사람들의 모임.
						불꺼주실 사랑의 여성 단원 대환영~!!</li>
						<li class="team_rank">Ranking No. 69</li>
					</div>
					<div class="teambtn">
						<li class="teambtn_sign" onclick=""></li>
						<li class="teambtn_phone" onclick=""></li>
					</div>
				</div>
	
				<div class="teambox Rank">
					<div class="team_rank">
						3
						<img src="images/rank_03.png" alt="SNUBH">
					</div>
					<div class="teamlogo" style="background-image:url(images/bg_logo03.png);"></div>
					<div class="teaminfo">
						<li class="team_title">수원썬더스</li>
						<li class="team_sub">(수원 , 94명)</li>
						<li class="team_info">수원에서 활동 가능한 누구나 모여 축구도 
						하고 친목도모도 하는 모임 입니다.<br/>
						개발이라도 말술 회원 우대~!!</li>
						<li class="team_rank">Ranking No. 23</li>
					</div>
					<div class="teambtn">
						<li class="teambtn_sign" onclick=""></li>
						<li class="teambtn_phone" onclick=""></li>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<footer class="_btnPlus plus_btn fixed" style="display:none;" onclick="page.controller.clickPlus();">
	</footer>
</div>

</form>
</body>
<script type="text/javascript" src="lib/header.js"></script>
<script type="text/javascript">
page.ready = function() {
	page.id = '/menu/menu.jsp';
	logger.debug('page.ready()', page.id);
	page.initFlag = true;
	page.selectTab = 0;
	page.plusTab1 = false;
	page.plusTab2 = false;
	page.plusTab3 = false;
	page.plusTab4 = false;
	
	page.model = (function() {
		var pub = {};
		pub.init = function() {
			logger.info('page.model.init()', page.id);
		};
		pub.getMyClubInfoList = function(callback) {
			$.ajax({
				type: 'post',
				url: 'getMyClubInfoList.do',
				data: {},
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
		pub.searchTeamScheduleList = function(callback) {
			$.ajax({
				type: 'post',
				url: 'searchTeamScheduleList.do',
				data: {},
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
		pub.searchTeamRankingList = function(callback) {
			$.ajax({
				type: 'post',
				url: 'searchTeamRankingList.do',
				data: {},
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
			
			pub.selectTab(1);
			
			page.controller.getMyClubInfoList();
			page.controller.searchClubInfoList();
			//page.controller.searchTeamScheduleList();
			//page.controller.searchTeamRankingList();
		};
		pub.complete = function() {
			$('body').css('visibility', 'visible');
			if(parent.page.view.complete && page.initFlag) {
				parent.page.view.complete();
				page.initFlag = false;
			}
		};
		pub.selectTab = function(selectTab) {
			if(page.selectTab != 0) {
				$('._selectTab'+page.selectTab).removeClass('on');
				$('._selectView'+page.selectTab).css('display','none');
			}
			$('._selectTab'+selectTab).addClass('on');
			$('._selectView'+selectTab).css('display','');
			page.selectTab = selectTab;
			
			$('._btnPlus').css('display','none');
			if(selectTab == 1 && page.plusTab1) {
				$('._btnPlus').css('display','');
			}
		};
		pub.selectTab3 = function(selectTab) {
			if(selectTab == 1) {
				$('._selectTab32').removeClass('on');
				$('._selectView32').css('display','none');
				$('._selectTab3'+selectTab).addClass('on');
				$('._selectView3'+selectTab).css('display','');
			} else {
				$('._selectTab31').removeClass('on');
				$('._selectView31').css('display','none');
				$('._selectTab3'+selectTab).addClass('on');
				$('._selectView3'+selectTab).css('display','');
			}
		};
		pub.selectTab4 = function(selectTab) {
			if(selectTab == 1) {
				$('._selectTab42').removeClass('on');
				$('._selectView42').css('display','none');
				$('._selectTab4'+selectTab).addClass('on');
				$('._selectView4'+selectTab).css('display','');
			} else {
				$('._selectTab41').removeClass('on');
				$('._selectView41').css('display','none');
				$('._selectTab4'+selectTab).addClass('on');
				$('._selectView4'+selectTab).css('display','');
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
			common.goBack();
		};
		pub.getMyClubInfoList = function() {
			page.model.getMyClubInfoList(function(data) {
				if(data.result != null && data.result.length > 0) {
					$('._selectView11').css('display','none');
					$('._selectView12').css('display','');
					
					$('._selectView12').html("");
					var html = '';
					for(var i=0;i<data.result.length; i++) {
						html += '\n<div class="teambox">';
						html += '\n	<div class="teamlogo"style="background-image:url(images/bg_logo01.png);"></div>';
						html += '\n	<div class="teaminfo" onclick="common.goParentContent(\'clubInfo.do\', \'clubInfos='+nvlString(data.result[i].infos)+'\');">';
						html += '\n		<li class="team_title">'+nvlString(data.result[i].clubName)+'</li>';
						html += '\n		<li class="team_sub">('+nvlString(data.result[i].area1)+' '+nvlString(data.result[i].area2)+', '+nvlString(data.result[i].memberCnt)+'명)</li>';
						html += '\n		<li class="team_info">'+replaceEnterToBr(data.result[i].intro)+'</li>';
						html += '\n		<li class="team_rank">Ranking No. 109</li>';
						html += '\n	</div>';
						html += '\n	<div class="teambtn">';
						html += '\n		<li class="teambtn_sign" onclick=""></li>';
						html += '\n		<li class="teambtn_phone" onclick=""></li>';
						html += '\n	</div>';
						html += '\n</div>';
					}
					$('._selectView12').append(html);
					page.plusTab1 = true;
					$('._btnPlus').css('display','');
				} else {
					$('._selectView11').css('display','');
					$('._selectView12').css('display','none');
					page.plusTab1 = false;
					$('._btnPlus').css('display','none');
				}
				page.view.complete();
			});
		};
		pub.searchClubInfoList = function() {
			page.model.searchClubInfoList(function(data) {
				$('._searchTeamList').html("");
				var html = '';
				if(data.result != null && data.result.length > 0) {
					for(var i=0;i<data.result.length; i++) {
						html += '\n<div class="teambox">';
						html += '\n	<div class="teamlogo" style="background-image:url(images/bg_logo01.png);"></div>';
						html += '\n	<div class="teaminfo" onclick="common.goParentContent(\'clubInfo.do\', \'clubInfos='+nvlString(data.result[i].infos)+'\');">';
						html += '\n		<li class="team_title">'+nvlString(data.result[i].clubName)+'</li>';
						html += '\n		<li class="team_sub">('+nvlString(data.result[i].area1)+' '+nvlString(data.result[i].area2)+', '+nvlString(data.result[i].memberCnt)+'명)</li>';
						html += '\n		<li class="team_info">'+replaceEnterToBr(data.result[i].intro)+'</li>';
						html += '\n		<li class="team_rank">Ranking No. 109</li>';
						html += '\n	</div>';
						html += '\n	<div class="teambtn">';
						html += '\n		<li class="teambtn_sign" onclick=""></li>';
						html += '\n		<li class="teambtn_phone" onclick=""></li>';
						html += '\n	</div>';
						html += '\n</div>';
					}
				}
				$('._searchTeamList').append(html);
			});
		};
		pub.searchTeamScheduleList = function() {
			page.model.searchTeamScheduleList(function(data) {
				$('#searchTeamScheduleList').html("");
				if(data.result != null && data.result.length > 0) {
					for(var i=0;i<data.result.length; i++) {
						//var html = '\n<button onclick="common.goParentContent(\'gameView.do\', \'infos='+nvlString(data.result[i].infos)+'\');">'+nvlString(data.result[i].gameType)+'</td>';
						//$('#searchTeamScheduleList').append(html);
					}
				}
			});
		};
		pub.searchTeamRankingList = function() {
			page.model.searchTeamRankingList(function(data) {
				$('#searchTeamRankingList').html("");
				if(data.result != null && data.result.length > 0) {
					for(var i=0;i<data.result.length; i++) {
						//var html = '\n<button onclick="common.goParentContent(\'teamInfo.do\', \'infos='+nvlString(data.result[i].infos)+'\');">'+nvlString(data.result[i].teamName)+'</td>';
						//$('#searchTeamRankingList').append(html);
					}
				}
			});
		};
		pub.clickPlus = function() {
			if(page.selectTab == 1) {
				common.goParentContent('clubReg.do');
			}
		};
		return pub;
	}());
}
</script>
</html>