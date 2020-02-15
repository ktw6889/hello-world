package com.ktw.nolja.club.controller;

import java.io.File;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ktw.nolja.club.service.NoljaClubService;
import com.ktw.nolja.club.service.NoljaMainService;
import com.ktw.nolja.club.vo.NoljaClubBoardVO;
import com.ktw.nolja.club.vo.NoljaClubInfoVO;
import com.ktw.nolja.club.vo.NoljaClubMessageVO;
import com.ktw.nolja.club.vo.NoljaMemberInfoVO;
import com.ktw.nolja.club.vo.NoljaVO;
import com.ktw.nolja.common.constant.CommonConstant;
import com.ktw.nolja.common.service.CommonService;
import com.ktw.nolja.common.util.CommonInfo;
import com.ktw.nolja.common.util.CommonUtil;
import com.ktw.nolja.common.vo.MemberInfoVO;
import com.ktw.nolja.common.vo.ResultVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Controller
public class NoljaClubController {
	public Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private NoljaMainService mainService;
	
	@Autowired
	private NoljaClubService clubService;
	
	 
	/*
	 * 팀등록 화면으로 이동 합니다===2222
	 */
	@RequestMapping("/clubReg.do")
	public ModelAndView teamReg(HttpServletRequest request, HttpServletResponse response, NoljaVO noljaVO) {
		logger.info("start3333333");
		     
		NoljaClubInfoVO clubInfoVO = new NoljaClubInfoVO();
		if(!"NEW".equals(noljaVO.getInfos())) {
			clubInfoVO = (NoljaClubInfoVO)CommonUtil.getClubInfoVO(request);
			try {
				if(clubInfoVO != null) {
					clubInfoVO = clubService.selectClubInfoDetail(clubInfoVO.getClubInfos());
				}
			} catch(Exception e) {
				logger.error(e.getMessage(), e);
			}
		}
		return new ModelAndView("club/clubReg", "command", clubInfoVO);
	}
	
	/*
	 * 팀중복체크
	 */
	@RequestMapping("/checkClubDuplication.do")
	@ResponseBody
	public ResultVO checkTeamDuplication(HttpServletRequest request, HttpServletResponse response, NoljaClubInfoVO clubInfoVO) {
		logger.info("start");
		
		ResultVO resultVO = new ResultVO();
		try {
			resultVO.setInfos(clubService.checkClubInfo(clubInfoVO.getInfos(), clubInfoVO.getClubName()));
			resultVO.setStatus(CommonConstant.SUCCESS);
		} catch(Exception e) {
			resultVO.setStatus(CommonConstant.ERROR);
			logger.error(e.getMessage(), e);
		}
		return resultVO;
	}
	
