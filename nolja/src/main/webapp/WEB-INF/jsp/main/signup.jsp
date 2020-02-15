<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/spring.tld" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, target-densitydpi=device-dpi">
<title>회원가입</title>
</head>
<body class="mobile" style="visibility:hidden;overflow-x:hidden;">
<form name="clubForm" method="post" enctype="multipart/form-data" onsubmit="return false;">
<input type="hidden" name="infos" value="${command.infos}">
<input type="hidden" name="password">

<div id="wrap">
	
	<header id="header" class="header_type fixed">
		<div class="btn_goback leftbtn" onclick="page.controller.goPageBack();"></div>
		<div class="_title title tL">
			회원가입
		</div>
	</header>

	<div id="contents" class="sign">

		<div class="sign_input">
			<table class="basic_table">	
				<colgroup>
					<col width="70" /><col width="" /><col width="" /><col width="" />
				</colgroup>
				<tr>
					<td class="bold tR">이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름 :</td>
					<td colspan="3" class="inputTd">
						<div class="_memberNameN">
							<input type="text" name="memberName" value="${command.memberName}">
						</div>
						<div class="_memberNameY" style="display:none;">
							${command.memberName}
						</div>
					</td>
				</tr>
				<tr>
					<td class="bold tR">아 이 디 :</td>
					<td colspan="3" class="inputTd">
						<div class="_emailN fbtn">
							<input type="text" name="email" value="${command.email}" placeholder="abce@naver.com" onchange="page.controller.changeMemberDuplication();">
							<span class="_duplication fbtn01 textbtn" onclick="page.controller.checkMemberDuplication();">중복확인</span>
						</div>
						<div class="_emailY fbtn" style="display:none;">
							${command.email}
						</div>
					</td>
				</tr>
				<tr>
					<td class="bold tR">비밀번호 :</td>
					<td colspan="3" class="inputTd"><input type="password" name="password1"></td>
				</tr>
				<tr>
					<td class="bold tR">확&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;인 :</td>
					<td colspan="3" class="inputTd"><input type="password" name="password2"></td>
				</tr>
				<tr>
					<td class="bold tR">사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;진 :</td>
					<td colspan="3" class="inputTd">
						<div class="fbtn">
							<input type="text" name="pictureFileStr" readonly="readonly">
							<input type="file" name="pictureFile" onchange="page.view.changePictureFile(this);" style="display:none;">
							<span class="fbtn01 photo" onclick="page.view.clickPictureFile();"></span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="bold tR">연 락 처 :</td>
					<td colspan="3" class="inputTd">
						<input type="text" name="phone" value="${command.phone}" placeholder="휴대폰번호, 숫자만 입력하세요."/>
					</td>
				</tr>
				<tr>
					<td class="bold tR">생년월일 :<input type="hidden" name="birthday"></td>
					<td class="selectTd">
						<select name="birthday1">
							<option value="">연도</option>
							<option value="2010">2010</option>
							<option value="2009">2009</option>
							<option value="2008">2008</option>
							<option value="2007">2007</option>
							<option value="2006">2006</option>
							<option value="2005">2005</option>
							<option value="2004">2004</option>
							<option value="2003">2003</option>
							<option value="2002">2002</option>
							<option value="2001">2001</option>
							<option value="2000">2000</option>
							<option value="1999">1999</option>
							<option value="1998">1998</option>
							<option value="1996">1996</option>
							<option value="1995">1995</option>
							<option value="1994">1994</option>
							<option value="1993">1993</option>
							<option value="1992">1992</option>
							<option value="1991">1991</option>
							<option value="1990">1990</option>
							<option value="1989">1989</option>
							<option value="1988">1988</option>
							<option value="1986">1986</option>
							<option value="1985">1985</option>
							<option value="1984">1984</option>
							<option value="1983">1983</option>
							<option value="1982">1982</option>
							<option value="1981">1981</option>
							<option value="1980">1980</option>
							<option value="1979">1979</option>
							<option value="1978">1978</option>
							<option value="1976">1976</option>
							<option value="1975">1975</option>
							<option value="1974">1974</option>
							<option value="1973">1973</option>
							<option value="1972">1972</option>
							<option value="1971">1971</option>
							<option value="1970">1970</option>
							<option value="1969">1969</option>
							<option value="1968">1968</option>
							<option value="1966">1966</option>
							<option value="1965">1965</option>
							<option value="1964">1964</option>
							<option value="1963">1963</option>
							<option value="1962">1962</option>
							<option value="1961">1961</option>
							<option value="1960">1960</option>
							<option value="1959">1959</option>
							<option value="1958">1958</option>
							<option value="1956">1956</option>
							<option value="1955">1955</option>
							<option value="1954">1954</option>
							<option value="1953">1953</option>
							<option value="1952">1952</option>
							<option value="1951">1951</option>
							<option value="1950">1950</option>
						</select>	
					</td>
					<td class="selectTd">
						<select name="birthday2">
							<option value="">월</option>
							<option value="01">1</option>
							<option value="02">2</option>
							<option value="03">3</option>
							<option value="04">4</option>
							<option value="05">5</option>
							<option value="06">6</option>
							<option value="07">7</option>
							<option value="08">8</option>
							<option value="09">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select>
					</td>
					<td class="selectTd">
						<select name="birthday3">
							<option value="">일</option>
							<option value="01">1</option>
							<option value="02">2</option>
							<option value="03">3</option>
							<option value="04">4</option>
							<option value="05">5</option>
							<option value="06">6</option>
							<option value="07">7</option>
							<option value="08">8</option>
							<option value="09">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
						</select>
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
					<td class="bold tR vT pt20">프 로 필 :</td>
					<td colspan="3" class="textareaTd">
						<textarea name="profile" style="height:90px;"></textarea>
					</td>
				</tr>
				<tr>
					<td class="bold tR">포 지 션 :</td>
					<td class="_position1 selectTd">
					</td>
					<td class="_position2 selectTd">
					</td>
					<td class="_position3 selectTd">
					</td>
				</tr>
				<!-- 
				<tr>
					<td class="bold tR">내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;팀 :</td>
					<td colspan="3" class="inputTd">
						<div class="fbtn">
							<input type="text" value=""/>
							<span class="fbtn01 reset"></span>
							<span class="fbtn02 search"></span>
						</div>
					</td>
				</tr>
				-->
			</table>
		</div>
		<div class="_signCheck">
			<div class="sign_check">
				<li><input type="checkbox" name="checkAll" class="sign_checkbox" onclick="page.controller.checkAll();"/>전체 동의</li>
				<li><input type="checkbox" name="checkClause" class="sign_checkbox"/>동아리야 놀자 서비스 약관<a  onclick="page.controller.closeClause(true);">자세히보기</a></li>
				<li><input type="checkbox" name="checkPersonalInfo" class="sign_checkbox"/>개인정보 취급 방침<a  onclick="page.controller.closePersonalInfo(true);">자세히보기</a></li>
			</div>
			
			<div class="_clause1 _personalInfo1 sign_detail" style="display:none;"></div>
			<div class="_clause2 sign_detail_text" style="display:none;">
				"파이티싸커"권리 및 책임에 관한 정책
				본 권리 및 책임에 관한 정책 (이하 "정책", "약관")은 "파이티싸커" 원칙에 기반을 두고 있으며, "파이티싸커"은 물론 "파이티싸커" 브랜드, 제품 및 서비스(이하 "서비스")를 이용하는 회원 및 비회원들과 저희의 관계를 규정하는 서비스 이용 약관입니다.
				"파이티싸커" 서비스를 이용하고 "파이티싸커" 서비스에 접속함으로써 회원님은 이 정책에 동의하는 것이며 정책은 아래의 섹션 13에 따라 때때로 업데이트 됩니다.
				또한 이 문서의 끝 부분에서 "파이티싸커"의 운영방침에 대한 이해를 돕기위한 리소스를 보실 수 있습니다.
				"파이티싸커"는 다양한 서비스를
			</div>
			<div class="_clause3 sign_detail_close" style="display:none;" onclick="page.controller.closeClause(false);"></div>
			
			<div class="_personalInfo2 sign_detail_text" style="display:none;">
