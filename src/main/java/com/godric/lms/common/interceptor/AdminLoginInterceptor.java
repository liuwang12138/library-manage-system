package com.godric.lms.common.interceptor;

import com.godric.lms.common.enums.UserTypeEnum;
import com.godric.lms.common.po.UserPO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Objects;

/**
 * @author Godric
 */
@Slf4j
public class AdminLoginInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession session = request.getSession();

        Object user = session.getAttribute("user");
        if((user == null || (!"admin".equals(user) && !Objects.equals(((UserPO) user).getType(), UserTypeEnum.ADMIN.getCode())))) {
            response.setCharacterEncoding("UTF-8");
            log.info("Interceptor：跳转到admin login页面！");
            request.getRequestDispatcher("/admin/login").forward(request, response);
            return false;
        } else {
            return true;
        }
    }
}