	/*
	 * 팀정보 저장
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/saveClubInfo.do")
	public String saveTeamInfo(HttpServletRequest request, HttpServletResponse response, NoljaVO noljaVO) {
		logger.info("start");
		
		try {
			MultipartRequest multi = new MultipartRequest(request, CommonInfo.getInstance().getUploadPath(), CommonInfo.getInstance().getUploadMaxSize(), CommonInfo.getInstance().getUploadEncoding(), new DefaultFileRenamePolicy());

			String infos = "";
			NoljaClubInfoVO clubInfoVO = new NoljaClubInfoVO();
			MemberInfoVO memberVO = CommonUtil.getMemberInfoVO(request);
			clubInfoVO.setCreateInfos(memberVO.getInfos());
			clubInfoVO.setModifyInfos(memberVO.getInfos());

			Enumeration<String> enumer = multi.getParameterNames();
		    while(enumer.hasMoreElements()) {
		        String key = enumer.nextElement();
		        String value = multi.getParameter(key);

		        if("infos".equals(key)) {
		        	clubInfoVO.setInfos(value);
		        	infos = value;
		        } else if("clubName".equals(key)) {
		        	clubInfoVO.setClubName(value);
		        } else if("area1".equals(key)) {
		        	clubInfoVO.setArea1(value);
		        } else if("area2".equals(key)) {
		        	clubInfoVO.setArea2(value);
		        } else if("clubType".equals(key)) {
		        	clubInfoVO.setClubType(value);
		        } else if("latPosition".equals(key)) {
		        	clubInfoVO.setLatPosition(value);
		        } else if("lngPosition".equals(key)) {
		        	clubInfoVO.setLngPosition(value);
		        } else if("intro".equals(key)) {
		        	clubInfoVO.setIntro(value);
		        } else if("fee".equals(key)) {
		        	clubInfoVO.setFee(value);
		        }
		    }
		    
		    if(CommonUtil.isNullString(infos)) {
		    	infos = commonService.getInfos();
		    }
		    
		    Enumeration<String> files = multi.getFileNames();
		    while(files.hasMoreElements()){
		    	String name = (String)files.nextElement();
		    	String filename = multi.getFilesystemName(name);
		    	if(CommonUtil.isNotNullString(filename)) {
					String orgFileName = CommonInfo.getInstance().getUploadPath()+CommonConstant.FILE_SEPARATOR+filename;
					
					File dir = new File(CommonInfo.getInstance().getUploadPath()+CommonConstant.FILE_SEPARATOR+infos);
					if(!dir.isDirectory()) {
						dir.mkdir();
					}
			    	if("symbolFile".equals(name)) {
			    		File bfile = new File(orgFileName);
			    		String aFileName = infos+CommonConstant.FILE_SEPARATOR+commonService.getInfos()+"_1"+filename.substring(filename.lastIndexOf("."));
			    		File afile = new File(CommonInfo.getInstance().getUploadPath()+CommonConstant.FILE_SEPARATOR+aFileName);
			    		if(afile.isFile()) {
			    			afile.delete();
						}
			    		bfile.renameTo(afile);
			    		clubInfoVO.setSymbol(aFileName);
			        } else if("introImage".equals(name)) {
			    		File bfile = new File(orgFileName);
			    		String aFileName = infos+CommonConstant.FILE_SEPARATOR+commonService.getInfos()+"_1"+filename.substring(filename.lastIndexOf("."));
			    		File afile = new File(CommonInfo.getInstance().getUploadPath()+CommonConstant.FILE_SEPARATOR+aFileName);
			    		if(afile.isFile()) {
			    			afile.delete();
						}
			    		bfile.renameTo(afile);
			    		clubInfoVO.setIntroImage(aFileName);
			        }
		    	}
		    }
		    
		    if(CommonUtil.isNullString(clubInfoVO.getInfos())) {
		    	clubInfoVO.setInfos(infos);
		    	clubInfoVO.setMemberAuth("회장");
				infos = clubService.insertClubInfo(clubInfoVO);
			} else {
				infos = clubService.updateClubInfo(clubInfoVO);
			}
		    
			if(CommonUtil.isNotNullString(infos)) {
				//mainService.insertSysLog(memberVO.getInfos(), infos, null, request.getRequestURI());
				
				request.setAttribute("FLAG", "SAVESUCCESS");
				request.setAttribute("INFOS", infos);
			} else {
				request.setAttribute("FLAG", "SAVEFAIL");
			}
		} catch(Exception e) {
			logger.error(e.getMessage(), e);
		}
		return "common/commonSave";
	}
	
	/*
	 * 팀 정보 조회
	 */
	@RequestMapping("/clubInfo.do")
	public ModelAndView teamInfo(HttpServletRequest request, HttpServletResponse response, NoljaClubInfoVO clubInfoVO) {
		logger.info("start");
		String viewName = "clubInfoView";
		String direct = clubInfoVO.getDirect();
		try {
			CommonInfo.getInstance().setClubService(clubService);
			MemberInfoVO memberInfoVO = CommonUtil.getMemberInfoVO(request);
			if(CommonUtil.isNotNullString(clubInfoVO.getClubInfos())) {
				clubInfoVO = clubService.selectClubInfo(memberInfoVO.getInfos(), clubInfoVO.getClubInfos());
				CommonUtil.setClubInfoVO(request, clubInfoVO);
				if(CommonUtil.isNotNullString(clubInfoVO.getMemberAuth()) && !"요청".equals(clubInfoVO.getMemberAuth())) {
					if(clubInfoVO != null && CommonUtil.isNotNullString(clubInfoVO.getClubInfos())) {
						memberInfoVO.setClubInfos(clubInfoVO.getClubInfos());
						CommonUtil.setMemberInfoVO(request, memberInfoVO);
						mainService.updateMemberInfoClubInfos(memberInfoVO.getInfos(), clubInfoVO.getClubInfos());
						//mainService.insertSysLog(memberInfoVO.getInfos(), clubInfoVO.getClubInfos(), null, request.getRequestURI());
						viewName = "clubInfo";
					}
				}
			} else {
				clubInfoVO = (NoljaClubInfoVO)CommonUtil.getClubInfoVO(request);
				clubInfoVO = clubService.selectClubInfo(memberInfoVO.getInfos(), clubInfoVO.getClubInfos());
				if(CommonUtil.isNotNullString(clubInfoVO.getMemberAuth()) && !"요청".equals(clubInfoVO.getMemberAuth())) {
					if(clubInfoVO != null && CommonUtil.isNotNullString(clubInfoVO.getClubInfos())) {
						viewName = "clubInfo";
					}
				}
			}
			
			if(CommonUtil.isNotNullString(direct)) {
				String[] directSp = direct.split("[|]");
				if("Talk".equals(directSp[0])) {
					response.sendRedirect("clubTalk.do");
					return null;
				} else if("Notice".equals(directSp[0])) {
					response.sendRedirect("clubNoticeList.do");
					return null;
				} else if("Schedule".equals(directSp[0])) {
					response.sendRedirect("teamGameSchedule.do");
					return null;
				} else if("Member".equals(directSp[0])) {
					response.sendRedirect("clubMemberList.do");
					return null;
				} else if("Support".equals(directSp[0])) {
					response.sendRedirect("teamSupportList.do");
					return null;
				} else if("Game".equals(directSp[0])) {
					response.sendRedirect("gameView.do?infos="+directSp[1]);
					return null;
				}
			}
			
		} catch(Exception e) {
			logger.error(e.getMessage(), e);
		}
		
		return new ModelAndView("club/"+viewName, "command", clubInfoVO);
	}
	
