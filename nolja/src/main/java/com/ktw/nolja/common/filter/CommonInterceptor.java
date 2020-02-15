package com.ktw.nolja.common.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ktw.nolja.common.util.CommonUtil;
import com.ktw.nolja.common.vo.MemberInfoVO;

/**
 * 모든 Controller 수행 전후를 Interceptor 하여 공통처리가 가능한 class
 */
public class CommonInterceptor extends HandlerInterceptorAdapter {

	/**
	 * Controller 수행 전에 전처리를 할 수 있는 메서드로
	 * 상속에 의해 자동 생성된 메서드
	 *
	 * @param request 서블릿 request
 	 * @param response 서블릿 response
 	 * @param handler
	 * @return controller 진행 여부
	*/
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String requestUri = ((HttpServletRequest)request).getRequestURI();
		MemberInfoVO memberInfoVO = CommonUtil.getMemberInfoVO(request);
		String requestId = new java.rmi.server.UID().toString();
		request.setAttribute("startDate:"+requestId,  System.currentTimeMillis());
		
		System.out.println("===========================>preHandle: "+requestId+" "+requestUri);
		request.setAttribute("REQUEST_UNIQUE_CODE", requestId);

		return true;
	}

	/**
	 * Controller 수행 후에 후처리를 할 수 있는 메서드로
	 * 상속에 의해 자동 생성된 메서드
	 *
	 * @param request 서블릿 request
 	 * @param response 서블릿 response
 	 * @param handler
 	 * @param modelAndView
	 * @return void
	*/
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		String requestUri = ((HttpServletRequest)request).getRequestURI();
		MemberInfoVO memberInfoVO = CommonUtil.getMemberInfoVO(request);
		String requestId = (String)request.getAttribute("REQUEST_UNIQUE_CODE");
		
		System.out.println("===========================>postHandle: "+requestId+" "+requestUri+" "+request.getAttribute("startDate:"+requestId));
	}

	/**
	 * Controller 완료 후에 처리를 할 수 있는 메서드로
	 * 상속에 의해 자동 생성된 메서드
	 *
	 * @param request 서블릿 request
 	 * @param response 서블릿 response
 	 * @param handler
 	 * @param ex
	 * @return void
	*/
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
//		String requestId = (String)request.getAttribute(SessionKeyConstants.REQUEST_UNIQUE_CODE);
//		WebLogVO webLogVO = new WebLogVO(requestId);
//		webLogVO.setJspEndTimeMills(System.currentTimeMillis());
//		WebLogQueue.getInstance().put(webLogVO);
	}
}
