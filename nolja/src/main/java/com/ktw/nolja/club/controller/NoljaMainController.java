package com.ktw.nolja.club.controller;

import java.io.File;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ktw.nolja.club.service.NoljaMainService;
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
public class NoljaMainController {
	public Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private NoljaMainService mainService;
	
	@RequestMapping("/main")
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response, NoljaVO clubVO) {
		logger.info("start~~~~");
		System.out.println("main~~~~");
		return new ModelAndView("main/main", "command", clubVO);
	}
	
	/*
	 * logo 화면으로 이동
	 */
	@RequestMapping("/logo")
	public ModelAndView logo(HttpServletRequest request, HttpServletResponse response,  NoljaVO clubVO) {
		logger.info("start");
		System.out.println("logo~~~~================>>>>>>>>>>>>>33333333");
		return new ModelAndView("main/logo", "command", clubVO);
	}
	
	
	/*
	 * Signup 화면으로 이동
	 */
	@RequestMapping("/signup")
	public ModelAndView signup(HttpServletRequest request, HttpServletResponse response, NoljaMemberInfoVO clubMemberInfoVO) {
		logger.info("start");

		try {
			MemberInfoVO memberInfoVO = CommonUtil.getMemberInfoVO(request);
			if(memberInfoVO != null && CommonUtil.isNotNullString(memberInfoVO.getInfos())) {
				//scMemberInfoVO  = mainService.selectMemberInfoDetail(memberInfoVO.getInfos());
			} else {
				clubMemberInfoVO = new NoljaMemberInfoVO();
			}
			
			/*
			RSAKeyInfoVO rsaKeyInfoVO = (RSAKeyInfoVO)CommonUtil.getRSAKeyInfoVO(request);
			if(rsaKeyInfoVO != null) {
				String[] modulesExponent = rsaKeyInfoVO.getModulusExponent();
				scMemberInfoVO.setRsaModulus(modulesExponent[0]);
				scMemberInfoVO.setRsaExponent(modulesExponent[1]);
			}
			*/
		} catch(Exception e) {
			logger.error(e.getMessage(), e);
		}
		return new ModelAndView("main/signup", "command", clubMemberInfoVO);
	}
	
	/*
	 * email, infos로 중복확인
	 */
	@RequestMapping(" /checkMemberDuplication")
	@ResponseBody
	public ResultVO checkMemberDuplication(HttpServletRequest request, HttpServletResponse response, NoljaMemberInfoVO memberInfoVO) {
		logger.info("start");
		
		ResultVO resultVO = new ResultVO();
		try {
			resultVO.setInfos(mainService.checkMemberInfo(memberInfoVO.getInfos(), memberInfoVO.getEmail()));
			resultVO.setStatus(CommonConstant.SUCCESS);
		} catch(Exception e) {
			resultVO.setStatus(CommonConstant.ERROR);
			logger.error(e.getMessage(), e);
		}
		return resultVO;
	}
	
	/*
	 * 사용자 정보 저장
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/saveSignup.do")
	public String saveSignup(HttpServletRequest request, HttpServletResponse response) {
		logger.info("start");
		
		try {
			MultipartRequest multi = new MultipartRequest(request, CommonInfo.getInstance().getUploadPath(), CommonInfo.getInstance().getUploadMaxSize(), CommonInfo.getInstance().getUploadEncoding(), new DefaultFileRenamePolicy());

			String infos = "";
			NoljaMemberInfoVO memberInfoVO = new NoljaMemberInfoVO();
			Enumeration<String> enumer = multi.getParameterNames();
		    while(enumer.hasMoreElements()) {
		        String key = enumer.nextElement();
		        String value = multi.getParameter(key);

		        if("infos".equals(key)) {
		        	memberInfoVO.setInfos(value);
		        	infos = value;
		        } else if("email".equals(key)) {
		        	memberInfoVO.setEmail(value);
		        } else if("password".equals(key)) {
		        	memberInfoVO.setPassword(value);
		        } else if("memberName".equals(key)) {
		        	memberInfoVO.setMemberName(value);
		        } else if("phone".equals(key)) {
		        	memberInfoVO.setPhone(value);
		        } else if("birthday".equals(key)) {
		        	memberInfoVO.setBirthday(value);
		        } else if("area1".equals(key)) {
		        	memberInfoVO.setArea1(value);
		        } else if("area2".equals(key)) {
		        	memberInfoVO.setArea2(value);
		        } else if("profile".equals(key)) {
		        	memberInfoVO.setProfile(value);
		        } else if("position1".equals(key)) {
		        	memberInfoVO.setPosition1(value);
		        } else if("position2".equals(key)) {
		        	memberInfoVO.setPosition2(value);
		        } else if("position3".equals(key)) {
		        	memberInfoVO.setPosition3(value);
		        }
		    }
		    
		    if(CommonUtil.isNullString(infos)) {
		    	infos = commonService.getInfos();
		    }
		    
		    //이미지 파일 Upload
		    //uploadPath+infos+_1+.확장자
		    //member 정보의 picture 컬럼에 저장
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
			    	if("pictureFile".equals(name)) {
			    		File bfile = new File(orgFileName);
			    		String aFileName = infos+CommonConstant.FILE_SEPARATOR+commonService.getInfos()+"_1"+filename.substring(filename.lastIndexOf("."));
			    		File afile = new File(CommonInfo.getInstance().getUploadPath()+CommonConstant.FILE_SEPARATOR+aFileName);
			    		if(afile.isFile()) {
			    			afile.delete();
						}
			    		bfile.renameTo(afile);
			    		memberInfoVO.setPicture(aFileName);
			        }
		    	}
		    }
		  /*  
		    //Pasword RSAKey로 복호화 후 MD5로 인코딩
		    if(CommonUtil.isNotNullString(memberInfoVO.getPassword())) {
				RSAKeyInfoVO rsaKeyInfoVO = (RSAKeyInfoVO)CommonUtil.getRSAKeyInfoVO(request);
				if(rsaKeyInfoVO != null) {
					String password = CommonUtil.encodeMd5(CommonUtil.decryptRsa(rsaKeyInfoVO.getPrivateKey(), memberInfoVO.getPassword()));
					memberInfoVO.setPassword(password);	
				}
			}
			*/
		    
		    if(CommonUtil.isNullString(memberInfoVO.getInfos())) {
		    	memberInfoVO.setInfos(infos);
				infos = mainService.insertMemberInfo(memberInfoVO);
			} else {
				infos = mainService.updateMemberInfo(memberInfoVO);
			}
		    
			if(CommonUtil.isNotNullString(infos)) {
				request.setAttribute("FLAG", "SAVESUCCESS");
				request.setAttribute("INFOS", infos);
				if(!"duplication".equals(infos)) {
					MemberInfoVO memberVO = new MemberInfoVO();
					memberVO.setInfos(infos);
					memberVO.setMemberId(memberInfoVO.getEmail());
					memberVO.setMemberName(memberInfoVO.getMemberName());
					memberVO.setMemberAuth(null);
					CommonUtil.setMemberInfoVO(request, memberVO);
					//mainService.insertSysLog(infos, null, null, request.getRequestURI());
				}
			} else {
				request.setAttribute("FLAG", "SAVEFAIL");
			}
		} catch(Exception e) {
			logger.error(e.getMessage(), e);
		}
		return "common/commonSave";
	}

	/*
	 *  로그아웃 이후 main화면으로 이동
	 */
	@RequestMapping("/logout")
	public void logout(HttpServletRequest request, HttpServletResponse response) {
		logger.info("start");
		
		try {
			CommonUtil.removeMemberInfoVO(request);
			response.sendRedirect("main.do");
		} catch(Exception e) {
			logger.error(e.getMessage(), e);
		}
	}
	
	/*
	 * 폰 로그 아웃
	 */
	@RequestMapping("/logoutPhone")
	@ResponseBody
	public ResultVO logoutPhone(HttpServletRequest request, HttpServletResponse response) {
		logger.info("start");
		
		ResultVO resultVO = new ResultVO();
		try {
			CommonUtil.removeMemberInfoVO(request);
			resultVO.setStatus(CommonConstant.SUCCESS);
		} catch(Exception e) {
			resultVO.setStatus(CommonConstant.ERROR);
			logger.error(e.getMessage(), e);
		}
		return resultVO;
	}
	

	
	/*
	@RequestMapping("/nolja/main")
	public ModelAndView noljamain(HttpServletRequest request, HttpServletResponse response, ClubVO clubVO) {
		logger.info("start~~~~");
		System.out.println("noljamain~~~~");
		return new ModelAndView("main/main", "command", clubVO);
	}
	*/
	
	
	/*
	 * login 화면으로 이동
	 */
	@RequestMapping("/login.do")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response, NoljaVO noljaVO) {
		logger.info("start");
		
		return new ModelAndView("main/login", "command", noljaVO);
	}
	
	/*
	 * login 화면으로 이동
	 */
	@RequestMapping("/adminLogin.do")
	public ModelAndView adminLogin(HttpServletRequest request, HttpServletResponse response, NoljaVO noljaVO) {
		logger.info("start");
		try {
			MemberInfoVO memberInfoVO = mainService.selectMemberInfo(noljaVO.getEmail(), null, null, null);
			CommonUtil.setMemberInfoVO(request, memberInfoVO);
			
			String contextPath = ((HttpServletRequest)request).getContextPath();
			((HttpServletResponse)response).sendRedirect(contextPath + "/main.do");
		} catch(Exception e) {
			logger.error(e.getMessage(), e);
		}
		return null;
	}
	
	
	/*
	 * 사용자가 존재하는지 체크
	 * email, password로 사용자 체크
	 * DB에 MD5로 인코딩되어 있어 MD5 인코딩해서 체크
	 */
	@RequestMapping("/checkLogin.do")
	@ResponseBody
	public ResultVO checkLogin(HttpServletRequest request, HttpServletResponse response, NoljaVO noljaVO) {
		logger.info("start");
		
		ResultVO resultVO = new ResultVO();
		try {
			String email = null;
			String password = null;
			/*
			RSAKeyInfoVO rsaKeyInfoVO = (RSAKeyInfoVO)CommonUtil.getRSAKeyInfoVO(request);
			if(rsaKeyInfoVO != null) {
				email = CommonUtil.decryptRsa(rsaKeyInfoVO.getPrivateKey(), noljaVO.getEmail());
				password = CommonUtil.encodeMd5(CommonUtil.decryptRsa(rsaKeyInfoVO.getPrivateKey(), noljaVO.getPassword()));
			}
			*/
			email = noljaVO.getEmail();
			password =  noljaVO.getPassword();
			
			MemberInfoVO memberInfoVO = mainService.selectMemberInfo(email, password, null, null);
			CommonUtil.setMemberInfoVO(request, memberInfoVO);
			CommonUtil.setClubInfoVO(request, null);
			if(memberInfoVO != null && CommonUtil.isNotNullString(memberInfoVO.getInfos())) {
				//mainService.insertSysLog(memberInfoVO.getInfos(), null, null, request.getRequestURI());
				resultVO.setResultObj(memberInfoVO);
			}
			resultVO.setStatus(CommonConstant.SUCCESS);
		} catch(Exception e) {
			resultVO.setStatus(CommonConstant.ERROR);
			logger.error(e.getMessage(), e);
		}
		return resultVO;
	}

}