	/*
	 * 팀공지리스트
	 */
	@RequestMapping("/clubNoticeList.do")
	public ModelAndView teamNoticeList(HttpServletRequest request, HttpServletResponse response, NoljaVO noljaVO) {
		logger.info("start");
		
		NoljaClubInfoVO clubInfoVO = (NoljaClubInfoVO)CommonUtil.getClubInfoVO(request);
		noljaVO.setClubInfos(clubInfoVO.getInfos());
		noljaVO.setClubName(clubInfoVO.getClubName());
		noljaVO.setSymbol(clubInfoVO.getSymbol());
		
		return new ModelAndView("club/clubNoticeList", "command", noljaVO);
	}
	
	/*
	 * 팀 가입 요청
	 */
	@RequestMapping("/joinClubInfo.do")
	@ResponseBody
	public ResultVO joinTeamInfo(HttpServletRequest request, HttpServletResponse response, NoljaClubInfoVO clubInfoVO) {
		logger.info("start");

		ResultVO resultVO = new ResultVO();
		try {
			MemberInfoVO memberInfoVO = CommonUtil.getMemberInfoVO(request);
			clubInfoVO.setCreateInfos(memberInfoVO.getInfos());
			clubInfoVO.setModifyInfos(memberInfoVO.getInfos());
			clubInfoVO.setMemberAuth("요청");
			String infos = clubService.insertClubMemberLink(clubInfoVO);
			
			//clubService.insertClubMessage("NOTICE", memberInfoVO.getMemberName()+" 님이 맴버를 등록요청되었습니다.", clubInfoVO.getClubInfos(), memberInfoVO.getInfos(), memberInfoVO.getInfos());
			
			/*
			// Push 전송
	    	NoljaClubInfoVO pushTeamInfoVO = (NoljaClubInfoVO)CommonUtil.getClubInfoVO(request);
	    	if(pushTeamInfoVO != null && memberInfoVO != null && clubInfoVO != null) {
	    		pushMessageService.sendJoinMember(memberInfoVO.getMemberName(), pushTeamInfoVO.getClubName(), memberInfoVO.getInfos(), clubInfoVO.getClubInfos(), pushTeamInfoVO.getSymbol());
	    	}
	    	*/
			
			resultVO.setInfos(infos);
			resultVO.setStatus(CommonConstant.SUCCESS);
		} catch(Exception e) {
			resultVO.setStatus(CommonConstant.ERROR);
			logger.error(e.getMessage(), e);
		}
		return resultVO;
	}
	
