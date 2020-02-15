package com.ktw.nolja.common.filter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.ktw.nolja.common.constant.CommonConstant;
import com.ktw.nolja.common.util.CommonUtil;
import com.ktw.nolja.common.vo.MemberInfoVO;

/*
* 생성일: 2017년 2월
* Class설명 : Filter
* 주요기능 : UTF-8 인코딩, SESSION에 RSAKEY 생성, Uri 체크(인증체크)
*/

public class AuthFilter implements Filter {
	
	// DEBUG, INFO, WARN, ERROR, FATAL 
	public Logger logger = Logger.getLogger(this.getClass());
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) {
		try {
			
			// UTF-8로 Response 인코딩
			response.setCharacterEncoding(CommonConstant.CHARACTER_ENCODING);
			
			String requestUri = ((HttpServletRequest)request).getRequestURI();
			String contextPath = ((HttpServletRequest)request).getContextPath();
			
			logger.info("contextPath : "+contextPath);
			logger.info("requestUri : "+requestUri);

			if(requestUri.endsWith(".do")){
				MemberInfoVO memberInfoVO = CommonUtil.getManagerInfoVO((HttpServletRequest)request);
				if(memberInfoVO == null) {
					System.out.println("사용자 정보 없음");
				}
			}
			
			// Uri가 없는 경우 Main 화면으로 Redirect
			/*
			if("/".equals(requestUri) || "".equals(requestUri)) {
				((HttpServletResponse)response).sendRedirect(contextPath + CommonInfo.getInstance().getUrlMain()); 
				return;
			}		
			*/
			/*	
			// Uri의 끝이 do 혹은  jsp  혹은 '.'가 없는 경우
			// Session에 RSA 공개Key가 없는 경우 RSAKey 생성
			if(requestUri.endsWith(".do") || requestUri.endsWith(".jsp") || requestUri.indexOf(".") == -1) {
				Object rsaKeyObj = CommonUtil.getRSAKeyInfoVO((HttpServletRequest)request);
				if(rsaKeyObj == null) {
					KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
					generator.initialize(1024);
					KeyPair keyPair = generator.genKeyPair();
					
					RSAKeyInfoVO rsaKeyInfoVO = new RSAKeyInfoVO();
					rsaKeyInfoVO.setPrivateKey(keyPair.getPrivate());
					rsaKeyInfoVO.setPublicKey(keyPair.getPublic());
					CommonUtil.setRSAKeyInfoVO(((HttpServletRequest)request), rsaKeyInfoVO);
				}
			
			// Uri가 manager로 시작되는 경우	
			// Uri가 main.do, login.do, logout.do, checkLogin.do가 아니고 세션에 사용자 정보가 없으면
			// ManagerMain으로 포워딩	
				if(requestUri.startsWith("/manager/")) {
					if(!requestUri.endsWith("/main.do") 
							&& !requestUri.endsWith("/login.do") && !requestUri.endsWith("/logout.do") 
							&& !requestUri.endsWith("/checkLogin.do")
							) {
						MemberInfoVO memberInfoVO = CommonUtil.getManagerInfoVO((HttpServletRequest)request);
						if(memberInfoVO == null) {
							((HttpServletResponse)response).sendRedirect(contextPath + CommonInfo.getInstance().getUrlManagerMain());
							return;
						}
					}
				} 
				// Uri가 admin로 시작되고
				// Uri가 main.do, login.do, logout.do, checkLogin.do가 아니고 세션에 사용자 정보가 없으면
				// AdminMain으로 이동
				else if(requestUri.startsWith("/admin/")) {
					if(!requestUri.endsWith("/main.do") 
							&& !requestUri.endsWith("/login.do") && !requestUri.endsWith("/logout.do") 
							&& !requestUri.endsWith("/checkLogin.do")
							) {
						MemberInfoVO memberInfoVO = CommonUtil.getManagerInfoVO((HttpServletRequest)request);
						if(memberInfoVO == null) {
							((HttpServletResponse)response).sendRedirect(contextPath + CommonInfo.getInstance().getUrlAdminMain());
							return;
						}
					}
				} 
				// Uri가 soccer로 시작되고
				// 아래 do로 끝나지 않고 세션에 사용자  정보가 없다면
				// SoccerMain으로 이동
				else if(requestUri.startsWith("/soccer/")) {
					if(!requestUri.endsWith("/main.do") && !requestUri.endsWith("/logo.do") 
							&& !requestUri.endsWith("/login.do") && !requestUri.endsWith("/logout.do")  && !requestUri.endsWith("/logoutPhone.do") 
							&& !requestUri.endsWith("/checkLogin.do") && !requestUri.endsWith("/autoLogin.do") && !requestUri.endsWith("/autoLoginPhone.do")
							&& !requestUri.endsWith("/signup.do") && !requestUri.endsWith("/checkMemberDuplication.do") && !requestUri.endsWith("/saveSignup.do")
							&& !requestUri.endsWith("/clause.do") && !requestUri.endsWith("/personalInfo.do")
							&& !requestUri.endsWith("/findId.do") && !requestUri.endsWith("/findPassword.do")
							&& !requestUri.endsWith("/getFindId.do") && !requestUri.endsWith("/getFindPassword.do")
							&& !requestUri.endsWith("/getDataItemUseList.do")
							&& !requestUri.endsWith("/upload.do") && !requestUri.endsWith("/saveToken.do")
							 && !requestUri.endsWith("/adminLogin.do")
							) {
						MemberInfoVO memberInfoVO = CommonUtil.getMemberInfoVO((HttpServletRequest)request);
						if(memberInfoVO == null) {
							((HttpServletResponse)response).sendRedirect(contextPath + CommonInfo.getInstance().getUrlSoccerMain());
							return;
						}
					}
				} 
				// Uri가 soccer, manager로 시작되지 않고 끝이 main.do가 아닌경우
				// main Uri로 이동
				else {
					if(!requestUri.endsWith("/main.do")) {
						((HttpServletResponse)response).sendRedirect(contextPath + CommonInfo.getInstance().getUrlMain());
						return;
					}
				}
			}
			*/
			//((HttpServletResponse)response).sendRedirect(contextPath + requestUri);
			chain.doFilter(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
			
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		logger.info("start");
	}

	public void destroy() {
		logger.info("start");
	}
	
}