<pre>
개인정보처리방침

<개인정보보호 종합포털> 개인정보 처리방침
<개인정보보호 종합포털>이 취급하는 모든 개인정보는 관련 법령에 근거하여 수집 · 보유 및 처리되고 있습니다. 「개인정보보호법」은 이러한 개인정보의 취급에 대한 일반적 규범을 제시하고 있으며, <개인정보보호 종합포털>은 이러한 법령의 규정에 따라 수집 · 보유 및 처리하는 개인정보를 공공업무의 적절한 수행과 이용자의 권익을 보호하기 위해 적법하고 적정하게 취급할 것입니다.

또한, <개인정보보호 종합포털>은 관련 법령에서 규정한 바에 따라 보유하고 있는 개인정보에 대한 열람, 정정·삭제, 처리정지 요구 등 이용자의 권익을 존중하며, 이용자는 이러한 법령상 권익의 침해 등에 대하여 행정심판법에서 정하는 바에 따라 행정심판을 청구할 수 있습니다.

<개인정보보호 종합포털>은 개인정보보호법 제 30조에 따라 정보주체의 개인정보 보호 및 권익을 보호하고 개인정보와 관련한 이용자의 고충을 원활하게 처리할 수 있도록 다음과 같은 개인정보 처리방침을 수립 · 공개하고 있습니다.