	/*
	 * 팀 옵션
	 */
	@RequestMapping("/clubOption.do")
	public ModelAndView teamOption(HttpServletRequest request, HttpServletResponse response, NoljaVO noljaVO) {
		logger.info("start");
		
		NoljaClubInfoVO clubInfoVO = (NoljaClubInfoVO)CommonUtil.getClubInfoVO(request);
		noljaVO.setClubInfos(clubInfoVO.getInfos());
		noljaVO.setClubName(clubInfoVO.getClubName());
		noljaVO.setSymbol(clubInfoVO.getSymbol());
		
		return new ModelAndView("club/clubOption", "command", noljaVO);
	}
	
	/*
	 * 팀 멤버관리 화면으로 리스트
	 */
	@RequestMapping("/clubMemberList.do")
	public ModelAndView teamMemberList(HttpServletRequest request, HttpServletResponse response, NoljaVO noljaVO) {
		logger.info("start");
		
		NoljaClubInfoVO clubInfoVO = (NoljaClubInfoVO)CommonUtil.getClubInfoVO(request);
		noljaVO.setClubInfos(clubInfoVO.getInfos());
		noljaVO.setClubName(clubInfoVO.getClubName());
		noljaVO.setSymbol(clubInfoVO.getSymbol());
		
		MemberInfoVO memberInfoVO = CommonUtil.getMemberInfoVO(request);
		noljaVO.setMemberInfos(memberInfoVO.getInfos());
		noljaVO.setMemberAuth(clubInfoVO.getMemberAuth());
		
		return new ModelAndView("club/clubMemberList", "command", noljaVO);
	}
	
	/*
	 * 팀 멤버 리스트
	 */
	@RequestMapping("/getClubMemberList.do")
	@ResponseBody
	public ResultVO getTeamMemberList(HttpServletRequest request, HttpServletResponse response, NoljaVO noljaVO) {
		logger.info("start");

		ResultVO resultVO = new ResultVO();
		try {
			MemberInfoVO memberInfoVO = CommonUtil.getMemberInfoVO(request);
			noljaVO.setClubInfos(memberInfoVO.getClubInfos());
			List<NoljaMemberInfoVO> list = clubService.selectClubMemberList(noljaVO);
			if(list != null && list.size() > 0) {
			//	clubService.updateClubMemberBadgeRead(list, memberInfoVO.getClubInfos(), memberInfoVO.getInfos());
			}
			resultVO.setResult(list);
			resultVO.setStatus(CommonConstant.SUCCESS);
		} catch(Exception e) {
			resultVO.setStatus(CommonConstant.ERROR);
			logger.error(e.getMessage(), e);
		}
		return resultVO;
	}
	
	/*
	 * 팀 회원 승낙
	 */
	@RequestMapping("/acceptClubMember.do")
	@ResponseBody
	public ResultVO acceptClubMember(HttpServletRequest request, HttpServletResponse response, NoljaMemberInfoVO memberInfoVO) {
		logger.info("start");

		ResultVO resultVO = new ResultVO();
		try {
			MemberInfoVO memberVO = CommonUtil.getMemberInfoVO(request);
			memberInfoVO.setCreateInfos(memberVO.getInfos());
			memberInfoVO.setModifyInfos(memberVO.getInfos());
			memberInfoVO.setClubInfos(memberVO.getClubInfos());
			memberInfoVO.setMemberAuth("회원");
			clubService.updateClubMemberLink(memberInfoVO);
			
			//clubService.insertClubMessage("NOTICE", memberInfoVO.getMemberName()+" 님이 팀원 가입되었습니다.", memberVO.getClubInfos(), memberInfoVO.getInfos(), memberVO.getInfos());
			
			/*
			// Push 전송
	    	NoljaClubInfoVO pushTeamInfoVO = (NoljaClubInfoVO)CommonUtil.getClubInfoVO(request);
	    	if(pushTeamInfoVO != null && memberInfoVO != null && memberVO != null) {
	    		pushMessageService.sendJoinMemberAccept(memberInfoVO.getMemberName(), pushTeamInfoVO.getClubName(), memberInfoVO.getInfos(), memberVO.getClubInfos(), pushTeamInfoVO.getSymbol());
	    	}
			*/
			resultVO.setInfos(memberInfoVO.getInfos());
			resultVO.setStatus(CommonConstant.SUCCESS);
		} catch(Exception e) {
			resultVO.setStatus(CommonConstant.ERROR);
			logger.error(e.getMessage(), e);
		}
		return resultVO;
	}
	
