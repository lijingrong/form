package com.landai.form.config;

import com.landai.form.utils.PageableInterceptor;
import com.landai.form.utils.UserInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration
public class MvcConfiguration extends WebMvcConfigurerAdapter {

    @Autowired
    private UserInterceptor userInterceptor;
    @Autowired
    private PageableInterceptor pageableInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(userInterceptor).addPathPatterns("/**").excludePathPatterns("/static/**");
        registry.addInterceptor(pageableInterceptor).addPathPatterns("/**");
    }
}