제1조 (개인정보의 처리 목적)

① <개인정보보호 종합포털>은 개인정보를 다음의 목적을 위해 처리합니다. 처리한 개인정보는 다음의 목적이외의 용도로는 사용되지 않으며 이용 목적이 변경되는 경우에는 개인정보 보호법 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.
가. 서비스 제공
교육 콘텐츠 제공, 본인인증, 증명서발급(교육 수료증) 등 서비스 제공에 관련한 목적으로 개인정보를 처리합니다. 
협박 사례를 적극 신고하시기 바랍니다.

나. 민원처리
개인정보 열람, 개인정보 정정·삭제, 개인정보 처리정지 요구, 개인정보 유출사고 신고 등 개인정보와 관련된 민원처리를 목적으로 개인정보를 처리합니다.

② <개인정보보호 종합포털>이 개인정보 보호법 제32조에 따라 등록·공개하는 개인정보파일의 처리목적은 다음과 같습니다.
순번	개인정보파일의 명칭	운영근거	처리목적
1	교육서비스 제공 사용자 정보	정보주체 동의	종합포털 개인정보보호 온라인교육에 대한 본인인증, 교육이력관리, 교육수료증 발급
2	개인정보 열람등요구 처리 사용자 정보	개인정보보호법 제35조-제39조	개인정보 열람등요구 처리 행정업무의 참고 또는 사실 증명
3	유출사고 신고 처리 사용자 정보	개인정보보호법 제34조	유출사고 신고 처리 행정업무의 참고 또는 사실 증명
4	개인정보보호 전문강사 명단	정보주체 동의	개인정보보호 교육지원(강사풀 제공)
제2조 (개인정보의 처리 및 보유 기간)

① <개인정보보호 종합포털>은 법령에 따른 개인정보 보유·이용기간 또는 정보주체로부터 개인정보를 수집시에 동의받은 개인정보 보유·이용기간 내에서 개인정보를 처리·보유합니다.
② 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다.
순번	개인정보파일의 명칭	운영근거	보유기간
(목적 달성시)
1	교육서비스 제공 사용자 정보	정보주체 동의	1년
2	개인정보 열람등요구 처리 사용자 정보	개인정보보호법 제35조-제39조	3년
3	유출사고 신고 처리 사용자 정보	개인정보보호법 제34조	3년
4	개인정보보호 전문강사 명단	정보주체 동의	3년
제3조 (개인정보의 제3자 제공)

① <개인정보보호 종합포털>은 정보주체의 동의, 법률의 특별한 규정 등 개인정보 보호법 제17조 및 제18조에 해당하는 경우에만 개인정보를 제3자에게 제공합니다.
② <개인정보보호 종합포털>은 개인정보 열람, 정정·삭제, 처리정지 요구 민원을 처리하기 위하여 민원 신청인의 개인정보를 개인정보파일 보유기관이 열람할 수 있도록 하고 있습니다.
③ <개인정보 열람, 정정·삭제, 처리정지 요구 사용자 정보>
- 민원인이 신청한 공공기관에 개인정보를 제공하고 있으며, 접수된 민원이 처리완료 되는 시점까지 보유 및 이용하고 있습니다.
- 제공하는 개인정보 항목 : 신청인 성명, 생년월일, 전화번호, 주소
제4조 (개인정보처리 위탁)

① <개인정보보호 종합포털>은 원활한 개인정보 업무처리를 위하여 다음과 같이 개인정보 처리업무를 위탁하고 있습니다.
가. 위탁처리 기관
- 수탁업체명　: 한국인터넷진흥원
- 주소 : 서울특별시 송파구 중대로 135 IT벤처타워
- 전화 : 02-405-5101
- 근무시간 : 09:00 - 18:00
- 위탁업무 : 개인정보보호 종합포털 운영
나. 위탁처리 수행업체
- 수탁업체명　: (주)오더
- 주소 : 서울특별시 서초구 방배로 111, 3-5층(방배동, 근복빌딩)
- 전화 : 02-403-0074
- 근무시간 : 09:00 - 18:00
- 위탁업무 : 개인정보보호 종합포털 H/W 및 S/W 유지보수, Help-desk 운영
라. 위탁처리 수행업체
- 수탁업체명　: 한국지역정보개발원
- 주소 : 서울시 마포구 성암로 301
- 전화 : 02-2031-9822
- 근무시간 : 09:00 - 18:00
- 위탁업무 : 본인인증
제5조 (정보주체 권리·의무 및 그 행사방법에 관한 사항)