	/*
	 * 팀 회원 권한 변경
	 */
	@RequestMapping("/changeMemberAuth.do")
	@ResponseBody
	public ResultVO changeMemberAuth(HttpServletRequest request, HttpServletResponse response, NoljaMemberInfoVO memberInfoVO) {
		logger.info("start");

		ResultVO resultVO = new ResultVO();
		try {
			MemberInfoVO memberVO = CommonUtil.getMemberInfoVO(request);
			memberInfoVO.setModifyInfos(memberVO.getInfos());
			memberInfoVO.setClubInfos(memberVO.getClubInfos());
			clubService.updateClubMemberLink(memberInfoVO);
			
			resultVO.setInfos(memberInfoVO.getInfos());
			resultVO.setStatus(CommonConstant.SUCCESS);
		} catch(Exception e) {
			resultVO.setStatus(CommonConstant.ERROR);
			logger.error(e.getMessage(), e);
		}
		return resultVO;
	}
	
	/*
	 * 팀 게시 리스트
	 */
	@RequestMapping("/getClubBoardList.do")
	@ResponseBody
	public ResultVO getClubBoardList(HttpServletRequest request, HttpServletResponse response, NoljaVO noljaVO) {
		logger.info("start");

		ResultVO resultVO = new ResultVO();
		try {
			MemberInfoVO memberInfoVO = CommonUtil.getMemberInfoVO(request);
			noljaVO.setClubInfos(memberInfoVO.getClubInfos());
			List<NoljaClubBoardVO> list = clubService.selectClubBoardList(noljaVO);
			if(list.size() == 0 && noljaVO.getCurrPageNum() != 1) {
				noljaVO.setCurrPageNum(1);
				list = clubService.selectClubBoardList(noljaVO);
			}
			if(list != null && list.size() > 0) {
				//clubService.updateTeamBoardBadgeRead(list, memberInfoVO.getInfos());
			}
			resultVO.setTotalRecord(clubService.countClubBoardList(noljaVO));
			resultVO.setResult(list);
			resultVO.setStatus(CommonConstant.SUCCESS);
		} catch(Exception e) {
			resultVO.setStatus(CommonConstant.ERROR);
			logger.error(e.getMessage(), e);
		}
		return resultVO;
	}
	
	/*
	 * 팀 게시 등록화면으로 이동
	 */
	@RequestMapping("/clubNoticeReg.do")
	public ModelAndView clubNoticeReg(HttpServletRequest request, HttpServletResponse response, NoljaVO noljaVO) {
		logger.info("start");
		
		NoljaClubInfoVO clubInfoVO = (NoljaClubInfoVO)CommonUtil.getClubInfoVO(request);
		noljaVO.setClubInfos(clubInfoVO.getInfos());
		noljaVO.setClubName(clubInfoVO.getClubName());
		noljaVO.setSymbol(clubInfoVO.getSymbol());
		
		return new ModelAndView("club/clubNoticeReg", "command", noljaVO);
	}
	
	/*
	 * 팀 게시 조회화면으로 이동
	 */
	@RequestMapping("/clubNoticeView.do")
	public ModelAndView clubNoticeView(HttpServletRequest request, HttpServletResponse response, NoljaVO noljaVO) {
		logger.info("start");
		
		NoljaClubBoardVO clubBoardVO = null;
		try {
			clubBoardVO = clubService.selectClubBoard(noljaVO.getInfos());
		} catch(Exception e) {
			logger.error(e.getMessage(), e);
		}
		return new ModelAndView("club/clubNoticeView", "command", clubBoardVO);
	}
	
