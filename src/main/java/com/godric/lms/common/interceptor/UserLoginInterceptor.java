package com.godric.lms.common.interceptor;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @author Godric
 */
@Slf4j
public class UserLoginInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession session = request.getSession();

        if(session.getAttribute("username") == null) {
            response.setCharacterEncoding("UTF-8");
            log.info("Interceptor：跳转到login页面！");
            request.getRequestDispatcher("/interceptor/index").forward(request, response);
            return false;
        } else {
            return true;
        }
    }
}