① 정보주체(만 14세 미만인 경우에는 법정대리인을 말함)는 언제든지 개인정보 열람?정정?삭제?처리정지 요구 등의 권리를 행사할 수 있습니다.
② 제1항에 따른 권리 행사는 개인정보보호법 시행규칙 별지 제8호 서식에 따라 작성 후 서면, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며, 이에 대해 지체 없이 조치하겠습니다.
③ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우 개인정보보호법 시행규칙 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.
④ 개인정보 열람 및 처리정지 요구는 개인정보보호법 제35조 제5항, 제37조 제2항에 의하여 정보주체의 권리가 제한 될 수 있습니다.
⑤ 개인정보의 정정 및 삭제 요구는 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.
⑥ 정보주체 권리에 따른 열람의 요구, 정정·삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다
* [개인정보보호법 시행규칙 별지 제8호] 개인정보(열람, 정정·삭제, 처리정지) 요구서
* [개인정보보호법 시행규칙 별지 제11호] 위임장
제6조 (처리하는 개인정보의 항목)

<개인정보보호 종합포털>은 다음의 개인정보 항목을 처리하고 있습니다.

순번	개인정보파일의 명칭	개인정보파일에 기록되는 개인정보의 항목
1	교육서비스 제공 사용자 정보	성명, 기관명, 직위, 전화번호, 이메일
2	개인정보 열람등요구 처리 사용자 정보	성명, 생년월일, 전화번호, 주소, 휴대폰번호(선택), fax번호(선택), 이메일(선택)
3	유출사고 신고 처리 사용자 정보	성명, 기관명, 부서, 직위, 전화번호, 이메일
4	개인정보보호 전문강사 명단	성명, 소속, 직급, 강의경력, 연락처, 이메일, 강의지역
제7조 (개인정보 파기 절차 및 방법)

① <개인정보보호 종합포털>은 원칙적으로 개인정보 처리목적이 달성된 경우에는 지체없이 해당 개인정보를 파기합니다. 다만, 다른 법률에 따라 보존하여야하는 경우에는 그러하지 않습니다. 파기의 절차, 기한 및 방법은 다음과 같습니다.
가. 파기절차
불필요한 개인정보 및 개인정보파일은 개인정보책임자의 책임 하에 내부방침 절차에 따라 다음과 같이 처리하고 있습니다.
- 개인정보의 파기
보유기간이 경과한 개인정보는 종료일로부터 지체 없이 파기합니다.
- 개인정보파일의 파기
개인정보파일의 처리 목적 달성, 해당 서비스의 폐지, 사업의 종료 등 그 개인정보파일이 불필요하게 되었을 때에는 개인정보의 처리가 불필요한 것으로 인정되는 날로부터 지체 없이 그 개인정보파일을 파기합니다.
나. 파기방법
1) 전자적 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다.
2) 종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다.
제8조 (개인정보 자동 수집 장치의 설치?운영 및 거부에 관한 사항)

<개인정보보호 종합포털>은 이용자에게 개별적인 맞춤서비스를 제공하기 위해 이용정보를 저장하고 수시로 불러오는 ‘쿠키(cookie)’를 사용하지 않습니다.

제9조 (개인정보의 안전성 확보 조치)

<개인정보보호 종합포털>은 「개인정보보호법」 제29조에 따라 다음과 같이 안전성 확보에 필요한 기술적, 관리적, 물리적 조치를 하고 있습니다.

1. 내부관리계획의 수립 및 시행
<개인정보보호 종합포털>의 내부관리계획 수립 및 시행은 행정자치부의 내부관리 지침을 준수하여 시행합니다.

2. 개인정보 취급 담당자의 최소화 및 교육
개인정보를 취급하는 담당자를 지정하고 최소화하여 개인정보를 관리하는 대책을 시행하고 있습니다.

3. 개인정보에 대한 접근 제한
개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여, 변경, 말소를 통하여 개인정보에 대한 접근통제를 위하여 필요한 조치를 하고 있으며 침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있습니다.