	/*
	 * 팀 게시 저장
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/saveClubNotice.do")
	public String saveClubNotice(HttpServletRequest request, HttpServletResponse response) {
		logger.info("start");
		
		try {
			MultipartRequest multi = new MultipartRequest(request, CommonInfo.getInstance().getUploadPath(), CommonInfo.getInstance().getUploadMaxSize(), CommonInfo.getInstance().getUploadEncoding(), new DefaultFileRenamePolicy());

			String infos = "";
			NoljaClubBoardVO clubBoardVO = new NoljaClubBoardVO();
			
			MemberInfoVO memberVO = CommonUtil.getMemberInfoVO(request);
			clubBoardVO.setCreateInfos(memberVO.getInfos());
			clubBoardVO.setModifyInfos(memberVO.getInfos());
			clubBoardVO.setBoardType("게시");
			Enumeration<String> enumer = multi.getParameterNames();
		    while(enumer.hasMoreElements()) {
		        String key = enumer.nextElement();
		        String value = multi.getParameter(key);

		        if("infos".equals(key)) {
		        	clubBoardVO.setInfos(value);
		        	infos = value;
		        } else if("clubInfos".equals(key)) {
		        	clubBoardVO.setClubInfos(value);
		        } else if("noticeType".equals(key)) {
		        	clubBoardVO.setNoticeType(value);
		        } else if("content".equals(key)) {
		        	clubBoardVO.setContent(value);
		        }
		    }
		    
		    if(CommonUtil.isNullString(infos)) {
		    	infos = commonService.getInfos();
		    }
		    
		    Enumeration<String> files = multi.getFileNames();
		    while(files.hasMoreElements()){
		    	String name = (String)files.nextElement();
		    	String filename = multi.getFilesystemName(name);
		    	if(CommonUtil.isNotNullString(filename)) {
					String orgFileName = CommonInfo.getInstance().getUploadPath()+CommonConstant.FILE_SEPARATOR+filename;
					
					File dir = new File(CommonInfo.getInstance().getUploadPath()+CommonConstant.FILE_SEPARATOR+infos);
					if(!dir.isDirectory()) {
						dir.mkdir();
					}
					
			    	if("attachPicture".equals(name)) {
			    		File bfile = new File(orgFileName);
			    		String aFileName = infos+CommonConstant.FILE_SEPARATOR+commonService.getInfos()+"_1"+filename.substring(filename.lastIndexOf("."));
			    		File afile = new File(CommonInfo.getInstance().getUploadPath()+CommonConstant.FILE_SEPARATOR+aFileName);
			    		if(afile.isFile()) {
			    			afile.delete();
						}
			    		bfile.renameTo(afile);
			    		clubBoardVO.setAttachPicture(aFileName);
			        }
		    	}
		    }
		    
		    if(CommonUtil.isNullString(clubBoardVO.getInfos())) {
		    	clubBoardVO.setInfos(infos);
		    	infos = clubService.insertClubBoard(clubBoardVO);
		    	//clubService.insertTeamBoardBadge(infos, clubBoardVO.getClubInfos());
		    	// Push 전송
		    	NoljaClubInfoVO clubInfoVO = (NoljaClubInfoVO)CommonUtil.getClubInfoVO(request);
		    	if(memberVO != null && clubInfoVO != null && clubBoardVO != null) {
		    		//pushMessageService.sendTeamNotice(memberVO.getMemberName(), clubInfoVO.getTeamName(), memberVO.getInfos(), teamBoardVO.getClubInfos(), clubInfoVO.getSymbol());
		    	}
			} else {
				infos = clubService.updateClubBoard(clubBoardVO);
				//clubService.insertTeamBoardBadge(infos, clubBoardVO.getClubInfos());
				//clubService.updateTeamBoardBadge(infos);
			}
		    
			if(CommonUtil.isNotNullString(infos)) {
				request.setAttribute("FLAG", "SAVESUCCESS");
				request.setAttribute("INFOS", infos);
			} else {
				request.setAttribute("FLAG", "SAVEFAIL");
			}
		} catch(Exception e) {
			logger.error(e.getMessage(), e);
		}
		return "common/commonSave";
	}
	
	/*
	 * 팀 톡 화면으로 이동
	 */
	@RequestMapping("/clubTalk.do")
	public ModelAndView clubTalk(HttpServletRequest request, HttpServletResponse response, NoljaVO noljaVO) {
		logger.info("start");
		
		NoljaClubInfoVO clubInfoVO = (NoljaClubInfoVO)CommonUtil.getClubInfoVO(request);
		noljaVO.setClubInfos(clubInfoVO.getInfos());
		noljaVO.setClubName(clubInfoVO.getClubName());
		noljaVO.setSymbol(clubInfoVO.getSymbol());
		
		return new ModelAndView("club/clubTalk", "command", noljaVO);
	}
	
