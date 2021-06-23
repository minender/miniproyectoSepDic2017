package com.calclogic.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import org.apache.log4j.Logger;

public class RequestInterceptor extends HandlerInterceptorAdapter {

    static final org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(RequestInterceptor.class);

	@Override
	public void afterCompletion(
	HttpServletRequest request, 
	HttpServletResponse response,
	Object handler, Exception ex) {
		String log = "SOURCE " + request.getRemoteAddr() + ":" + request.getRemotePort();
		log += " - METHOD " + request.getMethod();
		log += " - URI " + request.getRequestURI();
		log += " - STATUS " + response.getStatus();
		logger.info(log);


	}

}