4. 접속기록의 보관 및 위변조 방지
개인정보처리시스템에 접속한 기록(웹 로그, 요약정보 등)을 최소 6개월 이상 보관, 관리하고 있으며, 접속 기록이 위변조 및 도난, 분실되지 않도록 보안기능을 사용하고 있습니다.

5. 개인정보의 암호화
이용자의 개인정보는 암호화 되어 저장 및 관리되고 있습니다. 또한 중요한 데이터는 저장 및 전송 시 암호화하여 사용하는 등의 별도 보안기능을 사용하고 있습니다.

6. 해킹 등에 대비한 기술적 대책
<개인정보보호 종합포털>은 해킹이나 컴퓨터 바이러스 등에 의한 개인정보 유출 및 훼손을 막기 위하여 보안프로그램을 설치하고 주기적인 갱신·점검을 하며 외부로부터 접근이 통제된 구역에 시스템을 설치하고 기술적/물리적으로 감시 및 차단하고 있습니다. 또한 네트워크 트래픽의 통제(Monitoring)는 물론 불법적으로 정보를 변경하는 등의 시도를 탐지하고 있습니다.

7. 비인가자에 대한 출입 통제
개인정보를 보관하고 있는 개인정보시스템의 물리적 보관 장소를 별도로 두고 이에 대해 출입통제 절차를 수립, 운영하고 있습니다.

제10조 (권익침해 구제방법)

정보주체는 아래의 기관에 대해 개인정보 침해에 대한 피해구제, 상담 등을 문의하실 수 있습니다. <아래의 기관은 개인정보보호 종합포털과는 별개의 기관으로서, 개인정보보호 종합포털의 자체적인 개인정보 불만처리, 피해구제 결과에 만족하지 못하시거나 보다 자세한 도움이 필요하시면 문의하여 주시기 바랍니다>

▶ 개인정보 침해신고센터 (한국인터넷진흥원 운영)
- 소관업무 : 개인정보 침해사실 신고, 상담 신청
- 홈페이지 : privacy.kisa.or.kr
- 전화 : (국번없이) 118
- 주소 : (138-950) 서울시 송파구 중대로 135 한국인터넷진흥원 개인정보침해신고센터
▶ 개인정보 분쟁조정위원회 (한국인터넷진흥원 운영)
- 소관업무 : 개인정보 분쟁조정신청, 집단분쟁조정 (민사적 해결)
- 홈페이지 : www.kopico.go.kr
- 전화 : 1833-6972
- 주소 : (138-950) 서울시 송파구 중대로 135 한국인터넷진흥원 개인정보침해신고센터
▶ 대검찰청 사이버범죄수사단 : (국번없이) 1301, cid@spo.go.kr (www.spo.go.kr)
▶ 경찰청 사이버안전국 : (국번없이) 182 (cyberbureau.police.go.kr)
또한, 개인정보의 열람, 정정·삭제, 처리정지 등에 대한 정보주체자의 요구에 대하여 공공기관의 장이 행한 처분 또는 부작위로 인하여 권리 또는 이익을 침해 받은 자는 행정심판법이 정하는 바에 따라 행정심판을 청구할 수 있습니다.

☞ 중앙행정심판위원회(www.simpan.go.kr)의 전화번호 안내 참조

제11조(개인정보 열람청구)

① 정보주체는 개인정보 보호법 제35조에 따른 개인정보의 열람 청구를 아래의 부서에 할 수 있습니다. 행정자치부는 정보주체의 개인정보 열람청구가 신속하게 처리되도록 노력하겠습니다.
▶ 개인정보 열람청구 접수·처리 부서
부서명 : 개인정보보호정책과
담당자 : 박성주
연락처 : <전화번호 02-2100-4108>, <이메일 psjwa@korea.kr>, <팩스번호 02-2100-4100>
② 정보주체께서는 제1항의 열람청구 접수·처리부서 이외에, 행정자치부의 ‘개인정보보호 종합포털’ 웹사이트(www.privacy.go.kr)를 통하여서도 개인정보 열람청구를 하실 수 있습니다.
▶ 행정자치부 개인정보보호 종합지원 포털 → 개인정보 민원 → 개인정보 열람등 요구 (공공아이핀을 통한 실명인증 필요)
제12조 (개인정보보호 "분야별" 책임관 및 담당자 연락처)

<개인정보보호 종합포털>은 개인정보를 보호하고 개인정보와 관련한 불만을 처리하기 위하여 아래와 같이 개인정보 보호책임자 및 실무담당자를 지정하고 있습니다. (개인정보보호법 제31조 제1항에 따른 개인정보 보호책임자)