	/*
	 * 팀 톡 리스트
	 */
	@RequestMapping("/getClubTalkList.do")
	@ResponseBody
	public ResultVO getClubTalkList(HttpServletRequest request, HttpServletResponse response, NoljaVO noljaVO) {
		logger.info("start");

		ResultVO resultVO = new ResultVO();
		try {
			MemberInfoVO memberInfoVO = CommonUtil.getMemberInfoVO(request);
			noljaVO.setMemberInfos(memberInfoVO.getInfos());
			noljaVO.setClubInfos(memberInfoVO.getClubInfos());
			List<NoljaClubMessageVO> list = clubService.selectClubMessageList(noljaVO);
			if(list.size() == 0 && noljaVO.getCurrPageNum() != 1) {
				noljaVO.setCurrPageNum(1);
				list = clubService.selectClubMessageList(noljaVO);
			}
			if(list != null && list.size() > 0) {
				// clubService.updateClubMessageBadgeRead(list, memberInfoVO.getInfos());
			}
			resultVO.setTotalRecord(clubService.countClubMessageList(noljaVO));
			resultVO.setResult(list);
			resultVO.setStatus(CommonConstant.SUCCESS);
		} catch(Exception e) {
			resultVO.setStatus(CommonConstant.ERROR);
			logger.error(e.getMessage(), e);
		}
		return resultVO;
	}
	
	/*
	 * 팀 톡 리스트 최신갱신
	 */
	@RequestMapping("/getClubTalkListEnd.do")
	@ResponseBody
	public ResultVO getTeamTalkListEnd(HttpServletRequest request, HttpServletResponse response, NoljaVO noljaVO) {
		logger.info("start");

		ResultVO resultVO = new ResultVO();
		try {
			MemberInfoVO memberInfoVO = CommonUtil.getMemberInfoVO(request);
			noljaVO.setMemberInfos(memberInfoVO.getInfos());
			noljaVO.setClubInfos(memberInfoVO.getClubInfos());
			List<NoljaClubMessageVO> list = clubService.selectClubMessageListEnd(noljaVO);
			if(list != null && list.size() > 0) {
			//	clubService.updateClubMessageBadgeRead(list, memberInfoVO.getInfos());
			}
			resultVO.setResult(list);
			resultVO.setStatus(CommonConstant.SUCCESS);
		} catch(Exception e) {
			resultVO.setStatus(CommonConstant.ERROR);
			logger.error(e.getMessage(), e);
		}
		return resultVO;
	}
	
	/*
	 * 팀 톡 저장
	 */
	@RequestMapping("/saveClubTalk.do")
	@ResponseBody
	public ResultVO saveTeamTalk(HttpServletRequest request, HttpServletResponse response, NoljaClubMessageVO teamMessageVO) {
		logger.info("start");
		
		ResultVO resultVO = new ResultVO();
		try {
			MemberInfoVO memberVO = CommonUtil.getMemberInfoVO(request);
			teamMessageVO.setCreateInfos(memberVO.getInfos());
			teamMessageVO.setClubInfos(memberVO.getClubInfos());
			teamMessageVO.setMemberInfos(memberVO.getInfos());
			teamMessageVO.setMessageType("TALK");
			
			String infos = clubService.insertClubMessage(teamMessageVO);
			if(infos != null) {
				// Push 전송
		    	NoljaClubInfoVO clubInfoVO = (NoljaClubInfoVO)CommonUtil.getClubInfoVO(request);
		    	if(memberVO != null && clubInfoVO != null) {
		    	//	pushMessageService.sendTeamTalk(memberVO.getMemberName(), clubInfoVO.getTeamName(), memberVO.getInfos(), clubInfoVO.getClubInfos(), clubInfoVO.getSymbol());
		    	}
		    	
				resultVO.setInfos(infos);
				resultVO.setStatus(CommonConstant.SUCCESS);	
			} else {
				resultVO.setStatus(CommonConstant.FAIL);
			}
		} catch(Exception e) {
			resultVO.setStatus(CommonConstant.ERROR);
			logger.error(e.getMessage(), e);
		}
		return resultVO;
	}
	
	
}