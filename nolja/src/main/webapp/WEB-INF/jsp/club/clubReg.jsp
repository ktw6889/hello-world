<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/spring.tld" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, target-densitydpi=device-dpi">
<title>동아리 만들기</title>
</head>
<body class="mobile" style="visibility:hidden;overflow-x:hidden;">
<form name="soccerForm" method="post" enctype="multipart/form-data" onsubmit="return false;">
<input type="hidden" name="infos" value="${command.infos}">

<div id="wrap">

	<header id="header" class="header_type fixed">
		<div class="btn_goback leftbtn" onclick="page.controller.goPageBack();"></div>
		<div class="_title title tL">
			동아리 만들기
		</div>
	</header>

	<div id="contents" class="sign">
		
		<div class="team_photo">
			<img src="upload/${command.introImage}" alt="${command.clubName}" onclick="page.view.clickIntroImage();">
			<input type="hidden" name="introImageStr" readonly="readonly">
			<input type="file" name="introImage" style="display:none;">
			<p class="_teamIntro">동아리를 대표하는 이미지를 등록해 주세요!!</p> 
		</div>

		<div class="sign_input">
			<table class="basic_table">	
				<colgroup>
					<col width="70" /><col width="" /><col width="" /><col width="" />
				</colgroup>
				<tr>
					<td class="bold tR">동아리명 :</td>
					<td colspan="3" class="inputTd">
						<div class="_teamNameN fbtn">
							<input type="text" name="clubName" value="${command.clubName}" onchange="page.controller.changeMemberDuplication();">
							<span class="_duplication fbtn01 textbtn" onclick="page.controller.checkClubDuplication();">중복확인</span>
						</div>
						<div class="_teamNameY" style="display:none;">
							${command.clubName}
						</div>
					</td>
				</tr>
				<tr>
					<td class="bold tR">상&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;징 :</td>
					<td colspan="3" class="inputTd">
						<div class="fbtn">
							<input type="text" name="symbolFileStr" readonly="readonly">
							<input type="file" name="symbolFile" onchange="page.view.changeSymbolFile(this);" style="display:none;">
							<span class="fbtn01 photo" onclick="page.view.clickSymbolFile();"></span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="bold tR">타&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;입 :</td>
					<td colspan="3" class="inputTd">
						<input type="radio" name="clubType" value="공개" checked="checked">공개</input>
						<input type="radio" name="clubType" value="비공개">비공개</input>
					</td>
				</tr>
				<tr>
					<td class="bold tR">지&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;역 :</td>
					<td colspan="3" class="selectTd">
						<div class="fbtn">
							<div class="_area1 block2">
							</div>
							<div class="_area2 block2">
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td class="bold tR">팀 구 장 :</td>
					<td colspan="3" class="inputTd">
						<div class="fbtn">
							<input type="hidden" name="latPosition" value="${command.latPosition}">
							<input type="hidden" name="lngPosition" value="${command.lngPosition}">
							<input type="text" name="teamStadium" value="${command.teamStadium}" readonly="readonly"/>
							<span class="fbtn01 reset" onclick="page.controller.resetPlaceInfo();"></span>
								<span class="fbtn02 point" onclick="page.controller.searchMapInfo();"></span>
						</div>
					</td>
				</tr>
				
				<tr>
					<td class="bold tR">회&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;비 :</td>
					<td colspan="3" class="inputTd">
						<input type="text" name="fee" value="${command.fee}" class="tR"/>
					</td>
				</tr>
				<tr>
					<td class="bold tR vT pt20">소 개 글 :</td>
					<td colspan="3" class="textareaTd">
						<textarea name="intro" style="height:90px;"></textarea>
					</td>
				</tr>
				
			</table>
		</div>
	</div>
	
	<div class="_keyarea" style="display:none;"></div>
	<footer class="footer_type fixed">
		<div class="_btnTitle block1" onclick="page.controller.saveClubInfo();">
			동아리 만들기
		</div>
	</footer>
</div>

<div class="_intro" style="display:none;">${command.intro}</div>