구분	부서명	성명	연락처
개인정보보호 책임자	정책기획관	장영환	02-2100-3960
개인정보보호 분야별책임관	개인정보보호정책과장	장한	02-2100-4090
개인정보보호 담당자	개인정보보호정책과	박성주	02-2100-4108
제13조 (개인정보 처리방침의 변경)

① 본 방침은 2017년 2월 10일부터 시행됩니다.
② 이전의 개인정보 처리방침은 아래에서 확인하실 수 있습니다
</pre>
			</div>
			<div class="_personalInfo3 sign_detail_close" style="display:none;" onclick="page.controller.closePersonalInfo(false);"></div>
		</div>
		
		<!--  
		<div class="sign_check">
			<li>전체 동의</li>
			<li>GoAllIn 서비스 약관<a onclick="common.goParentContent('clause.do');">자세히보기</a></li>
			<li>개인정보 취급 방침<a onclick="common.goParentContent('personalInfo.do');">자세히보기</a></li>
		</div>
		-->
	</div>
	
	<div class="_keyarea" style="display:none;"></div>
	<footer class="footer_type fixed">
		<div class="_btnTitle block1" onclick="page.controller.saveSignup();">
			회원가입
		</div>
	</footer>
</div>

<div class="_profile" style="display:none;">${command.profile}</div>

