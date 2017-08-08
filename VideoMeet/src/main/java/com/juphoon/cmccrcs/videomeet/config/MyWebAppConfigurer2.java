package com.juphoon.cmccrcs.videomeet.config;

import com.juphoon.cmccrcs.videomeet.interceptor.MyInterceptor2;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * Created by Administrator on 2017/7/21.
 */
@Configuration
public class MyWebAppConfigurer2
        extends WebMvcConfigurerAdapter {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {


        registry.addInterceptor(new MyInterceptor2()).addPathPatterns("/search/**").excludePathPatterns("/search/login/**");

        super.addInterceptors(registry);
    }

}
