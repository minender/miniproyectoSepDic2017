package com.calclogic.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

// import org.apache.log4j.PrettyConfigurator;
import org.apache.log4j.Logger;
// import org.apache.log4j.PropertyConfigurator;

public class RequestInterceptor extends HandlerInterceptorAdapter {

    static final org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(RequestInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		System.out.println("Testing...");
		logger.error("Testing logger...");
		// PropertyConfigurator.configure("../../../../resources/log4j2.properties");

		long startTime = System.currentTimeMillis();
        // logger.error("Request URL::" + request.getRequestURL().toString()
        // + ":: Start Time=" + System.currentTimeMillis());
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
        // logger.error("Request URL::" + request.getRequestURL().toString()
        // + " Sent to Handler :: Current Time=" + System.currentTimeMillis());
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		long startTime = (Long) request.getAttribute("startTime");
        // logger.error("Request URL::" + request.getRequestURL().toString()
        // + ":: End Time=" + System.currentTimeMillis());
        // logger.error("Request URL::" + request.getRequestURL().toString()
        // + ":: Time Taken=" + (System.currentTimeMillis() - startTime));
	}

}