</form>
<iframe name="hiddenFrame" style="display:none;"></iframe>
</body>
<script type="text/javascript" src="lib/header.js"></script>
<script type="text/javascript">
page.ready = function() {
	page.id = '/main/signup.jsp';
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
		pub.getDataItemUseList = function(masterCode,itemCode,callback) {
			$.ajax({
				type: 'post',
				url: 'getDataItemUseList.do',
				data: {masterCode:masterCode,itemCode:itemCode},
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
		pub.checkMemberDuplication = function(callback) {
			$.ajax({
				type: 'post',
				url: 'checkMemberDuplication.do',
				data: {infos:$('input[name="infos"]').val(), email:$('input[name="email"]').val()},
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
			
			page.view.initViewInfo();
			
			//page.controller.getArea1List();
			
			//page.controller.getPosition1List();
			//page.controller.getPosition2List();
			//page.controller.getPosition3List();
			page.view.complete();
			
			if(common.isMobile()) {
				/*
				$('._keyarea').css('height', parent.page.height*0.43);
				$('input[type="text"],input[type="password"],textarea').focus(function () { 
					page.controller.inputFocus(this); 
				});
				$('input[type="text"],input[type="password"],textarea').blur(function () { 
					page.controller.inputBlur(this); 
				});
				*/
			}
		};
		pub.complete = function() {
			page.plugin.getPhone();
			$('body').css('visibility', 'visible');
			if(parent.page.view.complete && page.initFlag) {
				parent.page.view.complete();
				page.initFlag = false;
			}
		};
		pub.clickPictureFile = function() {
			$('input[name="pictureFile"]').click();
			page.plugin.getImageUpload();
		};
		pub.changePictureFile = function(obj) {
			$('input[name="pictureFileStr"]').val(obj.value);
		};
		pub.initViewInfo = function() {
			var memberName = '${command.memberName}';
			if(memberName != '') {
				$('._memberNameY').show();
				$('._memberNameN').hide();
			}
			var email = '${command.email}';
			if(email != '') {
				$('._emailY').show();
				$('._emailN').hide();
				page.duplication = true;
			}
			
			var birthday = '${command.birthday}';
			if(birthday != '') {
				$('select[name="birthday1"]').val(birthday.split('-')[0]);
				$('select[name="birthday2"]').val(birthday.split('-')[1]);
				$('select[name="birthday3"]').val(birthday.split('-')[2]);
			}
			
			$('textarea[name="profile"]').val($('._profile').html());
			
			if($('input[name="infos"]').val() != '') {
				$('._signCheck').hide();
				$('._title').html('내 정보 수정');
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
				common.goParentContent('logo.do');
			} else {
				common.goParentContent('option.do');
			}
		};
		pub.inputFocus = function(obj) {
			$('._keyarea').show();
			$(window).scrollTop($(obj).offset().top-200)
		};
		pub.inputBlur = function(obj) {
			$('._keyarea').hide();
		};
		pub.getArea1List = function() {
			page.model.getDataItemUseList('시도', null, function(data) {
				var html = '\n<select name="area1" class="selectText" onchange="page.controller.changeArea1(this);">';
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
				var html = '\n<select name="area2" class="selectText">';
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
		
		pub.getPosition1List = function() {
			page.model.getDataItemUseList('포지션', null, function(data) {
				var position1 = '${command.position1}';
				var selected = '';
				var html = '\n<select name="position1" class="selectText">';
				html += '\n 		<option value="">1지망</option>';
				for(var i=0;i<data.result.length; i++) {
					for(var i=0;i<data.result.length; i++) {
						if(position1 == data.result[i].itemCode) {
							selected = 'selected';
						} else {
							selected = '';
						}
						html += '\n 		<option value="'+nvlString(data.result[i].itemCode)+'" '+selected+'>'+nvlString(data.result[i].itemName)+'</option>'; 
					}
				}
				html += '</select>\n';
				$('._position1').html(html);
			});
		};
		pub.getPosition2List = function() {
			page.model.getDataItemUseList('포지션', null, function(data) {
				var position2 = '${command.position2}';
				var selected = '';
				var html = '\n<select name="position2" class="selectText">';
				html += '\n 		<option value="">2지망</option>';
				for(var i=0;i<data.result.length; i++) {
					for(var i=0;i<data.result.length; i++) {
						if(position2 == data.result[i].itemCode) {
							selected = 'selected';
						} else {
							selected = '';
						}
						html += '\n 		<option value="'+nvlString(data.result[i].itemCode)+'" '+selected+'>'+nvlString(data.result[i].itemName)+'</option>'; 
					}
				}
				html += '</select>\n';
				$('._position2').html(html);
			});
		};
		pub.getPosition3List = function() {
			page.model.getDataItemUseList('포지션', null, function(data) {
				var position3 = '${command.position3}';
				var selected = '';
				var html = '\n<select name="position3" class="selectText">';
				html += '\n 		<option value="">3지망</option>';
				for(var i=0;i<data.result.length; i++) {
					for(var i=0;i<data.result.length; i++) {
						if(position3 == data.result[i].itemCode) {
							selected = 'selected';
						} else {
							selected = '';
						}
						html += '\n 		<option value="'+nvlString(data.result[i].itemCode)+'" '+selected+'>'+nvlString(data.result[i].itemName)+'</option>'; 
					}
				}
				html += '</select>\n';
				$('._position3').html(html);
			});
		};
		pub.changeMemberDuplication = function() {
			$("._duplication").html('중복확인');
			page.duplication = false;
		};
		pub.checkMemberDuplication = function() {
			if($('input[name="email"]').val() == '') {
				alert('아이디를 입력하세요.');		
				return false;
			}
			if($('input[name="email"]').val().indexOf('@') == -1) {
				alert('잘못된 아이디 형식입니다. \nEmail 형식으로 입력하세요. 예)abce@naver.com');		
				return false;
			}
				
			page.model.checkMemberDuplication(function(data) {
				if(nvlString(data.infos) == '') {
					$("._duplication").html('<font color="#1DDB16;">사용 가능</font>');
					page.duplication = true;
				} else {
					$("._duplication").html('<font color="#ff0000;">사용 불가능</font>');
					page.duplication = false;
				}
			});	
		};
		pub.saveSignup = function() {
			if($('input[name="email"]').val() == '') {
				alert('아이디를 입력하세요.');		
				return false;
			}
			if($('input[name="email"]').val().indexOf('@') == -1) {
				alert('잘못된 아이디 형식입니다. \nEmail 형식으로 입력하세요. 예)abce@naver.com');		
				return false;
			}
			if(!page.duplication) {
				alert('아이디 중복확인을 해주세요.');
				return false;
			}
			
			if($('input[name="infos"]').val() == '') {
				if($('input[name="password1"]').val() == '') {
					alert('비밀번호를 입력하세요.');		
					return false;
				}
				if($('input[name="password1"]').val() != $('input[name="password2"]').val()) {
					alert('비밀번호 확인을 해주세요.');
					return false;
				}
			} else {
				if($('input[name="password1"]').val() != '') {
					if($('input[name="password1"]').val() != $('input[name="password2"]').val()) {
						alert('비밀번호 확인을 해주세요.');
						return false;
					}
				}
			}
			
			if($('select[name="birthday1"]').val() == '' || $('select[name="birthday2"]').val() == '' || $('select[name="birthday2"]').val() == '') {
				alert('생년월일을 입력하세요.');		
				return false;
			} else {
				$('input[name="birthday"]').val($('select[name="birthday1"]').val()+"-"+$('select[name="birthday2"]').val()+"-"+$('select[name="birthday3"]').val())
			}
			
			var rgEx = /([016789])(\d{4}|\d{3})\d{4}$/g;  
			var chkPhone = rgEx.test($('input[name="phone"]').val());    
			if(!chkPhone) {
				 alert("잘못된 연락처입니다.\n- 를 제외한 숫자만 입력하세요.");
				 return;
			}
			
			if($('input[name="infos"]').val() == '') {
				if(!$('input[name=checkClause]').is(":checked")) {
					alert('서비스 약관에 동의하셔야 합니다.');		
					return false;
				}
				if(!$('input[name=checkPersonalInfo]').is(":checked")) {
					alert('개인정보 취급 방침에 동의하셔야 합니다.');		
					return false;
				}
			}
			
			if($('input[name="password1"]').val() != '') {
				//$('input[name="password"]').val(parent.rsa.encrypt($('input[name="password1"]').val()));	
				$('input[name="password"]').val($('input[name="password1"]').val());
			}
			
			if(page.clickFlag) {
				page.clickFlag = false;
				if(confirm('저장하겠습니까?')) {
					common.loading(true);
					var form = document.clubForm;
					form.action = 'saveSignup.do';
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
				parent.page.toast.show('warning','중복된 이메일입니다.');
				page.clickFlag = true;
			} else {
				
				if(page.mobileFlag) {
					page.plugin.saveMobile(infos);
				} else {
					common.loading(false);
					parent.page.toast.show('success','저장에 성공하였습니다.');
					if($('input[name="infos"]').val() == '') {
						common.goParentContent('myClub.do');
						//common.goParentContent('myTeam.do');
					} else {
						common.goParentContent('option.do');
					}
					page.clickFlag = true;
				}
			}
			
		};
		pub.saveFail = function(infos) {
			common.loading(false);
			parent.page.toast.show('warning','저장에 실패하였습니다.');
			page.clickFlag = true;
		};
		pub.saveMobileSuccess = function() {
			common.loading(false);
			parent.page.toast.show('success','저장에 성공하였습니다.');
			if($('input[name="infos"]').val() == '') {
				common.goParentContent('appIntro.do');
			} else {
				common.goParentContent('option.do');
			}
			page.clickFlag = true;
		};
		pub.saveMobileFail = function() {
			common.loading(false);
			parent.page.toast.show('warning','저장에 실패하였습니다.');
			page.clickFlag = true;
		};
		
		pub.closePersonalInfo = function(flag) {
			if(flag) {
				$('._personalInfo1').css('display','');
				$('._personalInfo2').css('display','');
				$('._personalInfo3').css('display','');
			} else {
				$('._personalInfo1').css('display','none');
				$('._personalInfo2').css('display','none');
				$('._personalInfo3').css('display','none');
			}
		};
		pub.closeClause = function(flag) {
			if(flag) {
				$('._clause1').css('display','');
				$('._clause2').css('display','');
				$('._clause3').css('display','');
			} else {
				$('._clause1').css('display','none');
				$('._clause2').css('display','none');
				$('._clause3').css('display','none');
			}
		};
		pub.checkAll = function() {
			var checkAll = $('input[name=checkAll]').is(":checked");
			$('input[name=checkClause]').prop('checked', checkAll) ;
			$('input[name=checkPersonalInfo]').prop('checked', checkAll) ;
		};
		return pub;
	}());
	
	page.plugin = (function() {
		var pub = {};
		pub.getPhone = function() {
			if(window.android && window.android.setMessage) {
				window.android.setMessage('plugin:signup:getphone');
			} else if(parent.page.ios || parent.page.apple) {
				location.href = 'plugin:signup:getphone';
			}
		};
		pub.setPhone = function(phone) {
			if(phone.startsWith("82")) {
				phone = "0"+phone.substring(2);
			}
			$('input[name="phone"]').val(phone);
			$('input[name="phone"]').attr("readonly",true);
		};
		pub.getImageUpload = function() {
			if(window.android && window.android.setMessage) {
				window.android.setMessage('plugin:image:signup');
			} else if(parent.page.ios || parent.page.apple) {
				location.href = 'plugin:image:signup';
			}
			$('input[name="pictureFileStr"]').val("");
		};
		pub.setImageUploadStr = function(uploadType, imgStr) {
			$('input[name="pictureFileStr"]').val(imgStr);
			page.mobileFlag = true;
		};
		pub.saveMobile = function(infos) {
			if($('input[name="pictureFileStr"]').val() != null) {
				if(window.android && window.android.setMessage) {
					window.android.setMessage('plugin:saveimage:signup:'+infos);
				} else if(parent.page.ios || parent.page.apple) {
					location.href = 'plugin:saveimage:signup:'+infos;
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