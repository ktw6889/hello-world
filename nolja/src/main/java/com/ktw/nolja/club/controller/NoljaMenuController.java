package com.ktw.nolja.club.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ktw.nolja.club.service.NoljaMenuService;
import com.ktw.nolja.club.vo.NoljaClubInfoVO;
import com.ktw.nolja.club.vo.NoljaVO;
import com.ktw.nolja.common.constant.CommonConstant;
import com.ktw.nolja.common.util.CommonInfo;
import com.ktw.nolja.common.util.CommonUtil;
import com.ktw.nolja.common.vo.MemberInfoVO;
import com.ktw.nolja.common.vo.ResultVO;

@Controller
public class NoljaMenuController {

public Logger logger = Logger.getLogger(this.getClass());
	

	@Autowired
	private NoljaMenuService menuService;

	

	/*
	 * 메뉴 화면으로 이동
	 */
	@RequestMapping("/menu.do")
	public ModelAndView menu(HttpServletRequest request, HttpServletResponse response, NoljaVO clubVO) {
		logger.info("start");
		
		return new ModelAndView("menu/menu", "command", clubVO);
	}
	
	
	/*
	 * 옵션 화면으로 이동
	 */
	@RequestMapping("/option.do")
	public ModelAndView option(HttpServletRequest request, HttpServletResponse response, NoljaVO clubVO) {
		logger.info("start");
		
		MemberInfoVO memberVO = CommonUtil.getMemberInfoVO(request);
		clubVO.setInfos(memberVO.getInfos());
		clubVO.setVersionNo(CommonInfo.getInstance().getVersionNo());
		clubVO.setVersionDate(CommonInfo.getInstance().getVersionDate());
		clubVO.setPushFlag(memberVO.getPushFlag());
		return new ModelAndView("menu/option", "command", clubVO);
	}
	
	/*
	 * 나의 팀 화면으로 이동
	 */
	@RequestMapping("/myClub.do")
	public ModelAndView myClub(HttpServletRequest request, HttpServletResponse response, NoljaVO clubVO) {
		logger.info("start");
		
		return new ModelAndView("menu/myClub", "command", clubVO);
	}
	
	/*
	 * 팀 검색 화면으로 이동
	 */
	@RequestMapping("/clubSearch.do")
	public ModelAndView teamSearch(HttpServletRequest request, HttpServletResponse response, NoljaVO clubVO) {
		logger.info("start");
		
		return new ModelAndView("menu/clubSearch", "command", clubVO);
	}
	

	/*
	 * 나의 팀 리스트
	 */
	@RequestMapping("/getMyClubInfoList.do")
	@ResponseBody
	public ResultVO getMyClubInfoList(HttpServletRequest request, HttpServletResponse response, NoljaVO clubVO) {
		logger.info("start");

		ResultVO resultVO = new ResultVO();
		try {
			MemberInfoVO memberVO = CommonUtil.getMemberInfoVO(request);
			clubVO.setMemberInfos(memberVO.getInfos());
			
			List<NoljaClubInfoVO> list = menuService.selectMyClubInfoList(clubVO);
			resultVO.setResult(list);
			resultVO.setStatus(CommonConstant.SUCCESS);
		} catch(Exception e) {
			resultVO.setStatus(CommonConstant.ERROR);
			logger.error(e.getMessage(), e);
		}
		return resultVO;
	}

	/*
	 * 팀 검색
	 */
	@RequestMapping("/searchClubInfoList.do")
	@ResponseBody
	public ResultVO searchClubInfoList(HttpServletRequest request, HttpServletResponse response, NoljaVO clubVO) {
		logger.info("start");

		ResultVO resultVO = new ResultVO();
		try {
			MemberInfoVO memberVO = CommonUtil.getMemberInfoVO(request);
			clubVO.setMemberInfos(memberVO.getInfos());
			clubVO.setMemberArea1(memberVO.getArea1());
			clubVO.setMemberArea2(memberVO.getArea2());
			
			List<NoljaClubInfoVO> list = menuService.searchClubInfoList(clubVO);
			//resultVO.setTotalRecord(menuService.countSearchClubInfoList(clubVO));
			resultVO.setResult(list);
			resultVO.setStatus(CommonConstant.SUCCESS);
		} catch(Exception e) {
			resultVO.setStatus(CommonConstant.ERROR);
			logger.error(e.getMessage(), e);
		}
		return resultVO;
	}
}
