package com.landai.form.utils;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class PageableInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Integer page = ServletRequestUtils.getIntParameter(request, "page", 0);
        Integer size = ServletRequestUtils.getIntParameter(request, "size", 0);
        if (size == 0) size = Constants.PAGE_SIZE;
        Pageable pageable = new PageRequest(page, size);
        PageableHolder.setPageable(pageable);
        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        PageableHolder.empty();
    }
}
