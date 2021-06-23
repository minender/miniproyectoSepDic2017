package com.calclogic.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import org.apache.log4j.Logger;

public class RequestInterceptor extends HandlerInterceptorAdapter {

	// starts logger for interceptor class
    static final org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(RequestInterceptor.class);

	/**
	 * Handle every request after it has been completly processed.
	 * @param request incoming request object
	 * @param response outgoing response
	 * @param handler
	 * @param ex
	 */
	@Override
	public void afterCompletion(
		HttpServletRequest request, 
		HttpServletResponse response,
		Object handler, Exception ex
	) 
	{

		String log = "";

		// source IP request
		log += "SOURCE " + request.getRemoteAddr() + ":" + request.getRemotePort();
		// method requested
		log += " - METHOD " + request.getMethod();
		// URL requested
		log += " - URI " + request.getRequestURI();
		// response status
		log += " - STATUS " + response.getStatus();

		logger.info(log);
	}

}
