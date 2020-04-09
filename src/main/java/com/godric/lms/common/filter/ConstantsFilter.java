package com.godric.lms.common.filter;

import com.godric.lms.common.constants.LmsConstants;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author Godric
 */

public class ConstantsFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest)servletRequest;
        HttpServletResponse response = (HttpServletResponse)servletResponse;
        request.setAttribute("staticWebsite", LmsConstants.staticWebSite);
        request.setAttribute("website", LmsConstants.website);

        filterChain.doFilter(request, response);
    }

    @Override
    public void destroy() {

    }
}