</form>
<iframe name="hiddenFrame" style="display:none;"></iframe>
</body>
<script type="text/javascript" src="lib/header.js"></script>
<script type="text/javascript">
page.ready = function() {
	page.id = '/club/clubReg.jsp';
	logger.debug('page.ready()', page.id);
	page.initFlag = true;
	page.clickFlag = true;
	page.duplication = false;
	page.mobileFlag = false;
	
	page.model = (function() {
		var pub = {};
		pub.init = function() {
			logger.info('page.model.init()', page.id);
		};
		/*
		pub.getDataItemUseList = function(masterCode,itemCode,callback) {
			$.ajax({
				type: 'post',
				url: 'getDataItemUseList.do',
				data: {masterCode:masterCode, itemCode:itemCode},
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
		*/
		pub.checkClubDuplication = function(callback) {
			$.ajax({
				type: 'post',
				url: 'checkClubDuplication.do',
				data: {infos:$('input[name="infos"]').val(), clubName:$('input[name="clubName"]').val()},
				dataType: 'json',
				success: function(data) {
					if(data.status == '200') {
						callback(data);	
					} else {
						parent.page.toast.show('warning','중복확인에 실패하였습니다.'); 
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
			
			if($('input[name="infos"]').val() == 'NEW') {
				$('input[name="infos"]').val('');
			}
			
			if(!'${command.introImage}'.startsWith("default")) {
				$('._teamIntro').html('이미지를 클릭하면 변경가능합니다.');
			}
			
			page.view.initViewInfo();
			
		//	page.controller.getArea1List();
			
		    page.view.complete();
			if(common.isMobile()) {
				/*
				$('._keyarea').css('height', parent.page.height*0.43);
				$('input[type="text"],textarea').focus(function () { 
					page.controller.inputFocus(this); 
				});
				$('input[type="text"],textarea').blur(function () { 
					page.controller.inputBlur(this); 
				});
				*/
			}
		};
		pub.complete = function() {
			$('body').css('visibility', 'visible');
			if(parent.page.view.complete && page.initFlag) {
				parent.page.view.complete();
				page.initFlag = false;
			}
		};
		pub.clickSymbolFile = function() {
			$('input[name="symbolFile"]').click();
			page.plugin.getImageUploadSymbol();
		};
		pub.changeSymbolFile = function(obj) {
			$('input[name="symbolFileStr"]').val(obj.value);
		};
		pub.clickIntroImage = function() {
			$('input[name="introImage"]').click();
			page.plugin.getImageUploadIntro();
		};
		pub.changeIntroImage = function(obj) {
			$('input[name="introImageStr"]').val(obj.value);
		};
		pub.initViewInfo = function() {
			var clubName = '${command.clubName}';
			if(clubName != '') {
				$('._teamNameY').show();
				$('._teamNameN').hide();
				page.duplication = true;
			}
			
			var clubType = '${command.clubType}';
			$('input:radio[name="clubType"]:radio[value="'+clubType+'"]').attr("checked",true);

			
			
			$('textarea[name="intro"]').val($('._intro').html());
			
			if($('input[name="infos"]').val() != '') {
				$('._title').html('팀 정보 수정');
				$('._btnTitle').html('저장');
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
			if($('input[name="infos"]').val() == '') {
				common.goParentContent('myClub.do');
			} else {
				common.goParentContent('clubInfo.do');
			}
		};
		pub.inputFocus = function(obj) {
			$('._keyarea').show();
			$(window).scrollTop($(obj).offset().top-200)
		};
		pub.inputBlur = function(obj) {
			$('._keyarea').hide();
		};
		/*
		pub.getArea1List = function() {
			page.model.getDataItemUseList('시도', null, function(data) {
				var html = '\n<select name="area1" onchange="page.controller.changeArea1(this);">';
				var itemCode = '';
				var area1 = '';
				if(page.initFlag) {
					area1 = '${command.area1}';
				}
				var selected = '';
				for(var i=0;i<data.result.length; i++) {
					for(var i=0;i<data.result.length; i++) {
						if(area1 != '' && area1 == data.result[i].itemCode) {
							itemCode = area1;
							selected = 'selected';
						} else {
							selected = '';
							if(i==0) {
								itemCode = nvlString(data.result[i].itemCode);
							}
						}
						html += '\n 		<option value="'+nvlString(data.result[i].itemCode)+'" '+selected+'>'+nvlString(data.result[i].itemName)+'</option>'; 
					}
				}
				html += '</select>\n';
				$('._area1').html(html);
				
				page.controller.getArea2List(itemCode);
			});
		};
		pub.changeArea1 = function(obj) {
			page.controller.getArea2List($(obj).val());
		};
		pub.getArea2List = function(itemCode) {
			page.model.getDataItemUseList('시군구', itemCode, function(data) {
				var html = '\n<select name="area2">';
				var area2 = '';
				if(page.initFlag) {
					area2 = '${command.area2}';
				}
				var selected = '';
				for(var i=0;i<data.result.length; i++) {
					for(var i=0;i<data.result.length; i++) {
						if(area2 == data.result[i].itemCode) {
							selected = 'selected';
						} else {
							selected = '';
						}
						html += '\n 		<option value="'+nvlString(data.result[i].itemCode)+'" '+selected+'>'+nvlString(data.result[i].itemName)+'</option>'; 
					}
				}
				html += '</select>\n';
				page.area2 = html;
				
				$('._area2').html(page.area2);
				
				page.view.complete();
			});
		};
		*/
		pub.changeMemberDuplication = function() {
			$("._duplication").html('중복확인');
			page.duplication = false;
		};
		pub.checkClubDuplication = function() {
			if($('input[name="clubName"]').val() == '') {
				alert('팀명을 입력하세요.');				
			} else {
				page.model.checkClubDuplication(function(data) {
					if(nvlString(data.infos) == '') {
						$("._duplication").html('<font color="#1DDB16;">사용 가능</font>');
						page.duplication = true;
					} else {
						$("._duplication").html('<font color="#ff0000;">사용 불가능</font>');
						page.duplication = false;
					}
				});	
			}
		};
		
		pub.saveClubInfo = function() {
			if($('input[name="clubName"]').val() == '') {
				alert('팀명을 입력하세요.');		
				return false;
			}
			if(!page.duplication) {
				alert('팀명을 중복확인을 해주세요.');
				return false;
			}
			
			if(page.clickFlag) {
				page.clickFlag = false;
				if(confirm('저장하겠습니까?')) {
					common.loading(true);
					var form = document.soccerForm;
					form.action = 'saveClubInfo.do';
					form.target = 'hiddenFrame';
					form.submit();
				} else {
					page.clickFlag = true;
				}
			}
		};
		
		pub.saveSuccess = function(infos) {
			if('duplication' == infos) {
				common.loading(false);
				parent.page.toast.show('warning','중복된 팀명입니다.');
				page.clickFlag = true;
			} else {
				if(page.mobileFlag) {
					page.plugin.saveMobile(infos);
				} else {
					common.loading(false);
					parent.page.toast.show('success','저장에 성공하였습니다.');
					common.goParentContent('myClub.do');
					page.clickFlag = true;
				}
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
			if($('input[name="infos"]').val() == '') {
				common.goParentContent('myClub.do');
			} else {
				common.goParentContent('clubOption.do');
			}
			page.clickFlag = true;
		};
		pub.saveMobileFail = function() {
			common.loading(false);
			parent.page.toast.show('warning','저장에 실패하였습니다.');
			page.clickFlag = true;
		};
		pub.searchMapInfo = function() {
			var searchType = $("input[name='teamStadium']").val();
			var latPosition = $("input[name='latPosition']").val();
			var lngPosition = $("input[name='lngPosition']").val();
			
			if(searchType != ''){
				common.goParentContentPop('daumMap.do?searchType='+searchType+'&latPosition='+latPosition+'&lngPosition='+lngPosition);
			}else{
				common.goParentContentPop('daumMap.do');
			}
		};
		pub.resetPlaceInfo = function() {
			$('input[name="latPosition"]').val('');
			$('input[name="lngPosition"]').val('');
			$('input[name="teamStadium"]').val('');
		};
		page.mapResultCallBack = function(marker, title) {
			$('input[name="latPosition"]').val(marker.getPosition().getLat());
			$('input[name="lngPosition"]').val(marker.getPosition().getLng());
			$('input[name="teamStadium"]').val(title);
		};
		
		return pub;
	}());
	
	page.plugin = (function() {
		var pub = {};
		pub.getImageUploadSymbol = function() {
			if(window.android && window.android.setMessage) {
				window.android.setMessage('plugin:image:symbol');
			} else if(parent.page.ios || parent.page.apple) {
				location.href = 'plugin:image:symbol';
			}
			$('input[name="symbolFileStr"]').val("");
		};
		pub.getImageUploadIntro = function() {
			if(window.android && window.android.setMessage) {
				window.android.setMessage('plugin:image:intro');
			} else if(parent.page.ios || parent.page.apple) {
				location.href = 'plugin:image:intro';
			}
			$('input[name="introImageStr"]').val("");
		};
		pub.setImageUploadStr = function(uploadType, imgStr) {
			if(uploadType == 'symbol') {
				$('input[name="symbolFileStr"]').val(imgStr);
			} else if(uploadType == 'intro') {
				$('input[name="introImageStr"]').val(imgStr);
			}
			page.mobileFlag = true;
		};
		pub.saveMobile = function(infos) {
			if($('input[name="symbolFileStr"]').val() != null || $('input[name="introImageStr"]').val() != null) {
				if(window.android && window.android.setMessage) {
					window.android.setMessage('plugin:saveimage:team:'+infos);
				} else if(parent.page.ios || parent.page.apple) {
					location.href = 'plugin:saveimage:team:'+infos;
				}
			} else {
				page.controller.saveMobileSuccess();
			}
		};
		return pub;
	}());
}

function mapResultCallBack(marker, title) {
	$('input[name="latPosition"]').val(marker.getPosition().getLat());
	$('input[name="lngPosition"]').val(marker.getPosition().getLng());
	$('input[name="teamStadium"]').val(title);
}

</script>
</html>