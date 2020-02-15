package com.ktw.nolja.common.exception;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.dao.TransientDataAccessResourceException;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

public class CommonExceptionResolver implements HandlerExceptionResolver {
	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object obj, Exception exception) {
		ModelAndView view = new ModelAndView();
		view.setViewName("error/error");
		view.addObject("exception", exception.getClass().getName());
		view.addObject("exceptionMessage", exception.getMessage());

		if(exception instanceof TransientDataAccessResourceException) {
			view.setViewName("error/500");
		}
		return view;
	}
}